package securitydb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SetLoginPage extends SimpleUrlAuthenticationSuccessHandler{
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println("[/SetLoginPage] 체크박스 값 : "+ request.getParameter("rememberId"));

		
		// 로그인된 아이디
        String memId = SecurityContextHolder.getContext().getAuthentication().getName();

        // ✅ active_id = '1' 업데이트
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            con = DriverManager.getConnection(url, "quiz", "quiz");

            String sql = "UPDATE Members SET active_id = '1' WHERE userId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, memId);
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        
		
		//아이디 저장 cookie처리
		if(request.getParameter("rememberId") != null) {
			
            Cookie cookie = new Cookie("rememberId", memId);
            cookie.setPath("/");
            cookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(cookie);
		}
		else {
			Cookie cookie = new Cookie("rememberId", null);
			cookie.setValue("");
			cookie.setPath("/"); 
			cookie.setMaxAge(60 * 60 * 24 * 30); 
			response.addCookie(cookie);
		}
		
		
		if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			response.sendRedirect("/admin");
		}
		else {
			response.sendRedirect("/home");

		}
	}
	
}