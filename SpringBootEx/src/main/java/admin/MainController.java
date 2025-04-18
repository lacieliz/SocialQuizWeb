package admin;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/adminmain")
public class MainController {
	
	@GetMapping
	public String form( Model model ) {
		
		return "admin/adminForm";
	}
}
