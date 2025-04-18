package rank;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RankMapper {
	public int insertRank( RankDataBean rankDto );
	public RankDataBean getRank();
}
