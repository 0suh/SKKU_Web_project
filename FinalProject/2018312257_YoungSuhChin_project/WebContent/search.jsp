<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@ page import="java.util.Date" %>
 
<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>member modification</title>

<link rel="stylesheet" href="css/main.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/login-register.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/market.css"> <!-- link with css file -->

</head>
<body>
<%

    request.setCharacterEncoding("utf-8");
    String productname = request.getParameter("s_productname"); // data "s_productname" sent when search button was clicked 
  	String sellername=request.getParameter("s_sellername");  // data "s_sellername" sent when search button was clicked 
 try {
    	
    PreparedStatement pstmt = null; //declare statement
    ResultSet rs = null; //declare result

    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
   
   	pstmt = con.prepareStatement("select productname,price,name,phonenumber,tradingplace,sellmode,status,wish from product where productname=? and name=?");//sql select query
    pstmt.setString(1,productname);
   	pstmt.setString(2,sellername);
    rs = pstmt.executeQuery();//execute query
    rs.next(); //use the result value
%>

<ul>
<h1>SKKU Flea Market _for buyer</h1>
<!-- menu -->
<li><a href="welcomebuyer.jsp">Home</a></li>
<li><a href="productlist.jsp">Product List</a></li>
<li><a href="contact.jsp">Contact Us</a></li>
<li><a href="logout.jsp">Logout</a></li>
</ul>

<div class="main-content">

  <div class="form-register"  > 
<div class="form-register-with-ID">
 <div class="form-white-background" style="width:1000px">
 <div class="form-title-row">
    <h1>Search</h1>
    </div>
<!-- search result -->
<table style="color:#5f5f5f;background-color: #f3f3f3;text-align: center;padding:10px;width:100%;margin:0px auto">
   <!-- table for product list -->
   <tr style="background-color:#e0d4d3"> 
   <td>product name</td> <!-- table for product name -->
   <td>current price</td> <!-- table for price -->
   <td>name</td> <!-- table for name -->
   <td>phone number</td> <!-- table for phone number -->
   <td>trading place</td> <!-- table for trading place -->
   <td>sell mode</td> <!-- table for sell mode -->
   <td>status</td><!-- table for status -->
   <td>wish</td><!-- table for status -->
   <td>details</td> <!-- table for product details -->
   
   <tr>
   
	   <td><%=rs.getString("productname") %></td> <!-- get product name -->
	   <td><%=rs.getString("price") %></td> <!-- get price -->
	   <td><%=rs.getString("name") %></td> <!-- get name -->
	   <td><%=rs.getString("phonenumber") %></td> <!-- get phone number -->
	   <td><%=rs.getString("tradingplace") %></td> <!-- get trading place -->
	   <td><%=rs.getString("sellmode") %></td> <!-- get sell mode -->
	   <td><%=rs.getString("status") %></td> <!-- get status -->
	   <td><%=rs.getString("wish") %></td> <!-- get the number of wish -->
	   <td><a href="productdetails.jsp?mod=<%=rs.getString("productname") %>" style="text-decoration: none; color:#6caee0">see</a></td><!-- see the product details -->
	      </tr>
	      
	          </table>
        
    </div>

     <a href="productlist.jsp" class="form-log-in-with-existing">BACK</a> <!-- return to product list page -->
  
   </div>
 </div>
<%
}

 catch(Exception e){
 out.println( e );
}
%>

</div>

</body>
</html>
