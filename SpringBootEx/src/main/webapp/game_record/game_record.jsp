<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>전체 게임 기록</title>
    <link rel="stylesheet" type="text/css" href="/rank/style_rank.css">
</head>
<body>
<%@ include file="../home/header.jsp" %>


<br>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int currentPage = 1;
    int limit = 12;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int startRow = (currentPage - 1) * limit;
    int endRow = currentPage * limit;

    int totalRecords = 0;
    int totalPages = 1;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "quiz", "quiz");

        // 전체 기록 수 조회
        String countSql = "SELECT COUNT(*) FROM game_records";
        pstmt = con.prepareStatement(countSql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalRecords = rs.getInt(1);
            totalPages = (int) Math.ceil(totalRecords / (double) limit);
        }
        rs.close();
        pstmt.close();

        // ✅ 페이징 쿼리 (ROWNUM 사용)
        String sql =
            "SELECT * FROM (" +
            "  SELECT ROWNUM rnum, nickname, game_name, play_time, game_score FROM (" +
            "    SELECT m.nickname, g.game_name, TO_CHAR(gr.record_time, 'HH24:MI:SS') AS play_time, gr.game_score " +
            "    FROM Members m " +
            "    JOIN game_records gr ON m.userId = gr.userId " +
            "    JOIN Games g ON gr.game_id = g.game_id " +
            "    ORDER BY gr.record_time DESC" +
            "  ) WHERE ROWNUM <= ?" +
            ") WHERE rnum > ?";

        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, endRow);     // LIMIT 끝
        pstmt.setInt(2, startRow);   // LIMIT 시작
        rs = pstmt.executeQuery();
%>

<div class="ranking-container">
    <h1 class="ranking-title">전체 게임 기록</h1>
    <table class="ranking-table">
        <thead>
            <tr>
                <th>닉네임</th>
                <th>게임 이름</th>
                <th>저장 시간</th>
                <th>획득 점수</th>
            </tr>
        </thead>
        <tbody>
<%
    while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("nickname") %></td>
            <td><%= rs.getString("game_name") %></td>
            <td><%= rs.getString("play_time") %></td>
            <td><%= rs.getInt("game_score") %>점</td>
        </tr>
<%
    }
%>
        </tbody>
    </table>

<!-- ✅ 페이지네이션 개선 (이전/다음 포함) -->
<div style="text-align:center; margin: 20px;">
<%
    int prevPage = currentPage - 1;
    int nextPage = currentPage + 1;

    if (prevPage >= 1) {
%>
    <a href="?page=<%= prevPage %>">◀ 이전</a>
<%
    }

    for (int i = 1; i <= totalPages; i++) {
        if (i == currentPage) {
%>
        <strong>[<%= i %>]</strong>
<%
        } else {
%>
        <a href="?page=<%= i %>">[<%= i %>]</a>
<%
        }
    }

    if (nextPage <= totalPages) {
%>
    <a href="?page=<%= nextPage %>">다음 ▶</a>
<%
    }
%>
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
