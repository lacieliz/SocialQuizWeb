package rank;

import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

@Service
public class RankDBBean {
	@Resource
	private RankMapper rankMapper;
	
	public int insertRank( RankDataBean rankDto ) {
		return rankMapper.insertRank( rankDto );
	}
	
	
	
}
