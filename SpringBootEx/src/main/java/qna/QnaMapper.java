package qna;

import java.util.List;
import java.util.Map;

import board.BoardDataBean;

public interface QnaMapper {
	public int getCount();							// 총 게시글 수
	public int getMyCount(String userId);
	public int searchMyCount(Map<String, Object> map);	
	public int maxNum();							// 최대 num 값
	public void addReply(QnaDataBean qnaDto);	// 답글 정렬 처리
	public int insertArticle(QnaDataBean qnaDto);	// 글 등록
	public List<QnaDataBean> getArticles(Map<String, Integer> map);	// 목록 조회
	public List<QnaDataBean> getMyArticles(Map<String, Object> map);	// 자기 글 목록 조회
	public List<QnaDataBean> searchMyArticles(Map<String, Object> map);	// 자기 글 목록 조회
	public QnaDataBean getArticle(int num);		// 글 1개 조회
	public int modifyArticle(QnaDataBean qnaDto); // 글 수정
	public int checkReply(QnaDataBean qnaDto);	// 답글 유무 확인
	public void deleteReply(QnaDataBean qnaDto); // 답글 삭제
	public int deleteArticle(int num);				// 게시글 삭제
}
