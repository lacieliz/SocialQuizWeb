<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}passwdform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>  

<div class="form-container">

<h2>${logon_modify}</h2>

  <form id="passwdform" method="post" action="modifyuser">
    <div class="form-group">
      <label for="passwd">${str_passwd}</label>
      <input class="input" type="password" name="passwd" id="passwd" maxlength="20" placeholder="비밀번호를 입력하세요" autofocus>
    </div>

    <div class="form-actions">
      <input class="inputbutton btn-blue" id="deleteBtn" type="submit" value="${btn_mod}">
      <input class="inputbutton btn-gray" type="button" value="${btn_mod_cancle}" onclick="location='mypage'">
    </div>
  </form>
</div>

<script>
$(document).off("submit", "#passwdform").on("submit", "#passwdform", function (e) {
	  e.preventDefault();

	  $.ajax({
	    type: 'POST',
	    url: 'modifyuser',
	    data: $(this).serialize(),
	    success: function (response) {
	      $('#main-content').html(response);
	    }
	  });
	});


</script>
