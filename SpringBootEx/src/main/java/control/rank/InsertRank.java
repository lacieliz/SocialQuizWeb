package control.rank;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import rank.RankDBBean;
import rank.RankDataBean;

@Controller
@RequestMapping( "/insertrank" )
public class InsertRank {
	@Resource
	private RankDBBean rankDao;
	
	@GetMapping
	public String rank() throws Exception {
		return "rank/rank";
	}
	
	@PostMapping
	public String rankPro( @ModelAttribute RankDataBean rankDto, @RequestParam String userId, HttpSession session, Model model ) throws Exception {
		int result = rankDao.insertRank( rankDto );
		if( result == 1 ) 
			session.setAttribute( "memId", userId );
		// session.getAttribute("memId");
		model.addAttribute( "result", result );
		return "rank/rankPro"; 
	}
	
	/*
	@PostMapping
	public String oxPro( @RequestBody RankDataBean rankDto, Model model, HttpSession session ) throws Exception {
		int result = rankDao.insertRank(rankDto);
		if( result == 1 )
			session.setAttribute( "memId", rankDto.getUserId() );
		model.addAttribute( "result", result );
		return "quiz/oxGame/oxPro";
	}
	*/
}
