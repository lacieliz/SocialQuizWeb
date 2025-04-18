package control.websocket;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.sql.*;

@Controller
@RequestMapping("socketword")
public class SocketWord {

    @GetMapping
    public String websocket(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("memId");

        if (memId != null) {
            String blockId = getBlockId(memId);

            if ("1".equals(blockId)) {
                model.addAttribute("error", "차단된 회원은 채팅에 참여할 수 없습니다.");
                return "home/gameBlocked";
            }
        }

        return "websocket/MultiChatMain";
    }

    @PostMapping
    public String openChat(@RequestParam("nickname") String nickname, Model model) {
        model.addAttribute("nickname", nickname);
        return "websocket/ChatWindow";
    }

    // ✅ block_id 조회 메서드
    private String getBlockId(String userId) {
        String blockId = "0";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            con = DriverManager.getConnection(url, "quiz", "quiz");

            String sql = "SELECT block_id FROM Members WHERE userId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                blockId = rs.getString("block_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return blockId;
    }
}
