package control.rank;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import rank.RankDataBean;
import rank.RankDBBean;

@Controller
public class RankController {

    @Autowired
    private RankDBBean rankService;

    @GetMapping("/rank")
    public String showRank() {

        return "rank/rank";  // 실제로는 /webapp/rank/rank.jsp
    }
    
    @GetMapping("/record")
    public String showrecord() {

        return "rank/myrecord";  // 실제로는 /webapp/rank/rank.jsp
    }
    

}

