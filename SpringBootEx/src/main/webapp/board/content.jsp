<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
	<%@ include file="../setting.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${board}style_board.css">
<script type="text/javascript" src="${board}script_board.js"></script>

<h2>${board_content}</h2>
<br>

<table>
	<tr>
		<th style="width:150px;">${str_num}</th>
		<td style="text-align: center; width:200px">${number}</td>
		<th style="width:150px;">${str_readcount}</th>
		<td style="text-align: center; width:200px">${boardDto.readcount}</td>
	</tr>
	<tr>
		<th>${str_writer}</th>
		<td style="text-align: center;">${boardDto.userId}</td>  <!-- 수정된 부분 -->
		<th>${str_reg_date}</th>
		<td style="text-align: center;">
			<fmt:formatDate type="both" value="${boardDto.reg_date}" pattern="yyyy-MM-dd HH:mm" />
		</td>
	</tr>
	<tr>	
		<th>${str_subject}</th>
		<td colspan="3">${boardDto.subject}</td>
	</tr>
	<tr>
		<th>${str_content}</th>
		<td colspan="3"><pre>${boardDto.content}</pre></td>
	</tr>
	<tr>
	<th colspan="4">

		<%-- 로그인한 사용자와 작성자가 같을 때만 보여지는 수정/삭제 버튼 --%>
		<c:if test="${sessionScope.memId eq boardDto.userId}">
			<input class="inputbutton" type="button" value="${btn_modify}"
				onclick="location='boardmodify?num=${num}&pageNum=${pageNum}'">
			<input class="inputbutton" type="button" value="${board_btn_del}"
				onclick="location='boarddelete?num=${num}&pageNum=${pageNum}'">
		</c:if>

		<%-- 모든 사용자에게 보여지는 버튼 --%>
		<input class="inputbutton" type="button" value="${btn_list}"
			onclick="location='boardlist?pageNum=${pageNum}'">

	</th>
</tr>
</table>
