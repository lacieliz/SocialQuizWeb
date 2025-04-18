package control.board;

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
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class BoardModify {

    @Resource
    private BoardDBBean boardDao;

    // 수정 화면 보여주기
    @GetMapping("/boardmodify")
    public String modifyForm(@RequestParam int num,
                             @RequestParam String pageNum,
                             HttpSession session,
                             Model model) throws Exception {
        String loginUserId = (String) session.getAttribute("memId");
        BoardDataBean boardDto = boardDao.getArticle(num);

        // 작성자 확인
        if (!boardDto.getUserId().equals(loginUserId)) {
            model.addAttribute("result", -2);
            model.addAttribute("pageNum", pageNum);
            return "board/modifyPro";
        }

        model.addAttribute("boardDto", boardDto);
        model.addAttribute("pageNum", pageNum);
        return "board/modifyView";
    }

    // 수정 처리
    @PostMapping("/boardmodifypro")
    public String process(@ModelAttribute BoardDataBean boardDto,
                          @RequestParam String pageNum,
                          HttpSession session,
                          Model model) throws Exception {
        String loginUserId = (String) session.getAttribute("memId");

        int result = boardDao.modifyArticle(boardDto, loginUserId);

        model.addAttribute("result", result);
        model.addAttribute("pageNum", pageNum);
        return "board/modifyPro";
    }
}
