<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="../setting.jsp" %>
<link rel="stylesheet" type="text/css" href="${qna}replyform.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<h2>${page_write}</h2>
<br>

<form name="writeform" method="post" action="qnawrite">
	
	<input type="hidden" name="num" value="${num}">
	<input type="hidden" name="ref" value="${ref}">
	<input type="hidden" name="re_step" value="${re_step}">
	<input type="hidden" name="re_level" value="${re_level}">
	
	<table>
		<tr>
			<th colspan="2" style="text-align: right;">
				<a href="qnalist">${str_list}&nbsp;&nbsp;&nbsp;</a>
			</th>
		</tr>
		<tr>
			<th>${str_writer}</th>
			<td>
				<input class="input" type="text" name="userId" value="${sessionScope.memId}" readonly>
			</td>
		</tr>
		<tr>
		    <th>${str_subject}</th>
		    <td>
		        <c:choose>
		            <c:when test="${not empty param.subject}">
		                <input class="input" type="text" name="subject" maxlength="100" 
		                       value="re: ${fn:escapeXml(param.subject)}" readonly>
		            </c:when>
		            <c:otherwise>
		                <input class="input" type="text" name="subject" maxlength="100">
		            </c:otherwise>
		        </c:choose>
		    </td>
		</tr>
		<tr>
			<th>${str_content}</th>
			<td>
				<textarea name="content" rows="10" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input class="inputbutton" type="submit" value="${btn_write}">
				<input class="inputbutton" type="reset" value="${btn_cancle}">
				<input class="inputbutton" type="button" value="${btn_list}"
					onclick="history.back()">
			</th>
		</tr>
	</table>
</form>
