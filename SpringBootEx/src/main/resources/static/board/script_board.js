let msg_writer = "로그인 후에만 글 작성이 가능합니다.";
let msg_subject = "글제목을 입력하세요";
let msg_content = "글내용을 입력하세요";
let msg_passwd = "비밀번호를 입력하세요";
let msg_tag = "태그를 입력하면 안 됩니다";

let error_write = "글작성에 실패했습니다\n잠시 후 다시 시도하세요";
let error_passwd = "입력하신 비밀번호가 다릅니다\n다시 확인하세요";
let error_modify = "글수정에 실패했습니다\n잠시 후 다시 시도하세요";
let error_delete = "글삭제에 실패했습니다\n잠시 후 다시 시도하세요";
let error_reply = "답글이 있는 글은 삭제할 수 없습니다";

window.addEventListener(
	"DOMContentLoaded",
	() => {
		// 글쓰기	
		let writeform = document.querySelector( "form[name='writeform']" );
		if( writeform ) {
			writeform.addEventListener(
				"submit",
				( event ) => {
					let userId = document.querySelector( "input[name='userId']" );
					let subject = document.querySelector( "input[name='subject']" );
					let content = document.querySelector( "textarea[name='content']" );
					let passwd = document.querySelector( "input[name='passwd']" );
					let tag = /<[^>]*>/; 					
					if( ! userId.value ) {
						alert( msg_writer );
						event.preventDefault();
						userId.focus();
					} else if( ! subject.value ) {
						alert( msg_subject );
						event.preventDefault();
						subject.focus();
					} else if( ! content.value ) {
						alert( msg_content );
						event.preventDefault();
						content.focus();
					} else if( ! passwd.value ) {
						alert( msg_passwd );
						event.preventDefault();
						passwd.focus();
					} else if( tag.test( userId.value ) 
						|| tag.test( subject.value ) 
						|| tag.test( content.value ) 
						|| tag.test( passwd.value ) ) {
						alert( msg_tag );
						event.preventDefault();
						userId.focus();
					}					
				}			
			);
		} // writeform 있는 경우
		
		// 글수정
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
		} // passwdform 있는 경우
				
		let modifyform = document.querySelector( "form[name='modifyform']" );
		if( modifyform ) {
			modifyform.addEventListener(
				"submit",
				( event ) => {
					let subject = document.querySelector( "input[name='subject']" );
					let content = document.querySelector( "textarea[name='content']" );
					let passwd = document.querySelector( "input[name='passwd']" );
					if( ! subject.value ) {
						alert( msg_subject );
						event.preventDefault();
						subject.focus();
					} else if( ! content.value ) {
						alert( msg_content );
						event.preventDefault();
						content.focus();
					} else if( ! passwd.value ) {
						alert( msg_passwd );
						event.preventDefault();
						passwd.focus();
					}	
				}				
			);			
		} // modifyform 있는 경우			
	}
);




