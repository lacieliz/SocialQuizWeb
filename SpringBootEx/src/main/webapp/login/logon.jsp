<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}loginform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>    

<%@ include file="/home/header.jsp" %>

<div id="main">
<div class="login-container">
	<div class="signup-box">
		<h2> 아직,<br>게임 회원이<br>아니신가요?</h2>
		 <p>회원가입하고<br>퀴즈 랭킹에 도전해 보세요!</p>
      <button class="signup-button" onclick="location='/signup'">회원가입</button>
	</div>
	
	<div class="login-box">
		<form name="loginform" method="post" action="/logon">
			<h2>${page_login}</h2>
			<input class="input" type="text" name="userId" 
				placeholder="ID" value="${rememberedId}" maxlength="15" autofocus>
			<input class="input" type="password" name="passwd" 
				placeholder="Password" maxlength="20">
			 <div>
				<label><input type="checkbox" class="memory" name="rememberId"
					<c:if test="${not empty rememberedId}">checked</c:if> />아이디 저장</label>
			</div>
			<input class="inputbutton" type="submit" value="${btn_login}">
		
			<div class="link-row">
	          <span><a href="/findid" class="text-decoration-none">아이디 찾기</span> | <span><a href="/findpwd" class="text-decoration-none">비밀번호 찾기</span>
	        </div>
	
	        <div class="social-login">
	          <p>다른 계정으로 로그인</p>
	          <div class="sns-buttons">
	            <div class="sns naver">N</div>
	            <div class="sns kakao">K</div>
	            <div class="sns google">G</div>
	          </div>
	        </div>
		</form>
	</div>
</div>
</div>

<%@ include file="/home/footer.jsp" %>