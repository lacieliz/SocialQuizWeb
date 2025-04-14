<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${board}style_board.css">
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${board_modify}</h2>
<br>

<form name="modifyform" method="post" action="boardmodifypro">
	<input type="hidden" name="num" value="${boardDto.num}">
	<input type="hidden" name="pageNum" value="${pageNum}">
	<table>
		<tr>
			<th colspan="2">${msg_modify}</th>
		</tr>
		<tr>
			<th>${str_writer}</th>
			<td>&nbsp;${boardDto.user_id}</td>
		</tr>
		<tr>
			<th>${str_subject}</th>
			<td>
				<input class="input" type="text" name="subject" maxlength="100" autofocus
					   value="${boardDto.subject}">
			</td>
		</tr>
		<tr>
			<th>${str_content}</th>
			<td>
				<textarea name="content" rows="10" cols="40">${boardDto.content}</textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_mod}">
				<input class="inputbutton" type="reset" value="${btn_cancle}">
				<input class="inputbutton" type="button" value="${btn_mod_cancle}"
					   onclick="location='boardlist?pageNum=${pageNum}'">
			</th>
		</tr>
	</table>
</form>
