package control.oxgame;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import game.OxDBBean;
import game.OxDataBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

import java.sql.*; // ✅ DB 직접 조회용 추가

@Controller
@RequestMapping("quiz/startox")
public class StartOX {

	@Resource
	private OxDBBean oxDao;

	@GetMapping
	public String oxForm(HttpSession session, Model model) {

		String memId = (String) session.getAttribute("memId");

		if (memId != null) {
			String blockId = getBlockId(memId); // ✅ 차단 여부 조회

			if ("1".equals(blockId)) {
				model.addAttribute("error", "차단된 회원은 OX게임을 이용할 수 없습니다.");
				return "home/gameBlocked"; // ❗ 차단 메시지용 JSP 필요
			}
		}

		return "quiz/oxGame/oxForm";
	}

	@PostMapping
	public String oxPro(@RequestBody OxDataBean oxDto, Model model, HttpSession session) throws Exception {
		int result = oxDao.submitScore(oxDto);

		if (result == 1)
			session.setAttribute("memId", oxDto.getUserId());

		model.addAttribute("result", result);
		return "quiz/oxGame/oxPro";
	}

	// ✅ block_id 조회 메서드
	private String getBlockId(String userId) {
		String blockId = "0"; // 기본값
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
