<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${qna}qnaform.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의하기</title>
    
</head>
<body>

    <div class="qna-container">
        <h1 class="qna-title">1:1 문의하기</h1>

        <form action="qnawrite" method="post" enctype="multipart/form-data" class="qna-form">

            <div class="form-group">
                <label for="name">${str_writer}</label>
                <input type="text" id="name" name="userId" value="${sessionScope.memId}" readonly required>
            </div>

            <div class="form-group">
                <label for="title">문의 내용*</label>
                <input type="text" id="title" name="subject" placeholder="제목을 입력해주세요" required>
            </div>

            <div class="form-group">
                <textarea id="content" name="content" placeholder="문의 내용을 자세히 입력해주세요"
                          rows="5" maxlength="5000" oninput="updateCounter()" required></textarea>
                <div class="char-counter">
                    <span id="charCount">0</span>/5000
                </div>
            </div>

            <div class="form-group">
                <label for="file">첨부 파일</label>
                <input type="file" id="file" name="file" placeholder="파일을 등록해주세요">
            </div>

            <div class="form-group">
                <button type="submit" class="submit-btn">문의하기</button>
            </div>
        </form>
    </div>

</body>
</html>