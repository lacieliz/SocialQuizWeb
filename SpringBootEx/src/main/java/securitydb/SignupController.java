package securitydb;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import logon.LogonDataBean;
@Controller
@RequestMapping("/signup")
public class SignupController {
	@Resource
	UserMapper userMapper;	
		
	@Resource
	private PasswordEncoder passwordEncoder;
				
	@GetMapping
	public String form( Model model ) {		
		return "login/signup";
	}	
	
	@PostMapping
	public String pro( @ModelAttribute User user, @RequestParam String userId,
		@RequestParam String nickname, @RequestParam String email, @RequestParam String emailVerified, Model model) {
		
		System.out.println("[/signup] userId : " + userId);
	
		user.setEmail( email );
		 int checkid = userMapper.checkId(userId);
		 int checknickname = userMapper.checkNickname(nickname);
		 System.out.println("[/signup] cehckid : "+checkid);
		 System.out.println("[/signup] cehcknickname : "+checknickname);

		    if (checkid == 1) {  
		    	model.addAttribute("result", 2);
		    } else if (checknickname == 1) {
		    	model.addAttribute("result", 3);
		    } else if (!"true".equals(emailVerified)){
		    	model.addAttribute("result", 4);
		    } else {
		    	model.addAttribute("result", 1);
		    	user.setPasswd( passwordEncoder.encode( user.getPasswd() ) );
			    user.setAuth( "ROLE_" + user.getAuth() );
			    userMapper.insertUser( user );
		    }
		 //   user.setPasswd( passwordEncoder.encode( user.getPasswd() ) );
		 //   user.setAuth( "ROLE_" + user.getAuth() );
		//userMapper.insertUser( user );
		return "login/signupPro";
	}	
}
/*
 * 
 * 	@PostMapping
	public String inputPro( @ModelAttribute LogonDataBean logonDto, @RequestParam String userId,
			@RequestParam String nickname, @RequestParam String email, @RequestParam String emailVerified, Model model ) throws Exception {
		
		logonDto.setEmail( email );
		 int checkid = logonDao.check(userId);
		 int checknickname = logonDao.checkNickname(nickname);
		    if (checkid == 1) {  
		    	model.addAttribute("result", 2);
		    } else if (checknickname == 1) {
		    	model.addAttribute("result", 3);
		    } else if (!"true".equals(emailVerified)){
		    	model.addAttribute("result", 4);
		    } else {
		        int result = logonDao.insertMember(logonDto);
		        model.addAttribute("result", result);
		    }
		        return "member/inputPro";
		    
		}*/