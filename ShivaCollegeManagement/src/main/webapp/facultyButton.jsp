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
        height:30px;
        margin: 5px;
    }
</style>

</head>
<body>
<%	String b=request.getParameter("button");
if(b.equalsIgnoreCase("studentList")) {
	%><form action="fstudentList.jsp" method="post">
	<div class="container">
  <h1>Student List</h1>
	  <h3>select Class</h3>
	 <select name="classs">
 	 <option value="class1">class1</option>
	 <option value="class2">class2</option>
	 <option value="class3">class3</option>
	 </select>
	  <input type="checkbox"  name="button" value="dwnld">
  		<label > Want to download PDF</label><br>
	<input type="submit" class="registerbtn" value="studentList">
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
<%}else if(b.equalsIgnoreCase("NewAdmission")){
	RequestDispatcher rd=request.getRequestDispatcher("newJoin.jsp");  
	rd.forward(request, response);
}else if(b.equalsIgnoreCase("studentMarks")) {%>
	<form action="StudentMarks.jsp" method="post">
	<div class="container">
  <h1>Marks Entry</h1>
<label>enter the id</label>
<input type="text" name="id" required>
<label>Marks:</label>
<input type="text" name="marks" required>
 <input type="submit" class="registerbtn" value="Enter Marks">
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
   </body>
</html>
<% }
%>