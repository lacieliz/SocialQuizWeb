<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!-- ✅ 스타일 적용 -->
<link rel="stylesheet" type="text/css" href="/board/style_board.css">

<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String memId = (String) session.getAttribute("memId"); // 세션에서 로그인 사용자 ID 가져오기

try {
    if (memId != null) {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbid = "quiz";
        String dbpw = "quiz";
        con = DriverManager.getConnection(url, dbid, dbpw);

        String sql = 
            "SELECT * FROM (" +
            " SELECT num, subject, userId, reg_date" +
            " FROM Requests WHERE userId = ?" +
            " ORDER BY num DESC" +
            ") WHERE ROWNUM <= 3";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, memId); // 사용자 ID 바인딩
        rs = pstmt.executeQuery();
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
    } else {
%>
    <tr><td colspan="3" style="text-align:center;">로그인이 필요합니다.</td></tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
}
%>
    </tbody>
</table>
