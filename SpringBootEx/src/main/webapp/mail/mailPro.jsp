<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>   

<c:if test="${result == 0}">
    <script type="text/javascript">
        alert(" 인증 실패! 인증번호를 다시 확인해주세요.");
        history.back(); // 이전 페이지로 돌아가기 (선택사항)
    </script>
</c:if>

<c:if test="${result == 1}">
<script type="text/javascript">	
  	alert("인증 성공! ");
  	   </script>
    <c:redirect url="/logonmain" />
</c:if>
