package security;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan( basePackages={"login","admin", "mb", "logon", "board","qna","control.", 
		"websocket", "securitydb","game.","rank" ,"mail","setgame"} )

@MapperScan( basePackages= {"login", "admin", "logon", "board", "qna", "quiz.oxgame",
		"quiz.wordGame", "securitydb", "game.","rank", "mail","setgame"} )

public class SecurityApplication {
	public static void main(String[] args) {
		SpringApplication.run( SecurityApplication.class, args );
	}
}