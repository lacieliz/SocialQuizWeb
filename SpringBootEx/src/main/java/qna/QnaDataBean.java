package qna;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

// DTO
@Setter
@Getter
public class QnaDataBean {
	private int num;
	private String userId;
	private String subject;
	private Timestamp reg_date;
	private int ref;
	private int re_step;
	private int re_level;
	private String content;
	
	private int replyCount; // ✅ 추가: 이 글에 달린 답글 수
}

