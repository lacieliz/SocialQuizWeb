<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException"%>

<h2> JDBC - problem-answer insert</h2>

<%
   request.setCharacterEncoding("utf-8");
%>
<%

%>

<%
   Connection con = null;
   Statement stmt = null;
   
   try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbid = "quiz";
        String dbpasswd = "quiz";
        con = DriverManager.getConnection(url, dbid, dbpasswd);
        stmt = con.createStatement();
      	// 이게 초기화를 안하면 값이 번호가 다르게 들어가거나 할때가 많아서 
      	// DB를 제거하고 다시 넣는게 오래 걸리긴 하지만 이렇게 넣었음
      	
      	
        //String id[] = request.getParameterValues("qid_QnA");
        String questions[] = request.getParameterValues("Q");
        String answers[]= new String[questions.length];
        String scores[] = request.getParameterValues("S");
        for(int i=0; i<questions.length;i++){
        	   String temp[] = request.getParameterValues("answer"+i);
        	   answers[i] = temp[0];
        }
       
      	
        String deleteSql = "DELETE FROM quizzes";
        stmt.executeUpdate(deleteSql);
        
        
        for(int i=0; i< questions.length; i++){
           String sql = "insert into quizzes(quiz_id, game_id, category_id, question, answer, score) "
        		           +"values ("+(100+i)+", 1111, 0, '"+questions[i]+"', '"+answers[i]+"',"+ Integer.parseInt(scores[i])+")";
           int result = stmt.executeUpdate(sql);
        
           if(result == 0){
	       %>
	        insert에 실패하였습니다. <br>
	       <%}
        }
      
   }catch(SQLException e){
	   e.printStackTrace();
   }finally{
	   try{
		   if(stmt != null) stmt.close();
		   if(con != null) con.close();
	   }catch(SQLException e){
		   e.printStackTrace();
	   }
   }
   
%>