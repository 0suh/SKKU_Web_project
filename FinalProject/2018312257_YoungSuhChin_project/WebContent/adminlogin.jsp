<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("memberlistform.jsp");
}
%>
<%
int ID=0, password;//We check two elements:ID, password
try
{	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		ID=Integer.parseInt(request.getParameter("txt_ID")); //txt_ID
		password=Integer.parseInt(request.getParameter("txt_password")); //txt_password
		
		if(ID==0&&password==111111){ //administrator: ID=0, password=111111
			response.sendRedirect("memberlistform.jsp"); //go to the memberlist managing page
		}
		else
		{
			request.setAttribute("errorMsg","invalid ID or password"); //invalid error message for ID or password wrong
		}
	}
}catch(Exception e)
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

	<title>Administrator Login</title>

	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/login-register.css">
	
	<script>
		
		function validate() //to check if the inserted values are correct for form
		{
			var ID = document.myform.txt_ID;
			var password = document.myform.txt_password;
			
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
                        <h1>Administrator Login</h1>
                    </div>
					
					<p style="color:red"> 				   		
					<% //if there is something wrong, show error message
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for ID or password or classification
					}
					%>
					
					</p>
								
                    <div class="form-row">
                        <label>
                            <span>ID</span>
                           
                            <input type="text" name="txt_ID" id="ID" placeholder="enter ID"> 
                             <!-- blank to insert the student ID -->
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" placeholder="enter password">
                             <!-- blank to insert the password-->
                        </label>
                    </div>

					<input type="submit" name="btn_login" value="Login"> <!-- submit login-button -->
                    
                </div>

            </div>

        </form>

    </div>

</body>

</html>
