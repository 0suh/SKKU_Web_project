<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import = "java.sql.*" %>
<%
try
{
	Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbuser","root","root");  //create connection
	
	if(request.getParameter("btn_productupload")!=null) //check product upload button click event not null
	{
		String productname,price,name,phonenumber,tradingplace,sellmode,due;
		
		productname=request.getParameter("txt_productname"); //txt_productname
		price=request.getParameter("txt_price"); //txt_price
		name=request.getParameter("txt_name"); //txt_name
		phonenumber=request.getParameter("txt_phonenumber"); //txt_phonenumber
		tradingplace=request.getParameter("txt_tradingplace"); //txt_tradingplace
	
		sellmode=request.getParameter("txt_sellmode"); //txt_sellmode
		due=request.getParameter("txt_due"); //txt_due		
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("insert into product(productname,price,name,phonenumber,tradingplace,sellmode,due,status,wish) values(?,?,?,?,?,?,?,?,?)"); //sql insert query
		pstmt.setString(1,productname);
		pstmt.setString(2,price);
		pstmt.setString(3,name);
		pstmt.setString(4,phonenumber);
		pstmt.setString(5,tradingplace);
	
		pstmt.setString(6,sellmode);
		pstmt.setString(7,due);
		pstmt.setString(8,"selling");
		pstmt.setString(9,"0");
		
		pstmt.executeUpdate(); //execute query
		
		request.setAttribute("successMsg","Product upload success!"); //product upload success messeage

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
<title>Upload Product</title>

<link rel="stylesheet" href="css/main.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/login-register.css"> <!-- link with css file -->
<link rel="stylesheet" href="css/market.css"> <!-- link with css file -->

<script>

function validate() //to check if the inserted values are correct for form
{
	
	var productname_valid= /^[a-z A-Z 0-9]+$/; //pattern allowed a-z or A-Z or 0-9
	var price_valid= /^[0-9]+$/;  //pattern valid price validation
	var name_valid= /^[a-z A-Z]+$/; //pattern allowed alphabet a-z or A-Z 
	var phonenumber_valid= /^[0-9 -]+$/;  //pattern valid phonenumber validation
	var tradingplace_valid=/^[A-Z a-z 0-9 !@#$%&*()<>]+$/;//pattern password allowed A to Z, a to z, 0-9, !@#$%&*()<> charecter
	var sellmode_valid=/^[a-z A-Z]+$/; //pattern allowed alphabet a-z or A-Z 
		
	var productname = document.getElementById("productname"); //textbox productname 
	var price = document.getElementById("price"); //textbox price 
	var name = document.getElementById("name"); //textbox name
	var phonenumber = document.getElementById("phonenumber"); //textbox phone number
    var tradingplace = document.getElementById("tradingplace"); //textbox tradingplace 
    var sellmode = document.getElementsByName("txt_sellmode");  //checkbox sellmode
    var check_count = false; //the existence of sellmode

    
    for(var i=0 ; i< sellmode.length ; i++) //to check if the checkbox is not blank
    { 
    	if( sellmode[i].checked) 
    	{ 
    		 check_count = true;
    	} 
    	
    }
    if(check_count==false) 
    {
		alert("Choose the sell mode"); //alert message
        sellmode.focus(); 
        sellmode.style.background = '#f08080';  //make the sellmode blanck red
        return false;                    
    }

    if(!productname_valid.test(productname.value) || productname.value==''|| productname.value==null) 
    {
		alert("Enter Valid product name"); //alert message
        productname.focus();
        productname.style.background = '#f08080'; //make the product name blanck red
        return false;                    
    }
    if(!price_valid.test(price.value) || price.value=='' ||price.value==null) 
    {
		alert("Enter price"); //alert message
        price.focus();
        price.style.background = '#f08080'; //make the price blanck red
        return false;                    
    }
    if(!name_valid.test(name.value) || name.value=='' ||name.value==null) 
    {
		alert("Enter name(Alphabet Only)"); //alert message
        name.focus();
        name.style.background = '#f08080'; //make the name blanck red
        return false;                    
    }
	if(!phonenumber_valid.test(phonenumber.value) || phonenumber.value=='' ||phonenumber.value==null) 
    {
		alert("Enter phone number"); //alert message
        phonenumber.focus();
        phonenumber.style.background = '#f08080'; //make the phonenumber blanck red
        return false;                    
    }
	
	if(!tradingplace_valid.test(tradingplace.value) || tradingplace.value=='' || tradingplace.value==null) 
    {
		alert("Enter the trading place"); //alert message
        tradingplace.focus();
        tradingplace.style.background = '#f08080'; //make the tradingplace blanck red
        return false;                    
    }
}

//function to preview the uploaded image
function previewImage(f){ 
	var file = f.files;
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){ //check the file type
		alert('gif, jpg, png  : ' + file[0].name);
		f.outerHTML = f.outerHTML;//initialize the selected image
		document.getElementById('preview').innerHTML = '';
	}
	else {
		var reader = new FileReader(); //use the FileReader()
		reader.onload = function(rst){ //execute when file reading is completed
			document.getElementById('preview').innerHTML='<img src="'+rst.target.result+'" style="width:100px;height:100px">';
		}
		reader.readAsDataURL(file[0]);//read the file
	}
}

//doOpenCheck function makes the person can check only one checkbox button (auction or flea market only one!)
function doOpenCheck(check){
    var obj = document.getElementsByName("txt_sellmode"); //checkbox id sellmode
    for(var i=0; i<obj.length; i++){
        if(obj[i] != check){
            obj[i].checked = false;
        }
    }
}

//when auction sell mode check box is clicked, show check blanck of due time
//if not clicked, hide the time check blanck
function showduetime(check) {
	  if(check.checked == true) 
		  duetime.style.display = ''; //show
	  else 
		  duetime.style.display = 'none'; //hide
	  }
</script>

</head>
<body>

<ul>
<li>
</li>
</ul>

 <div class="main-content">

        <form class="form-register"  method="post" onsubmit="return validate();"> 

            <div class="form-register-with-ID">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Upload product</h1>
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
                            <span>Product Name</span>
                            <input type="text" name="txt_productname" id="productname" placeholder="enter Product Name"> <!-- blank to insert Product Name -->
                            
                        </label>
                        
                    </div>
                    
                    <div class="form-row">
                        <label>
                            <span>Product Price</span>
                            <input type="text" name="txt_price" id="price" placeholder="enter Product Price"> <!-- blank to insert the Product Price -->
                        </label>
                    </div>
                    
                     <div class="form-row">
                        <label>
                            <span>Seller Name</span>
                            <input type="text" name="txt_name" id="name" placeholder="enter Name"> <!-- blank to insert Seller Name -->
                            
                        </label>
                        
                    </div>
                    
                    
                    <div class="form-row">
                        <label>
                            <span>Phone Number</span>
                            <input type="text" name="txt_phonenumber" id="phonenumber" placeholder="enter Phone Number">  <!-- blank to insert the Phone Number-->
                        </label>
                    </div>
                    
                    <div class="form-row">
                        <label>
                            <span>Trading Place</span>
                            <input type="text" name="txt_tradingplace" id="tradingplace" placeholder="enter Trading Place">  <!-- blank to insert the Trading Place-->
                        </label>
                    </div>
                    
                     <div class="form-row">
                        <label>
                            <span>Product Image</span>
                            <input type="file" name="img_image" id="image" accept="image/*" onchange="previewImage(this)">  
                             <!-- blank to insert the Product Image-->
                             <br>
                          <div id="preview" style="margin:0px auto;text-align:center">
                          </div> <!-- display preview image -->


                        </label>
                    </div>
                    
                    
                    <div class="form-row">
                        <label>
                            <span>Sell mode</span> <!-- check box input type: select auction or flea market-->
                            
                            <input type="checkbox" id="auction" name="txt_sellmode" value="auction" onclick="doOpenCheck(this); showduetime(this);" style="width:70px">auction
                            <input type="checkbox" id="fleamarket" name="txt_sellmode" value="fleamarket" onclick="doOpenCheck(this);" style="width:70px">flea market
               
               				<div id="duetime" style="display:none">
							<span>Due time</span><input type="time" name="txt_due" id="due" placeholder="enter due time">  <!-- blank to insert the due time-->
                  </div>
                        </label>
                        <div style="color:#cccccc;text-align:center">[AUCTION : If you don't want to set price, write 0 in the price]</div>
                    </div>
					<input type="submit" name="btn_productupload" value="Product Upload"> <!-- submit product upload-button -->
					
                </div>
				
             <a href="welcomeseller.jsp" class="form-log-in-with-existing">Home</a> <!-- go to seller's main home page -->
            </div>

        </form>

    </div>


</body>
</html>