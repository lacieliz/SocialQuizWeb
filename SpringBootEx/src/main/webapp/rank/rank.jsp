<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>종합 랭킹</title>
    <link rel="stylesheet" type="text/css" href="/rank/style_rank.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />


    
</head>
<body>

<c:if test="${memId ne 'fruit'}">
	<%@ include file="../home/header.jsp" %>
</c:if>
<c:if test="${memId eq 'fruit'}">
	<%@ include file="../admin/header.jsp" %>
</c:if>



<!-- 게임 선택 및 나가기 버튼 -->
<div class="filter-bar">
  <form method="get" action="/rank">
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
    
    request.setAttribute("gameId", gameId);

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
    "  SELECT ROWNUM rnum, userId, nickname, active_id, rank_score, play_count FROM (" +
    "    SELECT m.userId, m.nickname, m.active_id, MAX(gr.game_score) AS rank_score, COUNT(*) AS play_count " +
    "    FROM Members m JOIN game_records gr ON m.userId = gr.userId " +
    "    WHERE gr.game_id = ? " +
    "    GROUP BY m.userId, m.nickname, m.active_id " +
    "    ORDER BY rank_score DESC, play_count ASC" +
    "  ) WHERE ROWNUM <= ?" +
    ") WHERE rnum > ?";

 	// 닉네임으로 활동 상태 표시
    // String nickname = request.getParmeter("nickname");
    // request.setAttribute("nickname", nickname);

    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(gameId));
    pstmt.setInt(2, endRow);
    pstmt.setInt(3, startRow);
    rs = pstmt.executeQuery();
%>

<div class="ranking-container">
    <h1 class="ranking-title"><%= gameName %> 랭킹 </h1>
    <table class="ranking-table">
        <thead>
            <tr>
                <th>순위</th>
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
                
                String rowUserId = rs.getString("userId");
                String activeId = rs.getString("active_id");
        %>
            <tr class="<%= rankClass %>">
                <td><%= rank %></td>
                <td><%= rs.getString("nickname") %></td>
                <td><%= rs.getInt("rank_score") %></td>
                <td><%= rs.getInt("play_count") %>판</td>
                <td>
                    <div class="<%= "1".equals(activeId) ? "status-active" : "status-none" %>"></div>
                </td>
                <td>
				    <form method="get" action="/record" style="margin:0;">
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
