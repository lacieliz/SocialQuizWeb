<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${project}loginform.css">
<script type="text/javascript" src="${project}script_member.js"></script>    

<h2> ${page_login} </h2>
		 <br>
	<div>
		<form name="loginform" method="post" action="logonlogin">
			<table>
				<tr>
					<td> <input class="input" type="text" name="userId" 
					placeholder="ID" maxlength="15" autofocus> </td>
				</tr>
				<tr>
					<td> <input class="input" type="password" name="passwd" 
					placeholder="Password" maxlength="20"> </td>
				</tr>
			</table> 
		 <div>
		 	<table>
				<tr>	
					<td><input type="checkbox" class="memory"> 아이디 저장</td>
			 	</tr>
			</table>
		</div>
			 	<p>
			 		<tr align="center">
			 			<td> 
			 				<input class="inputbutton" type="submit" value="${btn_login}">
			 			</td>
			 		</tr>
			 	</p>
		 		
			 	<p>
			 		<tr align="center">
			 			<td> 아이디 찾기 </td>
			 			<td> 비밀번호 찾기 </td>
			 		</tr>
			 	</p>
			 	<tr align="center">
			 		<td td colspan="2"> 과일 Quiz에 처음 참가하시나요? </td>
			 	</tr>
			 	<p>
		 			<tr align="center">
			 			<td> 
			 				<input class="inputbutton" type="button" value="${btn_input}"
			 				onclick="location='${pageContext.request.contextPath}/logoninput'">
			 			</td>
		 		</tr>
			 	</p>
			 		<p>
		 			<tr align="center">
			 			<td> 
			 				<input class="inputbutton" type="button" value="${btn_main}"
			 				onclick="location='${pageContext.request.contextPath}/logonmain'">
			 			</td>
		 		</tr>
			 	</p>
				
			</table>
		</form>

		