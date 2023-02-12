<%@page  import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
dialog {
            color: green;
            font-size: 30px;
            font-weight: Bold;
            font-style: italic;
            border-style: ridge;
        }
</style>
</head>

<%         
String opswrd=request.getParameter("opswrd");
String npswrd=request.getParameter("npswrd");
ServletContext context=getServletContext();  
String id=(String)context.getAttribute("id");  
ServletContext context2=getServletContext();  
String sos=(String)context2.getAttribute("sos"); 
Connection con=null;
String url="jdbc:mysql://localhost:3306/collegeManagement";
String usrname="root";
String pswrd="Shiva@9948";
try {
	 Class.forName("com.mysql.jdbc.Driver");
	 con = DriverManager.getConnection(url, usrname, pswrd);
    String pp=null;
    if(sos.equalsIgnoreCase("Student")){
    	  pp="select * from studentdetails where StudentID="+id+" ;";
    }else{
    	  pp="select * from faculty where FacultyID="+id+" ;";
    }
    PreparedStatement ps1=con.prepareStatement(pp);
	ResultSet rs=ps1.executeQuery(); 
	String dpswrd=null;
	while(rs.next()){
		dpswrd=rs.getString("pswrd");
	}
	int x=0;
	String pp1=null;
	if(dpswrd.equals(opswrd)){
		if(sos.equalsIgnoreCase("Student")){
	    	  pp1="update studentdetails  set pswrd='"+npswrd+"'  where StudentID="+id+" ;";
	    }else{
	    	  pp1="update faculty set pswrd='"+npswrd+"' where FacultyID="+id+" ;";
	    }
		 PreparedStatement ps=con.prepareStatement(pp1);
		 x=ps.executeUpdate();
		 if(x!=0){%>
			<dialog open>
		 <h1>Password UPDATED</h1>
			<p> Id =<%=id%></p>
			<p>New Password =<%=npswrd%></p>
		  </dialog>
		<%}else{%>
		 <dialog open>
		<h1>FAILED</h1>
		  </dialog>
		
	<%}}else{
		%>
		<dialog open>
	 <h1>Failed</h1>
		<h3>Enter Old password Correctly</h3>
	  </dialog>
	<%}
	
	}catch(Exception e){
			System.out.println(e);
		}%>

</body>
</html>