package setgame;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SetOxMapper {
	
	public List<SetOxBean> getOxList(Map<String, Integer> map);
	public int getCount();
	public int deleteOxList();
	public int insertOxList(SetOxBean s);
	public int resetSEQ();
	//public List<SetOxBean> getOxList();

}
