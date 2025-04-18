<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/quiz/wordgame.css">
<script src="/quiz/wordquiz.js"></script>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>끝말잇기 게임</title>
</head>
<body>
  <!-- 시작 모델 -->
  <div id="startModal" class="modal">
    <div class="modal-content">
      <h3> 끝말잇기 게임 설명</h3>
      <p style="margin-bottom: 15px; line-height: 1.6;">
        제시어의 마지막 글자로 시작하는 단어를 입력하세요.<br>
        <b>명사만 인정</b>되며, 두음법칙도 적용됩니다.<br>
        입력 시간은 10초이며, <br>
        제한 시간 내 입력하지 못하면 게임이 종료됩니다.<br>
        같은 단어는 다시 입력할 수 없습니다.
      </p>
      <div style="display: flex; justify-content: center; gap: 10px;">
        <button id="singleGameBtn" class="modal-btn">싱글플레이</button>
        <button id="multiGameBtn" class="modal-btn">멀티플레이</button>
        <button id="cancelGameBtn" class="modal-btn">돌아가기</button>
      </div>
    </div>
  </div>

  <!-- 사용자 ID -->
  <input type="hidden" id="userId" value="${sessionScope.memId}">

  <!-- 포인트 버튼 -->
  <div class="top-right-btn">
    <button onclick="restartGame()">다시하기</button>
    <button id="exitBtn" onclick="exit()">나가기</button>
  </div>

  <!-- 점수 -->
  <div class="score-box" id="scoreDisplay">
    <span>점수</span>
    <strong>0</strong>
  </div>

  <!-- 타이머 -->
  <div class="timer">Timer: <span id="timeout"></span></div>

  <!-- 입력된 단어 -->
  <div class="used-words-box">
    <h3>입력한 단어</h3>
    <ul id="usedWordsList"></ul>
  </div>

  <!-- 게임 하나하나 보여준은 포맷 -->
  <div class="game-container">
    <input type="text" name="show_word" class="word-display" readonly />
    <input type="text" name="user_input" class="word-input" autofocus />
  </div>

  <!-- 정의어 보여주는 포맷 -->
  <div name="definition" class="definition-box"></div>
  
  <div id="flash" class="flash-screen" style="display: none;"></div>
  <div id="flashRed" class="flash-red" style="display: none;"></div>
</body>
</html>