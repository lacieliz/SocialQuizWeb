package control.logon;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
@RequestMapping( "/logonmain" )
public class LogonMain {
	@GetMapping
	public String logonMain( @SessionAttribute( required=false ) String memId, Model model ) 
		throws Exception {		
		model.addAttribute( "memId", memId );
		System.out.println("logonmain들어옴");
		return "member/main";
	}
}





