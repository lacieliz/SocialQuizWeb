
	function setQid(id){
		let new_id = parseInt(id);
		let prev_id = new_id + 1;
		
		while(document.querySelector("td[name='id_QnA"+prev_id+"']") !=null){
			document.querySelector("td[name='id_QnA"+prev_id+"']").innerText = new_id;
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
	                            
	                            
	                   var new_id = ++last_num;
	                  
	                   let tr_QnA = document.createElement("tr");
	                   tr_QnA.setAttribute("name","tr_QnA"+new_id);
	                    
	                    let td_num = document.createElement("td");
	                    td_num.setAttribute("name","id_QnA"+new_id);
	                    td_num.setAttribute("align","center");
	                    
	                    
	                    td_num.innerText = new_id;                            
	                    
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
	            
	            function modifyOX() {
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
						let answerInput = document.querySelector('input[name="answer'+(i+1)+'"]:checked').value;
	                    let score = scores[i].value;
	                    // 문제 여러개 추가할때 중간을 비워두고 추가하니까 값이 이상하게 들어가서 
	                    // 문제를 빈칸없이 작성해야 들어가게 했음
	                    // 삭제를 누르고 설정을 완료해야 삭제가 되게 변경했음.
						
	                    if (! question) {	
	                        alert((i + 1) + "번 문제의 내용이 비어있습니다. 모든 문제를 입력해주세요.");
	                        questions[i].focus();
	                        return; 
	                    }

	                    formData.append("qid_QnA", qid);
	                    formData.append("Q", question);
	                    formData.append("S", score);
	                    formData.append("answer" + qid, answerInput);
	                }
					// 여기도 삭제처럼 ajax로 보냄 
	                fetch("/setoxgame", {
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
