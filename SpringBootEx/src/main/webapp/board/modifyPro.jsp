<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${board_modify}</h2>

<c:choose>
	<c:when test="${result eq -2}">
		<script type="text/javascript">
			alert("작성자만 수정할 수 있습니다.");
			history.back();
		</script>
	</c:when>
	<c:when test="${result eq 0}">
		<script type="text/javascript">
			alert(error_modify);
		</script>
		<meta http-equiv="refresh" content="0; url=boardlist?pageNum=${pageNum}">
	</c:when>
	<c:when test="${result eq 1}">
		<c:redirect url="boardlist?pageNum=${pageNum}" />
	</c:when>
</c:choose>
