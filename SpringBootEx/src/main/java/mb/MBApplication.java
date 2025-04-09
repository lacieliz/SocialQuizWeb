package mb;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan( basePackages={ "mb", "logon", "board", "qna","mail" ,"control.quiz",
		"control.oxgame","control.wordgame", "control.logon", 
		"control.board","control.qna", "websocket" } )
@MapperScan( basePackages= { "logon", "board", "qna","mail", "quiz.oxgame","quiz.wordGame" } )
public class MBApplication {
	public static void main(String[] args) {
		SpringApplication.run( MBApplication.class );		
	}
}

// localhost:8080/logonmain
// localhost:8080/boardlist
