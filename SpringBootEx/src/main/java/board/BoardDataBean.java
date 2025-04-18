package board;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

// DTO
@Setter
@Getter
public class BoardDataBean {
	private int num;				// 글 번호 (Primary Key)
	private String userId;			// 작성자 ID (Users 테이블의 user_id)
	private String subject;			// 글 제목
	private Timestamp reg_date;		// 작성일
	private int ref;				// 글 그룹
	private int re_step;			// 글 순서
	private int re_level;			// 글 레벨
	private String content;			// 글 내용
	private int readcount;			// 조회수
}



