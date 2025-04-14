package securitydb;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping( "/deleteuser" )
public class UserDeleteController {

    private final CustomUserDetailsService customUserDetailsService;
    
	@Resource
	private UserMapper userMapper;

    UserDeleteController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }
	
	@GetMapping
	public String deleteForm() throws Exception {		
		return "user/deleteUser";
	}
	@PostMapping
	private String deletePro( HttpSession session, @RequestParam String passwd, 
		Model model ) throws Exception {			
		String userId = session.getAttribute( "memId" ).toString();
		SecurityConfig sc = new SecurityConfig(this.customUserDetailsService);

		String pw = customUserDetailsService.loadUserByUsername(userId).getPassword();
		boolean checkPwd = sc.passwordEncoder().matches(passwd, pw);
		
		System.out.println("[/deleteuser] checkPwd : " + checkPwd);
		
		if(checkPwd) {
			int result = userMapper.deleteUser(userId);
			
			model.addAttribute( "checkPwd", 1 );
			model.addAttribute( "result", result );	
		}
		else {
			model.addAttribute( "checkPwd", 0 );
		}
		return "user/deleteUserPro";
	}
}
