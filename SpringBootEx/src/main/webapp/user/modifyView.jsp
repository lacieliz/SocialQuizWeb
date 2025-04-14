<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link rel="stylesheet" href="${logon}modifyview.css">
<script src="${logon}script_member.js"></script>  

<div class="form-container">
  <h2>${logon_modify}</h2>

  <c:if test="${checkPwd eq 1}">
    <form name="modifyform" method="post" action="modifypro">
      <input type="hidden" name="userId" value="${memberDto.userId}">
      
      <div class="form-group">
        <label>${str_user_id}</label>
        <div class="form-value">${memberDto.userId}</div>
      </div>

      <div class="form-group">
        <label>${str_passwd}</label>
        <input class="input" type="password" name="passwd" maxlength="20" autofocus>
      </div>

      <div class="form-group">
        <label>${str_passwd} 확인</label>
        <input class="input" type="password" name="repasswd" maxlength="20" >
      </div>

      <div class="form-group">
        <label>${str_nickname}</label>
        <div class="form-value">${memberDto.nickname}</div>
      </div>

      <div class="form-group">
        <label>${str_email}</label>
        <input class="input" type="text" name="email" maxlength="30" value="${memberDto.email}">
      </div>

      <div class="form-group">
        <label>${str_created_at}</label>
        <div class="form-value">
          <fmt:formatDate type="both" value="${memberDto.created_at}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>

      <div class="form-actions">
        <input class="inputbutton btn-blue" type="submit" value="${btn_mod}">
        <input class="inputbutton btn-gray" type="reset" value="${btn_cancle}">
        <input class="inputbutton btn-gray" type="button" value="${btn_mod_cancle}" onclick="location='mypage'">
      </div>
    </form>
  </c:if>

  <c:if test="${checkPwd eq 0}">
    <script>
    
      erroralert(error_passwd);
      $('#main-content').load('modifyuser');
      
    </script>
  </c:if>
</div>
<script>
let modifyform = document.querySelector( "form[name='modifyform']" );
if( modifyform ) {
	modifyform.addEventListener(
		"submit",
		( event ) => {
			let passwd = document.querySelector( "input[name='passwd']" );
			let repasswd = document.querySelector( "input[name='repasswd']" );
			if( ! passwd.value ) {
				alert( msg_passwd );
				event.preventDefault();
				passwd.focus();
			} else if( passwd.value != repasswd.value ) {
				alert( msg_repasswd );
				event.preventDefault();
				passwd.focus();
			} 					
		}							
	);	
}
</script>

