<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>product update action</title>
</head>
<body>
<%
try {  
    request.setCharacterEncoding("utf-8");
    String productname = request.getParameter("productname"); //productname
    String price = request.getParameter("price"); //price
    String name = request.getParameter("name"); //name
    String phonenumber = request.getParameter("phonenumber"); //productname
    String tradingplace = request.getParameter("tradingplace"); //trading place
    String sellmode = request.getParameter("sellmode"); //sellmode
    String due = request.getParameter("due"); //due

    
    PreparedStatement pstmt = null; //declare statement
    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
    
    pstmt = conn.prepareStatement("UPDATE product SET price=?, name=?, phonenumber=?,tradingplace=?,sellmode=?,due=? WHERE productname=?"); //sql update query
   
    pstmt.setString(1, price);
    pstmt.setString(2, name);
    pstmt.setString(3, phonenumber);
    pstmt.setString(4, tradingplace);
    pstmt.setString(5, sellmode);
    pstmt.setString(6, due);
    pstmt.setString(7, productname);

    pstmt.executeUpdate(); //execute updating

    pstmt.close(); //statement exit
    conn.close(); //connection exit
  
    response.sendRedirect("productstatus.jsp");//response  
}
catch(Exception e){
	  out.println( e );
	 }
%>
</body>
</html>
