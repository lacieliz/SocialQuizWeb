package securitydb;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping( "/admin" )
public class AdminController {
	@GetMapping
	public String adminform( Model model, HttpSession session ) {
		String memId = SecurityContextHolder.getContext().getAuthentication().getName();
		session.setAttribute("memId", memId);
		model.addAttribute( "result", "관리자페이지 입니다." );
		return "admin/admin";
	}	
}