package control.oxgame;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.annotation.Resource;
import setgame.SetOxBean;
import setgame.SetOxMapper;

@Controller
@RequestMapping("/setoxgame")
public class SetListController {
	@Resource
	private SetOxMapper setoxMapper;
	
	@GetMapping
	public String setOxList( @RequestParam( required=false ) String pageNum, Model model ) throws Exception {

		int count = setoxMapper.getCount();
		Map<String, Integer> map = new HashMap<String, Integer>();

		if( count > 0 ) {
			List<SetOxBean> dtos = setoxMapper.getOxList(map);
			model.addAttribute( "dtos", dtos );
		}
		System.out.println("[/setlistOX] count : " + count);
		
		return "admin/setOX";
	}
}
