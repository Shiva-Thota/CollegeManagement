<%@page  import="java.sql.*" import ="java.util.StringTokenizer"%>
<!DOCTYPE html>
<%@page import="com.itextpdf.text.log.SysoCounter"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%
ServletContext context=getServletContext();  
String n=(String)context.getAttribute("id");
Connection con=null;
String url="jdbc:mysql://localhost:3306/collegeManagement";
String usrname="root";
String pswrd="Shiva@9948";
try {
	 Class.forName("com.mysql.jdbc.Driver");
	 con = DriverManager.getConnection(url, usrname, pswrd);
	PreparedStatement ps1=con.prepareStatement("select * from faculty where FacultyID=? ;");
	ps1.setString(1, n);
	ResultSet rs=ps1.executeQuery();
	String dsig=null;
	while(rs.next()) {
			dsig=rs.getString("Designation");
		}

%>
<style>

.container {
 position: absolute;
  left:470px;
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


</style>
</head>
<body>
<form action="newEntry" method="post">
  <div class="container">
  <script>

function yesnoCheck() {
    if (document.getElementById('yesCheck').checked) {
        document.getElementById('ifYes').style.visibility = 'visible';
        document.getElementById('ifYe').style.visibility = 'hidden';
    }
    else{ 
    	document.getElementById('ifYe').style.visibility = 'visible';
    	document.getElementById('ifYes').style.visibility = 'hidden';}

}
function subjectcheck() {
    if (document.getElementById('yesCheck1').checked) {
        document.getElementById('ifYes1').style.visibility = 'visible';
        document.getElementById('ifYe1').style.visibility = 'hidden';
    }
    else{ 
    	document.getElementById('ifYe1').style.visibility = 'visible';
    	document.getElementById('ifYes1').style.visibility = 'hidden';}

}
</script>
<div><h1>Enter the Details<h1></div>
<br>
<table>
  <tr>
  <%if(dsig.equalsIgnoreCase("HOD")){
  %>
  <td><label>Select:</label></td>
 <td><input type="radio" name="studentOrfaculty" value="Student" onclick="javascript:yesnoCheck();"  id="noCheck" required />Student
 <input type="radio" name="studentOrfaculty" value="Faculty" onclick="javascript:yesnoCheck();"  id="yesCheck" required />Faculty
 </td>
 </tr>
 <%}else{ %>
 <td><label>Select:</label></td>
  <td><input type="radio" name="studentOrfaculty" value="Student" onclick="javascript:yesnoCheck();"  id="noCheck" required />Student
  </tr>
 <tr>
 <td> Year   : </td>
 <td><select name="Year">
 <option value="1">1</option>
 <option value="2">2</option>
 <option value="3">3</option>
 <option value="4">4</option>
 </select></td>
 </tr>
 
 <%}}catch(Exception e){
	System.out.println(e);
}%>

 <tr>
 <td>First Name:</td>
 <td><input type="text" name="First Name"   required/></td>
 </tr>
 <tr>
 <td>Last Name:</td>
 <td><input type="text" name="Last Name"  required/></td>
 </tr>
 <tr>
 <td>Phone Number:</td>
 <td><input type="text" name="phone"  /></td>
 </tr>
 <tr>
 <td>Gender:</td>
 <td><input type="radio" name="gender" value="male"  required/>Male
 <input type="radio" name="gender" value="female" required />Female</td>
 </tr>
 <tr>
 <td>Select Department:</td>
 <td><select name="Branch">
 <option value=" "></option>
 <option value="CSE">CSE</option>
 <option value="ECE">ECE</option>
 <option value="EEE">EEE</option>
 <option value="MECH">MECH</option>
 <option value="CIVIL">CIVIL</option>  required
 </select></td>
 </tr>
 <tr>
 <td>Password:</td>
 <td><input type="text" name="pswrd"  required/></td>
 </tr>
 <tr>
 <td>Conform Password:</td>
 <td><input type="text" name="pswrd1" required /></td>
 </tr>
 </table>
 <div id="ifYe" style="visibility:hidden">
     Year   :  <select name="Year">
 <option value="1">1</option>
 <option value="2">2</option>
 <option value="3">3</option>
 <option value="4">4</option>
 </select>
 </div>
 <div id="ifYes" style="visibility:hidden">
      Designation 		:<input type="radio" name="Designation" value="HOD" onclick="javascript:subjectcheck();"  id="noCheck1"   />HOD
 <input type="radio" name="Designation" value="Teaching Staff" onclick="javascript:subjectcheck();"  id="yesCheck1"   />Teaching
   </div>
 <div id="ifYes1" style="visibility:hidden">
       subject  :<input type="text" name="subject">
 </div>  
<div id="ifYe1" style="visibility:hidden">
 </div> 
    <input type="submit" class="registerbtn"  value="Submit Details">
</div>
  </div>
   </form>
</body>
</html>