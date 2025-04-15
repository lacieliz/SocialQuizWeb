<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>종합 랭킹</title>
    <link rel="stylesheet" type="text/css" href="/rank/style_rank.css">
    <!-- 예시: Noto Sans KR -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />


    
</head>
<body>

<%@ include file="../home/header.jsp" %>


<!-- 게임 선택 및 나가기 버튼 -->
<div class="filter-bar">
  <form method="get" action="/rank/rank">
    <select id="gameSelect" name="game_id" onchange="this.form.submit()" class="form-select custom-select">
      <option value="1" <%= "1".equals(request.getParameter("game_id")) ? "selected" : "" %>>OX게임</option>
      <option value="2" <%= "2".equals(request.getParameter("game_id")) ? "selected" : "" %>>끝말잇기</option>
      <option value="3" <%= "3".equals(request.getParameter("game_id")) ? "selected" : "" %>>라이어 게임</option>
    </select>
  </form>
</div>



<%
Connection con = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String gameName = "게임";

int currentPage = 1;
int limit = 12;
if (request.getParameter("page") != null) {
    currentPage = Integer.parseInt(request.getParameter("page"));
}
int startRow = (currentPage - 1) * limit;
int endRow = currentPage * limit;

int totalRecords = 0, totalPages = 1;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    con = DriverManager.getConnection(url, "quiz", "quiz");

    String gameId = request.getParameter("game_id");
    if (gameId == null) gameId = "1";

    // 게임 이름 조회
    stmt = con.createStatement();
    ResultSet gameRs = stmt.executeQuery("SELECT game_name FROM Games WHERE game_id = " + gameId);
    if (gameRs.next()) {
        gameName = gameRs.getString("game_name");
    }
    gameRs.close();

    // 총 사용자 수
    ResultSet countRs = stmt.executeQuery(
        "SELECT COUNT(DISTINCT m.nickname) " +
        "FROM Members m JOIN game_records gr ON m.userId = gr.userId " +
        "WHERE gr.game_id = " + gameId
    );
    if (countRs.next()) {
        totalRecords = countRs.getInt(1);
        totalPages = (int) Math.ceil(totalRecords / (double) limit);
    }
    countRs.close();
    stmt.close();

    // 랭킹 정보 (페이징 포함)
    String sql =
    "SELECT * FROM (" +
    "  SELECT ROWNUM rnum, userId, nickname, rank_score, play_count FROM (" +
    "    SELECT m.userId, m.nickname, MAX(gr.game_score) AS rank_score, COUNT(*) AS play_count " +
    "    FROM Members m JOIN game_records gr ON m.userId = gr.userId " +
    "    WHERE gr.game_id = ? " +
    "    GROUP BY m.userId, m.nickname " +
    "    ORDER BY rank_score DESC, play_count ASC" +
    "  ) WHERE ROWNUM <= ?" +
    ") WHERE rnum > ?";


    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(gameId));
    pstmt.setInt(2, endRow);
    pstmt.setInt(3, startRow);
    rs = pstmt.executeQuery();
%>

<div class="ranking-container">
    <h1 class="ranking-title"><%= gameName %> 랭킹</h1>
    <table class="ranking-table">
        <thead>
            <tr>
                <th>순위</th>
                <th>프로필</th>
                <th>닉네임</th>
                <th>최고점수</th>
                <th>판수</th>
                <th>상태</th>
                <th>정보</th>
            </tr>
        </thead>
        <tbody>
        <%
            int rank = startRow + 1;
            while (rs.next()) {
                String rankClass = "";
                if (rank == 1) rankClass = "first-place";
                else if (rank == 2) rankClass = "second-place";
                else if (rank == 3) rankClass = "third-place";
        %>
            <tr class="<%= rankClass %>">
                <td><%= rank %></td>
                <td><img src="<%= request.getContextPath() %>/images/sample_profile.png" class="profile-img" alt="profile"></td>
                <td><%= rs.getString("nickname") %></td>
                <td><%= rs.getInt("rank_score") %></td>
                <td><%= rs.getInt("play_count") %>판</td>
                <td><div class="status-dot"></div></td>
                <td>
				    <form method="get" action="/mypage/mypage.jsp" style="margin:0;">
				        <input type="hidden" name="userId" value="<%= rs.getString("userId") %>">

				        <button type="submit" class="action-btn">정보</button>
				    </form>
				</td>
            </tr>
        <%
                rank++;
            }
        %>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div style="text-align:center; margin: 20px;">
    <%
        int prevPage = currentPage - 1;
        int nextPage = currentPage + 1;

        if (prevPage >= 1) {
    %>
        <a href="?game_id=<%= gameId %>&page=<%= prevPage %>">◀ 이전</a>
    <%
        }

        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
    %>
            <strong>[<%= i %>]</strong>
    <%
            } else {
    %>
            <a href="?game_id=<%= gameId %>&page=<%= i %>">[<%= i %>]</a>
    <%
            }
        }

        if (nextPage <= totalPages) {
    %>
        <a href="?game_id=<%= gameId %>&page=<%= nextPage %>">다음 ▶</a>
    <%
        }
    %>
    </div>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
}
%>

<%@ include file="../home/footer.jsp" %>


</body>
</html>
