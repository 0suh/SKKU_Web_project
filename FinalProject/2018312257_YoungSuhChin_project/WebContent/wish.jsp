<%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>

<%
 request.setCharacterEncoding("utf-8");
 String productname = request.getParameter("wish");

 try{
	 PreparedStatement pstmt = null; //declare statement
	 Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
  	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
 
  	pstmt=con.prepareStatement( "update product set wish=wish+1 where productname='" + request.getParameter("wish")+"'");//sql update query 
 //add the number of wish(wish=wish+1)
  pstmt.executeUpdate(); 
  
  pstmt.close(); // Statement exit
  con.close(); // Connection exit
  response.sendRedirect("productlist.jsp");
 }

  catch(Exception e){
  out.println( e );
 }
 %> 