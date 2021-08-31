<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>memberUpdateAction</title>
</head>
<body>
<%
try {  
    request.setCharacterEncoding("utf-8");
    String ID = request.getParameter("ID"); //ID
    String name = request.getParameter("name"); //name
    String password = request.getParameter("password"); //password
    String classification = request.getParameter("classification"); //classification(buyer/seller)

    
    PreparedStatement pstmt = null; //declare statement
    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
    
    pstmt = conn.prepareStatement("UPDATE login SET name=?,password=?,classification=? WHERE ID=?"); //sql update query
    pstmt.setString(1, name);
    pstmt.setString(2, password);
    pstmt.setString(3, classification);
    pstmt.setString(4, ID);

    pstmt.executeUpdate(); //execute updating

    pstmt.close(); //statement exit
    conn.close(); //connection exit
  
    response.sendRedirect("memberlistform.jsp");//response  
}
catch(Exception e){
	  out.println( e );
	 }
%>
</body>
</html>
