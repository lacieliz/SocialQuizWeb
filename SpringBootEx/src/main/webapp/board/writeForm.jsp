<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${board}style_board.css">
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${board_write}</h2>
<br>

<form name="writeform" method="post" action="boardwrite">
	<input type="hidden" name="num" value="${num}">
	<input type="hidden" name="ref" value="${ref}">
	<input type="hidden" name="re_step" value="${re_step}">
	<input type="hidden" name="re_level" value="${re_level}">

	<table>
		<tr>
			<th colspan="2" style="text-align: right;">
				<a href="boardlist">${str_list}&nbsp;&nbsp;&nbsp;</a>
			</th>
		</tr>
		<tr>
			<th>${str_writer}</th>
			<td>
				<input class="input" type="text" name="user_id" value="${sessionScope.memId}" readonly>
			</td>
		</tr>
		<tr>
			<th>${str_subject}</th>
			<td>
				<input class="input" type="text" name="subject" maxlength="100">
			</td>
		</tr>
		<tr>
			<th>${str_content}</th>
			<td>
				<textarea name="content" rows="10" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_write}">
				<input class="inputbutton" type="reset" value="${btn_cancle}">
				<input class="inputbutton" type="button" value="${btn_list}"
					onclick="location='boardlist'">
			</th>
		</tr>
	</table>
</form>
