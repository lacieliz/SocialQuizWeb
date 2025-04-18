<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<script type="text/javascript" src="${logon}script_member.js">
</script>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${logon}main.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" />
	<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
	
	</head>
	<body>
	<%@ include file="header.jsp" %>

	<div class="container">
		<div class="div1">Welcome to Social Quiz!</div>

		<div class="div2">
		<a href="quiz/selectquiz" >추천게임 </a>
		<a href="/quiz/startox" class="game-card">
		  <img src="/images/oxbutton.png" alt="OX 게임" class="icon-img">
		  <span class="game-title">OX게임</span>
		</a>

		<a href="/quiz/startword" class="game-card">
		  <img src="/images/wordbutton.png" alt="끝말잇기" class="icon-img">
		  <span class="game-title">끝말잇기</span>
		</a>
		<a href="/socketword" class="game-card">
		  <img src="/images/liarbutton.png" alt="라이어게임" class="icon-img">
		  <span class="game-title">라이어게임</span>
		</a>
		</div>
		
		<div class="div3"> 
			<a href="/rank">
			<span > 실시간 순위 </span>
			</a>
		    <jsp:include page="rankView.jsp" flush="true" />		           
		</div>	
		<div class="testest" name="loginSession" style="overflow-y:scroll; max-height:100%; 
		width: 200%; object-fit:fill;">
			<a href="/acitivemems">
			<span> 현재 접속 회원 </span>
			</a>
			<div >
			<jsp:include page="activeMemsMini.jsp" flush="true" />
			</div>
		
		</div>
		<div class="div5">
		<a href="boardlist">
			<span > 공지사항 </span>
		</a>
		<!-- 공지사항 목록 JSP 삽입 -->
   			 <jsp:include page="noticeMini.jsp" flush="true" />
		</div>
		<div class="div6">
			<a href="qnalist">
				<span > 1대1 문의 내역 </span>
			</a>
			<!-- 1대1문의 목록 JSP 삽입 -->
   			 <jsp:include page="qnaMini.jsp" flush="true" />
		</div>
		<div class="div7">
		</div>
		
	</div>
<%@ include file="footer.jsp" %>
