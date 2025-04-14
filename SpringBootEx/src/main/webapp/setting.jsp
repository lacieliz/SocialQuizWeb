<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--logon-->
<c:set var="logon" value="/logon/"/>

<c:set var="logon_main" value="메인페이지"/>
<c:set var="logon_input" value="회 원 가 입"/>
<c:set var="logon_confirm" value="아이디 중복 확인"/>
<c:set var="logon_login" value="로 그 인"/>
<c:set var="logon_delete" value="회 원 탈 퇴"/>
<c:set var="logon_modify" value="회원 정보 수정"/>

<c:set var="logon_msg_main" value="비회원이시면 회원가입을 해주세요"/>
<c:set var="logon_msg_login" value="님 안녕하세요"/> 
<c:set var="logon_msg_input" value="회원정보를 입력하세요"/>
<c:set var="logon_msg_confirmX" value="는 사용할 수 없습니다"/>
<c:set var="logon_msg_confirmO" value="는 사용할 수 있습니다"/>
<c:set var="logon_msg_signup" value="회원가입에 성공했습니다"/>
<c:set var="logon_msg_passwd" value="비밀번호를 다시 확인해 주세요"/>
<c:set var="logon_msg_modify" value="수정할 정보를 입력하세요"/>

<c:set var="str_user_id" value="아이디"/>
<c:set var="str_passwd" value="비밀번호"/>
<c:set var="str_nickname" value="닉네임"/>
<c:set var="str_email" value="이메일"/>
<c:set var="str_created_at" value="가입일자"/>

<c:set var="btn_login" value="로그인"/>
<c:set var="btn_ok" value="확인"/>
<c:set var="btn_cancle" value="취소"/>
<c:set var="btn_input" value="회원가입"/>
<c:set var="btn_logon_modify" value="정보수정"/>
<c:set var="btn_delete" value="회원탈퇴"/>
<c:set var="btn_logout" value="로그아웃"/>
<c:set var="btn_confirm" value="중복확인"/>
<c:set var="btn_input_cancle" value="가입취소"/>
<c:set var="btn_main" value="메인페이지"/>
<c:set var="btn_mod" value="수정"/>
<c:set var="btn_mod_cancle" value="수정취소"/>
<c:set var="btn_del" value="탈퇴"/>
<c:set var="btn_del_cancle" value="탈퇴취소"/>

<!--borad-->
<c:set var="board" value="/board/"/>

<c:set var="board_list" value="글 목 록"/>
<c:set var="board_write" value="글 작 성"/>
<c:set var="board_content" value="글 보 기"/>
<c:set var="board_modify" value="글 수 정"/>
<c:set var="board_delete" value="글 삭 제"/>

<c:set var="board_msg_list_x" value="게시판에 글이 없습니다. 글쓰기를 눌러주세요"/>
<c:set var="board_msg_passwd" value="비밀번호를 입력해주세요"/>
<c:set var="board_msg_modify" value="수정할 정보를 입력하세요"/>

<c:set var="str_count" value="전체글"/>
<c:set var="str_write" value="글쓰기"/>
<c:set var="str_num" value="글번호"/>
<c:set var="str_subject" value="글제목"/>
<c:set var="str_writer" value="작성자"/>
<c:set var="str_reg_date" value="작성일"/>
<c:set var="str_readcount" value="조회수"/>
<c:set var="str_ip" value="IP"/>
<c:set var="str_content" value="글내용"/>
<c:set var="str_list" value="글목록"/>

<c:set var="btn_write" value="작성"/>
<c:set var="btn_list" value="목록"/>
<c:set var="board_btn_modify" value="글수정"/>
<c:set var="board_btn_delete" value="글삭제"/>
<c:set var="btn_reply" value="답글"/>
<c:set var="board_btn_del" value="삭제"/>
<c:set var="board_btn_cancle" value="삭제취소"/>

<!--qna-->
<c:set var="qna" value="/qna/"/>

<c:set var="qna_list" value="글 목 록"/>
<c:set var="qna_write" value="글 작 성"/>
<c:set var="qna_content" value="글 보 기"/>
<c:set var="qna_modify" value="글 수 정"/>
<c:set var="qna_delete" value="글 삭 제"/>

<c:set var="qna_msg_list" value="게시판에 글이 없습니다. 글쓰기를 눌러주세요"/>
<c:set var="qna_msg_passwd" value="비밀번호를 입력해주세요"/>
<c:set var="qna_msg_modify" value="수정할 정보를 입력하세요"/>


    
    
    