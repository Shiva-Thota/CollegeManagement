<%@page  import="java.sql.*" import ="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
    <style>
dialog {
            color: green;
            font-size: 30px;
            font-weight: Bold;
            font-style: italic;
            border-style: ridge;
        }
</style>
<body>
<%      
String sid=request.getParameter("id");
 String attend=request.getParameter("attendance");
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
	String brnch=null;
	String yr=null;
	String sub1=null;
	String subcode1=null,subcode2=null,subcode3=null;
	String dsig=null;
while(rs.next()) {
   sub1=rs.getString("subject");
	    subcode1=rs.getString("AllotedClass1SubjectCode");
	 	subcode2=rs.getString("AllotedClass2SubjectCode");
		subcode3=rs.getString("AllotedClass3SubjectCode");
		dsig=rs.getString("Designation");
	}
int flag=0;
String att=null;
if(dsig.equalsIgnoreCase("HOD")){
	 att="EventAttend";
	flag=1;
}else{
String p="f";
String dprt1=null,year=null;
	PreparedStatement ps9=con.prepareStatement("select StudentID from studentdetails where exists (SELECT StudentID FROM studentdetails WHERE StudentID=?);");
ps9.setString(1, sid);
ResultSet rs9=ps9.executeQuery();
	while(rs9.next()) {
		 p=rs9.getString("StudentID");
	}
	if(p.equalsIgnoreCase("f")){
		%>
		<dialog open>
			<h1>ID Number Doesnot Exist</h1>
			</dialog>
	<%}else{
   PreparedStatement ps=con.prepareStatement("select * from studentdetails where StudentID=?;");
	ps.setString(1, sid);
	ResultSet rs1=ps.executeQuery();
	 	while(rs1.next()) {
	 dprt1=rs1.getString("Branch");
	 year=rs1.getString("Year");
	
	 	
	 	
	 	}
	 	int q=1;
	 String sub9=null;
	 if(subcode1!=null){
	StringTokenizer st=new StringTokenizer(subcode1);
	 brnch=st.nextToken("-");
	yr=st.nextToken();
	sub9=st.nextToken();
	if(dprt1.equalsIgnoreCase(brnch)&&year.equalsIgnoreCase(yr)){ 
		q++;
		flag=1;
	}
 }
	 if(subcode2!=null&&q==1){
		StringTokenizer st=new StringTokenizer(subcode2);
	 brnch=st.nextToken("-");
	yr=st.nextToken();
	sub9=st.nextToken();
	if(dprt1.equalsIgnoreCase(brnch)&&year.equalsIgnoreCase(yr)){ 	    	
		q++;
		flag=1;
	}
	 }
	if(subcode3!=null&&q==1){
		StringTokenizer st=new StringTokenizer(subcode3);
	 brnch=st.nextToken("-");
	yr=st.nextToken();
	sub9=st.nextToken();
	if(dprt1.equalsIgnoreCase(brnch)&&year.equalsIgnoreCase(yr)){ 	    		
		q++;
		flag=1;
	}
	 }
	if(q==1){
		%>%><dialog open>
			<h1>This Id is Not present in your classes</h1>
			</dialog> <% 
	}
	 att=sub9+"Attend";
	}}
	int x=0;
	 if(flag==1){
		 String up="Update studentdetails set "+att+"="+attend+" where StudentID="+sid+";";
		PreparedStatement pst=con.prepareStatement(up);
	x=pst.executeUpdate();
	if(x!=0){%>
	<dialog open>
			<h1>Attendance UPDATED</h1>
			<p>Student ID=<%=sid%></p>
			<p>Subject =<%=sub1%></p>
			<p>Attendance =<%=attend%></p>
			</dialog>
	<%}else{%>
	<h1>Failed</h1>
	 <%}
	}
	
	 }catch(Exception e){
	System.out.println(e);
}
		%>
		</body>
</html>