<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${qna}style_qna.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>

<h2>${page_modify}</h2>
<br>

<form name="modifyform" method="post" action="qnamodifypro">
	<input type="hidden" name="num" value="${qnaDto.num}">
	<input type="hidden" name="pageNum" value="${pageNum}">
	<table>
		<tr>
			<th colspan="2">${msg_modify}</th>
		</tr>
		<tr>
			<th>${str_writer}</th>
			<td>&nbsp;${qnaDto.userId}</td>
		</tr>
		<tr>
			<th>${str_subject}</th>
			<td>
				<input class="input" type="text" name="subject" maxlength="100" autofocus
					   value="${qnaDto.subject}">
			</td>
		</tr>
		<tr>
			<th>${str_content}</th>
			<td>
				<textarea name="content" rows="10" cols="40">${qnaDto.content}</textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_mod}">
				<input class="inputbutton" type="reset" value="${btn_cancle}">
				<input class="inputbutton" type="button" value="${btn_mod_cancle}"
					   onclick="location='qnalist?pageNum=${pageNum}'">
			</th>
		</tr>
	</table>
</form>
