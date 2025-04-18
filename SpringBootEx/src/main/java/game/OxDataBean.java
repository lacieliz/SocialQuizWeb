package game;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OxDataBean {
	// Ox Quiz 
	private String question;
	private String answer;
	
	// 점수 기록용
	private int game_id;
	private String userId;
	private Timestamp record_time;
	private int game_score;

}
