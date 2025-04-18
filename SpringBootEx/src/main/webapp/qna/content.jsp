<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="../setting.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="${qna}content.css">
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
		<form id="deletePro" method="post" action="/qnadelete">
	  		<input type="hidden" name="num" value="${num}">
	  		<input type="hidden" name="pageNum" value="${pageNum}">
		</form>
		<c:if test="${memId eq 'fruit'}">
		    <input class="inputbutton" type="button" value="답글" 
		    onclick="location='qnareply?num=${qnaDto.num}&ref=${qnaDto.ref}&re_step=${qnaDto.re_step}&re_level=${qnaDto.re_level}'">
		</c:if>
			<input  class="inputbutton" type="button" value="삭제" onclick="submitDeleteForm()">
			
			
			<c:if test="${memId eq 'fruit'}">
				<input class="inputbutton" type="button" value="${btn_list}"
								onclick="location='qnalist'">
			</c:if>
			<c:if test="${memId ne 'fruit'}">
			<input class="inputbutton" type="button" value="${btn_list}"
				onclick="location='qnamylist'">
			</c:if>

	</th>
</tr>
</table>

<script>

document.addEventListener("DOMContentLoaded", () => {
	  document.querySelector("table").addEventListener("click", function (e) {
	    const target = e.target.closest("a");
	    if (target && target.getAttribute("href")?.startsWith("qnacontent")) {
	      e.preventDefault();
	      const url = target.getAttribute("href");
	      $("#main-content").load(url); 
	    }
	  });
	});
function submitDeleteForm() {
    if (confirm("정말 삭제하시겠습니까?")) {
      document.getElementById("deletePro").submit();
    }
  }
	
	
</script>
