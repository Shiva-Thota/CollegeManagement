<%@page  import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
.container {
 position: absolute;
  left:400px;
  margin: 8px;
  max-width: 1000px;
  padding: 40px;
  background-color: white;
}
.button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  width: 150px;
 height: 50px;
}
/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}
.registerbtn {
  background-color: #04AA6D;
  color: white;
  padding: 16px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
}
h1{text-align: center;}

select {
        width: 100%;
        height:40px;
        margin: 5px;
    }
    label{
        font-size: 28px;}
</style>

<%	String b=request.getParameter("button");
if(b.equalsIgnoreCase("studentList")) {
	%><form action="viewStudents.jsp" method="post">
	<div class="container">
  <h1>Student List</h1>
  <h3>select the branch</h3>
	<select name="Branch">
	 <option value=" "></option>
	 <option value="CSE">CSE</option>
	 <option value="ECE">ECE</option>
	 <option value="EEE">EEE</option>
	 <option value="MECH">MECH</option>
	 <option value="CIVIL">CIVIL</option>  required
	 
	 </select>
	  <h3>select year</h3>
	 <select name="Year">
 	 <option value="1">1</option>
	 <option value="2">2</option>
	 <option value="3">3</option>
	 <option value="4">4</option>
	  <option value="All">All</option> required
	 </select>
	  <input type="checkbox"  name="button" value="dwnld">
  		<label > Want to download PDF</label><br>
	<input type="submit" class="registerbtn" value="studentList">
   </div>
	 </form>
<%
}else if(b.equalsIgnoreCase("AllotSubjects")) {%>
	<form action="AllotSubject.jsp" method="post">
	<div class="container">
 <h1 font-size: 38px;>Allot Subject</h1>
	<label>enter the id of Teacher</label>
	<input type="text" name="id" required>
	<br>
	<label>select the branch</label>
	<select name="Branch">
	 <option value="CSE">CSE</option>
	 <option value="ECE">ECE</option>
	 <option value="EEE">EEE</option>
	 <option value="MECH">MECH</option>
	 <option value="CIVIL">CIVIL</option>  required
	 </select>
	 <br>
	 <label>select year</label>
	 <br>
	 <select name="Year">
 	 <option value="1">1</option>
	 <option value="2">2</option>
	 <option value="3">3</option>
	 <option value="4">4</option>required
	 </select>
	 
	<input type="submit" class="registerbtn" value="Allot Subject">
   </div>
	 </form>
	
<%}else if(b.equalsIgnoreCase("staffList")){
	%><form action="ViewStaff.jsp" method="post">
		<div class="container">
	<h1>Staff List</h1>
	<label>select the branch</label>
	<select name="Branch">
	 <option value=" "></option>
	 <option value="CSE">CSE</option>
	 <option value="ECE">ECE</option>
	 <option value="EEE">EEE</option>
	 <option value="MECH">MECH</option>
	 <option value="CIVIL">CIVIL</option>  
	 <option value="All">All</option> 
	 </select>
	 <input type="checkbox"  name="button" value="dwnld">
  		<label > Want to download PDF</label><br>
	 <input type="submit" class="registerbtn" value="Show Staff">
	</div>
	 </form>
<%
}else if(b.equalsIgnoreCase("SemCompleted")){
	Connection con=null;
	String url="jdbc:mysql://localhost:3306/collegeManagement";
	String usrname="root";
	String pswrd="Shiva@9948";
	try {
		 Class.forName("com.mysql.jdbc.Driver");
		   con = DriverManager.getConnection(url, usrname, pswrd);
	      PreparedStatement ps=con.prepareStatement("delete from classAllotment;");
			int x=0;
			x=ps.executeUpdate();
			out.print("came into classAllotment");
			PreparedStatement ps1=con.prepareStatement("update faculty set AllotedClass1SubjectCode=NULL;");
    		x=ps1.executeUpdate();
    		out.print("came into classAllotment1");
    		PreparedStatement ps2=con.prepareStatement("update faculty set AllotedClass2SubjectCode=NULL;");
    		x=ps2.executeUpdate();
    		out.print("came into classAllotment2");
    		PreparedStatement ps3=con.prepareStatement("update faculty set AllotedClass3SubjectCode=NULL;");
    		x=ps3.executeUpdate();
    		out.print("came into classAllotment3");
			if(x!=0){%>
			<h1>SEM COMPLETED</h1>
			<%}else{%>
				<h1>FAILED</h1>
	<%}
			}catch(Exception e){
				System.out.println(e);
			}
}else if(b.equalsIgnoreCase("YearCompleted")){
	Connection con=null;
	String url="jdbc:mysql://localhost:3306/collegeManagement";
	String usrname="root";
	String pswrd="Shiva@9948";
	try {
		 Class.forName("com.mysql.jdbc.Driver");
		   con = DriverManager.getConnection(url, usrname, pswrd);
	        PreparedStatement ps=con.prepareStatement("update studentdetails set Year=Year+1;");
			int x=0;
			x=ps.executeUpdate();
		    PreparedStatement ps1=con.prepareStatement("delete from studentdetails where Year=5;");
		    x=ps1.executeUpdate();		
			if(x!=0){%>
			<h1>YEAR INCREASED</h1>
			<%}else{%>
				<h1>FAILED</h1>
	<%}
			}catch(Exception e){
				System.out.println(e);
			}
}else if(b.equalsIgnoreCase("NewAdmission")){
	RequestDispatcher rd=request.getRequestDispatcher("newJoin.jsp");  
	rd.forward(request, response);
}else if(b.equalsIgnoreCase("ReplaceSubjectTeacher")){
	%>
	<form action="ReplaceSubjectTeacher.jsp" method="post">
 <div class="container">
 <h1 >ReplaceSubjectTeacher</h1>
	<label>enter the id</label>
	<input type="text" name="newid" required>
	<label>select the branch</label>
	<select name="Branch">
	 <option value="CSE">CSE</option>
	 <option value="ECE">ECE</option>
	 <option value="EEE">EEE</option>
	 <option value="MECH">MECH</option>
	 <option value="CIVIL">CIVIL</option>  required
	 </select>
	 <label>select year</label>
	 <select name="Year">
 	 <option value="1">1</option>
	 <option value="2">2</option>
	 <option value="3">3</option>
	 <option value="4">4</option>required
	 </select>
	 <label>Previous Teacher Id</label>
	 <input type="text" name="oldId" required>	 
	<input type="submit" class="registerbtn" value="Allot Subject">
   </div>
</form>
<%
	
}else if(b.equalsIgnoreCase("removeStaff")){%>
	<form action="removeStaff.jsp" method="post">
	<div class="container">
 <h1>Remove Staff</h1>
	<label>enter the id</label>
	<input type="text" name="id" required>
	<label>select the branch</label>
	<select name="Branch">
	 <option value=" "></option>
	 <option value="CSE">CSE</option>
	 <option value="ECE">ECE</option>
	 <option value="EEE">EEE</option>
	 <option value="MECH">MECH</option>
	 <option value="CIVIL">CIVIL</option>  
	 </select>
	 <input type="submit"  class="registerbtn" value="Delete Staff">
   </div>
 </form>
<%}else if(b.equalsIgnoreCase("ChangePassword")) {%>
	<form action="changePassword.jsp" method="post">
<div class="container">
  <h1>Password Change</h1>
<label>Enter Old Password</label>
<input type="text" name="opswrd" required>
<label>New Password:</label>
<input type="text" name="npswrd" required>
 <input type="submit" class="registerbtn" value="Change Password">
   </div>
 </form>	
<%}else if(b.equalsIgnoreCase("studentAttendance")) {%>
<form action="Attendance.jsp" method="post">
<div class="container">
  <h1>Attendance Entry</h1>
<label>enter the id</label>
<input type="text" name="id" required>
<label>Attendance:</label>
<input type="text" name="attendance" required>
 <input type="submit" class="registerbtn" value="Enter Attendance">
   </div>
 </form>
 <%}else if(b.equalsIgnoreCase("removeStudent")) {%>
 <form action="removeStudent.jsp" method="post">
 	<div class="container">
<h1>Remove Student</h1>
<label>enter the id</label>
<input type="text" name="id" required>
<label>select the branch</label>
<select name="Branch">
 <option value=" "></option>
 <option value="CSE">CSE</option>
 <option value="ECE">ECE</option>
 <option value="EEE">EEE</option>
 <option value="MECH">MECH</option>
 <option value="CIVIL">CIVIL</option>  
 </select>
 <input type="submit" class="registerbtn" value="Delete Student">
 </div>
 </form>
 
  <br><br><br>
 </form>
 
<% }
%>
</body>
</html>