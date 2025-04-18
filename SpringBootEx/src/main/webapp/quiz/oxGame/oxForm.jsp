<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="/quiz/oxquiz.js"></script>

<html>
<!-- 퀴즈 설명 모달 -->
<div id="startModal" class="modal">
  <div class="modal-content">
    <h3> OX 퀴즈 설명</h3>
    <p style="margin-bottom: 15px; line-height: 1.6;">
      총 10문제가 출제됩니다.<br>
      문제당 제한 시간은 10초이며,<br>
      <b>O 또는 X 버튼</b>을 눌러 정답을 선택하세요.<br>
      제한 시간 초과 시 자동으로 다음 문제로 넘어갑니다.
    </p>
    <div style="display: flex; justify-content: center; gap: 10px;">
      <button id="startGameBtn" class="modal-btn">시작</button>
      <button id="cancelGameBtn" class="modal-btn">돌아가기</button>
    </div>
  </div>
</div>

</div>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="oxForm.css" />
	    <title>퀴즈 게임</title>
	</head>
	<body>
		<input type="hidden" id="userId" value="${memId}" />
		   <div class="timer">Timer: <span id="timeout"></span></div>
		 <div class="header-buttons">
		        <button id="restartBtn">다시하기</button>
		        <button id="exitBtn" onclick="location='selectquiz'">나가기</button>
		    </div>
		    
		<div class="quiz-container">
		    <div class="question"></div>
		    <div class="options">
		        <div class="btn_O">O</div>
		        <div class="btn_X">X</div>
		    </div>
		    <p id="result"></p>
		</div>
		
</body>

</html>
