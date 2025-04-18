package control.qna;

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
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class QnaModify {

    @Resource
    private QnaDBBean qnaDao;

    // 수정 화면 보여주기
    @GetMapping("/qnamodify")
    public String modifyForm(@RequestParam int num,
                             @RequestParam String pageNum,
                             HttpSession session,
                             Model model) throws Exception {
        String loginUserId = (String) session.getAttribute("memId");
        QnaDataBean qnaDto = qnaDao.getArticle(num);

        // 작성자 확인
        if (!qnaDto.getUserId().equals(loginUserId)) {
            model.addAttribute("result", -2);
            model.addAttribute("pageNum", pageNum);
            return "qna/modifyPro";
        }

        model.addAttribute("qnaDto", qnaDto);
        model.addAttribute("pageNum", pageNum);
        return "qna/modifyView";
    }

    // 수정 처리
    @PostMapping("/qnamodifypro")
    public String process(@ModelAttribute QnaDataBean qnaDto,
                          @RequestParam String pageNum,
                          HttpSession session,
                          Model model) throws Exception {
        String loginUserId = (String) session.getAttribute("memId");

        int result = qnaDao.modifyArticle(qnaDto, loginUserId);

        model.addAttribute("result", result);
        model.addAttribute("pageNum", pageNum);
        return "qna/modifyPro";
    }
}
