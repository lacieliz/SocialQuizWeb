<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 랭킹</title>
    <style>
        body {
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
        }

        .rank-container {
            max-width: 800px;
            margin-top: 0px !important;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 20px;
            position: relative;
            height: 400px;
            overflow: hidden;
        }

        .rank-table {
            position: absolute;
            width: 100%;
            top: 0;
            left: 0;
            transition: all 0.6s ease-in-out;
            opacity: 0;
            transform: translateX(-100%);
        }

        .rank-table.active {
            opacity: 1;
            transform: translateX(0%);
            z-index: 1;
        }

        .rank-header-title {
            background-color: #000 !important;
            color: #fff !important;
            font-weight: bold;
            font-size: 16px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        th {
            color: #fff;
            padding: 10px 12px !important;
            text-align: center;
            height: 48px;
            background-color: #222;
        }

        td {
            padding: 12px 12px !important;
            text-align: center;
            font-size: 15px;
            height: 48px;
        }

        .text-center {
            text-align: center;
        }

        .status-dot {
            width: 8px !important;
            height: 8px !important;
            border-radius: 50% !important;
            background-color: gray;
            display: inline-block !important;
            margin: 0 auto !important;
            line-height: 0 !important;
            padding: 0 !important;
        }

        tr.rank-1 td {
            background-color: #fff8dc !important;
        }
        tr.rank-2 td {
            background-color: #f0f0f0 !important;
        }
        tr.rank-3 td {
            background-color: #fbe5d6 !important;
        }
    </style>
</head>
<body>

<!-- ✅ 랭킹 박스 -->
<div class="rank-container">
<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

String[] gameIds = {"1", "2"};
String[] divIds = {"ox", "word"};
String[] gameTitles = {"OX게임", "끝말잇기"};

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "quiz", "quiz");
    stmt = con.createStatement();

    for (int g = 0; g < 2; g++) {
        String sql = "SELECT m.nickname, m.active_id, MAX(gr.game_score) AS rank_score, COUNT(*) AS play_count " +
                     "FROM Members m JOIN game_records gr ON m.userId = gr.userId " +
                     "WHERE gr.game_id = " + gameIds[g] +
                     " GROUP BY m.nickname, m.active_id ORDER BY rank_score DESC, play_count ASC";

        rs = stmt.executeQuery(sql);
%>
    <div id="rank-<%= divIds[g] %>" class="rank-table <%= (g == 0 ? "active" : "") %>">
        <table class="table">
            <thead>
                <tr><th colspan="5" class="rank-header-title"><%= gameTitles[g] %> 랭킹</th></tr>
                <tr>
                    <th class="text-center">순위</th>
                    <th class="text-center">닉네임</th>
                    <th class="text-center">점수</th>
                    <th class="text-center">판수</th>
                    <th class="text-center">상태</th>
                </tr>
            </thead>
            <tbody>
<%
        int i = 0;
        while (rs.next() && i < 5) {
            String rankDisplay = "";
            switch (i) {
                case 0: rankDisplay = "🥇"; break;
                case 1: rankDisplay = "🥈"; break;
                case 2: rankDisplay = "🥉"; break;
                default: rankDisplay = String.valueOf(i + 1); break;
            }

            String activeId = rs.getString("active_id");
            String dotColor = "1".equals(activeId) ? "green" : "red";
%>
                <tr class="rank-<%= (i + 1) %>">
                    <td class="text-center"><%= rankDisplay %></td>
                    <td class="text-center"><%= rs.getString("nickname") %></td>
                    <td class="text-center"><%= rs.getInt("rank_score") %></td>
                    <td class="text-center"><%= rs.getInt("play_count") %>판</td>
                    <td class="text-center" style="padding: 4px; vertical-align: middle;">
                        <div class="status-dot" style="background-color: <%= dotColor %>;"></div>
                    </td>
                </tr>
<%
            i++;
        }
%>
            </tbody>
        </table>
    </div>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
</div>

<!-- ✅ 슬라이드 전환 스크립트 -->
<script>
    const rankIds = ['ox', 'word'];
    let currentIndex = 0;

    function rotateRank() {
        const currentEl = document.getElementById('rank-' + rankIds[currentIndex]);
        const nextIndex = (currentIndex + 1) % rankIds.length;
        const nextEl = document.getElementById('rank-' + rankIds[nextIndex]);

        currentEl.style.transition = 'all 0.6s ease-in-out';
        currentEl.style.transform = 'translateX(100%)';
        currentEl.style.opacity = '0';

        nextEl.style.transition = 'none';
        nextEl.style.transform = 'translateX(-100%)';
        nextEl.style.opacity = '0';
        nextEl.classList.add('active');

        requestAnimationFrame(() => {
            nextEl.style.transition = 'all 0.6s ease-in-out';
            nextEl.style.transform = 'translateX(0%)';
            nextEl.style.opacity = '1';
        });

        setTimeout(() => {
            currentEl.classList.remove('active');
            currentEl.style.transition = 'none';
            currentEl.style.transform = 'translateX(-100%)';
        }, 600);

        currentIndex = nextIndex;
    }

    window.onload = () => {
        setInterval(rotateRank, 5000);
    };
</script>

</body>
</html>