<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<script type="text/javascript" src="${logon}script_member.js">

</script>    

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${logon}main.css">
	</head>

	<body>
	
	<!-- Nav-Bar -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	  
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="/home">${page_main}</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="quiz/startox">O/X게임</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="quiz/startword">끝말잇기</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#">랭킹</a>
	        </li>
	        
	       </ul>
	      <a class="navbar-brand" href="#">	      
		  	<img src="${logon}images/socialQuiz.png" alt="img" class="center-img">
		  </a>

	      &nbsp;&nbsp;
		      <form class="d-flex" role="search">
		        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
		        <button class="btn btn-outline-success" type="submit">Search</button>
		      </form>
	    </div>
	    &nbsp;&nbsp;
	    <div>
	    	<form>
	    
	   <c:if test="${memId eq null}">
	    	<button type="button" class="btn btn-outline-dark" onclick="location='logon'">로그인</button>
	 	    <button type="button" class="btn btn-outline-dark" onclick="location='signup'">회원가입</button>
	    	&nbsp;		
		</c:if> 	
	    	
	    	
	    	
    	<c:if test="${memId ne null}">
	    	<button type="button" class="btn btn-outline-dark" onclick="location='logout'">로그아웃</button>
			<button type="button" class="btn btn-outline-dark" onclick="location='mypage'">마이페이지</button>
			&nbsp;	
		</c:if>
	    	
	    	
</form>
	    </div>
	  </div>
	</nav>
	
	<div class="container">
		<div class="div1"> </div>
		<div class="div2">
		<a href="quiz/selectquiz" >추천게임 </a> 
		
		</div>
		<img src="${logon}images/teamFruit.jpg" alt="img" class="image" >
		<div class="div3"> 
			<h1 class="home"> 실시간 순위 </h1>  			           
		</div>	
		<div class="div4" name="loginSession">
<c:if test="${memId eq null}">
	<p class="d-inline-flex gap-1">
			  <button type="button" class="btn btn-primary" data-bs-toggle="button" onclick="location='logon'">
			  	로그인
				  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0z"/>
					  <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
					</svg>
				</button>
			</p>	
</c:if>

<c:if test="${memId ne null}">		
</c:if>
		</div>
		<div class="div5">
		<a href="boardlist">
			<span > 소식 </span>
		</a>
		</div>
		<div class="div6">
			<a href="qnalist">
				<span > 1대1 게시판 </span>
			</a>
		</div>
		<div class="div7">
		</div>
		
	</div>










