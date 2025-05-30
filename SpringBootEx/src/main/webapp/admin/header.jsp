<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link type="text/css" rel="stylesheet" href="${logon}header.css">
<link rel="icon" href="${logon}images/q.png" type="image/png">
<title>Social Quiz</title>


<header>

	<div class="header">
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		</button>
		<div class="header-inner">
		    <div class="logo">
		      <img src="${logon}images/socialQuiz.png" alt="로고" height="50">
		      <span class="logo-text">SQW</span>
		    </div>
		    
		    	<ul class="nav-menu">
			      <li class="nav-item"><a class="nav-link active" href="/admin">관리자 홈</a></li>
			      <li class="nav-item"><a class="nav-link" href="/setoxgame">O/X게임 문제 설정</a></li>
			      <li class="nav-item"><a class="nav-link" href="/rank">랭킹</a></li>
			      <li class="nav-item"><a class="nav-link" href="/qnalist">문의게시판</a></li>
			      <li class="nav-item"><a class="nav-link" href="/boardlist">공지사항</a></li>
			      <li class="nav-item"><a class="nav-link" href="/acitivemems">접속자 조회</a></li>
			    </ul>
		    
			<div class="header-buttons">
				<c:if test="${memId eq null}">
					<button type="button" class="btn btn-outline-dark" onclick="location='/logon'">로그인</button>
	 	   		</c:if>
	 	   		<c:if test="${memId ne null}">
				    <button type="button" class="btn btn-outline-dark" onclick="location='/logout'">로그아웃</button>
					&nbsp;	
				</c:if>
		    </div>
		</div>
	</div>
</header>