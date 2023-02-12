<%@page  import="java.sql.*" import ="java.util.StringTokenizer"  import ="javax.servlet.ServletException"
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
String cls=request.getParameter("classs");
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
		String classs=null;
		String sub99=null;
		if(cls.equalsIgnoreCase("class1")){	
			PreparedStatement ps=con.prepareStatement("select * from faculty where FacultyID=? ;");
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
    while(rs.next()) {
   		 classs=rs.getString("AllotedClass1SubjectCode"); 
   		sub99=rs.getString("subject");
    	}
		}else if(cls.equalsIgnoreCase("class2")){
			PreparedStatement ps=con.prepareStatement("select * from faculty where FacultyID=? ;");
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
    while(rs.next()) {
   		 classs=rs.getString("AllotedClass2SubjectCode"); 
   		sub99=rs.getString("subject");
    }
		}else if(cls.equalsIgnoreCase("class3")){
			PreparedStatement ps=con.prepareStatement("select * from faculty where FacultyID=? ;");
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
    while(rs.next()) {
   		 classs=rs.getString("AllotedClass3SubjectCode"); 
   		sub99=rs.getString("subject");
		}
		}
		String brnch=null;
		String yr=null;
		String sub=null;
		 if(classs!=null){
			 StringTokenizer st=new StringTokenizer(classs);
	    	 brnch=st.nextToken("-");
	    	yr=st.nextToken();
	    	sub=st.nextToken();
		 }
		 String att=sub+"Attend";
		 String ss="select * from studentdetails where Branch='"+brnch+"' and Year="+yr+";";
		 
		 
		 PreparedStatement ps2=con.prepareStatement(ss);
			ResultSet rs2=ps2.executeQuery();
			 PreparedStatement ps=con.prepareStatement(ss);
				ResultSet rs=ps.executeQuery();
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
<h1>List of Students</h1>
<h3>Branch : <%=brnch%></h3>
<h3>Year : <%=yr%></h3>
<table>
  <tr>
  	<th>Student ID</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Gender</th>
     <th>Phone Number</th> 
     <th>Marks</th>
     <th>Attendance</th>
     </tr>
  			<%	int i=0;
  				while(rs.next()) {
     		 		int sid=rs.getInt("StudentID");
    				String fname=rs.getString("FirstName");
    				String lname=rs.getString("LastName");
    				String phone=rs.getString("phoneNumber");
    				String gender=rs.getString("Gender");
    				String marks=rs.getString(sub);
    				String yr1=rs.getString(att);
  					%><% %>					
  					 <tr>
   						   <td><%=sid%></td>
    				       <td><%=fname%></td>
   						   <td><%=lname%></td>
   						   <td><%=gender%></td>
   						   <td><%=phone%></td>
   						   <td><%=marks%></td>
   						   <td><%=yr1%></td>
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
  				PdfWriter.getInstance(document, new FileOutputStream("D:\\DataStudent-"+brnch+"-"+yr+"-"+sub99+".pdf"));
  				document.open();
  				PdfPTable table = new PdfPTable(7);
  				
  				String paragraph="Students List\nDepartment :"+brnch+"\nYear    :"+yr+"\nSubject  :"+sub99+"\n\n\n";
  				Paragraph para = new Paragraph (paragraph); 
  				document.add(para);
  				
  			    table.addCell("Student ID");
  			 	table.addCell("First Name");
  				table.addCell("Last Name");
  				table.addCell("Gender");
  				table.addCell("Phone");
  				table.addCell("Marks");
  				table.addCell("Attendance");
  				
  				while (rs2.next()) {
  					table.addCell(rs2.getString("StudentID"));
  					table.addCell(rs2.getString("FirstName"));
  					table.addCell(rs2.getString("LastName"));
  					table.addCell(rs2.getString("Gender"));
  					table.addCell(rs2.getString("phoneNumber"));
  					table.addCell(rs2.getString(sub));
  					table.addCell(rs2.getString(att));
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