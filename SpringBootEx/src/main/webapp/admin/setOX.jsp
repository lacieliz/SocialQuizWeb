<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>

<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/quiz/setGame.css" />
	    <title>관리자 - OX 퀴즈 문제 설정</title>
	</head>
	<body> 
	
	<div id="quiz-container">
		<div class="button-container">
		   <input type="button" value="문항 추가" id="button_Add">
		   <input type="button" value="설정 완료" onclick="modifyOX()">
		</div>
		
		<table border="1" name="table_list">
		    <tr>
		      	<th> 문항번호 </th>
		      	<th> 게임명 </th>
		      	<th> 문제 </th>
		      	<th> 정답 </th>
		      	<th> 점수 </th>
		      	<td> 삭제 </td>
		    </tr>
			<c:forEach var="set" items="${dtos}">
		<tr name="tr">
				<td align="center" name="quiz_id">${set.quiz_id}</td>
				<c:if test="${set.game_id eq 1}">
				   <td align="center" name="game_id">OX게임 </td>
				</c:if>
				<td><input type="text" value="${set.question}" name="question" required placeholder="문제를 입력하세요."></td>
				<td>
				<c:choose>
				<c:when test="${set.answer eq 'O'}">
					<input type="radio" value="O" name="answer${set.quiz_id}" checked/> O&nbsp;
					<input type="radio" value="X" name="answer${set.quiz_id}" /> X&nbsp;
				</c:when>
				<c:otherwise>
					<input type="radio" value="O" name="answer${set.quiz_id}" /> O&nbsp;
					<input type="radio" value="X" name="answer${set.quiz_id}" checked/> X&nbsp;
				</c:otherwise>
				</c:choose>

				</td>
				<td>
			        <input type="number" min="10" max="300" step="10" value="${set.quiz_score}" 
			        	name="quiz_score">
				</td>
				<td>
			        <input type="button" value="삭제" name="btn_delete" id="${set.quiz_id}" onclick="delete_btn(this.id)">
				</td>
			</tr>
			</c:forEach>

		</table>
	</div>
	</body>
</html>

<script type="text/javascript">
	var last_num = <%=length%>

	function setQid(id){
		let new_id = parseInt(id);
		let prev_id = new_id + 1;
		
		while(document.querySelector("td[name='id_QnA"+prev_id+"']") !=null){
			document.querySelector("td[name='id_QnA"+prev_id+"']").innerText = new_id+1;
			document.querySelector("td[name='id_QnA"+prev_id+"']").setAttribute("name","id_QnA"+new_id);
			document.querySelector("tr[name='tr_QnA"+prev_id+"']").setAttribute("name","tr_QnA"+new_id);
			document.querySelector("input[name='answer"+prev_id+"']").setAttribute("name","answer"+new_id);
			document.querySelector("input[name='answer"+prev_id+"']").setAttribute("name","answer"+new_id);
			document.querySelector("input[id='"+prev_id+"']").setAttribute("id",new_id);

			prev_id++;
			new_id++;
		}	
		last_num--;
	}

	function delete_btn(id){
	    let tr_QnA = document.querySelector("tr[name='tr_QnA"+id+"']");

	    // 화면에서도 삭제
	    tr_QnA.remove();
	    setQid(id);
	}

	 window.addEventListener(
	          "DOMContentLoaded", (event)=>{
	                	
	             let btn_Add = document.getElementById("button_Add");
	             btn_Add.addEventListener(
	                  "click", (event)=>{
	                           
	                   let table_QnA = document.querySelector("table[name='table_list']");
	                            
	                            
	                   var new_id = last_num;
	                   last_num++;
	                  
	                   let tr_QnA = document.createElement("tr");
	                   tr_QnA.setAttribute("name","tr_QnA"+new_id);
	                    
	                    let td_num = document.createElement("td");
	                    td_num.setAttribute("name","id_QnA"+new_id);
	                    td_num.setAttribute("align","center");
	                    
	                    
	                    td_num.innerText = new_id+1;                            
	                    
	                    let td_Q = document.createElement("td");
	                    let text_Q = document.createElement("input");
	                    text_Q.setAttribute("name","Q");
	                    text_Q.setAttribute("type","text");
	                    text_Q.setAttribute("required","true");
	                    text_Q.setAttribute("placeholder","문제를 입력하세요.");
	                    td_Q.append(text_Q);
	                    
	                    let td_A = document.createElement("td");
	                    td_A.innerHTML += "<input type='radio' value='O' name='answer"+new_id+"' checked> O&nbsp;";
	                    td_A.innerHTML += "<input type='radio' value='X' name='answer"+new_id+"'> X&nbsp;";
	                    
	                    
				       // <input type="number"  min="10" max="300" step="10" value="10" name="S">

	                    let td_S = document.createElement("td");
	                    let text_S = document.createElement("input");
	                    text_S.setAttribute("name","S");
	                    text_S.setAttribute("type","number");
	                    text_S.setAttribute("value","10");
	                    text_S.setAttribute("min","10");
	                    text_S.setAttribute("max","300");
	                    text_S.setAttribute("step","10");
	                    td_S.append(text_S);
	                    
	                    let td_button = document.createElement("td");
	                    let btn_delete = document.createElement("input");
	                    btn_delete.setAttribute("name", "btn_delete");
	                    btn_delete.setAttribute("type","button");
	                    btn_delete.setAttribute("value","삭제");
	                    btn_delete.setAttribute("id",new_id);
	                    btn_delete.setAttribute("onclick","delete_btn(this.id)");
	                    td_button.appendChild(btn_delete);
	                    	
	                    tr_QnA.appendChild(td_num);
	                    tr_QnA.appendChild(td_Q);
	                    tr_QnA.appendChild(td_A);
	                    tr_QnA.appendChild(td_S);
	                    tr_QnA.append(td_button);
	                    table_QnA.appendChild(tr_QnA);
	                    
	                   
	                        });
	                });
	            
	            function modifyQnA() {
	            	if(last_num==0){
	                	alert("문제를 하나 이상 입력해주세요.");
	                    return; 
	             }
	            	let formData = new URLSearchParams();
	                let questions = document.querySelectorAll('input[name="Q"]');
	                let scores = document.querySelectorAll('input[name="S"]');

	                for(let i = 0; i < questions.length; i++) {
	                    let qid = i;			// 인덱스라서 
	                    let question = questions[i].value.trim();   
	                    let answerInput = document.querySelector('input[name="answer' + qid + '"]:checked');
	                    let score = scores[i].value;
	                    // 문제 여러개 추가할때 중간을 비워두고 추가하니까 값이 이상하게 들어가서 
	                    // 문제를 빈칸없이 작성해야 들어가게 했슴
	                    // 삭제를 누르고 설정을 완료해야 삭제가 되게 변경했슴.
	                    if (! question) {	
	                        alert((i + 1) + "번 문제의 내용이 비어있습니다. 모든 문제를 입력해주세요.");
	                        questions[i].focus();
	                        return; 
	                    }

	                    formData.append("qid_QnA", qid);
	                    formData.append("Q", question);
	                    formData.append("S", score);
	                    formData.append("answer" + qid, answerInput.value);
	                }
					// 여기도 삭제처럼 ajax로 보냄 
	                fetch("modifyQnA.jsp", {
	                    method: "POST",
	                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
	                    body: formData.toString()
	                })
	                .then(res => res.text())
	                .then(result => {
	                    alert("설정 완료");
	                    console.log(result);
	                })
	                .catch(err => {
	                    alert("전송 실패");
	                    console.error(err);
	                });
	            }
</script>