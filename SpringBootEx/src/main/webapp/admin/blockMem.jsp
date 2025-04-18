<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");
    String action = request.getParameter("action"); // block 또는 unblock

    if (userId == null || userId.trim().isEmpty() || action == null) {
        out.println("<script>alert('차단 처리에 필요한 정보가 없습니다.'); history.back();</script>");
        return;
    }

    String newBlockValue = "block".equals(action) ? "1" : "0";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        con = DriverManager.getConnection(url, "quiz", "quiz");

        String sql = "UPDATE Members SET block_id = ? WHERE userId = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, newBlockValue);
        pstmt.setString(2, userId);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            String message = "block".equals(action) ? "차단" : "차단 해제";
            out.println("<script>alert('" + userId + " 회원을 " + message + "했습니다.'); location.href='/acitivemems';</script>");
        } else {
            out.println("<script>alert('처리 실패: 회원을 찾을 수 없습니다.'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('처리 중 오류가 발생했습니다.'); history.back();</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
