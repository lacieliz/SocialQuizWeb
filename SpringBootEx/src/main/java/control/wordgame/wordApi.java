package control.wordgame;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("quiz/wordapi")
public class wordApi {
	@GetMapping
	public String api() {
		return "quiz/wordGame/wordApi";
	}
}
