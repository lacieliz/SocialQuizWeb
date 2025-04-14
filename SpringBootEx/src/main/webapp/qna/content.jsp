<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
	<%@ include file="../setting.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${qna}style_qna.css">
<script type="text/javascript" src="${qna}script_qna.js"></script>

<h2>${page_content}</h2>
<br>

<table>
	<tr>	
		<th >${str_subject}</th>
		<td colspan="5">${qnaDto.subject}</td>
	</tr>
	<tr>
		<th style="width:150px;">${str_num}</th>
		<td style="text-align: center; width:200px">${number}</td>
		<th>${str_writer}</th>
		<td style="text-align: center;">${qnaDto.userId}</td>  <!-- 수정된 부분 -->
		<th>${str_reg_date}</th>
		<td style="text-align: center;">
			<fmt:formatDate type="both" value="${qnaDto.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
		</td>
	</tr>
	<tr>
		<th>${str_content}</th>
		<td colspan="5"><pre>${qnaDto.content}</pre></td>
	</tr>
	<tr>	
	<th colspan="6">

			<input class="inputbutton" type="button" value="${btn_delete}"
				onclick="location='qnadelete?num=${num}&pageNum=${pageNum}'">
			<input class="inputbutton" type="button" value="${btn_reply}"
				onclick="location='qnareply?num=${qnaDto.num}&ref=${qnaDto.ref}&re_step=${qnaDto.re_step}&re_level=${qnaDto.re_level}&subject=${qnaDto.subject}'">
			<input class="inputbutton" type="button" value="${btn_list}"
				onclick="history.back()">

	</th>
</tr>
</table>
