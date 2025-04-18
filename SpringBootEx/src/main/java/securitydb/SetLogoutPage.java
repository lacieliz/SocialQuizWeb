package securitydb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SetLogoutPage extends SimpleUrlLogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {

        if (authentication != null) {
            String memId = authentication.getName(); // 로그아웃 대상 ID
            //System.out.println("[/SetLogoutPage] 로그아웃 아이디 : " + memId);

            // ✅ active_id = '0'로 업데이트
            Connection con = null;
            PreparedStatement pstmt = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                String url = "jdbc:oracle:thin:@localhost:1521:xe";
                con = DriverManager.getConnection(url, "quiz", "quiz");

                String sql = "UPDATE Members SET active_id = '0' WHERE userId = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, memId);
                pstmt.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        }
        

        // ✅ 로그아웃 후 리다이렉트
        response.sendRedirect("/logon");
    }
}
