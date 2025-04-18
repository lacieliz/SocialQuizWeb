package securitydb;

import org.apache.ibatis.annotations.Mapper;

import logon.LogonDataBean;

import java.util.Optional;
@Mapper
public interface UserMapper {    
	Optional<User> findByUserId( String userId );
	int insertUser( User user );
	
	//checkSQL
	int checkId(String userId);
	int checkEmail(String email);
	int checkNickname(String nickname);
	int checkPwd(String userId, String passwd);

	String findId(String email);
	String findPasswd(String userId);
	public int changePasswd(User user);
	int deleteUser(String id);
	public int modifyMember( User user );
}

