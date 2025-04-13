<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${project}style_member.css">
<script type="text/javascript" src="${project}script_member.js"></script>  

<h2> ${page_modify} </h2>

<c:if test="${result eq 1}">
	<form name="modifyform" method="post" action="logonmodifypro">
		<input type="hidden" name="userId" value="${memberDto.userId}">
		<table>
			<tr>				
				<th colspan="2"> ${msg_modify} </th>
			</tr>
			<tr>
				<th> ${str_user_id} </th>
				<td> &nbsp;${memberDto.userId} </td>
			</tr>
			<tr>
				<th rowspan="2"> ${str_passwd} </th>
				<td> 
					<input class="input" type="password" name="passwd" maxlength="20" autofocus
						value="${memberDto.passwd}"> 
				</td>					
			</tr>
			<tr>
				<td>
					<input class="input" type="password" name="repasswd" maxlength="20" autofocus
						value="${memberDto.passwd}"> 
				</td>
			</tr>
			<tr>
				
				<th> ${str_nickname} </th>
				<td> &nbsp;${memberDto.nickname} </td>
			</tr>
			<tr>
				<th> ${str_email} </th>
				<td>
					<input class="input" type="text" name="email" maxlength="20" style="width:80;"
					value="${memberDto.email}">
				</td>
			</tr>
			<tr>
				<th> ${str_created_at} </th>
				<td>
					&nbsp;<fmt:formatDate type="both" value="${memberDto.created_at}" 
						pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input class="inputbutton" type="submit" value="${btn_mod}">
					<input class="inputbutton" type="reset" value="${btn_cancle}">
					<input class="inputbutton" type="button" value="${btn_mod_cancle}"
						onclick="location='mypage'">
				</th>
			</tr>
		</table>			
	</form>
</c:if>
<c:if test="${result eq 0}">
	<script type="text/javascript">		
		erroralert( error_passwd );
	</script>
</c:if>
















