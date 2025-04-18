package securitydb;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping( "/home" )
public class HomeController {
	
	private CustomUserDetailsService customUserDetailsService;
	HomeController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }
	
	
	
	
	@GetMapping
	public String main( Model model, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		
		String memId = SecurityContextHolder.getContext().getAuthentication().getName();
		if(memId == "anonymousUser")
			memId = null;
		
		else {
			// 현재 로그인한 사용자 정보
	        User user = customUserDetailsService.getUser();

	        String auth = user.getAuth();
	        String nickname = user.getNickname(); // ✅ 닉네임 가져오기

	        session.setAttribute("Auth", auth);
	        session.setAttribute("nickname", nickname); // ✅ 닉네임 세션에 저장
	   
		}
		session.setAttribute("memId", memId);

		return "home/home";
	}	
}
