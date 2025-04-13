<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<link rel="stylesheet" href="${project}findform.css">

<h2 class="form_title">비밀번호 찾기</h2>

<form class="form" name="inputform" method="post" action="sendmail">
    <input type="email" name="email" placeholder="Email" class="input" required />
    <input type="text" name="emailAuth" placeholder="Email Auth" class="input" />
   
    <input type="button" id="emailAuthBtn" value="이메일 인증하기" class="inputbutton" onclick="sendEmailAuthCode()"/>
    <input type="button" value="로그인으로 돌아가기" class="inputbutton" onclick="location.href='logon'" />
</form>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 전체 함수 정의 이 안에 넣기
    let lastSentEmail = null;

    window.sendEmailAuthCode = function () {
        const form = document.forms['inputform'];
        const email = form['email'].value.trim();
        const authInput = form['emailAuth']?.value?.trim();

        if (!email) {
            alert('이메일을 입력해주세요!');
            return;
        }

        if (email === lastSentEmail) {
            if (!authInput) {
                alert('이미 인증번호를 보냈습니다. \n메일을 확인한 후 인증번호를 입력해주세요.');
                return;
            }

            fetch('sendmailcheck', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'emailAuth=' + encodeURIComponent(authInput)
            })
            .then(response => response.json())
            .then(data => {
                if (data.verified) {
                    alert('이메일 인증에 성공했습니다!');
                    location.href = '/logonchangepwd';
                } else {
                    alert('인증번호가 올바르지 않습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('서버 오류가 발생했습니다.');
            });

            return;
        }

        fetch('sendmail', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'email=' + encodeURIComponent(email)
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                lastSentEmail = email;
                alert('인증번호가 이메일로 전송되었습니다!');
            } else if (result === 'duplicate') {
                alert('중복된 이메일입니다! 다른 이메일을 사용해주세요.');
            } else {
                alert('이메일 전송 실패');
            }
        })
        .catch(error => {
            console.error('에러 발생:', error);
            alert('서버 오류가 발생했습니다.');
        });
    };
});
</script>