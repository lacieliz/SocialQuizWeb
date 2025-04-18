<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<script type="text/javascript" src="${qna}script_qna.js"></script>

<h2>${page_write}</h2>

<c:choose>
	<c:when test="${result eq 0}">
		<script type="text/javascript">
			alert(error_write);
		</script>
		<meta http-equiv="refresh" content="0; url=mypage">
	</c:when>

	<c:when test="${result eq 1}">
		<c:if test="${memId eq 'fruit'}">
			<c:redirect url="qnalist" />
		</c:if>
		<c:if test="${memId ne 'fruit'}">
			<c:redirect url="mypage" />
		</c:if>
		
	</c:when>
</c:choose>
