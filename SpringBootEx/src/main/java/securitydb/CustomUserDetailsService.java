package securitydb;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final UserMapper userMapper;
    private User user;
    public CustomUserDetailsService( UserMapper userMapper) {
        this.userMapper = userMapper;
    }
	
    @Override
    public UserDetails loadUserByUsername( String userId ) throws UsernameNotFoundException {	   
    	
       	 user = userMapper.findByUserId( userId )
       			.orElseThrow(() -> 
       			new UsernameNotFoundException( "User not found" ));

       	System.out.println("로그인 들어옴"+userId);
       	System.out.println("[/CustomUserDetail] : " + user.getPasswd());
      	return new org.springframework.security.core.userdetails.User(
       		user.getUserId(), user.getPasswd(),
			Collections.singletonList( new SimpleGrantedAuthority( user.getAuth() ) )
      	);
  	}
    
    public User getUser() {
    	return user;
    }
    
}