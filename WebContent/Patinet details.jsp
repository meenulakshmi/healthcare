<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<div style=" position: absolute;left:100px;width:100%;">
	<h3 style="color:green;"> Personal Details:</h3>
	<% 
	  try
	  {  
		request.getParameter("pid");
		int pat_id1   = Integer.parseInt(request.getParameter("pid"));
		Class.forName("com.mysql.jdbc.Driver");
		Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","lakshmi");
		Statement st1=con1.createStatement();
		String sql1= "select name ,age ,sex ,phone , city from patprofile where pid ="+pat_id1; 
		ResultSet rs1=st1.executeQuery(sql1);
		String patname = null; 
		String age = null;
		String sex = null;
		String phone = null;
		String city = null;
		while (rs1.next()) 
		{
    		patname = rs1.getString("name");
    		age = rs1.getString("age");
    		sex = rs1.getString("sex");
    		phone = rs1.getString("phone");
    		city = rs1.getString("city");
    		    		
		    out.println("<div style='width:80;'> Patient ID      :"+pat_id1);
		    out.println("</div>");
		    out.println("<br>");
		    
		    out.println("<div style='width:20;'> Patient Sex     :"+sex);
		    out.println("</div>");  	        
  	        out.println("<br>");
  	        
  	        out.println("<div> Patient Name    :"+patname.toUpperCase( ));
  	        out.println("</div>");
  	        out.println("<br>");
  	        
  	        out.println("<div> Patient Age     :"+age);
	        out.println("</div>");
	        out.println("<br>");	              
	        	        
         }
	
		if( patname == null )
		{ 
			session.setAttribute("patientid","error");
   			response.sendRedirect("Patient login.jsp");
		}
			st1.close();
			con1.close();
	  }
		
	  catch(Exception e)
	 {
	    e.printStackTrace();
	 }		  
%>
</div>
<br><br>
<br><br>
<br>
