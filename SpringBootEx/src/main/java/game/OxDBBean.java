package game;

import java.util.List;

import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

@Service
public class OxDBBean {
	@Resource
	private OxMapper oxMapper;
	
    public int submitScore( OxDataBean oxDto ) {
    	return oxMapper.submitScore(oxDto);
    	// json
    }
}
