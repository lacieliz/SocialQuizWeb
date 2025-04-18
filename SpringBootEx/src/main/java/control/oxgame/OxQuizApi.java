package control.oxgame;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import game.OxDBBean;
import game.OxDataBean;
import jakarta.annotation.Resource;
import setgame.SetOxBean;
import setgame.SetOxMapper;

@RestController
@RequestMapping("quiz/oxquiz")
public class OxQuizApi {
	@Resource
	private SetOxMapper setoxMapper;
	
	@GetMapping
	public List<SetOxBean> getOxList(Map<String, Integer> map) {
		return setoxMapper.getOxList(map);
	}

}
