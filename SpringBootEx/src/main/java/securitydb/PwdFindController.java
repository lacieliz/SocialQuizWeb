package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.Resource;

@Controller
@RequestMapping( "/findpwd" )
public class PwdFindController {
	@Resource
	private UserMapper userMapper;
	
	@GetMapping
	public String findPwdForm() throws Exception {
		return "login/findpwd";
	}
	
} 