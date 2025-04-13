<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../setting.jsp" %>
<link rel="stylesheet" href="${project}findform.css">

<h2 class="form_title">아이디 찾기</h2>

<form class="form" method="post" action="/findid">
    <input type="email" name="email" placeholder="이메일을 입력하세요" class="input" required />
    
    <input type="submit" value="아이디 찾기" class="inputbutton" />
    <input type="button" value="로그인으로 돌아가기" class="inputbutton" onclick="location.href='logon'" />
</form>
