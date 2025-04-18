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

@Controller
@RequestMapping
public class PwdFindController {
	
	private CustomUserDetailsService customUserDetailsService;
	SecurityConfig sc = new SecurityConfig(this.customUserDetailsService);
	
	@Resource
	private UserMapper userMapper;
	
	@GetMapping( "/findpwd" )
	public String findPwdForm() throws Exception {
		return "login/findpwd";
	}
	
	@GetMapping( "/changepwd" )
	public String ChangePwdForm() throws Exception {
		return "login/changePwd";
	}
	
	@PostMapping( "/changepwd" )
	public String changePwdPro( @ModelAttribute User user, @RequestParam String userId, @RequestParam String passwd,
			@RequestParam String repasswd, Model model, HttpSession session ) throws Exception {		
		
		String email = (String) session.getAttribute("email");
		String Id = userMapper.findId(email);
		String Passwd = userMapper.findPasswd(userId);
		
	      if(!Id.equals(userId)) {				// 아까 이메일 인증받은게 아이디가 user_id랑 똑같은지 확인하고 처리
	    	  model.addAttribute("result", 0);
	      } else if(sc.passwordEncoder().matches(passwd, Passwd)) {	// 비밀번호가 기존 비밀번호랑 같은지 확인하고 처리
	    	  model.addAttribute("result", 2);  
	      } else {
	    	  String newPW = sc.passwordEncoder().encode(passwd);
	    	  user.setPasswd(newPW);
	    	  
	    	  userMapper.changePasswd(user);
	    	  model.addAttribute("result", 1);
	      }
	      	
	      return "login/changePwdPro";
		    
		}

	
} 