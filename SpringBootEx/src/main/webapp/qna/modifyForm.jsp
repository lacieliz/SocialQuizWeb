<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${qna}qnaform.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>

<h2>${page_modify}</h2>
<br>

<form method="get" action="qnamodify">
	<input type="hidden" name="num" value="${num}">
	<input type="hidden" name="pageNum" value="${pageNum}">

	<table>
		<tr>
			<th colspan="2">${msg_modify_confirm}</th>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_mod}">
				<input class="inputbutton" type="button" value="${btn_mod_cancle}"
					onclick="location='qnalist?pageNum=${pageNum}'">
			</th>
		</tr>
	</table>
</form>
