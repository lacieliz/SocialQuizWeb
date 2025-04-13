package securitydb;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//로그인 실패 컨트롤러
@Controller
@RequestMapping( "/fail" )
public class SetFailurePage {
	
	@GetMapping
	public String onAuthenticationFail(HttpServletRequest request, HttpServletResponse response,
			Model model) throws IOException, ServletException {

		model.addAttribute( "result", 0 );				

		return "login/loginPro";

	}
}
