<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<script type="text/javascript" src="${logon}script_member.js"></script>    
<h2> ${page_input} </h2>

<c:if test="${result eq 0}">
	<script type="text/javascript">
		erroralert( error_input );
	    history.back();
	</script>
</c:if>
<c:if test="${result eq 1}">
	<c:redirect url="logon"/>		
</c:if>

<c:if test="${result eq 2}">
		<script type="text/javascript">
		erroralert( msg_confirm_user_id );
	    history.back();
	</script>
</c:if>

<c:if test="${result eq 3}">
		<script type="text/javascript">
		erroralert( msg_confirm_nickname );
	    history.back();
	</script>	
</c:if>

<c:if test="${result eq 4}">
		<script type="text/javascript">
		erroralert( msg_confirm_email_auth );
	    history.back();
	</script>	
</c:if>













