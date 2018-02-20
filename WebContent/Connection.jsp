 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project1","root","");
%>