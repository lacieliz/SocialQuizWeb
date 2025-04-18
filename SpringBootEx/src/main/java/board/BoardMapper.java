package board;

import java.util.List;
import java.util.Map;

public interface BoardMapper {
	public int getCount();							// 총 게시글 수
	public int searchCount(Map<String, Object> map);	
	public int maxNum();							// 최대 num 값
	public void addReply(BoardDataBean boardDto);	// 답글 정렬 처리
	public int insertArticle(BoardDataBean boardDto);	// 글 등록
	public List<BoardDataBean> getArticles(Map<String, Integer> map);	// 목록 조회
	public List<BoardDataBean> searchArticles(Map<String, Object> map);	// 목록 조회
	public BoardDataBean getArticle(int num);		// 글 1개 조회
	public void addCount(int num);					// 조회수 증가
	public int modifyArticle(BoardDataBean boardDto); // 글 수정
	public int checkReply(BoardDataBean boardDto);	// 답글 유무 확인
	public void deleteReply(BoardDataBean boardDto); // 답글 삭제
	public int deleteArticle(int num);				// 게시글 삭제
}

