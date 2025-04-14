<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}loginform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>    

<h2> ${page_login} </h2>
		 <br>
	<div>
		<form name="loginform" method="post" action="/logon">
			<table>
				<tr>
					<td> <input class="input" type="text" name="userId" 
					placeholder="ID" value="${rememberedId}" maxlength="15" autofocus> </td>
				</tr>
				<tr>
					<td> <input class="input" type="password" name="passwd" 
					placeholder="Password" maxlength="20"> </td>
				</tr>
			</table> 
		 <div>
		 	<table>
				<tr>	
					<td>
					  <label>
					    <input type="checkbox" name="rememberId" 
					      <c:if test="${not empty rememberedId}">checked</c:if> /> 아이디 저장
					  </label>
					</td>

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
			 			<a href="/findid" class="no-underline">아이디 찾기 </a> 
			 			<a href="/findpwd" class="no-underline"> 비밀번호 찾기 </a>
			 		</tr>
			 	</p>
			 	<tr align="center">
			 		<td td colspan="2"> 과일 Quiz에 처음 참가하시나요? </td>
			 	</tr>
			 	<p>
		 			<tr align="center">
			 			<td> 
			 				<input class="inputbutton" type="button" value="${btn_input}"
			 				onclick="location='/signup'">
			 			</td>
		 		</tr>
			 	</p>
			 		<p>
		 			<tr align="center">
			 			<td> 
			 				<input class="inputbutton" type="button" value="${btn_main}"
			 				onclick="location='/home'">
			 			</td>
		 		</tr>
			 	</p>
				
			</table>
		</form>

		