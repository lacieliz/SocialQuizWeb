<%@ page language = "java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html>
	<head>
		<title>
			웹소켓 채팅
		</title>
		<style>
		  #chatWindow {
		    border: 1px solid black;
		    width: 300px;
		    height: 300px;
		    overflow-y: scroll;
		    padding: 10px;
		    background-color: #fff;
		  }
		
		    .myMsg {
		    text-align: right;
		    color: blue;
		    font-weight: bold;
		    margin: 5px;
		  	}
		
		  .otherMsg {
		    text-align: left;
		    color: black;
		    margin: 5px;
			}
		</style>
		
		<script>
			var host = location.hostname;
			var webSocket = new WebSocket("ws://" + host + ":8080/ChatingServer"); // 192.168.0.84
			
			window.onload = function(){
				const chatIdInput = document.getElementById("nickname");
			    if (chatIdInput) {
			        console.log("nickname 값: " + chatIdInput.value); // 확인 로그
			    } else {
			        console.error("❌ nickname input element를 찾을 수 없음!");
			    }
			}
			function sendMessage(){
				var nickname = document.getElementById("nickname").value || "익명";
				var chatMessage = document.getElementById("chatMessage");
				var chatWindow = document.getElementById("chatWindow");
				
				const msg = chatMessage.value;
				if (msg) {
					chatWindow.innerHTML +="<div class='myMsg'>" + msg + "</div>"
					webSocket.send( nickname + "|" + msg );
					msg.value = "";
					chatMessage.value = "";
					chatMessage.focus();
					chatWindow.scrollTop = chatWindow.scrollHeight;
				}
			}
			function disconnect(){
				webSocket.close();
			}
			function enterKey(){
				if(window.event.keyCode == 13){
					sendMessage();
				}
			}
			
			webSocket.onopen = function(event){
				const chatWindow = document.getElementById("chatWindow");
			    const nickname = document.getElementById("nickname").value;
			    
				chatWindow.innerHTML += "라이어 게임방에 입장하셨습니다.<br/>";
				webSocket.send("JOIN|Chat|" + nickname);
			};
			
			webSocket.onclose = function(event){
				chatWindow.innerHTML += "라이어 게임을 종료합니다.<br/>";
			};
			webSocket.onerror = function(event){
				alert(event.data);
				chatWindow.innerHTML += "게임 중 에러가 발생하였습니다.<br/>";
			};
			
			webSocket.onmessage = function(event){
			    const chatWindow = document.getElementById("chatWindow");
			    const nickname = document.getElementById("nickname").value;
			    
			    console.log("📩 서버에서 받은 메시지:", event.data);

			    const message = event.data.split("|");
			    
			    if (message.length === 1) {
			        chatWindow.innerHTML += "<div class='otherMsg'>" + message[0] + "</div>";
			    }
			    else {
			        const sender = message[0];
			        const content = message[1] || "";	// undefined 방지
				    if (content !== "") {
				        // 나 자신이면 오른쪽 정렬
				        if (sender === nickname) {
				            chatWindow.innerHTML += "<div class='myMsg'>" + content + "</div>";
				        }
				        // 귓속말 처리
				        else if (content.includes("/" + nickname)) {
				            const temp = content.replace("/" + nickname, "[귓속말] : ");
				            chatWindow.innerHTML += "<div class='otherMsg'>" + sender + " " + temp + "</div>";
				        }
				        // 일반 메시지
				        else {
				            chatWindow.innerHTML += "<div class='otherMsg'>" + sender + " : " + content + "</div>";
				        }
				    }
			    }

			    chatWindow.scrollTop = chatWindow.scrollHeight;
			};
		</script>
		
	</head>
	<body>
		<h3> 끝말잇기 게임방 </h3>
		<input type="text" id="nickname" value="${memId}" readonly />
		<div id="chatWindow" style="border:1px solid #ccc; height:300px; overflow:auto; margin-bottom:10px;"></div>
		<input type="text" id="chatMessage" onkeyup="enterKey(event);"/>
		<button id="sendBtn" onclick="sendMessage();">전송</button>
		<button id="closeBtn" onclick="disconnect();">채팅 종료</button>
	</body>
</html>
	