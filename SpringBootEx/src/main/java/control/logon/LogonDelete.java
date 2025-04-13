package control.logon;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import logon.LogonDBBean;

@Controller
@RequestMapping( "/logondelete" )
public class LogonDelete {
	@Resource
	private LogonDBBean logonDao;
	
	@GetMapping
	public String deleteForm() throws Exception {		
		return "member/deleteForm";
	}
	@PostMapping
	public String deletePro( HttpSession session, @RequestParam String passwd, 
		Model model ) throws Exception {			
		String userId = (String) session.getAttribute( "memId" );
		int checkPwd = logonDao.check( userId, passwd );
		model.addAttribute( "checkPwd", checkPwdCheck );
				
		if( checkPwd == 1 ) {
			int result = logonDao.deleteMember( userId );
			model.addAttribute( "result", result );
			if( result == 1 )
				session.removeAttribute( "memId" );	
		}			
		return "member/deletePro";
	}
}
