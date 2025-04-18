package control.quiz;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("quiz/selectquiz")
public class SelectQuiz {
	@GetMapping
	public String selectQuiz() {
		return "quiz/selectQuiz";
	}
}



