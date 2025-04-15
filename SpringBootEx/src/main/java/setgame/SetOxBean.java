package setgame;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SetOxBean {
	
	private String quiz_id;
	private String game_id;
	private String category_id;
	private String question;
	private String answer;
	private int quiz_score;

}
