<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>

<%
 request.setCharacterEncoding("utf-8");
 String productname = request.getParameter("buy");

 try{
	 PreparedStatement pstmt = null; //declare statement
	 Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
  	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
 
  	pstmt=con.prepareStatement( "update product set status=? where productname='" + request.getParameter("buy")+"'");//sql update query 
  
  pstmt.setString(1, "sold");//to change the status=sold
  pstmt.executeUpdate(); 
  
  pstmt.close(); // Statement exit
  con.close(); // Connection exit
  response.sendRedirect("productlist.jsp");//return to product list
 }

  catch(Exception e){
  out.println( e );
 }
 %> 