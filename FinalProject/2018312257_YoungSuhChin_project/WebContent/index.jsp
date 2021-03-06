<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to register.jsp page
{
	response.sendRedirect("welcome.jsp");
}
%>
<%
String ID="",password,classification; //We check three elements:ID, password, classification
try
{	
	Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root"); //create connection
	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbID,dbpassword,dbclassification;
		
		ID=request.getParameter("txt_ID"); //txt_ID
		password=request.getParameter("txt_password"); //txt_password
		classification=request.getParameter("txt_classification"); //txt_classification
		
		out.print(password);
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from login where ID=? AND password=? AND classification=?"); //sql select query 
		pstmt.setString(1,ID);
		pstmt.setString(2,password);
		pstmt.setString(3,classification);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbID=rs.getString("ID");
			dbpassword=rs.getString("password");
			dbclassification=rs.getString("classification");
			
			if(ID.equals(dbID) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbID); //session name is login and store fetchable database ID
				session.setAttribute("classify",dbclassification); //session name is login and store fetchable database classification
				
				response.sendRedirect("welcome.jsp"); //after login success redirect to welcome.jsp page
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid ID or password or classification"); //invalid error message for ID or password wrong
		}
		
		con.close(); //close connection	
	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Login</title>

	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/login-register.css">
	
	<script>
		
		function validate() //to check if the inserted values are correct for form
		{
			var ID = document.myform.txt_ID;
			var password = document.myform.txt_password;
			var classification = document.myform.txt_classification;
			
			var check_count = false;
			
			if (ID.value == null || ID.value == "") //to check ID if the textbox is not blank
			{
				window.alert("please enter ID ?"); //alert message
				ID.style.background = '#f08080'; //make the ID blanck red
				ID.focus();
				return false;
			}
			if (password.value == null || password.value == "") //check password textbox not blank
			{
				window.alert("please enter password ?"); //alert message
				password.style.background = '#f08080'; //make the password blanck red
				password.focus();
				return false;
			}

            
            for(var i=0 ; i< classification.length ; i++) //check the number of elements of classification(It shoud be 1, not 0)
            { 
            	if( classification[i].checked) 
            	{ 
            		 check_count = true;
            	} 
            	
            }
            if(check_count==false) //if the check_count is false, that means user didn't check anything
            {
				alert("Choose the classification"); //alert message
                classification.focus(); //make the password blanck red
                classification.style.background = '#f08080';
                return false;                    
            }
		}
		function doOpenCheck(check){
		    var obj = document.getElementsByName("txt_classification"); //checkbox id classification
		    for(var i=0; i<obj.length; i++){
		        if(obj[i] != check){
		            obj[i].checked = false;
		        }
		    }
		}

			
	</script>
	
</head>

<body>

    <ul>
        <li></li>
    </ul>

    <div class="main-content">

        <form class="form-register" method="post" name="myform" onsubmit="return validate();">

            <div class="form-register-with-ID">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Login</h1>
                    </div>
					
					<p style="color:red"> 				   		
					<% //if there is something wrong, show error message
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for ID or password or classification
					}
					%>
					<%
					if(request.getParameter("txt_ID")!="")
					{
						out.println("<h1>"+ID+"</h1>");
					}
					%>
					</p>
					<br>
					
					<div class="form-row">
                        <label>
                            <span>Classification</span>
                            <!-- to select the classification (buyer or seller) -->
                            <input type="checkbox" id="classification" name="txt_classification" value="buyer" onclick="doOpenCheck(this);" style="width:70px">buyer
                           
                            <input type="checkbox" id="classification" name="txt_classification" value="seller" onclick="doOpenCheck(this);" style="width:70px">seller
                         
                        </label>
                        
                    </div>
				   

                    <div class="form-row">
                        <label>
                            <span>ID</span>
                           
                            <input type="text" name="txt_ID" id="ID" placeholder="enter ID">  <!-- blank to insert the student ID -->
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" placeholder="enter password"> <!-- blank to insert the password-->
                        </label>
                    </div>

					<input type="submit" name="btn_login" value="Login"> <!-- submit login-button -->
                    
                </div>

				<a href="register.jsp" class="form-log-in-with-existing">You Don't have an account? <b> Register here </b></a>
				<!-- if user does not have an account, go to the register page -->
				
				<a href="adminlogin.jsp" class="form-log-in-with-existing"><b>--ADMIN--</b>member's information</a>
				<!-- administrator login page-->

            </div>

        </form>

    </div>

</body>

</html>
