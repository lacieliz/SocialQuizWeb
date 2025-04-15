
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<script>
	var last_num = ${count};
</script>
<script type="text/javascript" src="${quiz}setoxquiz.js">
	</script>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/quiz/setGame.css" />
	    <title>관리자 - OX 퀴즈 문제 설정</title>
	</head>
	<body> 
	
	<div id="quiz-container">
		<div class="button-container">
		   <input type="button" value="문항 추가" id="button_Add">
		   <input type="button" value="설정 완료" onclick="modifyOX()">
		</div>
		
		<table border="1" name="table_list">
		    <tr>
		      	<th> 문항번호 </th>
		      	<th> 문제 </th>
		      	<th> 정답 </th>
		      	<th> 점수 </th>
		      	<td> 삭제 </td>
		    </tr>
			<c:forEach var="set" items="${dtos}">
		<tr name="tr_QnA${set.quiz_id}">
				<td name="id_QnA${set.quiz_id}" align="center" >${set.quiz_id}</td>
				<td><input type="text" value="${set.question}" name="Q" required placeholder="문제를 입력하세요."></td>
				<td>
				<c:choose>
				<c:when test="${set.answer eq 'O'}">
					<input type="radio" value="O" name="answer${set.quiz_id}" checked/> O&nbsp;
					<input type="radio" value="X" name="answer${set.quiz_id}" /> X&nbsp;
				</c:when>
				<c:otherwise>
					<input type="radio" value="O" name="answer${set.quiz_id}" /> O&nbsp;
					<input type="radio" value="X" name="answer${set.quiz_id}" checked/> X&nbsp;
				</c:otherwise>
				</c:choose>

				</td>
				<td>
			        <input type="number" min="10" max="300" step="10" value="${set.quiz_score}" 
			        	name="S">
				</td>
				<td>
			        <input type="button" value="삭제" name="btn_delete" id="${set.quiz_id}" onclick="delete_btn(this.id)">
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	</body>
</html>

