package control.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.QnaDBBean;
import qna.QnaDataBean;
import control.oxgame.StartOX;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class QnaList {

    private final StartOX startOX;
	@Resource
	private QnaDBBean qnaDao;

    QnaList(StartOX startOX) {
        this.startOX = startOX;
    }
	
	@GetMapping( "/qnalist" )
	public String qnaList( @RequestParam( required=false ) String pageNum, Model model ) throws Exception {
		
		int pageSize = 10;
		int pageBlock = 5; 
		
		int count = 0;				// 전체 글 개수		
		int currentPage = 0;		// 계산용 페이지 번호
		int start = 0;				// 출력할 페이지 첫 DB index
		int end = 0;				// 출력할 페이지 마지막 DB index	
		int number = 0;				// 출력용 글번호
		int pageCount = 0;			// 페이지 개수
		int startPage = 0;			// 출력할 페이지 시작 번호
		int endPage = 0;			// 출력할 페이지 끝 번호
		
		count = qnaDao.getCount();
				
		if( pageNum == null || pageNum.equals( "" ) ) {
			// 첫 페이지를 보겠다는 의미
			pageNum = "1";
		}
		currentPage = Integer.parseInt( pageNum );
		start = ( currentPage - 1 ) * pageSize + 1;		// ( 5 - 1 ) * 10 + 1		41
		end = start + pageSize - 1;						// 41 + 10 - 1				50
		if( end > count ) {
			// 계산보다 실제 글이 적은 경우
			end = count;
		}
		
		number = count - ( currentPage - 1 ) * pageSize;// 50 - ( 1 - 1 ) * 10 		50 
		
		pageCount = ( count / pageSize ) + ( count % pageSize > 0 ? 1 : 0 );	
		startPage = ( currentPage / pageBlock ) * pageBlock + 1;	
		if( currentPage % pageBlock == 0 )
			startPage -= pageBlock;
		endPage = startPage + pageBlock - 1;
		if( endPage > pageCount )
			endPage = pageCount;
			
		model.addAttribute( "pageBlock", pageBlock );
		model.addAttribute( "count", count );
		model.addAttribute( "number", number );
		model.addAttribute( "pageNum", pageNum );
		model.addAttribute( "currentPage", currentPage );
		model.addAttribute( "pageCount", pageCount );
		model.addAttribute( "startPage", startPage );
		model.addAttribute( "endPage", endPage );
		
		if( count > 0 ) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put( "start", start );
			map.put( "end", end );
			List<QnaDataBean> dtos = qnaDao.getArticles( map );
			model.addAttribute( "dtos", dtos );
		}
		
		return "qna/list";
	}
	
	@GetMapping("/qnamylist")
	public String qnaMyList(@RequestParam(required = false) String pageNum,
	                        HttpSession session,
	                        Model model) throws Exception {

	    String userId = (String) session.getAttribute("memId");

	    int pageSize = 10;
	    int pageBlock = 5;
	    int count;
	    int currentPage;
	    int start;
	    int end;
	    int number;
	    int pageCount;
	    int startPage;
	    int endPage;

	    if (pageNum == null || pageNum.isEmpty()) {
	        pageNum = "1";
	    }

	    currentPage = Integer.parseInt(pageNum);
	    start = (currentPage - 1) * pageSize + 1;
	    end = start + pageSize - 1;

	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    count = qnaDao.getMyCount(userId); // 기존 로직
	

	    if (end > count) end = count;
	    number = count - (currentPage - 1) * pageSize;
	    pageCount = (count / pageSize) + (count % pageSize > 0 ? 1 : 0);
	    startPage = (currentPage / pageBlock) * pageBlock + 1;
	    if (currentPage % pageBlock == 0) startPage -= pageBlock;
	    endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;

	    model.addAttribute("pageBlock", pageBlock);
	    model.addAttribute("count", count);
	    model.addAttribute("number", number);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("pageCount", pageCount);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);

	    if (count > 0) {
	        map.put("start", start);
	        map.put("end", end);
	        List<QnaDataBean> dtos = qnaDao.getMyArticles(map);  // 🔄 subject 포함된 map
	        model.addAttribute("dtos", dtos);
	    }

	    return "qna/viewQna";
	}

	@PostMapping("/qnamylist")
	public String qnaSearchList(@RequestParam(required = false) String pageNum,
				@RequestParam(required = false) String query,
	                        HttpSession session,
	                        Model model) throws Exception {

	    String userId = (String) session.getAttribute("memId");

	    int pageSize = 10;
	    int pageBlock = 5;
	    int count;
	    int currentPage;
	    int start;
	    int end;
	    int number;
	    int pageCount;
	    int startPage;
	    int endPage;

	    if (pageNum == null || pageNum.isEmpty()) {
	        pageNum = "1";
	    }

	    currentPage = Integer.parseInt(pageNum);
	    start = (currentPage - 1) * pageSize + 1;
	    end = start + pageSize - 1;

	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("subject", query);
	    count = qnaDao.searchMyCount(map); // 기존 로직
	

	    if (end > count) end = count;
	    number = count - (currentPage - 1) * pageSize;
	    pageCount = (count / pageSize) + (count % pageSize > 0 ? 1 : 0);
	    startPage = (currentPage / pageBlock) * pageBlock + 1;
	    if (currentPage % pageBlock == 0) startPage -= pageBlock;
	    endPage = startPage + pageBlock - 1;
	    if (endPage > pageCount) endPage = pageCount;

	    model.addAttribute("pageBlock", pageBlock);
	    model.addAttribute("count", count);
	    model.addAttribute("number", number);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("pageCount", pageCount);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);

	    if (count > 0) {
	        map.put("start", start);
	        map.put("end", end);
	        List<QnaDataBean> dtos = qnaDao.searchMyArticles(map);  // 🔄 subject 포함된 map
	        model.addAttribute("dtos", dtos);
	    }

	    return "qna/viewQna";
	}
}
