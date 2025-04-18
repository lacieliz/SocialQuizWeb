<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>접속자 조회</title>
	<link rel="stylesheet" type="text/css" href="/rank/style_rank.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />
	<style>
		.status-active {
			width: 10px !important;
			height: 10px !important;
			border-radius: 50% !important;
			background-color: green !important;
			display: inline-block !important;
			margin: 0 auto !important;
		}

		.status-none {
			width: 10px !important;
			height: 10px !important;
			border-radius: 50% !important;
			background-color: red !important;
			display: inline-block !important;
			margin: 0 auto !important;
		}
	</style>
</head>
<body>

<%@ include file="../admin/header.jsp" %>

<!-- ✅ 드롭다운 필터 -->
<div class="filter-bar">
	<form method="get" action="/acitivemems">
	  <select id="activeSelect" name="active_id" onchange="this.form.submit()" class="form-select custom-select">
	    <option value="1" <%= "1".equals(request.getParameter("active_id")) ? "selected" : "" %>>접속 회원</option>
	    <option value="0" <%= "0".equals(request.getParameter("active_id")) ? "selected" : "" %>>비접속 회원</option>
	    <option value="2" <%= request.getParameter("active_id") == null || "2".equals(request.getParameter("active_id")) ? "selected" : "" %>>전체</option>
	  </select>
	</form>
</div>

<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String activeName = "전체";
int currentPage = 1;
int limit = 12;

if (request.getParameter("page") != null) {
    currentPage = Integer.parseInt(request.getParameter("page"));
}
int startRow = (currentPage - 1) * limit;
int endRow = currentPage * limit;

int totalRecords = 0, totalPages = 1;

String activeParam = request.getParameter("active_id");
if (activeParam == null) 
	activeParam = "2"; // 기본: 전체
	
int activeId = Integer.parseInt(activeParam);

if (activeId == 1) activeName = "접속 회원";
else if (activeId == 0) activeName = "비접속 회원";
else activeName = "전체";
request.setAttribute("activeName", activeName);

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    con = DriverManager.getConnection(url, "quiz", "quiz");

    Statement stmt = con.createStatement();
    ResultSet countRs;
    if (activeId == 0 || activeId == 1) {
        countRs = stmt.executeQuery("SELECT COUNT(*) FROM Members WHERE auth = 'ROLE_MEMBER' AND active_id = " + activeId);
    } else {
        countRs = stmt.executeQuery("SELECT COUNT(*) FROM Members WHERE auth = 'ROLE_MEMBER'");
    }
    if (countRs.next()) {
        totalRecords = countRs.getInt(1);
        totalPages = (int) Math.ceil(totalRecords / (double) limit);
    }
    countRs.close();
    stmt.close();

    // ✅ block_id까지 포함해서 조회
    String sql;
    if (activeId == 2) {
        sql = "SELECT * FROM (" +
              "  SELECT ROWNUM rnum, userId, nickname, active_id, block_id FROM (" +
              "    SELECT userId, nickname, active_id, block_id FROM Members " +
              "    WHERE auth = 'ROLE_MEMBER' " +
              "    ORDER BY created_at DESC" +
              "  ) WHERE ROWNUM <= ?" +
              ") WHERE rnum > ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, endRow);
        pstmt.setInt(2, startRow);
    } else {
        sql = "SELECT * FROM (" +
              "  SELECT ROWNUM rnum, userId, nickname, active_id, block_id FROM (" +
              "    SELECT userId, nickname, active_id, block_id FROM Members " +
              "    WHERE auth = 'ROLE_MEMBER' AND active_id = ? " +
              "    ORDER BY created_at DESC" +
              "  ) WHERE ROWNUM <= ?" +
              ") WHERE rnum > ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, activeId);
        pstmt.setInt(2, endRow);
        pstmt.setInt(3, startRow);
    }

    rs = pstmt.executeQuery();
%>

<!-- ✅ 출력 테이블 -->
<div class="ranking-container" align="center">
	<h1 class="ranking-title"> <%= activeName %> 목록 </h1>
	<table class="ranking-table">
		<thead>
			<tr>
				<th>회원 아이디</th>
				<th>닉네임</th>
				<th>접속 상태</th>
				<th>차단</th>
			</tr>
		</thead>
		<tbody>
		<%
			while (rs.next()) {
				String userId = rs.getString("userId");
				String nickname = rs.getString("nickname");
				String active = rs.getString("active_id");
				String block = rs.getString("block_id");
		%>
			<tr>
				<td><%= userId %></td>
				<td><%= nickname %></td>
				<td>
					<div class="<%= "1".equals(active) ? "status-active" : "status-none" %>"></div>
				</td>
				<td>
					<form method="get" action="/admin/blockMem.jsp" style="margin:0;">
						<input type="hidden" name="userId" value="<%= userId %>">
						<input type="hidden" name="action" value="<%= "1".equals(block) ? "unblock" : "block" %>">
						<button type="submit">
							<%= "1".equals(block) ? "해제" : "차단" %>
						</button>
					</form>
				</td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
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
