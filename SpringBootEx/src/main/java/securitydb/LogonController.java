package securitydb;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mb.CreateBeans;
@Controller
@RequestMapping( "/logon" )
public class LogonController {
	
	    private final CreateBeans createBeans;

		LogonController(CreateBeans createBeans) {
	        this.createBeans = createBeans;
	    }
	
	@GetMapping
	public String form( Model model, HttpServletRequest request, HttpServletResponse response) {
		
	
		//로그인 페이지에 들어왔을 때 아이디 저장 되있으면 아이디값 넣어주기
		System.out.println("체크여부:" +request.getParameter("rememberId"));
		String rememberedId = "";									// 여기 get매핑은 링크로 이동하는 곳이니까 여기에다가  
	    Cookie[] cookies = request.getCookies();				// 쿠키 통으로 가져옴
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {						// 쿠키 끝까지 반복문
	            if ("rememberId".equals(cookie.getName())) {	// rememberId에 저장해놨으니까 이거 가져와
	                rememberedId = cookie.getValue();			// 값에다가 넣고 rememberedId
	                break;
	            }
	        }
	    }

	    model.addAttribute("rememberedId", rememberedId);		// 값에다가 넣고 rememberedId	
		System.out.println("[/logon] rememberId : "+request.getParameter("rememberId"));
		
		
		return "login/logon";
	}
}