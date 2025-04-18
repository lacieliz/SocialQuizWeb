package board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qna.QnaDataBean;

@Service
public class BoardDBBean {
	@Autowired
	private BoardMapper boardMapper;

	public int getCount() {
		return boardMapper.getCount();
	}
	public int searchCount(Map<String, Object> map) {
		return boardMapper.searchCount(map);
	}
	// 글쓰기
	public int insertArticle(BoardDataBean boardDto) {
		int num = boardDto.getNum();
		int ref = boardDto.getRef();
		int re_step = boardDto.getRe_step();
		int re_level = boardDto.getRe_level();

		if (num == 0) {
			// 새 글 (제목글)
			int maxNum = boardMapper.maxNum();
			ref = (maxNum == 0) ? 1 : maxNum + 1;
			re_step = 0;
			re_level = 0;
		} else {
			// 답변글
			boardMapper.addReply(boardDto);
			re_step++;
			re_level++;
		}

		boardDto.setRef(ref);
		boardDto.setRe_step(re_step);
		boardDto.setRe_level(re_level);
		return boardMapper.insertArticle(boardDto);
	}

	public List<BoardDataBean> getArticles(Map<String, Integer> map) {
		return boardMapper.getArticles(map);
	}

	public List<BoardDataBean> searchArticles(Map<String, Object> map) {
		return boardMapper.searchArticles(map);
	}

	public BoardDataBean getArticle(int num) {
		return boardMapper.getArticle(num);
	}

	public void addCount(int num) {
		boardMapper.addCount(num);
	}

	// 글수정 처리
	public int modifyArticle(BoardDataBean boardDto, String loginUserId) {
	    BoardDataBean origin = getArticle(boardDto.getNum());

	    if (!origin.getUserId().equals(loginUserId)) {
	        return -2; // 권한 없음
	    }

	    return boardMapper.modifyArticle(boardDto);
	}


	// 글 삭제 ( 자기가 쓴 글 만 가능 )
	public int deleteArticle(int num, String loginUserId) {
	    BoardDataBean boardDto = getArticle(num);

	    // 작성자 검증
	    if (!boardDto.getUserId().equals(loginUserId)) {
	        return -2; // 권한 없음
	    }

	    int result = 0;
	    int countReply = boardMapper.checkReply(boardDto);

	    if (countReply != 0) {
	        result = -1; // 답글 있음
	    } else {
	        boardMapper.deleteReply(boardDto);
	        result = boardMapper.deleteArticle(num);
	    }

	    return result;
	}

}
