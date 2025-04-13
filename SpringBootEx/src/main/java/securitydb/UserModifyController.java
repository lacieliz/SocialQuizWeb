package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import logon.LogonDataBean;

@Controller
@RequestMapping( "/modifyuser" )
public class UserModifyController {
    
	private CustomUserDetailsService customUserDetailsService;

	UserModifyController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }
	
	@Resource
	private UserMapper userMapper;
	
	@GetMapping
	public String modifyForm() throws Exception {	
		return "user/modifyUser";
	}
	@PostMapping
	public String process( HttpSession session, @RequestParam String passwd, Model model ) 
		throws Exception {		
		
		String userId = session.getAttribute( "memId" ).toString();
		SecurityConfig sc = new SecurityConfig(this.customUserDetailsService);

		String pw = customUserDetailsService.loadUserByUsername(userId).getPassword();
		boolean checkPwd = sc.passwordEncoder().matches(passwd, pw);
		
		System.out.println("[/modifyuser] checkPwd : " + checkPwd);
		
		if(checkPwd) {
			model.addAttribute( "result", 1 );	
		}
		else {
			model.addAttribute( "result", 0 );	
		}
		
		return "user/modifyView";
	}
	
	/*@PostMapping( "/logonmodifypro" )
	public String process( @ModelAttribute LogonDataBean logonDto, 
		
		@RequestParam String email, Model model ) throws Exception {
		logonDto.setEmail( email );			
		//int result = userMapper.modifyMember( logonDto );			
		//model.addAttribute( "result", result );		
		return "member/modifyPro";
	}*/
	
}

/*
@Controller
@RequestMapping
public class LogonModify {
	@Resource
	private LogonDBBean logonDao;
	
	@GetMapping( "/logonmodify" )
	public String modifyForm() throws Exception {	
		return "member/modifyForm";
	}
	@PostMapping( "/logonmodify" )
	public String process( HttpSession session, @RequestParam String passwd, Model model ) 
		throws Exception {		
		String userId = (String) session.getAttribute( "memId" );
		int result = logonDao.check( userId, passwd );
		model.addAttribute( "result", result );	
		if( result == 1 ) {
			LogonDataBean memberDto = logonDao.getMember( userId );
			model.addAttribute( "memberDto", memberDto );
		}		
		return "member/modifyView";
	}
	
	@PostMapping( "/logonmodifypro" )
	public String process( @ModelAttribute LogonDataBean logonDto, 
		
		@RequestParam String email, Model model ) throws Exception {
		logonDto.setEmail( email );			
		int result = logonDao.modifyMember( logonDto );			
		model.addAttribute( "result", result );		
		return "member/modifyPro";
	}
	
}*/

