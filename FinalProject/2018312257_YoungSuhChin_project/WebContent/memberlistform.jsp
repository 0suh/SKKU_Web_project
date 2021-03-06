<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>    

<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>member list</title>
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
	
	String query="select ID, name, password, classification from login"; //sql select query 
	rs=stmt.executeQuery(query); //execute query and store in resultset object rs.	
%>
   <form class="form-register" action="memberdelete.jsp" method="post"> <!-- submit->goto memberdelete.jsp -->
   
   <div class="form-register-with-ID">
   <div class="form-white-background">
     <div class="form-title-row">
    <h1>Member List</h1>
    </div>
   
   <table style="color:#5f5f5f;background-color: #f3f3f3;text-align: center;padding:10px;width:100%;margin:0px auto">
   
   <tr style="background-color:#e0d4d3"> 
   <td>ID</td> <!-- table for ID -->
   <td>name</td> <!-- table for name -->
   <td>password</td> <!-- table for password -->
   <td>classification(Buyer/Seller)</td> <!-- table for classification -->
   <th>Modify</th> <!-- table for modify -->
   <th>Delete</th> <!-- table for delete -->
   </tr>
   <%
   while(rs.next()){ //get object's field value
	   %>
	   <tr>
   
	   <td><%=rs.getString("ID") %></td> <!-- get ID -->
	   <td><%=rs.getString("name") %></td> <!-- get name -->
	   <td><%=rs.getString("password") %></td> <!-- get password -->
	   <td><%=rs.getString("classification") %></td> <!-- get classification -->
	   <td><a href="membermodify.jsp?mod=<%=rs.getString("ID") %>" style="text-decoration: none; color:#6caee0">modify</a></td><!-- modify member -->
	   <td><a href="memberdelete.jsp?del=<%=rs.getString("ID") %>" style="text-decoration: none; color:#6caee0">delete</a></td><!-- delete member --> 
     </tr>
     <%
     } //end of the while
   %>
     </table>
     </div>
     <a href="index.jsp" class="form-log-in-with-existing">Return to login page</a> <!-- return to login page -->
    
   <a href="register.jsp" class="form-log-in-with-existing">Return to register page</a> <!-- return to register page -->
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
