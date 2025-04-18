package control.qna;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.QnaDBBean;
import qna.QnaDataBean;
import jakarta.annotation.Resource;

@Controller
@RequestMapping("/qnacontent")
public class QnaContent {
	@Resource
	private QnaDBBean qnaDao;

	@GetMapping
	public String qnaContent(@RequestParam int num, @RequestParam String pageNum,
	                           @RequestParam int number, Model model) throws Exception {
		
		// 게시글 조회
		QnaDataBean qnaDto = qnaDao.getArticle(num);

		// 모델에 데이터 담기
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("number", number);
		model.addAttribute("qnaDto", qnaDto);

		return "qna/content";
	}
}
