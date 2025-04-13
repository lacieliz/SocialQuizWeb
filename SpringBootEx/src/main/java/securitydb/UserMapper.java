package securitydb;

import org.apache.ibatis.annotations.Mapper;
import java.util.Optional;
@Mapper
public interface UserMapper {    
	Optional<User> findByUserId( String userId );
	int insertUser( User user );
	
	//checkSQL
	int checkId(String userId);
	int checkEmail(String email);
	int checkNickname(String nickname);
	
	String findId(String email);
}

