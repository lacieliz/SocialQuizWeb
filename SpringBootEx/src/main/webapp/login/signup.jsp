<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}loginform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>    

<%@ include file="/home/header.jsp" %>

<div id="main">
<div class="login-container">
	<div class="signup-box"> 
      <h2>이미 계정이 있으신가요?</h2>
      <p>로그인하고 퀴즈를 바로 시작하세요!</p>
      <button class="signup-button" onclick="location='logon'">로그인</button>
    </div>
    
	<div class="login-box">
		<form class="form" method="post" name ="inputform" action="/signup">
			<h2>${page_input}</h2>
			<input type="hidden" name="emailVerified" id="emailVerified" value="false">
		
			<input type="text" placeholder="아이디" class="input" name="userId" /> 
			<input type="password" placeholder="비밀번호" class="input"name="passwd" /> 
			<input type="password" placeholder="비밀번호 재확인" class="input" name="repasswd" /> 
			<input type="text" placeholder="닉네임" class="input" name="nickname" />
			<input type="text" placeholder="이메일" class="input" name="email" /> 
			<input type="text" placeholder="인증번호" class="input" name="emailAuth" />
		 	<input class="inputbutton" type="button" value="이메일 인증" onclick="sendEmailAuthCode()" id="emailAuthBtn">
		 	<input class="inputbutton" type="submit" value="가입" name="sub_btn"> 
		</form>
	</div>
</div>
</div>

<%@ include file="/home/footer.jsp" %>