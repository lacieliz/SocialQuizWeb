package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
@RequestMapping( "/mypage" )
public class LogonPage {
	@GetMapping
	public String logonPage( ) {		
		return "user/mypage";
	}
}
