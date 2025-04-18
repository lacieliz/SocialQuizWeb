<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="/quiz/oxquiz.js"></script>

<c:if test="${result eq 0}">
	<script type="text/javascript">
		erroralert( "DB 저장 실패" );
	</script>
</c:if>
<c:if test="${result eq 1}">
	<c:redirect url="selectquiz"/>		
</c:if>

