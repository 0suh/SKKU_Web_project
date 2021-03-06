
<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to register.jsp page
{
	response.sendRedirect("welcome.jsp");
}
%>
<%
try
{
	Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root");  //create connection
	
	if(request.getParameter("btn_register")!=null) //check register button click event not null
	{
		String ID,name,password,classification;
		
		ID=request.getParameter("txt_ID"); //txt_ID
		name=request.getParameter("txt_name"); //txt_name
		password=request.getParameter("txt_password"); //txt_password
		classification=request.getParameter("txt_classification"); //txt_classification
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("insert into login(ID,name,password,classification) values(?,?,?,?)"); //sql insert query
		pstmt.setString(1,ID);
		pstmt.setString(2,name);
		pstmt.setString(3,password);
		pstmt.setString(4,classification);
		
		pstmt.executeUpdate(); //execute query
		
		request.setAttribute("successMsg","Register Successfully...! Please login"); //register success messeage

		con.close(); //close connection
	}
	
	if(request.getParameter("btn_duplicate")!=null) //when "click the btn_duplicate button" ->check the ID and his/her classification
	{
		String dbID;
		String dbclassification;
		String ID=request.getParameter("txt_ID"); //txt_ID
		String classification=request.getParameter("txt_classification"); //txt_classification
		
		PreparedStatement pstmt=null;
		pstmt=con.prepareStatement("select ID,classification from login where ID=? AND classification=?"); //sql query
		pstmt.setString(1,ID);
		pstmt.setString(2,classification);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) 
		{
			dbID=rs.getString("ID");
			dbclassification=rs.getString("classification");
			
			if(ID.equals(dbID)&&classification.equals(dbclassification)) //if ID&classification is already in the data base
			{
				request.setAttribute("errorMsg","Not Usable ID"); //invalid error message for ID or classification wrong
			}
		}
		else
		{
			request.setAttribute("successMsg","Usable ID"); //invalid error message for ID or classification wrong
		}
		
		
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
		
	<title>Register </title>

	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/login-register.css">
	
	<!-- javascript for registeration form validation-->
	<script>	
	
		function validate() //to check if the inserted values are correct for form
		{
			var ID_valid= /^[0-9]{1,10}$/;  //pattern valid ID validation
			var name_valid= /^[a-z A-Z]+$/; //pattern allowed alphabet a-z or A-Z 
			var password_valid=/^[A-Z a-z 0-9 !@#$%&*()<>]{6,12}$/; //pattern password allowed A to Z, a to z, 0-9, !@#$%&*()<> charecter 
		
				
			var ID = document.getElementById("ID"); //textbox id ID
			var name = document.getElementById("name"); //textbox id name
            var password = document.getElementById("password"); //textbox id password
            var classification = document.getElementsByName("txt_classification");  //checkbox name classification
            var check_count = false; //the existence of classification
        
            for(var i=0 ; i< classification.length ; i++) //to check if the checkbox is not blank
            { 
            	if( classification[i].checked) 
            	{ 
            		 check_count = true;
            	} 
            	
            }
            if(check_count==false) 
            {
				alert("Choose the classification"); //alert message
                classification.focus(); 
                classification.style.background = '#f08080';  //make the classification blanck red
                return false;                    
            }

            if(!ID_valid.test(ID.value) || ID.value==''|| ID.value==null) 
            {
				alert("Enter Valid ID"); //alert message
                ID.focus();
                ID.style.background = '#f08080'; //make the ID blanck red
                return false;                    
            }
			if(!name_valid.test(name.value) || name.value=='' ||name.value==null) 
            {
				alert("Enter name (Alphabet Only)"); //alert message
                name.focus();
                name.style.background = '#f08080'; //make the name blanck red
                return false;                    
            }
			
			if(!password_valid.test(password.value) || password.value=='' || password.value==null) 
            {
				alert("Enter the Password (Must Be 6 to 12 and allowed !@#$%&*()<> character)"); //alert message
                password.focus();
                password.style.background = '#f08080'; //make the password blanck red
                return false;                    
            }
			
			
		}
		//<additional function>
		//doOpenCheck function makes the person can check only one checkbox button (seller or buyer only one!)
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

    <ul> <li></li> </ul>

    <div class="main-content">

        <form class="form-register" method="post" onsubmit="return validate();"> <!-- to check before the submit by function validate() -->

            <div class="form-register-with-ID">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Register</h1>
                    </div>
				   
					<p style="color:#2E9AFE">				   		
					<% 
					 
					if(request.getAttribute("successMsg")!=null)
					{
						out.println(request.getAttribute("successMsg")); //register success message
					}
					%>
					</p>
					<p style="color:red">				   		
					<%//if there is something wrong, show error message
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for ID or password or classification 
					}
					%>
				
					</p>
				   
				   <div class="form-row">
                        <label>
                            <span>ID</span>
                            <input type="text" name="txt_ID" id="ID" placeholder="enter ID"> <!-- blank to insert the student ID -->
                            
                        </label>
                        
                    </div>
                    
                    <div class="form-row">
                        <label>
                            <span>Classification</span> <!-- check box input type: select seller or buyer -->
                            <!-- only one choice can be inserted -->
                            
                            <input type="checkbox" id="classification" name="txt_classification" value="buyer" onclick="doOpenCheck(this);" style="width:70px">buyer
                           
                            <input type="checkbox" id="classification" name="txt_classification" value="seller" onclick="doOpenCheck(this);" style="width:70px">seller
                         
                        </label>
                        
                    </div>
                   
					<div class="form-row">
                        <label>
                            <span>name</span>
                            <input type="text" name="txt_name" id="name" placeholder="enter name"> <!-- blank to insert the name -->
                        </label>
                    </div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" placeholder="enter password">  <!-- blank to insert the password-->
                        </label>
                    </div>
                    
                      <input type="submit" name="btn_duplicate" value="Duplicate" > <!-- submit duplication check-button -->
                   

					<input type="submit" name="btn_register" value="Register"> <!-- submit login-button -->
					
                </div>
				
                <a href="index.jsp" class="form-log-in-with-existing">Already have an account? <b> Login here </b></a> <!-- go to the login page -->

            </div>

        </form>

    </div>

</body>

</html>
