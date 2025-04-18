<%@ page language = "java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<html>
	<head>
		<title>끝말잇기 입장</title>
	</head>
	<body>
	<div align="center">
		<h2>끝맛잇기 채팅방 입장</h2>
		
		<form id="chatForm" method="post" action="/quiz/socketword" target="popupWindow" onsubmit="return openChatPopup();">
       		  닉네임을 확인해주세요 &nbsp; <br><br>
       		 <input type="text" id="nickname" name="nickname" value="${memId}" readonly/> <br><br>
     	  	 <button type="submit">채팅 참여</button> <br>
  	  	</form>
	</div>
		<script>
			function openChatPopup(){
				const nickname = document.getElementById("nickname").value.trim();
				if(nickname == "") {
					alert("닉네임을 입력해주세요");
					nickname.focus();
					return false;
				}
				
				// const serverIP = "192.168.0.84";
				// const form = document.getElementById( "chatForm" );
				
				// 강재로 form의 action 수정
				// form.action = "http://" + serverIP + ":8080/socketword";
				window.open( "", "popupWindow", "width=500, height=600" );
				// chatId.value="";
				return true;
			}
		</script>

	</body>
</html>
	