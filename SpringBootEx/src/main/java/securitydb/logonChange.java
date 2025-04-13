
package securitydb;

/*@Controller
@RequestMapping("/logonchangepwd")
public class logonChange {
	@Resource
	private LogonDBBean logonDao;
	
	@GetMapping
	public String changePwdForm() throws Exception {
		return "member/changePwdForm";
	}
	
	@PostMapping
	public String changePwdPro(@ModelAttribute LogonDataBean logonDto, @RequestParam String userId, @RequestParam String passwd,
			@RequestParam String repasswd, Model model, HttpSession session ) throws Exception {		
		
		String email = (String) session.getAttribute("email");
		String Id = logonDao.findId(email);
		String Passwd = logonDao.findPasswd(userId);
		
	      if(!Id.equals(userId)) {				// 아까 이메일 인증받은게 아이디가 user_id랑 똑같은지 확인하고 처리
	    	  model.addAttribute("result", 0);
	      } else if(Passwd.equals(passwd)) {	// 비밀번호가 기존 비밀번호랑 같은지 확인하고 처리
	    	  model.addAttribute("result", 2);  
	      } else {
	    	  logonDao.changePasswd(logonDto);
	    	  model.addAttribute("result", 1);
	      }
	      	
	      return "member/changePwdPro";
		    
		}
} */







