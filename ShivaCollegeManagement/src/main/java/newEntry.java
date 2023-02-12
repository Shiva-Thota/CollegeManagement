

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.xdevapi.Statement;

@WebServlet("/newEntry")
public class newEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public newEntry() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		String select=req.getParameter("studentOrfaculty");
		String fname=req.getParameter("First Name");
		String lname=req.getParameter("Last Name");
		String phone=req.getParameter("phone");
		String gender =req.getParameter("gender");
		String dprt=req.getParameter("Branch");
		String pswrd1=req.getParameter("pswrd");
		String pswrd2=req.getParameter("pswrd1");
		if(pswrd2.equals(pswrd1)) {
			int i=0;
			Connection con=null;
			String url="jdbc:mysql://localhost:3306/collegeManagement";
			String usrname="root";
			String pswrd="Shiva@9948";
			try {
				 Class.forName("com.mysql.jdbc.Driver");
			      con = DriverManager.getConnection(url, usrname, pswrd);
			     if(select.equalsIgnoreCase("Student")) {
	
			    	 String yr=req.getParameter("Year");
			    	 
			    	 DatabaseMetaData dbm = con.getMetaData();
				      ResultSet tables = dbm.getTables(null, null, "studentdetails", null);
				      if (tables.next()) {
				       // System.out.println("EXIXTS____________");
				      } else {
				        // Table does not exist, create it
				    	  String tb="create table studentdetails(StudentID int auto_increment,FirstName varchar(30),LastName varchar(30),Gender varchar(30),"
				  				+ "phoneNumber long,pswrd varchar(30),Branch varchar(30),Year varchar(30),sub1 int,sub2 int,sub3 int,sub4 int,sub5 int,sub6 int,sub1Attend int,sub2Attend int,sub3Attend int,sub4Attend int,sub5Attend int,sub6Attend int,EventAttend double, primary key(StudentID));";	
				  			     PreparedStatement ps9999=con.prepareStatement(tb);
				  			     ps9999.executeUpdate(tb);
				  			   out.println("table created");
				      }
			 /*   String tb="create table studentdetails(StudentID int auto_increment,FirstName varchar(30),LastName varchar(30),Gender varchar(30),"
				+ "phoneNumber long,pswrd varchar(30),Branch varchar(30),Year varchar(30),sub1 int,sub2 int,sub3 int,sub4 int,sub5 int,sub6 int,sub1Attend int,sub2Attend int,sub3Attend int,sub4Attend int,sub5Attend int,sub6Attend int,EventAttend double, primary key(StudentID));";	
			     PreparedStatement ps=con.prepareStatement(tb);
			     ps.executeUpdate(tb);
			     out.println("table created");
			   */
			    	 PreparedStatement ps=con.prepareStatement("Insert into studentdetails(FirstName,LastName,Gender,phoneNumber,Branch,Year,pswrd) values(?,?,?,?,?,?,?);");
			    	 ps.setString(1, fname);
			    	 ps.setString(2, lname);
			    	 ps.setString(3, gender);
			    	 ps.setString(4, phone);
			    	 ps.setString(5, dprt);
			    	 ps.setString(6, yr);
			    	 ps.setString(7, pswrd1);
			    	 i=ps.executeUpdate();	 
			    if(i!=0) {
			    	PreparedStatement ps1=con.prepareStatement("select * from studentdetails where phoneNumber=?;");
			    	ps1.setString(1, phone);
				    ResultSet rs=ps1.executeQuery();
				    while(rs.next()) {
				    	int id=rs.getInt("StudentID");
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
				    			+ "<h1> Details entered<h1>\r\n"
				    			+ "<table><tr>\r\n"
				    			+ "</td> </tr> <tr>\r\n"
				    			+ " <td>ID    </td><td> "+id  +"</td> </tr><tr>\r\n"
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
			    }else {
			    	out.print("failed");
			    }	
			    
			    
			    
			     }else if(select.equalsIgnoreCase("Faculty")) {
			    	 String sub=req.getParameter("subject");
			    	 String desig=req.getParameter("Designation");
			    	 
			    	 DatabaseMetaData dbm = con.getMetaData();
				      ResultSet tables = dbm.getTables(null, null, "faculty", null);
				      if (tables.next()) {
				       // System.out.println("EXIXTS____________");
				      } else {
				        // Table does not exist, create it
				    	  String tb="create table faculty(FacultyID int auto_increment,FirstName varchar(30),LastName varchar(30),Gender varchar(30),"
							   		+ "phoneNumber long,pswrd varchar(30),Branch varchar(30), subject varchar(30),Designation varchar(30),AllotedClass1SubjectCode varchar(30),AllotedClass2SubjectCode varchar(30),AllotedClass3SubjectCode varchar(30),primary key(FacultyID));"; 
				    	  PreparedStatement ps999=con.prepareStatement(tb);
				  			     ps999.executeUpdate(tb);
				  			   out.println("table created");
				      }
			    	 
			    	 
			    	 
			  /*   String tb="create table faculty(FacultyID int auto_increment,FirstName varchar(30),LastName varchar(30),Gender varchar(30),"
						   		+ "phoneNumber long,pswrd varchar(30),Branch varchar(30), subject varchar(30),Designation varchar(30),AllotedClass1SubjectCode varchar(30),AllotedClass2SubjectCode varchar(30),AllotedClass3SubjectCode varchar(30),primary key(FacultyID));";
			    	// String tb="drop table faculty;";
			    	 PreparedStatement ps=con.prepareStatement("select * from booksdetail",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			    	 ps.executeUpdate(tb);
				     out.println("table created");*/
			  	PreparedStatement ps=con.prepareStatement("Insert into faculty(FirstName,LastName,Gender,phoneNumber,Branch,pswrd,Designation,subject) values(?,?,?,?,?,?,?,?);");
			    	 ps.setString(1, fname);
			    	 ps.setString(2, lname);
			    	 ps.setString(3, gender);
			    	 ps.setString(4, phone);
			    	 ps.setString(5, dprt);
			    	 ps.setString(6, pswrd1);
			    	 ps.setString(7, desig);
			    	 ps.setString(8, sub);
			    	 i=ps.executeUpdate();
			    	 if(i!=0) {
					    	PreparedStatement ps1=con.prepareStatement("select * from faculty where phoneNumber=?;");
					    	ps1.setString(1, phone);					    	
					    ResultSet rs=ps1.executeQuery();			    	 
			    	 while(rs.next()) {
			    		 int id=rs.getInt("FacultyID");
			    		 	String fname1=rs.getString("FirstName");
							String lname1=rs.getString("LastName");
							String phone1=rs.getString("phoneNumber");
							String gender1=rs.getString("Gender");
							String dprt1=rs.getString("Branch");
							String password=rs.getString("pswrd");
							String desig1 =rs.getString("Designation");
							String sub1 =rs.getString("Subject");
							
							
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
						    			+ "<h1> Details entered<h1>\r\n"
						    			+ "<table><tr>\r\n"
						    			+ " <td>ID    </td><td> "+id  +"</td> </tr><tr>\r\n"
						    			+ "  <td><label>Designation</label></td><td>"+desig+"</td> </tr> <tr>\r\n"
						    			+ " <td>First Name</td><td> "+fname1  +"</td> </tr><tr>\r\n"
						    			+ " <td>Last Name</td><td>"+lname1  +" </td></tr><tr>\r\n"
						    			+ " <td>Phone Number</td><td> "+phone1  +"</td></tr><tr>\r\n"
						    			+ " <td>Gender</td><td>"+gender1  +" </td> </tr><tr>\r\n"
						    			+ " <td>Select Department</td><td> "+ dprt1 +"</td></tr>\r\n"
						    			+ " </tr> <tr><td>Subject </td><td> "+sub1  +"</td>\r\n"
						    			+ " <tr><td>Password</td><td> "+  password+"</td>\r\n"
						    			+ " </tr></table>");
					    	 out.print("</body></html>");
			    	 } 
			    	 }else {
					    	out.print("failed");
					    }
			     }
		
			}catch(Exception e) {
				System.out.println(e);
			}
			}else {
			out.println("Password Not Matched with Conform password");
		}
		
	}

}
