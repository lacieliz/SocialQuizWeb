package game;

import java.util.List;

public interface OxMapper {
	public List<OxDataBean> getOxQuiz();
	public int submitScore(OxDataBean oxDto);
}