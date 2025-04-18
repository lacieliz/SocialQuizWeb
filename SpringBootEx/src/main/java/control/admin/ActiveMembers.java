package control.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping( "/acitivemems" )
public class ActiveMembers {
	@GetMapping
	public String activeForm() {
		return "admin/activeMems";
	}
}