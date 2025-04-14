<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${qna}qnaform.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>

<h2>${page_delete}</h2>
<br>

<form method="post" action="qnadelete">
	<input type="hidden" name="num" value="${num}">
	<input type="hidden" name="pageNum" value="${pageNum}">

	<table>
		<tr>
			<th colspan="2">${msg_delete_confirm}</th>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_del}">
				<input class="inputbutton" type="button" value="${btn_del_cancle}"
					onclick="location='qnalist?pageNum=${pageNum}'">
			</th>
		</tr>
	</table>
</form>
