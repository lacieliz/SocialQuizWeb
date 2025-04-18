<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<script type="text/javascript" src="${logon}script_member.js"></script>    

<c:if test="${result eq 0}">
	<script type="text/javascript">
		erroralert( error_id_incorrect );
	</script>
</c:if>

<c:if test="${result eq 1}">
	<script type="text/javascript">
		alert( msg_email_change );
		<c:redirect url="logonlogin"/>		
	</script>
</c:if>

<c:if test="${result eq 2}">
	<script type="text/javascript">
	erroralert( error_passwd_duplicate );	
	</script>
</c:if>






