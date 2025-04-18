<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>  
<link rel="stylesheet" href="${logon}findform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>  

<h2 class="form_title">비밀번호 변경</h2>

<form class="form" name="inputform" method="post" action="changepwd">
    <input type="text" name="userId" placeholder="ID" class="input" required />
    <input type="password" name="passwd" placeholder="PASSWORD" class="input" required/>
    <input type="password" name="repasswd" placeholder="REPASSWORD" class="input" required/>
    <input type="submit" value="비밀번호 변경하기" class="inputbutton"/>
    <input type="button" value="로그인으로 돌아가기" class="inputbutton" onclick="location.href='logon'" />
</form>
    
