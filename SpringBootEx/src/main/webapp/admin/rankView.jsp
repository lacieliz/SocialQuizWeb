<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");

    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbid = "quiz";
    String dbpasswd = "quiz";
    con = DriverManager.getConnection(url, dbid, dbpasswd);
    
    stmt = con.createStatement();
    
 // 랭킹 정보 가져오기 - 최고 점수 + 게임 판수 기준
    String sql = "SELECT m.nickname, MAX(gr.game_score) AS rank_score, " +
             "COUNT(*) AS play_count " +
             "FROM Members m " +
             "JOIN game_records gr ON m.userId = gr.userId " +
             "WHERE gr.game_id = 1 " +
             "GROUP BY m.nickname " +
             "ORDER BY rank_score DESC, play_count ASC";

    
    rs = stmt.executeQuery(sql);
%>
<table class="table">
    <thead>
        <tr>
            <th colspan="4">OX게임 랭킹</th>
        </tr>
        <tr class="table-dark">
            <th class="text-center">닉네임</th>
            <th class="text-center">점수</th>
            <th class="text-center">판수</th>
        </tr>
    </thead>
    <tbody>
<%
    String css[] = {"table-danger","table-primary","table-warning","table-active","table-light","table-light"};
    int i = 0;
    while (rs.next() && i < 6) { // 상위 6명까지만 출력
        String rowClass = (i < 5) ? css[i] : css[5];
%>
        <tr class="<%= rowClass %>">
            <td class="text-center"><%= rs.getString("nickname") %></td>
            <td class="text-center"><%= rs.getInt("rank_score") %></td>
            <td class="text-center"><%= rs.getInt("play_count") %></td>




        </tr>
<%
	i++;
    }
} catch (SQLException e) {
    e.printStackTrace();
} catch (ClassNotFoundException e) {
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
    </tbody>
</table>
