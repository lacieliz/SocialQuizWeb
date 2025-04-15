<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
  <!-- 우측 상단 버튼 영역 -->
  <div class="position-absolute top-0 end-0 m-3 d-flex gap-2">
    <a href="/home" class="btn btn-outline-primary">메인페이지</a>
  </div>

<!-- OX 게임 -->
<div class="container mt-5">
  <div class="position-relative mt-4 p-5 bg-primary text-white rounded" onclick="location='startox'">
    <a href="#" class="btn btn-sm btn-light position-absolute top-0 end-0 m-2"
       onclick="event.stopPropagation()">ⓘ</a>
    <h1>OX게임</h1>
    <p>맞으면 O! 틀리면 X!</p>
  </div>
</div>

<!-- 끝말잇기 게임 -->
<div class="container mt-3">
  <div class="position-relative mt-4 p-5 bg-primary text-white rounded" onclick="location='startword'">
    <a href="#" class="btn btn-sm btn-light position-absolute top-0 end-0 m-2"
       onclick="event.stopPropagation()">ⓘ</a>	<!--event.stopPropagation() 이게 없으면 부모 버튼인 startword가 같이 실행되어서 일케 써야만 함  -->
    <h1>끝말잇기 게임</h1>
    <p>(2인용) 끝말로 시작하는 단어를 입력!</p>
  </div>
</div>

<!-- 라이어 게임 -->
<div class="container mt-3">
  <div class="position-relative mt-4 p-5 bg-primary text-white rounded" onclick="location='apiliar'">
    <a href="#" class="btn btn-sm btn-light position-absolute top-0 end-0 m-2"
       onclick="event.stopPropagation()">ⓘ</a>
    <h2>라이어 게임</h2>
    <p>(4인용) 제시어를 받지 못한 자를 찾아라!</p>
  </div>
</div>

<!-- 행맨 게임 -->
<div class="container mt-3">
  <div class="position-relative mt-4 p-5 bg-primary text-white rounded" onclick="location='starthangman'">
    <a href="#" class="btn btn-sm btn-light position-absolute top-0 end-0 m-2"
	       onclick="event.stopPropagation()">ⓘ</a>
    <h2>행맨 게임</h2>
    <p>단어의 철자를 하나씩 추측하여 제한된 기회 안에 단어를 맞혀라!</p>
  </div>
</div>

