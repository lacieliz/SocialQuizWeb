package control.wordgame;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping( "quiz/socketword" )
public class wordSocket {
	@GetMapping
	public String websocket() {
		return "quiz/wordGame/socket/MultiChatMain";
	}
		
	@PostMapping
	 public String openChat(@RequestParam("nickname") String nickname, Model model) {
        model.addAttribute("nickname", nickname);
        return "quiz/wordGame/socket/ChatWindow";
    }
}