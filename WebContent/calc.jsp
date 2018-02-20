<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, th, td {
    border: 1px solid black;
}
</style>
</head>
<body>
<%
//request.getParameter("pid"));
//request.getParameter("start_date"));
//request.getParameter("end_date"));

try
{
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project1","root","");
Statement st=con.createStatement();

out.println(" <div align='center'>" +"<font size='6'>" + " Patient Details: </font>" +"</div>");
out.println("<table>");
out.println("<tr>");
out.println("<th>" + "Minimum Blood Pressure " +"</th>   " +
            "<th>"+  "Maximum Blood Pressure "+ "</th>");
out.println("</br>");
out.println("</tr>");

 ResultSet rs=st.executeQuery("select bp_systole , bp_diastole from project where pid = 8316");
 ArrayList<Integer> Min_BP = new ArrayList<Integer>();
 ArrayList<Integer> Max_BP = new ArrayList<Integer>();
 
    while(rs.next())     
   {
     Min_BP.add(Integer.valueOf(rs.getString("bp_diastole")));
     Max_BP.add(Integer.valueOf(rs.getString("bp_systole")));
 	//out.println(rs.getString("bp_systole"));
   }
   int min = Collections.max(Min_BP);
   int max = Collections.max(Max_BP);
   out.println("<tr>");
   out.println("<td>" + min +"</td>   " +
               "<td>"+  max + "</td>");
   out.println("</tr>");

out.println("</table>");
rs.close();
st.close();
con.close();
}
catch(Exception e)
{
e.printStackTrace();
}
%>

</body>
</html>