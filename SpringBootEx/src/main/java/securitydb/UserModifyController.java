package securitydb;
import java.util.Collections;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class UserModifyController {

    private final AuthenticationManager authenticationManager;
	private CustomUserDetailsService customUserDetailsService;
	private User user;
	UserModifyController(CustomUserDetailsService customUserDetailsService, AuthenticationManager authenticationManager) {
        this.customUserDetailsService = customUserDetailsService;
        this.authenticationManager = authenticationManager;
    }
	
	SecurityConfig sc = new SecurityConfig(this.customUserDetailsService);

	@Resource
	private UserMapper userMapper;
	@Resource
	private PasswordEncoder passwordEncoder;

	@GetMapping( "/modifyuser" )
	public String modifyForm() throws Exception {	
		return "user/modifyUser";
	}
	@PostMapping( "/modifyuser" )
	public String process( HttpSession session, @RequestParam String passwd, Model model) 
		throws Exception {		
		String userId = session.getAttribute( "memId" ).toString();
		
		String pw = customUserDetailsService.loadUserByUsername(userId).getPassword();
		boolean checkPwd = sc.passwordEncoder().matches(passwd, pw);
		user = customUserDetailsService.getUser();
		
		System.out.println("[/modifyuser] checkPwd : " + checkPwd);
		
		if(checkPwd) {
			model.addAttribute("User", user);  
			System.out.println(user.getUserId());
			model.addAttribute( "checkPwd", 1 );
			model.addAttribute( "result", 1 );	
		}
		else {
			model.addAttribute( "checkPwd", 0 );
			model.addAttribute( "result", 0 );	
		}
		
		return "user/modifyView";
	}
	@PostMapping( "/modifypro" )
	public String modifyPro(@RequestParam String passwd, @RequestParam String email, Model model ) throws Exception {
			
			
			
			userMapper.deleteUser(user.getUserId());

			String changedPW = passwordEncoder.encode( passwd );
			user.setEmail( email );
			user.setPasswd(changedPW);
			
			System.out.println("[/modifypro] passwd : "+ passwd);
			System.out.println("[/modifypro] changedPW : "+ changedPW);
			System.out.println("[/modifypro] setpasswd : " +user.getPasswd() );
			System.out.println("[/modifypro] user : "+ user);
			int result =  userMapper.insertUser( user );
			    
			    
			model.addAttribute( "result", result );		
			return "user/modifyPro";
		}
}

