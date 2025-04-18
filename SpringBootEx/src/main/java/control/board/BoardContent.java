package control.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.BoardDBBean;
import board.BoardDataBean;
import jakarta.annotation.Resource;

@Controller
@RequestMapping("/boardcontent")
public class BoardContent {
	@Resource
	private BoardDBBean boardDao;

	@GetMapping
	public String boardContent(@RequestParam int num, @RequestParam String pageNum,
	                           @RequestParam int number, Model model) throws Exception {

		// 조회수 무조건 증가
		boardDao.addCount(num);

		// 게시글 조회
		BoardDataBean boardDto = boardDao.getArticle(num);

		// 모델에 데이터 담기
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("number", number);
		model.addAttribute("boardDto", boardDto);

		return "board/content";
	}
}
