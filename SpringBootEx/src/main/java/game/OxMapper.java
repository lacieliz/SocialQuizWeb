package game;

import java.util.List;
import java.util.Map;

public interface OxMapper {
	public List<OxDataBean> getOxList(Map<String, Integer> map);
	public List<OxDataBean> getOxQuiz(Map<String, Integer> map);
	public int submitScore(OxDataBean oxDto);
}