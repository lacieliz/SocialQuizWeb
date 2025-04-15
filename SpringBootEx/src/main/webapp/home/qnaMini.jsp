<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!-- ✅ 스타일 적용 -->
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

    // ✅ 최근 3개 QnA 글 가져오기
    String sql =
        "SELECT * FROM (" +
        " SELECT num, subject, userId, reg_date " +
        " FROM Requests ORDER BY num DESC" +
        ") WHERE ROWNUM <= 3";

    rs = stmt.executeQuery(sql);
%>

<table class="table" style="font-size: 14px;">
    <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
    </thead>
    <tbody>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    while (rs.next()) {
        int num = rs.getInt("num");
        String subject = rs.getString("subject");
        String userId = rs.getString("userId");
        Timestamp regDate = rs.getTimestamp("reg_date");
%>
        <tr>
            <td>
                <a href="/qnacontent?num=<%= num %>&pageNum=1&number=<%= num %>">
                    <%= subject %>
                </a>
            </td>
            <td><%= userId %></td>
            <td><%= sdf.format(regDate) %></td>
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
