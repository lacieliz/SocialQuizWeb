<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link type="text/css" rel="stylesheet" href="${logon}passwdform.css">
<script type="text/javascript" src="${logon}script_member.js"></script>

<div class="form-container">
  <h2>${logon_delete}</h2>

  <form id="passwdform" method="post" action="deleteuser">
    <div class="form-group">
      <label for="passwd">${str_passwd}</label>
      <input class="input" type="password" name="passwd" id="passwd" maxlength="20" placeholder="비밀번호를 입력하세요" autofocus>
    </div>

    <div class="form-actions">
      <input class="inputbutton btn-blue" id="deleteBtn" type="submit" value="${btn_del}">
      <input class="inputbutton btn-gray" type="button" value="${btn_del_cancle}" onclick="location='home'">
    </div>
  </form>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("passwdform");
    const deleteBtn = document.getElementById("deleteBtn");

    form.addEventListener("submit", function (e) {
      e.preventDefault();

      if (!confirm("정말로 회원 탈퇴하시겠습니까? 모든 정보는 삭제됩니다.")) {
        return;
      }

      const passwd = document.getElementById("passwd").value.trim();
      if (!passwd) {
        alert("비밀번호를 입력해주세요.");
        return;
      }

      fetch("deleteuser", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({ passwd: passwd })
      })
      .then(response => {
        if (response.ok) {
          alert("회원 탈퇴가 완료되었습니다.");
          window.location.href = "/logon";
        } else {
          return response.text().then(text => { throw new Error(text); });
        }
      })
      .catch(error => {
        alert("탈퇴 실패: " + error.message);
      });
    });
  });
</script>
