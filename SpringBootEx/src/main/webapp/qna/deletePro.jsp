<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<script type="text/javascript" src="${qna}script_qna.js"></script>
<h2>${page_delete}</h2>

<c:choose>
	<c:when test="${result eq -2}">
		<script type="text/javascript">
			alert("작성자만 삭제할 수 있습니다.");
			history.back();
		</script>
	</c:when>
	<c:when test="${result eq -1}">
		<script type="text/javascript">
			alert(error_reply);
		</script>
		<c:if test="${memId eq 'fruit'}">
			<meta http-equiv="refresh" content="0; url=qnalist?pageNum=${pageNum}">
		</c:if>
		<c:if test="${memId ne 'fruit'}">
			<meta http-equiv="refresh" content="0; url=qnamylist?pageNum=${pageNum}">
		</c:if>
	</c:when>

	<c:when test="${result eq 0}">
		<script type="text/javascript">
			alert(error_delete);
		</script>
		<c:if test="${memId eq 'fruit'}">
			<meta http-equiv="refresh" content="0; url=qnalist?pageNum=${pageNum}">
		</c:if>
		<c:if test="${memId ne 'fruit'}">
			<meta http-equiv="refresh" content="0; url=qnamylist?pageNum=${pageNum}">
		</c:if>
		
	</c:when>

	<c:when test="${result eq 1}">
		<c:if test="${memId eq 'fruit'}">
			<c:redirect url="qnalist?pageNum=${pageNum}" />
		</c:if>
		<c:if test="${memId ne 'fruit'}">
			<c:redirect url="qnamylist?pageNum=${pageNum}" />
		</c:if>
	</c:when>
</c:choose>
