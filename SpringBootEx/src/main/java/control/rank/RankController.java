package control.rank;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import wordgame.WordServer;

@Controller
public class RankController {
    @GetMapping("/rank")
    public String showRank( Model model ) {
    	int activeMem = WordServer.getActiveMember();
    	model.addAttribute( "activeMem", activeMem );

        return "rank/rank";  // 실제로는 /webapp/rank/rank.jsp
    }

}

