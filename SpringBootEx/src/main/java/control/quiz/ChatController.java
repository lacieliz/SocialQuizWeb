package control.quiz;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ChatController {

    @GetMapping("/chatmain")
    public String MultiChatMain() {
        return "websocket/ChatWindow";  
    }
    
    @PostMapping("/chatmain")
    public String chatWindow() {
        return "websocket/ChatWindow";  
    }
}
