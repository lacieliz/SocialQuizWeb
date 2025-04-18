package wordgame;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import websocket.CustomSpringConfigurator;

@ServerEndpoint( value = "/WordGame", configurator = CustomSpringConfigurator.class )
public class WordServer {
	
	@Autowired
	private WordService wordService;
	
	private static final Map<String, Set<Session>> gameRooms = new ConcurrentHashMap<>();
    private static final Map<Session, String> userNames = new ConcurrentHashMap<>();
    private static final Map<Session, String> gameTypes = new ConcurrentHashMap<>();
    private static final Map<String, String> lastWordInRoom = new ConcurrentHashMap<>();
	
	private static Set<Session> clients = 
			Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session session) throws IOException {
		clients.add(session);
		System.out.println("끝말잇기 웹소켓 연결: " + session.getId());
		
		broadcast( "SYSTEM|현재 접속자 수:" + clients.size());
		
	}
	
	@OnMessage
	public void onMessage(String message, Session session) throws IOException{
		if( message.startsWith( "JOIN|" )) {
			String[] parts = message.split("\\|");
			String gameType= parts[1];	// wordgame 부분
			String nickname = parts[2];	// nickname 부분
			
			gameRooms.putIfAbsent(gameType, ConcurrentHashMap.newKeySet());
			gameRooms.get(gameType).add(session);
			userNames.put(session, nickname);
			gameTypes.put(session, gameType );
			
			if (!lastWordInRoom.containsKey(gameType)) {
		        lastWordInRoom.put(gameType, "사과"); // 고정 시작 단어
		        session.getBasicRemote().sendText("SYSTEM|[wordgame] Start! 첫 단어는 '사과'입니다!");
		    } else {
		        session.getBasicRemote().sendText("[" + gameType + "] 게임에 참가했습니다.");
		    }
			return;
		}
		
		// 게임방에 참여한 후 메시지 처리
        String nickname = userNames.get(session);
        String gameType = gameTypes.get(session);
        Set<Session> room = gameRooms.get(gameType);
        
        // ✅ 메시지를 nickname|단어 형식으로 분리
        String[] msgParts = message.split("\\|");
        if (msgParts.length < 2) {
            session.getBasicRemote().sendText("SYSTEM|❌ 잘못된 메시지 형식입니다.");
            return;
        }

        String sender = msgParts[0];
        String currentWord = msgParts[1].trim();

        
        // 끝말잇기 룰 체크
        String lastWord = lastWordInRoom.get(gameType);

        if (lastWord != null) {
            char lastChar = lastWord.charAt(lastWord.length() - 1);
            char firstChar = currentWord.charAt(0);
            if (lastChar != firstChar) {
                session.getBasicRemote().sendText("❌ 단어는 [" + lastChar + "]로 시작해야 합니다! 다시 입력하세요.");
                return;
            }
        }

        // 단어 업데이트
        lastWordInRoom.put(gameType, currentWord);

        // 같은 게임방의 모든 세션에 메시지 전송
        for (Session s : room) {
            if (s.isOpen()) {
                s.getBasicRemote().sendText("💬 [" + nickname + "] : " + currentWord);
            }
        }
       	/*
		System.out.println(session.getId() + ":" + message);
		synchronized (clients) {
			for(Session client : clients) {
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
		*/
	}
	
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("웹소켓 종료 : " + session.getId());
	}
	
	@OnError
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
	
	private void broadcast(String message) throws IOException {
		synchronized ( clients ) {
			for ( Session client : clients ) {
				if( client.isOpen()) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}
	
	public static int getActiveMember() {
		int count = 0;
		synchronized (clients) {
			for ( Session client : clients ) {
				if( client.isOpen()) {
					count++;
				}
			}
		}
		return count;
	}
}
