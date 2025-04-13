package mail;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.annotation.Resource;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import securitydb.UserMapper;

@Service
@Controller

@RequestMapping
public class sendEmail {
	@Resource
	private UserMapper userMapper;
	
   @Autowired
	private JavaMailSender mailSender;
	
	private static String key;
	public void RandomKey(){
		key = Integer.toString( (int) Math.floor(Math.random()*90000)+10000);
	}
	
	@GetMapping("/sendmail")
	public String sendEmailForm() throws Exception {		
		return "mail/mailForm";
	}
	
	@PostMapping("/sendmail")
	@ResponseBody
	public String sendEmailPro( Model model, @RequestParam String email, @RequestParam(required = false) String emailVerified, 
			HttpSession session, HttpServletResponse response) {
		int checkemail = userMapper.checkEmail(email);
		
		if ("false".equals(emailVerified) && checkemail == 1) {
	        return "duplicate"; // 이메일 중복됨
	    }
		RandomKey();
		
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			message.setFrom("socialquizwebsite@gmail.com");
			message.setRecipients(MimeMessage.RecipientType.TO, email);
			message.setSubject("소셜 퀴즈 웹사이트 이메일 인증");
			String text = "";
			text += "<h1>"+"인증코드 : "+"</h1><br>";
			text += "<h2>"+key+"</h2>";
			//System.out.println(key);
			message.setText(text,"UTF-8","html");
			
			mailSender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		System.out.println("[/sendmail] 메일 전송 성공!");
		session.setAttribute("authKey",key);
        session.setAttribute("email", email);
		return "success";
	}
	
	@PostMapping("/sendmailcheck")
	@ResponseBody
	public Map<String, Object> sendEmailCheck(@RequestParam String emailAuth, HttpSession session) {
	    String storedKey = (String) session.getAttribute("authKey");
	    Map<String, Object> result = new HashMap<>();

	    if (storedKey != null && storedKey.equals(emailAuth.trim())) {
	        result.put("verified", true);
	    } else {
	        result.put("verified", false);
	    }

	    return result;
	}


	
	
	
}
