<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<link type="text/css" rel="stylesheet" href="${quiz}wordgame.css">
<script type="text/javascript" src="${quiz}wordquiz.js"></script>   

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>끝말잇기 게임</title>
</head>
<body>
  <div class="top-right-btn">
    <button onclick="restartGame()">다시하기</button>
    <button id="exitBtn" onclick="exit()">나가기</button>
  </div>

  <div class="timer">Timer: <span id="timeout"></span></div>
		   
  <div class="used-words-box">
    <h3>입력한 단어</h3>
    <ul id="usedWordsList"></ul>
  </div>

  <div class="game-container">
    <input type="text" name="show_word" class="word-display" readonly />
    <input type="text" name="user_input" class="word-input" autofocus />
  </div>

  <div name="definition" class="definition-box"></div>

</body>
</html>
