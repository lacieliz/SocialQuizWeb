package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;

@Controller
@RequestMapping( "/findid" )
public class IdFindController {
	@Resource
	private UserMapper userMapper;
	
	@GetMapping
	public String findIdForm() throws Exception {
		return "login/findid";
	}
	
	@PostMapping
	public String findIdPro( @RequestParam String email, Model model ) throws Exception {
		
		        String userId  = userMapper.findId(email);
		        String result = userId.substring(0, 2) + "*".repeat(userId.length() - 2);
		        model.addAttribute("result", result);		 
		        
		        return "login/findidPro";
		}
} 