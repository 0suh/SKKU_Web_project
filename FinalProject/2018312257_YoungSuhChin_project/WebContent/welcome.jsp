<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Welcome : <%=session.getAttribute("login")%></title>
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/login-register.css">
</head>
<body>
    <div class="main-content">
	<%
	if(session.getAttribute("login")==null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
	{
		response.sendRedirect("index.jsp"); 
	}
	String classification =(String)session.getAttribute("classify");
	%>
	<h1> Welcome, <%=session.getAttribute("login")%> </h1>
<%	if(classification.equals("buyer")){ //if the clasification is buyer, go to the welcomebuyer.jsp
		response.sendRedirect("welcomebuyer.jsp");
	}
	if(classification.equals("seller")){ //if the classification is seller, go to the welcomeseller.jsp
		response.sendRedirect("welcomeseller.jsp");
	}
%>
	<h2><a href="logout.jsp">Logout</a></h2> <!-- logout button -->
    
    </div>

</body>

</html>
