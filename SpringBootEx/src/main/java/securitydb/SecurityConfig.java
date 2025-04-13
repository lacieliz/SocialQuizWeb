package securitydb;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	private final UserDetailsService userDetailsService;
  	public SecurityConfig( UserDetailsService userDetailsService ) {
      	this.userDetailsService = userDetailsService;
   	}	 
   	
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public AuthenticationManager authenticationManager( AuthenticationConfiguration authenticationConfiguration) 
		throws Exception {
      	return authenticationConfiguration.getAuthenticationManager();
    }  	
    
	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return web -> web.ignoring()
				.requestMatchers("/static/board/**", "/static/logon/**", "/resources/**");
	}
	
	@Bean
	public SecurityFilterChain filterChain( HttpSecurity http ) throws Exception {		
		
		http.csrf(
			AbstractHttpConfigurer::disable
		).authorizeHttpRequests(
			authz -> authz.requestMatchers("/fail", "/signup/**","/home/**", 
					"/login/**", "/logon/**", "/input/**", "/security/**", 
					"main", "/sendmail/**", "/sendmailcheck", "/mail/**",
					"/findid", "/findpwd","/deleteuser","/user/**","/securitydb/**","/modifyuser").permitAll()
					.requestMatchers( "/member/**").hasRole( "MEMBER" )
					.requestMatchers( "/admin/**" ).hasRole( "ADMIN" )
					.anyRequest().authenticated()
		).httpBasic(
			Customizer.withDefaults()
		).formLogin(
			f -> f.loginPage( "/logon" )
				.usernameParameter( "userId" )
				.passwordParameter( "passwd" )
				.failureUrl("/fail")
			    .successHandler(new SetLoginPage())
		).logout(
			f -> f.logoutUrl( "/logout" )
				.invalidateHttpSession( true )				
				.deleteCookies( "JSESSIONID")			
				.logoutSuccessUrl( "/logon" )
		);
		
		return http.build();
	}
}
