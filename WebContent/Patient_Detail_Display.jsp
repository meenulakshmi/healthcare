<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Insert title here</title>
  
  <style>
  
     table, td {
                border: 1px solid black;
     			color:black;
   				}
 			th {
    			border: 1px solid black;
    			color:blue;
    			}
	</style>

 </head>

 <body background="Patient.jpg">
 
       <br> 
        <h1 style="color:purple;" align=center> 
          Patient Health Details
        </h1>

        <%@ include file = "Patinet details.jsp"%>
		
		<br></br>
		<br></br>

		<%@ include file = "Patient_proj.jsp"%>

 </body>
</html>