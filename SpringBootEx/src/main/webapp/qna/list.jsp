<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/qna/viewqna.css">
<script type="text/javascript" src="/qna/script_qna.js"></script>

<h2>1대1 게시판</h2>
<br>

<table>
	<tr>
		<td colspan="5" class="input center-content"> 
			<div class="search-container">
				<!-- 메인페이지 버튼 -->
				<c:choose>
				    <c:when test="${memId eq 'fruit'}">
				        <button class="button" onclick="location.href='/admin'">메인페이지</button>
				    </c:when>
				    <c:otherwise>
				        <button class="button" onclick="location.href='/home'">메인페이지</button>
				    </c:otherwise>
				</c:choose>
			</div>
		</td>
	</tr>
	<tr>
		<th style="width:7%">${str_num}</th>
		<th style="width:40%">${str_subject}</th>
		<th style="width:13%">${str_writer}</th>
		<th style="width:15%">${str_reg_date}</th>
		<th style="width:10%"> 답변 여부 </th>
	</tr>

	<c:if test="${count eq 0}">
		<tr>
			<td colspan="5" style="text-align: center;">${msg_list_x}</td>
		</tr>
	</c:if>

	<c:if test="${count ne 0}">
		<c:set var="number" value="${number}" />
		<c:forEach var="dto" items="${dtos}">
			<tr>
				<td style="text-align: center;">
					${number}
					<c:set var="number" value="${number - 1}" />
				</td>
				<td>
					<c:if test="${dto.re_level gt 1}">
						<c:set var="wid" value="${(dto.re_level - 1) * 10}" />
						<img src="${pageContext.request.contextPath}images/level.gif" width="${wid}" height="15">
					</c:if>
					<c:if test="${dto.re_level gt 0}">
						<img src="${pageContext.request.contextPath}images/re.gif" width="20" height="15">
					</c:if>
					<a href="qnacontent?num=${dto.num}&pageNum=${pageNum}&number=${number + 1}">
						${dto.subject}
					</a>
				</td>
				<td style="text-align: center;">${dto.userId}</td> <!-- 수정된 부분 -->
				<td style="text-align: center;">
					<fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd HH:mm" />
				</td>
				<td align="center">
					<c:choose>
						<c:when test="${dto.re_level eq 0}">
							<c:choose>
								<c:when test="${dto.replyCount gt 0}">
									<span style="color: green; font-weight: bold;">답변완료</span>
								</c:when>

								<c:otherwise>
									<button onclick="location='qnacontent?num=${dto.num}&pageNum=${pageNum}&number=${number + 1}'">답변</button>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<!-- 답글인 경우는 답변 여부 칸 비워둠 -->
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:if>
</table>
<br>
<center>
	<c:if test="${count gt 0}">
		<c:if test="${startPage gt pageBlock}">
			<a href="qnalist">[◀◀]</a>
			<a href="qnalist?pageNum=${startPage - pageBlock}">[◀]</a>
		</c:if>

		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
				<c:when test="${i eq currentPage}">
					<b>[${i}]</b>
				</c:when>
				<c:otherwise>
					<a href="qnalist?pageNum=${i}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${pageCount gt endPage}">
			<a href="qnalist?pageNum=${startPage + pageBlock}">[▶]</a>
			<a href="qnalist?pageNum=${pageCount}">[▶▶]</a>
		</c:if>
	</c:if>
</center>
