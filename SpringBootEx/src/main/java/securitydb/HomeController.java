package securitydb;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping( "/home" )
public class HomeController {
	
	private CustomUserDetailsService customUserDetailsService;
	private User user;
	HomeController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }
	
	
	
	
	@GetMapping
	public String main( Model model, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		
		String memId = SecurityContextHolder.getContext().getAuthentication().getName();
		if(memId == "anonymousUser")
			memId = null;
		
		String nickname = customUserDetailsService.getUser().getNickname();
		
		session.setAttribute("memId", memId);
		session.setAttribute("ninkName", nickname );

		
		return "home/home";
	}	
}
