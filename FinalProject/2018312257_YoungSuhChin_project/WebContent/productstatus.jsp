<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>    

<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>product status</title>
<link rel="stylesheet" href="css/main.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/login-register.css"> <!-- link with css file -->
</head>
<body>
<ul>
<li></li>
</ul>

<div class="main-content">
<%
response.setContentType("text/html;charset=utf-8");
request.setCharacterEncoding("utf-8"); //set charset, encoding
Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
Connection con=null; //declare connection
Statement stmt=null; //declare statement
ResultSet rs=null; //declare result

try
{	
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
	stmt=con.createStatement();
	
	String query="select productname,price,phonenumber,tradingplace,sellmode,status,wish from product"; //sql select query 
	rs=stmt.executeQuery(query); //execute query and store in resultset object rs.	
%>
   <form class="form-register" action="memberdelete.jsp" method="post"  > <!-- goto memberdelete.jsp -->
   
   <div class="form-register-with-ID">
   <div class="form-white-background" style="width:1000px">
     <div class="form-title-row">
    <h1>Product Status for Seller</h1>
    </div>
   
   <table style="color:#5f5f5f;background-color: #f3f3f3;text-align: center;padding:10px;width:100%;margin:0px auto">
   
   <tr style="background-color:#e0d4d3"> 
   <td>product name</td> <!-- table for product name -->
   <td>current price</td> <!-- table for price -->
   <td>phone number</td> <!-- table for phone number -->
   <td>trading place</td> <!-- table for trading place -->
   <td>sell mode</td> <!-- table for sell mode -->
   <td>status</td><!-- table for status -->
   <td>wish</td> <!-- table for the number of wish -->
   <td>modify</td> <!-- table for modify -->
   <td>delete</td> <!-- table for delete -->
   </tr>
   <%
   while(rs.next()){ //get object's field value
	   %>
	   <tr>
   
	   <td><%=rs.getString("productname") %></td> <!-- get product name -->
	   <td><%=rs.getString("price") %></td> <!-- get price -->
	   <td><%=rs.getString("phonenumber") %></td> <!-- get phone number -->
	   <td><%=rs.getString("tradingplace") %></td> <!-- get trading place -->
	   <td><%=rs.getString("sellmode") %></td> <!-- get sellmode -->
	   <td><%=rs.getString("status") %></td> <!-- get status -->
	   <td><%=rs.getString("wish") %></td> <!-- get the number of wish -->
	   <td><a href="modifyproduct.jsp?mod=<%=rs.getString("productname") %>" style="text-decoration: none; color:#6caee0">modify</a></td><!-- modify member -->
	   <td><a href="deleteproduct.jsp?del=<%=rs.getString("productname") %>" style="text-decoration: none; color:#6caee0">delete</a></td><!-- delete member --> 
     </tr>
     <%
     } //end of the while
   %>
     </table>
     </div>
     <a href="uploadproduct.jsp" class="form-log-in-with-existing">Upload Product</a><!-- upload product page -->
     <a href="logout.jsp" class="form-log-in-with-existing">Logout</a> <!-- log out -->
    
   <a href="welcomeseller.jsp" class="form-log-in-with-existing">HOME</a> <!-- return to home page -seller -->
    </div>
   </form>
   <%
   rs.close(); // ResultSet exit
   stmt.close(); // Statement exit
   con.close();  // Connection exit
}
   catch(SQLException e){
   out.println("err:"+e.toString());
   }
   %>
   </div>
   
</body>
</html>
