<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${board}style_board.css">
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${page_delete}</h2>
<br>

<form method="post" action="boarddelete">
	<input type="hidden" name="num" value="${num}">
	<input type="hidden" name="pageNum" value="${pageNum}">

	<table>
		<tr>
			<th colspan="2">${msg_delete_confirm}</th>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${board_btn_del}">
				<input class="inputbutton" type="button" value="${board_btn_cancle}"
					onclick="location='boardlist?pageNum=${pageNum}'">
			</th>
		</tr>
	</table>
</form>
