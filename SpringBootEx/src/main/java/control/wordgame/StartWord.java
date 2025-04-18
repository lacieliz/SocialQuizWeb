package control.wordgame;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import game.WordDBBean;
import game.WordDataBean;

import java.sql.*;
import java.util.Map;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("quiz/startword")
public class StartWord {

    @Autowired
    private WordDBBean wordDBBean;

    @GetMapping
    public String play(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("memId");

        if (memId != null) {
            String blockId = getBlockId(memId);

            if ("1".equals(blockId)) {
                model.addAttribute("error", "차단된 회원은 끝말잇기를 이용할 수 없습니다.");
                return "home/gameBlocked";
            }
        }

        return "quiz/wordGame/wordForm";
    }

    // ✅ 점수 저장 (POST)
    @PostMapping
    @ResponseBody
    public Map<String, Object> saveWordScore(@RequestBody WordDataBean dto) {
        System.out.println("끝말잇기 점수 저장 요청: " + dto);
        wordDBBean.insertGameRecord(dto);
        return Map.of("result", "success");
    }

    // ✅ block_id 조회 메서드 (OX와 동일)
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
