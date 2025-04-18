<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${board_write}</h2>

<c:choose>
	<c:when test="${result eq 0}">
		<script type="text/javascript">
			alert(error_write);
			history.back();
		</script>
		<meta http-equiv="refresh" content="0; url=boardlist">
	</c:when>

	<c:when test="${result eq 1}">
		<c:redirect url="boardlist" />
	</c:when>
	
	<c:when test="${isEmpty eq 1}">
			<script type="text/javascript">
				alert("제목 또는 내용을 입력해주세요!");
				history.back();
			</script>
			<meta http-equiv="refresh" content="0; url=boardlist">
		</c:when>
</c:choose>
