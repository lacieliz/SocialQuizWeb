package websocket;

import org.springframework.stereotype.Service;

@Service
public class ChatService {
	public void log(String msg) {
		System.out.println( "[ChatService 로그]" + msg );
	}
}
