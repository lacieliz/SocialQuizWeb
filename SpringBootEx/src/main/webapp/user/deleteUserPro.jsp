<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<script type="text/javascript" src="${logon}script_member.js"></script>
  
<h2> ${logon_delete} </h2>

<c:if test="${checkPwd eq 1}">
	<c:if test="${result eq 0}">	
		<script type="text/javascript">
			alert( error_delete );				
		</script>	
		<meta http-equiv="fresh" content="0; url=mypage">		
	</c:if>
	<c:if test="${result eq 1}">				
		<c:redirect url="logout"/>			
	</c:if>
</c:if>
<c:if test="${checkPwd eq 0}">
	<script type="text/javascript">
		erroralert( error_passwd );
		  $('#main-content').load('deleteuser');
	</script>
</c:if>














