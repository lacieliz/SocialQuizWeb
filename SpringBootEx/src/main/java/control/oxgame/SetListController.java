package control.oxgame;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import setgame.SetOxBean;
import setgame.SetOxMapper;

@Controller
@RequestMapping("/setoxgame")
public class SetListController {
	@Resource
	private SetOxMapper setoxMapper;
	
	@GetMapping
	public String setOxList( Model model ) throws Exception {

		int count = setoxMapper.getCount();
		Map<String, Integer> map = new HashMap<String, Integer>();

		if( count > 0 ) {
			List<SetOxBean> dtos = setoxMapper.getOxList(map);
			model.addAttribute( "dtos", dtos );
		}
		model.addAttribute("count",count);
		System.out.println("[/setlistOX] count : " + count);
		
		return "admin/setOX";
	}
	@PostMapping
	public String modifyOxList( HttpServletRequest request, Model model ) throws Exception {

        String questions[] = request.getParameterValues("Q");
        String answers[]= new String[questions.length];
        String scores[] = request.getParameterValues("S");

        setoxMapper.deleteOxList();

        SetOxBean s = new SetOxBean();
        for(int i=0; i<questions.length;i++){
        	   String temp[] = request.getParameterValues("answer"+i);
        	   answers[i] = temp[i];
        	   
               s.setQuiz_id(i+1);
               s.setGame_id(1);
               s.setCategory_id(1);
               s.setQuestion(questions[i]);
               s.setAnswer(answers[i]);
               s.setQuiz_score(Integer.parseInt(scores[i]));
               
       		setoxMapper.insertOxList(s);
        }
       
        //String deleteSql = "DELETE FROM quizzes";
        
		
		//setoxMapper.insertOxList(map);
        
		return "admin/setOX";
	}
}
