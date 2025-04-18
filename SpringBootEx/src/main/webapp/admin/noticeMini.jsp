<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<link rel="stylesheet" type="text/css" href="/board/style_board.css">

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbid = "quiz";
    String dbpw = "quiz";
    con = DriverManager.getConnection(url, dbid, dbpw);
    stmt = con.createStatement();

    // ✅ readcount 포함하여 최근 3개 공지 가져오기
    String sql = 
        "SELECT * FROM (" +
        "SELECT num, subject, userId, readcount " +
        "FROM Notices ORDER BY num DESC) " +
        "WHERE ROWNUM <= 3";

    rs = stmt.executeQuery(sql);
%>

<table class="table" style="font-size: 14px;">
    <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th> <!-- ✅ 변경된 열 -->
        </tr>
    </thead>
    <tbody>
<%
    while (rs.next()) {
        int num = rs.getInt("num");
        String subject = rs.getString("subject");
        String userId = rs.getString("userId");
        int readcount = rs.getInt("readcount"); // ✅ 조회수
%>
        <tr>
            <td>
			    <a href="/boardcontent?num=<%= num %>&pageNum=1&number=<%= num %>">
			        <%= subject %>
			    </a>
			</td>
            <td><%= userId %></td>
            <td><%= readcount %></td> <!-- ✅ 조회수 출력 -->
        </tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (con != null) con.close();
}
%>
    </tbody>
</table>
