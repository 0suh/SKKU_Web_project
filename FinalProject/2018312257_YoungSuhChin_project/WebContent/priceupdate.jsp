<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>price update</title>
</head>
<body>

<%
try {  
    request.setCharacterEncoding("utf-8");
    String price = request.getParameter("txt_price"); //price
    String productname = request.getParameter("txt_productname");//productname
    
    PreparedStatement pstmt = null; //declare statement
    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
    
    pstmt = conn.prepareStatement("UPDATE product SET price=? WHERE productname=?"); //sql update query
    pstmt.setString(1, price);
    pstmt.setString(2, productname);

    pstmt.executeUpdate(); //execute updating

    pstmt.close(); //statement exit
    conn.close(); //connection exit
  
    response.sendRedirect("productlist.jsp");//response  
}
catch(Exception e){
	  out.println( e );
	 }
%>
</body>
</html>
