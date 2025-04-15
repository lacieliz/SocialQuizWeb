package control.game_record;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GameRecordController {

    @GetMapping("/game_record/game_record")
    public String showGameRecordPage() {
        return "game_record/game_record"; // => /webapp/game_record/game_record.jsp
    }
}
