<%@page  import="java.sql.*" import ="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <!DOCTYPE html>
<html>
<head>
<style> 
div.absolute {
  position: absolute;
  top: 300px;
  width: 100%;
  height: 830px;

}
table {
  border-collapse: collapse;
  width: 100%;
}
th, td {
  text-align: left;
  padding: 8px;
}
tr:nth-child(even){background-color: #f2f2f2}
th {
  background-color: #04AA6D;
  color: white;
}
h1{text-align: center;}
  input[type=submit] {
  background-color: #04AA6D;
  border: none;
  color: white;
  padding: 9px 16px;
  text-decoration: none;
  margin: 2px 10px;
  cursor: pointer;
}
</style>
<%      String sos=request.getParameter("studentOrfaculty");
		String usr=request.getParameter("username");
		String pwrd=request.getParameter("password");
		ServletContext context=getServletContext();  
		context.setAttribute("id",usr); 
		ServletContext context2=getServletContext();  
		context2.setAttribute("sos",sos);
		Connection con=null;
		String url="jdbc:mysql://localhost:3306/collegeManagement";
		String usrname="root";
		String pswrd="Shiva@9948";
		try {
			String p="f";
			 Class.forName("com.mysql.jdbc.Driver");
		      con = DriverManager.getConnection(url, usrname, pswrd);
		if(sos.equalsIgnoreCase("Student")) {
			PreparedStatement ps9=con.prepareStatement("select StudentID from studentdetails where exists (SELECT StudentID FROM studentdetails WHERE StudentID=?);");
			ps9.setString(1,usr);
			ResultSet rs9=ps9.executeQuery();
				while(rs9.next()) {
					 p=rs9.getString("StudentID");
				}
				if(p.equalsIgnoreCase("f")){
					%><dialog open>
			<h1>ID Number Doesnot Exist</h1>
			</dialog>
				<%}else{			
			PreparedStatement ps1=con.prepareStatement("select * from studentdetails where StudentID=? ;");
	    	ps1.setString(1, usr);
	    	ResultSet rs=ps1.executeQuery();
	    	String dprt1=null,yr=null;
	    	int ev=0,l=0;
		    while(rs.next()) {
		    	int id=rs.getInt("StudentID");
				String fname1=rs.getString("FirstName");
				String lname1=rs.getString("LastName");
				String phone1=rs.getString("phoneNumber");
				String gender1=rs.getString("Gender");
				dprt1=rs.getString("Branch");
				yr=rs.getString("Year");
				String password=rs.getString("pswrd");
				String sub1=rs.getString("sub1");
				String sub2=rs.getString("sub2");
				String sub3=rs.getString("sub3");
				String sub4=rs.getString("sub4");
				String sub5=rs.getString("sub5");
				String sub6=rs.getString("sub6");
				String sub1at=rs.getString("sub1Attend");
				String sub2at=rs.getString("sub2Attend");
				String sub3at=rs.getString("sub3Attend");
				String sub4at=rs.getString("sub4Attend");
				String sub5at=rs.getString("sub5Attend");
				String sub6at=rs.getString("sub6Attend");
				String evtatt=rs.getString("EventAttend");
				int TMarks=0,Tattend=0;
				if(sub1==null||sub2==null||sub3==null||sub4==null||sub5==null||sub6==null){
					
				}else{
					int tm=Integer.parseInt(sub1)+Integer.parseInt(sub2)+Integer.parseInt(sub3)+Integer.parseInt(sub4)+Integer.parseInt(sub5)+Integer.parseInt(sub6);
					TMarks=tm/6;
				}
				if(sub1at==null||sub2at==null||sub3at==null||sub4at==null||sub5at==null||sub6at==null){
					
				}else{
					if(evtatt==null){
						ev=0;
						l=6;
					}else{
						ev=Integer.parseInt(evtatt);
						l=7;
					}
					int ta=Integer.parseInt(sub1at)+Integer.parseInt(sub2at)+Integer.parseInt(sub3at)+Integer.parseInt(sub4at)+Integer.parseInt(sub5at)+Integer.parseInt(sub6at)+ev;
					Tattend=ta/l;
				}
				if(pwrd.equals(password)) {
				    %> 			
				
				
<body>
<div>
<h1>Chaitanya Bharathi Institute of Technology<h1>
</div>
<style>

</style>
 <div style="float: left; margin: 40px ;">
           	<h3>Name   :<%=fname1+" "+lname1%><h3> 
            <h3>Id     :<%=id%><h3>
            <h3>Branch :<%=dprt1%><h3>
            <h3>
</div>
<div style="float: Right; margin: 40px ;">
       <h3>Gender:<%=gender1%><h3>
       <h3>phone :<%=phone1%> <h3>  
       <h3>Year  :<%=yr%><h3>
</div>
  <div class="absolute">
  <table>
  <tr>
  	<th>SubjectName</th>
    <th>Marks</th>
    <th>Attendance</th>
    </tr>
 <tr>
 <td>Subject 1</td>
 <td><%=sub1%></td>
 <td><%=sub1at%></td>
 </tr>
 <tr>
 <td>Subject 2</td>
 <td><%=sub2%></td>
 <td><%=sub2at%></td>
 </tr>
 <tr>
 <td>Subject 3</td>
 <td><%=sub3%></td>
 <td><%=sub3at%></td>
 </tr>
 <tr>
 <td>Subject 4</td>
 <td><%=sub4%></td>
 <td><%=sub4at%></td>
 </tr>
 <tr>
 <td>Subject 5</td>
 <td><%=sub5%></td>
 <td><%=sub5at%></td>
 </tr>
 <tr>
 <td>Subject 6</td>
 <td><%=sub6%></td>
 <td><%=sub6at%></td>
 </tr>
 </table>
<br><br>
<%if(TMarks!=0){ %>
<h3>Percentage of Marks :<%=TMarks%> %</h3>
<%} if(Tattend!=0){ %>
<h3>Overall Attendance:<%=Tattend%>%</h3>
<%} %>
<form action="facultyButton.jsp" method="post">
	<div style="float: right;">
             <input type="submit" name=button value="ChangePassword">
  </div>
  </form>
  	<form action="LoginForm.html" method="post">
	<div style="float: right;">
              <input type="submit" value="LOG OUT">
</div>	
 </form>
</div>	
</div>
</div>
 							
				<%
				  }else {
					out.print("<html> <style>\r\n"
					 		+ "div { style=\\\\\\\"font-size:50px; color:red; text-align: center;}\r\n"
					 		+ "</style> <body>");
			    	 out.print("<div> <h3>Wrong Password</h3><br/>");
			    	 out.print("</div></body></html>");
				}}
		    }    
		}else if(sos.equalsIgnoreCase("Faculty")) {
	 
			PreparedStatement ps9=con.prepareStatement("select FacultyID from faculty where exists (SELECT FacultyID FROM faculty WHERE FacultyID=?);");
			ps9.setString(1,usr);
			ResultSet rs9=ps9.executeQuery();
			if(usr.equalsIgnoreCase("Admin")&&pwrd.equals("123")){
				p="abc";
				%><form action="HODButton.jsp" method="post">
				 <h2>Select the operation</h2>
				<input type="submit" name=button value="AllotSubjects">
				<input type="submit" name=button value="ReplaceSubjectTeacher">
				<input type="submit"  name=button value="staffList">
				<input type="submit" name=button value="studentList">
				<input type="submit" name=button value="studentAttendance">
				<input type="submit" name=button value="NewAdmission">
				<input type="submit" name=button value="removeStaff">
				<input type="submit" name=button value="SemCompleted">
				<input type="submit" name=button value="YearCompleted">
				<input type="submit" name=button value="removeStudent">
				 <form action="removeStaff.jsp" method="post">
				
				<%
			}
				while(rs9.next()) {
					 p=rs9.getString("FacultyID");
				}
				if(p.equalsIgnoreCase("f")){
					%>
				<dialog open>
			<h1>ID Number Doesnot Exist</h1>
			</dialog>
				<%}else{	
			
			    	PreparedStatement ps1=con.prepareStatement("select * from faculty where FacultyID=? ;");
			    	ps1.setString(1, usr);	
			    	ResultSet rs=ps1.executeQuery();
			    	int q=0,w=0,e=0;
			    	 String  brnch1=null, yr1=null,brnch2=null, yr2=null,brnch3=null, yr3=null;
	    	 while(rs.next()) {
	    		 int id=rs.getInt("FacultyID");
	    		 	String fname1=rs.getString("FirstName");
					String lname1=rs.getString("LastName");
					String phone1=rs.getString("phoneNumber");
					String gender1=rs.getString("Gender");
					String dprt1=rs.getString("Branch");
					String password=rs.getString("pswrd");
					
					String desig1 =rs.getString("Designation");
					ServletContext context3=getServletContext();  
					context3.setAttribute("desig1",desig1);
					
					String sub1=rs.getString("subject");
					String sub1Allot=rs.getString("AllotedClass1SubjectCode");
		    		 String sub2Allot=rs.getString("AllotedClass2SubjectCode");
		    		 String sub3Allot=rs.getString("AllotedClass3SubjectCode");		 
					if(pwrd.equals(password)) {
						%>
						<style>
div.relative {
  position: relative;
  width: 100%;
  height: 1000px;
 
} 
div.absolute {
  position: absolute;
  top: 200px;
  width: 100%;
  height: 808px;
 }
h1{text-align: center;}

</style>
</head>
<body><div>
<h1>Chaitanya Bharathi Institute of Technology<h1>
</div>
<div class="relative">
 <div style="float: left; margin: 40px ;">
           	<h3>Name   :<%=fname1+" "+lname1%><h3> 
            <h3>Id     :<%=id%><h3>
            <h3>Branch :<%=dprt1%><h3>
             <h3>Designation :<%=desig1%><h3>
            <h3>
</div>
<div style="float: Right; margin: 40px ;">
       <h3>Gender:<%=gender1%><h3>
       <h3>phone :<%=phone1%> <h3>  
       <h3>Subject  :<%=sub1%><h3>
</div>
						<%
			    	
			    	 if(desig1.equalsIgnoreCase("HOD")) {
			    		%>
<div class="absolute"> 
 
<form action="HODButton.jsp" method="post">
 <h2>Select the operation</h2>
<input type="submit" name=button value="AllotSubjects">
<input type="submit" name=button value="ReplaceSubjectTeacher">
<input type="submit"  name=button value="staffList">
<input type="submit" name=button value="studentList">
<input type="submit" name=button value="studentAttendance">
<input type="submit" name=button value="NewAdmission">
<input type="submit" name=button value="removeStaff">
<input type="submit" name=button value="SemCompleted">
<input type="submit" name=button value="YearCompleted">
<input type="submit" name=button value="removeStudent">
 <form action="removeStaff.jsp" method="post">
<br><br>
	<div style="float: right;">
	<input type="submit" name=button value="ChangePassword">
              
  </div>
   </form>
   	<form action="LoginForm.html" method="post">
	<div style="float: right;">
              <input type="submit" value="LOG OUT">
</div>	
 </form>
</div>
</div>
</body>
</html>		
 <%
			    	 }else { 
			    	%> 
<div class="absolute"> 
 	
  <h3>Alloted Subjects :<%=sub1Allot+","%><%=sub2Allot+","%><%=sub3Allot%><h3>		    	
  <h2>Select the operation</h2>
<form action="facultyButton.jsp" method="post">
<input type="submit" name=button value="studentList">
<input type="submit" name=button value="studentMarks">
<input type="submit" name=button value="studentAttendance">
<input type="submit" name=button value="NewAdmission">
 
<br><br>
	<div style="float: right;">
             <input type="submit" name=button value="ChangePassword">
  </div>
   </form>
  	<form action="LoginForm.html" method="post">
	<div style="float: right;">
	<input type="submit" value="LOG OUT">
</div>	
 </form>
  </div>
</div>
			  <% }		}else {
						 out.print("<html> <style>\r\n"
							 		+ "{ style=\\\"font-size:50px; color:red; text-align: center;}\r\n"
							 		+ "</style> <body>");
					    	 out.print("<div> <h3>Wrong Password</h3><br/>");
					    	 out.print("</div></body></html>");
					}
					
					
	    	 } }
		}
		}catch(Exception e) {
	    	  System.out.println(e);
	      }%>
	         
	      