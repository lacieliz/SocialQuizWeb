<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/qna/viewqna.css">
<script type="text/javascript" src="/qna/script_qna.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h2>내 문의</h2>
<br>	

<form id="searchForm" method="post" action="qnamylist">
<table>
	<tr>
		<td colspan="5" class="input center-content"> 
			<div class="search-container">
 					 <input type="text" name="query" placeholder="검색어를 입력해주세요" required>
  					<button type="submit">검색</button>	
				<button class="button" onclick="location.href='home'">메인페이지</button>
			</div>
		</td>
	</tr>
	<tr>
		<th style="width:7%">${str_num}</th>
		<th style="width:40%">${str_subject}</th>
		<th style="width:13%">${str_writer}</th>
		<th style="width:15%">${str_reg_date}</th>
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
				    <!-- 답글 레벨이 1 이상이면 들여쓰기용 level.gif 출력 -->
				    <c:if test="${dto.re_level gt 1}">
				        <c:set var="wid" value="${(dto.re_level - 1) * 10}" />
				        <img src="${pageContext.request.contextPath}/images/level.gif" width="${wid}" height="15">
				    </c:if>

				    <!-- 답글 레벨이 0 초과면 re 아이콘 출력 -->
				    <c:if test="${dto.re_level gt 0}">
				        <img src="${pageContext.request.contextPath}/images/re.gif" width="20" height="15">
				    </c:if>

				    <!-- 제목 링크 -->
				    <a href="qnacontent?num=${dto.num}&pageNum=${pageNum}&number=${number + 1}">
				        ${dto.subject}
				    </a>
				</td>


				<td style="text-align: center;">${dto.userId}</td> <!-- 수정된 부분 -->
				<td style="text-align: center;">
					<fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd HH:mm" />
				</td>
			</tr>
		</c:forEach>
	</c:if>
</table>
</form>
<br>

<center>
	<c:if test="${count gt 0}">
		<c:if test="${startPage gt pageBlock}">
			<a href="qnamylist">[◀◀]</a>
			<a href="qnamylist?pageNum=${startPage - pageBlock}">[◀]</a>
		</c:if>

		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
				<c:when test="${i eq currentPage}">
					<b>[${i}]</b>
				</c:when>
				<c:otherwise>
					<a href="qnamylist?pageNum=${i}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${pageCount gt endPage}">
			<a href="qnamylist?pageNum=${startPage + pageBlock}">[▶]</a>
			<a href="qnamylist?pageNum=${pageCount}">[▶▶]</a>
		</c:if>
	</c:if>
</center>

<script>
$(document).ready(function () {
  // 검색 Ajax 처리
  $("#searchForm").on("submit", function (e) {
    e.preventDefault(); // 기본 form 제출 막기

    const queryData = $(this).serialize(); // form 데이터 직렬화

    $.ajax({
      type: "POST",
      url: "qnamylist",
      data: queryData,
      success: function (html) {
        $("#main-content").html(html); // 결과를 main-content에 출력
      },
      error: function () {
        alert("검색 중 오류가 발생했습니다.");
      }
    });
  });

