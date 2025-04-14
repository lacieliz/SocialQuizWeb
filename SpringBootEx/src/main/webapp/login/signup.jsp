<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}inputform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>    


<form class="form" method="post" name ="inputform" action="/signup">
	<h2 class="form_title">${page_input}</h2>
	<input type="hidden" name="emailVerified" id="emailVerified" value="false">

	<input type="text" placeholder="ID" class="input" name="userId" /> 
	<input type="password" placeholder="Password" class="input"name="passwd" /> 
	<input type="password" placeholder="Repeat Password" class="input" name="repasswd" /> 
	<input type="text" placeholder="Nickname" class="input" name="nickname" />
	<input type="text" placeholder="Email" class="input" name="email" /> 
	<input type="text" placeholder="Email Auth" class="input" name="emailAuth" />
 	<input class="inputbutton" type="button" value="이메일 인증" onclick="sendEmailAuthCode()" id="emailAuthBtn">
 	<input class="inputbutton" type="submit" value="Sign up" name="sub_btn"> 
	<input class="inputbutton" type="button" value="Sign in" onclick="location='logon'">
</form>

