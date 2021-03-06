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

<script>

//check if the new price is higher than the original one before the submit
function newpriceCheck(){
	var p = document.getElementById("price"); //textbox price
	var op = document.getElementById("oldprice"); //textbox price name(original price)
	if(p.value> op.value)
		return true;//submit okay
	else{
		alert("New price should be higher than original one"); //alert message
        p.focus();
        p.style.background = '#f08080'; //make the price blanck red
        return false;//cannot submit
	}
}

</script>
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
   
   	pstmt = con.prepareStatement("SELECT  productname,price,name,phonenumber,tradingplace,sellmode,due from product WHERE productname=?");//sql select query
    pstmt.setString(1,productname);
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

  <form class="form-register" action="priceupdate.jsp" method="post" onsubmit="return newpriceCheck();"> 
    <!-- before submit, check the new price (newpriceCheck()) -->

<div class="form-register-with-ID">
 <div class="form-white-background">
 <p style="color:#2E9AFE">				   		
					<% 
					 
					if(request.getAttribute("successMsg")!=null)
					{
						out.println(request.getAttribute("successMsg")); //success message
					}
					%>
					</p>
					<p style="color:red">				   		
					<%//if there is something wrong, show error message
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message 
					}
					%>
				
					</p>

 
 <div class="form-row">
        <label>
        <span>
       <%=rs.getString("sellmode")%><!-- show sell mode -->
       </span>
       <input type="text" name="txt_price" id="price" placeholder="new price" style="width:120px"> <!-- blank to insert the new price -->
       <input type="submit" name="btn_priceupdate" value="bid" style="width:100px"> <!-- submit new price-button -->
                                        
       	</label>
       	</div>
     
 		<div class="form-row">
  		<label>
        <span>Product Name</span>
       <div style="display:none"> 
       <input type="text" name="txt_productname" id="productname" value=<%=rs.getString("productname")%>><!-- to use in the newpriceCheck() function --> 
       </div>
       <%=rs.getString("productname")%><!-- show product name -->
        </label>
        </div>
        
        <div class="form-row">
     	<label>
        <span>Current Price</span>
        <div style="display:none"> 
       <input type="text" name="txt_oldprice" id="oldprice" value=<%=rs.getString("price")%>>      <!-- to use in the newpriceCheck() function --> 
       </div>
       <%=rs.getString("price")%> won <!-- show current price -->
        </label>
        </div>
        
        <div class="form-row">
     	<label>
        <span>Seller Name</span>
       <%=rs.getString("name")%><!-- show seller name -->
        </label>
        </div>
        
        <div class="form-row">
        <label>
        <span>Phone Number</span>
       <%=rs.getString("phonenumber")%><!-- show seller's phone number -->
       	</label>
       	</div>
       	
       	 <div class="form-row">
        <label>
        <span>Trading Place</span>
        <%=rs.getString("tradingplace")%><!-- show trading place -->
       	</label>
       	</div>
       	
       	<a href="wish.jsp?wish=<%=rs.getString("productname") %>" style="text-decoration: none; color:white;background-color:#bfcbde;padding:15px">WISH!</a>
       	<!-- add the number of wish --> 
        <a href="purchase.jsp?buy=<%=rs.getString("productname") %>" style="text-decoration: none; color:white;background-color:#bfcbde;padding:15px">BUY!</a>
        <!-- purchase product(status become "sold") --> 
       
        
    </div>

    
  
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
