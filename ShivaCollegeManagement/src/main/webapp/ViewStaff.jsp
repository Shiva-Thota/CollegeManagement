<%@page  import="java.sql.*" import ="javax.servlet.ServletException"
import ="javax.servlet.annotation.WebServlet"
import ="javax.servlet.http.HttpServlet"
import ="javax.servlet.http.HttpServletRequest"
import ="javax.servlet.http.HttpServletResponse"
import ="com.itextpdf.text.Document"
import ="com.itextpdf.text.pdf.PdfPTable"
import ="com.itextpdf.text.pdf.PdfWriter"
import ="java.io.*"
import ="com.itextpdf.text.Paragraph"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
      	String dprt=request.getParameter("Branch");
		Connection con=null;
		String url="jdbc:mysql://localhost:3306/collegeManagement";
		String usrname="root";
		String pswrd="Shiva@9948";
			try {
			 Class.forName("com.mysql.jdbc.Driver");
	  		 con = DriverManager.getConnection(url, usrname, pswrd);
     		String ss=null;
     		if(dprt.equalsIgnoreCase("All")){
     			ss="select * from faculty;";
     		}else{
     		 ss="select * from faculty where Branch='"+dprt+"';";
     		}
     		  PreparedStatement ps=con.prepareStatement(ss);
  			ResultSet rs=ps.executeQuery();
  			 PreparedStatement ps2=con.prepareStatement(ss);
 			ResultSet rs2=ps2.executeQuery();
  			%>
  			<!DOCTYPE html>
<html>
<head>
<style>
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
</style>
</head>
<body>
<h1>List of Staff</h1>
<h3>Branch : <%=dprt%></h3>
<table>
  <tr>
  	<th>Faculty ID</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Gender</th>
     <th>Phone Number</th> 
     <th>Department</th>
     <th>Subject<th>  
     </tr>
  			<% int i=0;
  				while(rs.next()) {
     		 		int id=rs.getInt("FacultyID");
    				String fname=rs.getString("FirstName");
    				String lname=rs.getString("LastName");
    				String phone=rs.getString("phoneNumber");
    				String gender=rs.getString("Gender");
    				String sub=rs.getString("subject");
    				String dprt1=rs.getString("Branch");
  					%><% %>
  					 <tr>
   						   <td><%=id%></td>
    				       <td><%=fname%></td>
   						   <td><%=lname%></td>
   						   <td><%=gender%></td>
   						   <td><%=phone%></td>
   						   <td><%=dprt1%></td>
   						   <td><%=sub%></td>
  					</tr>
  					<%
     		 	i++;}
     		%>
     		</table>
			<h3>Total : <%=i%></h3>
			</body>
			</html><%
			
			String b=request.getParameter("button");
			if(b!=null) {
			try {
  				Document document = new Document();
  				PdfWriter.getInstance(document, new FileOutputStream("D:\\DataStaff-"+dprt+".pdf"));
  				document.open();
  				PdfPTable table = new PdfPTable(7);
  				
  				String paragraph="Staff List\nDepartment :"+dprt+"\n\n\n";
  				Paragraph para = new Paragraph (paragraph); 
  				document.add(para);
  				
  				table.addCell("Faculty ID");
  			 	table.addCell("First Name");
  				table.addCell("Last Name");
  				table.addCell("Gender");
  				table.addCell("Phone");
  				table.addCell("Department");
  				table.addCell("Subject");
  				
  				while (rs2.next()) {
  					table.addCell(rs2.getString("FacultyID"));
  					table.addCell(rs2.getString("FirstName"));
  					table.addCell(rs2.getString("LastName"));
  					table.addCell(rs2.getString("Gender"));
  					table.addCell(rs2.getString("phoneNumber"));
  					table.addCell(rs2.getString("Branch"));
  					table.addCell(rs2.getString("subject"));
  				}
  				document.add(table);
  				document.close();
  				%><h3>PDF Downloaded</h3><%
  			}catch(Exception e){
				System.out.println(e);
			}
			}
     		}catch(Exception e){
			System.out.println(e);
		}

%>