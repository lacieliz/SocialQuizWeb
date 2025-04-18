package control.qna;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.QnaDBBean;
import qna.QnaDataBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping
public class QnaWrite {
	@Resource
	private QnaDBBean qnaDao;

	// 글쓰기 폼
	@GetMapping("/qnawrite")
	public String writeForm(@RequestParam(defaultValue = "0") int num,
	                        @RequestParam(defaultValue = "1") int ref,
	                        @RequestParam(defaultValue = "0") int re_step,
	                        @RequestParam(defaultValue = "0") int re_level,
	                        Model model) throws Exception {
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_step", re_step);
		model.addAttribute("re_level", re_level);
		return "qna/writeForm";
	}
	
	@GetMapping("/qnareply")
	public String replyForm(@RequestParam(defaultValue = "0") int num,
	                        @RequestParam(defaultValue = "1") int ref,
	                        @RequestParam(defaultValue = "0") int re_step,
	                        @RequestParam(defaultValue = "0") int re_level,
	                        Model model) throws Exception {
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("re_step", re_step);
		model.addAttribute("re_level", re_level);
		return "qna/replyForm";
	}

	// 글쓰기 처리
	@PostMapping("/qnawrite")
	public String writePro(@ModelAttribute QnaDataBean qnaDto,
	                       HttpServletRequest request, Model model) throws Exception {
	    // 로그인된 사용자 ID 세션에서 가져오기
	    String userId = (String) request.getSession().getAttribute("memId");
	    qnaDto.setUserId(userId); // 자동 주입

	    // 작성일 설정
	    qnaDto.setReg_date(new Timestamp(System.currentTimeMillis()));

	    int result = qnaDao.insertArticle(qnaDto);
	    model.addAttribute("result", result);
	    return "qna/writePro";
	}
}
