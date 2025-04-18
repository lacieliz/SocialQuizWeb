package wordgame;

import org.springframework.stereotype.Service;

@Service
public class WordService {
	public void log(String msg) {
		System.out.println( "[WordService 로그]" + msg );
	}
}
