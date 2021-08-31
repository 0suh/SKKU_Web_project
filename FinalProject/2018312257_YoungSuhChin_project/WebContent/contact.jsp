<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
 <%
try
{
	Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root");  //create connection
	
	if(request.getParameter("btn_message")!=null) //check register button click event not null
	{
		String name,address,classification,message;
		
		name=request.getParameter("txt_name"); //txt_name
		address=request.getParameter("txt_address"); //txt_address
		classification=request.getParameter("txt_classification"); //txt_classification
		message=request.getParameter("txt_message"); //txt_message
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("insert into contactmessage(name,address,classification,message) values(?,?,?,?)"); //sql insert query
		pstmt.setString(1,name);
		pstmt.setString(2,address);
		pstmt.setString(3,classification);
		pstmt.setString(4,message);
		
		pstmt.executeUpdate(); //execute query
		
		request.setAttribute("successMsg","Successful message transmission!"); //success messeage

		con.close(); //close connection
	}
	
}
catch(Exception e)
{
	out.println(e);
}


			
%>  
 
 
 
<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<title>Welcome! SKKU Flea Market for seller</title>

<link rel="stylesheet" href="css/main.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/login-register.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/market.css"> <!-- link with css file -->

</head>
<body>

<ul>

<li><div class="contact"><h1>Contact Us</h1></div></li>
</ul>

   
    <div class="main-content">
   
      <form class="form-register" method="post">
       <div class="form-register-with-ID">
       <div class="form-white-background">
       <p style="color:#2E9AFE">				   		
					<% 
					 
					if(request.getAttribute("successMsg")!=null)
					{
						out.println(request.getAttribute("successMsg")); //register success message
					}
					%>
					</p>
      <div class="form-row">
     <label>
    <span>name</span>
     <input type="text" name="txt_name" id="name" placeholder="enter name"> <!-- blank to insert the name -->
 		</label>
        </div>
        
         <div class="form-row">
     <label>
    <span>address</span>
     <input type="text" name="txt_address" id="address" placeholder="enter address"> <!-- blank to insert the address -->
 		</label>
        </div>
        
          <div class="form-row">
     <label>
     <span>seller/buyer</span>
     <input type="text" name="txt_classification" id="classification" placeholder="seller/buyer"> <!-- blank to insert the classification -->
 		</label>
        </div>
        
        <div class="form-row">
        <label>
        <span>message</span>
        <textarea id="message" name="txt_message"  placeholder="enter message" style="height:100px; width:230px"></textarea>
        </label>
        </div>
        
        <input type="submit" name="btn_message" value="Send Message">
        </div>
          <a href="logout.jsp" class="form-log-in-with-existing">logout</a> <!-- logout button -->
         </div>
      </form>
      
    </div>



</body>
</html>