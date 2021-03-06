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
    String productname = request.getParameter("mod"); // data "productname" sent when modify button was clicked 
  
 try {
	 //the modify pageConnection 
    PreparedStatement pstmt = null; //declare statement
    ResultSet rs = null; //declare result

    Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
   
   	pstmt = con.prepareStatement("SELECT  productname,price,name,phonenumber,tradingplace,sellmode,due from product WHERE productname=?");//sql insert query
    pstmt.setString(1,productname);
    rs = pstmt.executeQuery();//execute query
    rs.next(); //use the result value
%>

<ul>
<li><h1>PRODUCT MODIFICATION</h1></li>
</ul>
<div class="main-content">
    <form class="form-register" action = "productupdateaction.jsp" method="post" > <!-- when click the complete button, inserted data go to productupdateaction.jsp -->

<div class="form-register-with-ID">
 <div class="form-white-background">
 		<div class="form-row">
  		<label>
        <span>product name</span>
        <input type="text" name="productname" id="productname" value=<%=rs.getString("productname")%> readonly> <br> <!-- get product name -->
        </label>
        </div>
        
        <div class="form-row">
     	<label>
        <span>price</span>
        <input type="text" name="price" id="price" value=<%=rs.getString("price")%>> <br> <!-- get price -->
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
        <span>phone number</span>
        <input type="text" name="phonenumber" id="phonenumber" value=<%=rs.getString("phonenumber")%>> <br> <!-- get phone number -->
       	</label>
       	</div>
       	
       	 <div class="form-row">
        <label>
        <span>trading place</span>
        <input type="text" name="tradingplace" id="tradingplace" value=<%=rs.getString("tradingplace")%>> <br> <!-- get trading place -->
       	</label>
       	</div>
       	
       	<div class="form-row">
        <label>
        <span>sell mode</span>
        <input type="text" name="sellmode" id="sellmode" value=<%=rs.getString("sellmode")%>> <br> <!-- get sell mode-->
       	</label>
       	</div>
       	
       		<div class="form-row">
        <label>
        <span>due date</span>
        <input type="time" name="due" id="due" value=<%=rs.getString("due")%>> <br> <!-- get due date-->
       	</label>
       	</div>
       
        <input type="submit" value="modification complete"> <!-- if modification is completed, click the button -->
    </div>
   <a href="logout.jsp" class="form-log-in-with-existing">Logout</a> <!-- log out -->
    
   <a href="welcomeseller.jsp" class="form-log-in-with-existing">HOME</a> <!-- return to home page -seller -->
     <a href="productstatus.jsp" class="form-log-in-with-existing">Product Status</a> <!-- return to product status page -->
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
