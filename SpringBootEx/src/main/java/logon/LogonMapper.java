package logon;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LogonMapper {
	public LogonDataBean getMember( String userId );
	public int modifyMember( LogonDataBean memberDto );
	public String findPasswd(String userId);
	public int changePasswd(LogonDataBean logonDto);
}
