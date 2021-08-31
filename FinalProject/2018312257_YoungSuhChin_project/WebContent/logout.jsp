<% 
session.invalidate(); //destroy session
response.sendRedirect("index.jsp");//return to login page
%>


