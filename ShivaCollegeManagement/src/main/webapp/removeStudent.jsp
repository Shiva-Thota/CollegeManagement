<%@page  import="java.sql.*" %>
<%@ page language="java"  contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <style>
dialog {
            color: green;
            font-size: 30px;
            font-weight: Bold;
            font-style: italic;
            border-style: ridge;
        }
</style>
  <%   
  		 String id=request.getParameter("id");
 	     String dprt=request.getParameter("Branch");
		Connection con=null;
		String url="jdbc:mysql://localhost:3306/collegeManagement";
		String usrname="root";
		String pswrd="Shiva@9948";
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			   con = DriverManager.getConnection(url, usrname, pswrd);
    		PreparedStatement ps1=con.prepareStatement("select * from studentdetails where StudentID=? and Branch=?;");
 			ps1.setString(1, id);
 			ps1.setString(2,dprt);
 			ResultSet rs=ps1.executeQuery();
	    while(rs.next()) {
	    	int sid=rs.getInt("StudentID");
			String fname1=rs.getString("FirstName");
			String lname1=rs.getString("LastName");
			String phone1=rs.getString("phoneNumber");
			String gender1=rs.getString("Gender");
			String dprt1=rs.getString("Branch");
			String password=rs.getString("pswrd");
			String yr1=rs.getString("Year");
			 out.print("<html> <body>");
	    	out.print(" <style>\r\n"
	    			+ "table {\r\n"
	    			+ "  border-collapse: collapse;\r\n"
	    			+ "  width: 100%;\r\n"
	    			+ "}th, td {\r\n"
	    			+ "  text-align: left;\r\n"
	    			+ "  padding: 8px;}\r\n"
	    			+ "tr:nth-child(even){background-color: #f2f2f2}\r\n"
	    			+ "th {background-color: #04AA6D;\r\n"
	    			+ "  color: white;}\r\n"
	    			+ "h1{text-align: center;}\r\n"
	    			+ "</style>\r\n"
	    			+ "<h1> Student Deleted<h1>\r\n"
	    			+ "<table><tr>\r\n"
	    			+ "</td> </tr> <tr>\r\n"
	    			+ " <td>ID    </td><td> "+sid  +"</td> </tr><tr>\r\n"
	    			+ " <td>First Name</td><td> "+fname1  +"</td> </tr><tr>\r\n"
	    			+ " <td>Last Name</td><td>"+lname1  +" </td></tr><tr>\r\n"
	    			+ " <td>Phone Number</td><td> "+phone1  +"</td></tr><tr>\r\n"
	    			+ " <td>Gender</td><td>"+gender1  +" </td> </tr><tr>\r\n"
	    			+ " <td>Select Department</td><td> "+ dprt1 +"</td></tr>\r\n"
	    			+ " </tr> <tr><td>Year </td><td> "+yr1  +"</td>\r\n"
	    			+ " <tr><td>Password</td><td> "+  password+"</td>\r\n"
	    			+ " </tr></table>");
	    	 out.print("</body></html>");
	    }
	    PreparedStatement ps=con.prepareStatement("delete from studentdetails where StudentID=? and Branch=?;");
	    ps.setString(1, id);
		ps.setString(2,dprt);
		int x=0;
		x=ps.executeUpdate();
		if(x!=0){%>
		 <dialog open>
		 <h1>STUDENT DELETED</h1>
		  </dialog>
		<%}else{%>
		 <dialog open>
		<h1>FAILED</h1>
		  </dialog>
<%}
		}catch(Exception e){
			System.out.println(e);
		}
 	  %>
 	  