// WWD Wild Web Developer
let msg_user_id = "아이디를 입력하세요";
let msg_passwd = "비밀번호를 입력하세요";
let msg_repasswd = "비밀번호가 일치해야 합니다";
let msg_nickname = "이름을 입력하세요";
let msg_email = "이메일을 입력하세요";
let msg_confirm_user_id = "중복된 아이디 입니다.";
let msg_confirm_nickname = "중복된 닉네임 입니다.";
let msg_confirm_email = "중복된 이메일 입니다.";
let msg_confirm_email_auth = "이메일 인증을 완료해주세요.";
let msg_email_change = "비밀번호가 성공적으로 변경되었습니다.";

let error_input = "회원가입에 실패했습니다.\n잠시 후 다시 시도하세요";
let error_login = "입력하신 아이디 또는 비밀번호가 일치하지 않습니다.\n다시 확인하세요.";
let error_passwd = "비밀번호가 일치하지 않습니다.\n다시 입력하세요.";
let error_passwd1 = "비밀번호가 일치하지 않습니다.\n마이페이지로 돌아갑니다.";
let error_delete = "회원탈퇴에 실패했습니다.\n잠시 후 다시 시도하세요";
let error_modify = "회원정보수정에 실패했습니다.\n잠시 후 다시 시도하세요";
let error_id_incorrect =  "아이디가 일치하지 않습니다. \n다시 확인해주세요.";
let error_passwd_duplicate ="기존 비밀번호와 동일합니다. \n다른 비밀번호를 입력해주세요.";

let erroralert = ( msg ) => {
	alert( msg );
	history.back();
}
	
let loginCheck = ( event ) => {
	let userId = document.querySelector( "input[name='userId']" );
	let passwd = document.querySelector( "input[name='passwd']" );
	if( ! userId.value ) {
		alert( msg_user_id );
		event.preventDefault();
		userId.focus();
	} else if( ! passwd.value ) {
		alert( msg_passwd );
		event.preventDefault();
		passwd.focus();
	}	
}
window.addEventListener(
	"DOMContentLoaded",
	() => {
		// 메인 페이지 
		let mainform = document.querySelector( "form[name='mainform']" );
		if( mainform ) {
			mainform.addEventListener(
				"submit",
				loginCheck
			);
		}
		
		// 가입 페이지				
		let inputform = document.querySelector( "form[name='inputform']" );
		if( inputform ) {
			inputform.addEventListener(
				"submit",
				( event ) => {										
					loginCheck( event );
					let userId = document.querySelector( "input[name='userId']" );
					let passwd = document.querySelector( "input[name='passwd']" );
					let repasswd = document.querySelector( "input[name='repasswd']" );
					let nickname = document.querySelector( "input[name='nickname']" );	
					let email = document.querySelector( "input[name='email']" );
					if( userId.value && passwd.value ) {						
						if( passwd.value != repasswd.value ) {
							alert( msg_repasswd );
							event.preventDefault();	
							passwd.focus();
						} else if( ! nickname.value ) {
							alert( msg_nickname );
							event.preventDefault();
							nickname.focus();
						} else if (! email.value) {	
							alert( msg_email )
							event.preventDefault();
							email.focus();
						} else {
							let confirm = document.querySelector( "input[name='confirm']" );						
							if( confirm.value == "0" ) {
								alert( msg_confirm );
								event.preventDefault();
							}								
						}	 
										
					} // 아이디 / 비밀번호가 있으면 
				} // submit 이벤트 핸들러
			);
			
			// 중복 확인 페이지
			let confirm = document.querySelector( "input[value='중복확인']" );			
			confirm.addEventListener(
				"click",
				( event ) => {
					let userId = document.querySelector( "input[name='id']" );
					if( ! userId.value ) {
						alert( msg_id );
						userId.focus();
					} else {
						let url = "logonconfirmid?id=" + userId.value;	
						open( url, "confirm", "scrollbar=no, satusbar=no, titlebar=no, menubar=no, width=400px, height=250px" );
					}						
				}			
			);			
		} // inputform 이 있으면 
		
		// 중복 확인 페이지	
		let confirmform = document.querySelector( "form[name='confirmform']" );
		if( confirmform ) {
			confirmform.addEventListener(
				"submit",
				( event ) => {
					let userId = document.querySelector( "input[name='id']" );
					if( ! userId.value ) {
						alert( msg_id );
						event.preventDefault();
						userId.focus();
					}
				}
			);	
		} // confirmform 이 있으면  
			
		// 로그인
		let loginform = document.querySelector( "form[name='loginform']" );
		if( loginform ) {
			loginform.addEventListener(
				"submit",
				loginCheck	
			);
		}
		
		// 회원탈퇴
		let passwdform = document.querySelector( "form[name='passwdform']" );
		if( passwdform ) {
			passwdform.addEventListener(
				"submit",
				( event ) => {
					let passwd = document.querySelector( "input[name='passwd']" );
					if( ! passwd.value ) {
						alert( msg_passwd );
						event.preventDefault();
						passwd.focus();
					}	
				}			
			);
		}
		
		// 회원 정보 수정
		let modifyform = document.querySelector( "form[name='modifyform']" );
		if( modifyform ) {
			modifyform.addEventListener(
				"submit",
				( event ) => {
					let passwd = document.querySelector( "input[name='passwd']" );
					let repasswd = document.querySelector( "input[name='repasswd']" );
					if( ! passwd.value ) {
						alert( msg_passwd );
						event.preventDefault();
						passwd.focus();
					} else if( passwd.value != repasswd.value ) {
						alert( msg_repasswd );
						event.preventDefault();
						passwd.focus();
					} 					
				}							
			);	
		}
		
	
	}	
);

let setuser_id = ( userId ) => {
	opener.document.inputform.id.value = userId;
	opener.document.inputform.confirm.value = "1";
	window.close();			
}	

let lastSentEmail = null;

function sendEmailAuthCode() {
    const form = document.forms['inputform'];
    const email = form['email'].value.trim();
    const authInput = form['emailAuth']?.value?.trim(); // 인증번호 입력 필드가 있을 경우

    if (!email) {
        alert('이메일을 입력해주세요!');
        return;
    }

    if (email === lastSentEmail) {
        // 인증번호 입력란이 있어야 함
        if (!authInput) {
            alert('이미 인증번호를 보냈습니다. \n메일을 확인한 후 인증번호를 입력해주세요.');
            return;
        }

        // 인증번호 확인 요청
        fetch('sendmailcheck', {
		    method: 'POST',
		    headers: {
		        'Content-Type': 'application/x-www-form-urlencoded',
		    },
		    body: 'emailAuth=' + encodeURIComponent(authInput)
		})
		.then(response => response.json())
		.then(data => {
		    if (data.verified) {
		        alert('이메일 인증에 성공했습니다!');
				form['email'].readOnly = true;
				form['emailAuth'].readOnly = true;
				form['email'].style.backgroundColor = '#eee';
				form['emailAuth'].style.backgroundColor = '#eee';				
				document.getElementById('emailAuthBtn').style.display = "none";
				document.getElementById('emailVerified').value = "true";
		        // 추가 인증 성공 처리
		    } else {
		        alert('인증번호가 올바르지 않습니다.');
		    }
		})
		.catch(error => {
		    console.error('에러 발생:', error);
		    alert('서버 오류가 발생했습니다.');
		});


        return;
    }

	fetch('sendmail', {
	    method: 'POST',
	    headers: {
	        'Content-Type': 'application/x-www-form-urlencoded',
	    },
	    body: 'email=' + encodeURIComponent(email)+ '&emailVerified=false'
	})
	.then(response => response.text())
	.then(result => {
	    if (result === 'success') {
	        lastSentEmail = email;
	        alert('인증번호가 이메일로 전송되었습니다!');
	    } else if (result === 'duplicate') {
	        alert('중복된 이메일입니다! 다른 이메일을 사용해주세요.');
	    } else {
	        alert('이메일 전송 실패');
	    }
	})
	.catch(error => {
	    console.error('에러 발생:', error);
	    alert('서버 오류가 발생했습니다.');
	});

}



