<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
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
    String ID = request.getParameter("mod"); // data "ID" sent when modify button was clicked 
  
 try {//the modify pageConnection 
    	
    PreparedStatement pstmt = null; //declare statement
    ResultSet rs = null; //declare result

    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
   
   	pstmt = con.prepareStatement("SELECT ID,name,password,classification FROM login WHERE ID=?");//sql insert query
    pstmt.setString(1,ID);
    rs = pstmt.executeQuery();//execute query
    rs.next(); //use the result value
%>

<ul>
<li></li>
</ul>
<div class="main-content">
    <form class="form-register" action = "memberUpdateAction.jsp" method="post" > <!-- when click the complete button, inserted data go to memberUpdateAction.jsp -->

<div class="form-register-with-ID">
 <div class="form-white-background">
 		<div class="form-row">
  		<label>
        <span>ID</span>
        <input type="text" name="ID" id="ID" value=<%=rs.getString("id")%> readonly> <br> <!-- get ID -->
        </label>
        </div>
        
        <div class="form-row">
     	<label>
        <span>name</span>
        <input type="text" name="name" id="name" value=<%=rs.getString("name")%>> <br> <!-- get name -->
        </label>
        </div>
        
        <div class="form-row">
        <label>
        <span>password</span>
        <input type="text" name="password" id="password" value=<%=rs.getString("password")%>> <br> <!-- get password -->
       	</label>
       	</div>
       	
       	<div class="form-row">
        <label>
        <span>classification<br>(buyer/seller)</span>
        <input type="text" name="classification" id="classification" value=<%=rs.getString("classification")%>> <br> <!-- classification -->
       	</label>
       	</div>
       
        <input type="submit" value="modification complete"> <!-- if modification is completed, click the button -->
    </div>
   
    
    <a href="register.jsp" class="form-log-in-with-existing">Return to register page</a> <!-- return to register page -->
    <a href="memberlistform.jsp" class="form-log-in-with-existing">Return to member list</a> <!-- return to administrator - member list page -->
 </div>
 </form>
<%
}

 catch(Exception e){
 out.println( e );
}
%>
</div>

</body>
</html>
