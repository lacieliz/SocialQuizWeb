<%
	            int rank = 1;
	            while (rs.next()) {
	                String rankClass = "";
	                if (rank == 1) rankClass = "first-place";
	                else if (rank == 2) rankClass = "second-place";
	                else if (rank == 3) rankClass = "third-place";
	        %>
	            <tr class="<%= rankClass %>">
	                <td><%= rank %></td>
	                <td><img src="<%= request.getContextPath() %>/images/sample_profile.png" class="profile-img" alt="profile"></td>
	                <td><%= rs.getString("nickname") %></td>
	                <td><%= rs.getInt("rank_score") %></td>
	                <td><%= rs.getInt("rank_time") %>초</td>
	                <td><div class="status-dot"></div></td>
	                <td><button class="action-btn">정보</button></td>
	            </tr>
	        <%
	                rank++;
	            }
	        %>