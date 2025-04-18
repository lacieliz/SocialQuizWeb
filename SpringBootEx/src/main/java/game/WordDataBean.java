package game;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WordDataBean {
    private int game_id;          // 게임 종류 ID (끝말잇기 = 2)
    private String userId;        // 사용자 ID
    private Timestamp record_time; // 게임 기록 시간
    private int game_score;       // 획득한 점수
}