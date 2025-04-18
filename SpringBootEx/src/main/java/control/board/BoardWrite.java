package control.board;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.BoardDBBean;
import board.BoardDataBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/boardwrite")
public class BoardWrite {
	@Resource
	private BoardDBBean boardDao;

	// 글쓰기 폼
	@GetMapping
	public String writeForm(@RequestParam(defaultValue = "0") int num,
	                        @RequestParam(defaultValue = "1") int ref,
	                        @RequestParam(defaultValue = "0") int re_step,
	                        @RequestParam(defaultValue = "0") int re_level,
	                        Model model) throws Exception {
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_step", re_step);
		model.addAttribute("re_level", re_level);
		return "board/writeForm";
	}

	// 글쓰기 처리
	@PostMapping
	public String writePro(@ModelAttribute BoardDataBean boardDto,
	                       HttpServletRequest request, Model model) throws Exception {
	    // 로그인된 사용자 ID 세션에서 가져오기
	    String userId = (String) request.getSession().getAttribute("memId");
	    boardDto.setUserId(userId); // 자동 주입

	    if(boardDto.getSubject()=="" || boardDto.getContent()=="") {
	    	model.addAttribute("isEmpty",1);
		    return "board/writePro";

	    }
	    // 작성일 설정
	    boardDto.setReg_date(new Timestamp(System.currentTimeMillis()));

	    int result = boardDao.insertArticle(boardDto);
	    model.addAttribute("result", result);
	    return "board/writePro";
	}
}
