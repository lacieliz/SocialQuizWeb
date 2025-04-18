package rank;

import lombok.Getter;
import lombok.Setter;

//Rank DTO
@Getter
@Setter
public class RankDataBean {
	// User table
	// private String nickname;
	
	// Rank table
    private String userId;
	private int game_id;			// 게임 종류
	private int rank_score;
	private int rank_time;
}