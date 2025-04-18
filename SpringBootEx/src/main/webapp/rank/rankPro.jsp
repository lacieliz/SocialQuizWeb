<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<script type="text/javascript" src="${logon}script_member.js"></script>    
<h2> ${page_rank} </h2>

<c:if test="${result eq 0}">
	<script type="text/javascript">
		erroralert( errorr_input );
	</script>
</c:if>
<c:if test="${result eq 1}">
	<c:redirect url="quiz/startox"/>		
</c:if>
