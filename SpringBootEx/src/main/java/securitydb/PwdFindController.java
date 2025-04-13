package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import logon.LogonDBBean;

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