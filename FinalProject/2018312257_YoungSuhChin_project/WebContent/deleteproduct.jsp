<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>

<%
 request.setCharacterEncoding("utf-8");
 String productname = request.getParameter("del");

 try{
	 Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
  Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
  Statement stat = con.createStatement();

  String query = "delete from product where productname='" + request.getParameter("del")+"'"; //sql delete query 

  stat.executeUpdate(query); //return 1.
  stat.close(); // Statement exit
  con.close(); // Connection exit
  response.sendRedirect("productstatus.jsp");//return to product status page
 }

  catch(Exception e){
  out.println( e );
 }
 %>
