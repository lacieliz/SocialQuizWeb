<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../setting.jsp"%>
<link rel="stylesheet" href="/rank/myrecord.css">

<%! 
    public String formatDateTime(Timestamp ts) {
        if (ts == null) return "";
        return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(ts);
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. userId 파라미터가 있으면 해당 유저 조회, 없으면 세션에서 로그인 유저 조회
    String targetId = request.getParameter("userId");
    String sessionId = (String) session.getAttribute("memId");

    if (targetId == null) {
        if (sessionId == null) {
            response.sendRedirect("/logonlogin"); // 로그인 안 했으면 로그인 페이지로
            return;
        }
        targetId = sessionId;
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String nickname = "", auth = "", email = "";
    Timestamp createdAt = null;
    int oxScore = 0, wordScore = 0, liarScore = 0;
    String oxRecent = "-", wordRecent = "-", liarRecent = "-";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "quiz", "quiz");

        // 2. 유저 정보 조회
        String sql = "SELECT nickname, auth, email, created_at FROM Members WHERE userId = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, targetId);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            nickname = rs.getString("nickname");
            auth = "admin".equalsIgnoreCase(rs.getString("auth")) ? "관리자" : "사용자";
            email = rs.getString("email");
            createdAt = rs.getTimestamp("created_at");
        }
        rs.close();
        pstmt.close();

     // 3. 게임별 최고 점수와 최근 플레이 날짜 (game_id 기준 조회)
        sql = "SELECT gr.game_id, MAX(gr.game_score) AS max_score, MAX(gr.record_time) AS recent_play " +
              "FROM game_records gr WHERE gr.userId = ? GROUP BY gr.game_id";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, targetId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int gid = rs.getInt("game_id");
            int score = rs.getInt("max_score");
            Timestamp recent = rs.getTimestamp("recent_play");  // ✅ 수정


            if (gid == 1) {
                oxScore = score;
                oxRecent = formatDateTime(recent);
            } else if (gid == 2) {
                wordScore = score;
                wordRecent = formatDateTime(recent);
            } else if (gid == 3) {
                liarScore = score;
                liarRecent = formatDateTime(recent);
            }
        }


    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<body>

<div class="record-container">
  <h2 class="record-title"><%= nickname %>님의 게임전적</h2>
  <table class="info-table">
    
    <tr><th>닉네임</th><td><%= nickname %></td></tr>
    <tr><th>회원 유형</th><td><%= auth %></td></tr>
    <tr><th>가입일</th><td><%= formatDateTime(createdAt) %></td></tr>

    <tr><th>OX게임 최고 점수</th><td><%= oxScore %>점</td></tr>
    <tr><th>OX게임 최근 플레이</th><td><%= oxRecent %></td></tr>

    <tr><th>끝말잇기 최고 점수</th><td><%= wordScore %>점</td></tr>
    <tr><th>끝말잇기 최근 플레이</th><td><%= wordRecent %></td></tr>

    <tr><th>라이어게임 최고 점수</th><td><%= liarScore %>점</td></tr>
    <tr><th>라이어게임 최근 플레이</th><td><%= liarRecent %></td></tr>

  </table>
</div>

</body>
</html>
