<%@ page language = "java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<html>
<style>
.modal {
  display: block;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.6);
  backdrop-filter: blur(5px);
}

.modal-content {
  background-color: #fff;
  padding: 25px;
  border-radius: 10px;
  width: 350px;
  margin: 15% auto;
  text-align: center;
  animation: fadeIn 0.4s ease;
}

.modal-btn {
  padding: 10px 20px;
  font-size: 14px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  background-color: #007bff;
  color: white;
}

.modal-btn:hover {
  background-color: #0056b3;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-20px); }
  to { opacity: 1; transform: translateY(0); }
}

</style>
<div id="startModal" class="modal">
  <div class="modal-content">
    <h3> 라이어게임 설명</h3>
    <p style="margin-bottom: 15px; line-height: 1.6;">
      라이어 게임은 4인 이상하길 추천드립니다.<br>
      시간은 무제한 입니다.<br>
      Free하게 즐기세요.<br>
      <b>라이어는</b> 바로 <b>너</b>가 될지도?<br>
      죄송합니다. 자유입니다.
    </p>
    <div style="display: flex; justify-content: center; gap: 10px;">
      <button id="startGameBtn" class="modal-btn">시작</button>
      <button id="cancelGameBtn" class="modal-btn">돌아가기</button>
    </div>
  </div>
</div>
	<head>
		<title>웹소켓 채팅</title>
	</head>
	<body>
	<div align="center">
		<h2> 라이어 게임 </h2>
		
		<form id="chatForm" method="post" action="/socketword" target="popupWindow" onsubmit="return openChatPopup();">
       		  게임방에서 사용할 닉네임을 확인해주세요. &nbsp; <br><br>
       		 <input type="text" id="nickname" name="nickname" value="${memId}"/> <br><br>
     	  	 <button type="submit">게임 참여</button> <br>
  	  	</form>
	</div>
		<script>
			function openChatPopup(){
				var nickname = document.getElementById("nickname");
				if(nickname.value == "") {
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
	<script>
	document.getElementById("startGameBtn").addEventListener("click", () => {
		  document.getElementById("startModal").style.display = "none";
		
		});


		document.getElementById("cancelGameBtn").addEventListener("click", () => {
		  window.location.href = "quiz/selectquiz"; 
		});
	</script>