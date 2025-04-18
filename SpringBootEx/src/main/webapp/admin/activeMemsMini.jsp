<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
		
			/* ✅ 접속 상태 원 - 강제 적용 */
			.status-active {
				width: 10px !important;
				height: 10px !important;
				border-radius: 30% !important;
				background-color: green !important;
				display: inline-block !important;
				margin: 0 auto !important;
			}

			.status-none {
				width: 10px !important;
				height: 10px !important;
				border-radius: 30% !important;
				background-color: red !important;
				display: inline-block !important;
				margin: 0 auto !important;
			}
		

		.ranking-table {
			width: 90%;
			margin: 0 auto;
			border-collapse: collapse;
			font-size: 13px;
		}

		.ranking-table th, .ranking-table td {
			padding: 8px;
			border: 1px solid #ddd;
			text-align: center;
		}

		.ranking-table th {
			background-color: #3366ff;
			color: white;
			font-weight: bold;
		}
	</style>
</head>
<body>

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

int totalRecords = 0, totalPages = 1;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    con = DriverManager.getConnection(url, "quiz", "quiz");

    // ✅ 총 회원 수 조회
    Statement stmt = con.createStatement();
    ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) FROM Members WHERE auth = 'ROLE_MEMBER'");
    if (countRs.next()) {
        totalRecords = countRs.getInt(1);
        totalPages = (int) Math.ceil(totalRecords / (double) limit);
    }
    countRs.close();
    stmt.close();

    // ✅ 회원 목록 + active_id 조회
    String sql =
        "SELECT * FROM (" +
        "  SELECT ROWNUM rnum, userId, nickname, active_id FROM (" +
        "    SELECT userId, nickname, active_id FROM Members " +
        "    WHERE auth = 'ROLE_MEMBER' ORDER BY created_at DESC" +
        "  ) WHERE ROWNUM <= ?" +
        ") WHERE rnum > ?";

    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, endRow);
    pstmt.setInt(2, startRow);
    rs = pstmt.executeQuery();
%>

	<table class="ranking-table">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>접속 상태</th>
			</tr>
		</thead>
		<tbody>
		<%
			while (rs.next()) {
				String userId = rs.getString("userId");
				String nickname = rs.getString("nickname");
				String activeId = rs.getString("active_id"); // ✅ CHAR(1) 안전 처리
				String statusClass = "1".equals(activeId) ? "status-active" : "status-none";
		%>
			<tr>
				<td><%= userId %></td>
				<td><%= nickname %></td>
				<td><div class="<%= statusClass %>"></div></td> <!-- ✅ 초록/빨강 표시 -->
			</tr>
		<%
			}
		%>
		</tbody>
	</table>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
}
%>

</body>
</html>
