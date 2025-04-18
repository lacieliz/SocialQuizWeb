package control.qna;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.QnaDBBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/qnadelete")
public class QnaDelete {
	@Resource
	private QnaDBBean qnaDao;

	// 삭제 확인 폼
	@GetMapping
	public String deleteForm(@RequestParam int num, @RequestParam String pageNum, Model model) throws Exception {
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		return "qna/deleteForm";
	}

	// 삭제 처리
	@PostMapping
	public String deletePro(@RequestParam int num,
	                        @RequestParam String pageNum,
	                        Model model,
	                        HttpSession session) throws Exception {

	    String loginUserId = (String) session.getAttribute("memId");
	    int result = qnaDao.deleteArticle(num, loginUserId);

	    model.addAttribute("num", num);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("result", result);

	    return "qna/deletePro";
	}
}
