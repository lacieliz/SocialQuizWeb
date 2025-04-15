package setgame;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SetOxBean {
	
	private int quiz_id;
	private int game_id;
	private int category_id;
	private String question;
	private String answer;
	private int quiz_score;

}
