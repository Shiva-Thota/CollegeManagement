<%@page  import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
	 	 String newid=request.getParameter("newid");
         String oldid=request.getParameter("oldId");
		 String dprt=request.getParameter("Branch");
 	     String yr=request.getParameter("Year");
		 Connection con=null;
		 String url="jdbc:mysql://localhost:3306/collegeManagement";
		 String usrname="root";
		 String pswrd="Shiva@9948";
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
			   con = DriverManager.getConnection(url, usrname, pswrd);
		       PreparedStatement ps1=con.prepareStatement("select * from classAllotment where Branch=? and Year=?;");
			ps1.setString(1, dprt);
			ps1.setString(2, yr);
			ResultSet rs1=ps1.executeQuery();
			int sub1=0;
			int sub2=0;
			int sub3=0;
			int sub4=0;
			int sub5=0;
			int sub6=0;
		while(rs1.next()) {
    	sub1=rs1.getInt("sub1");
    	sub2=rs1.getInt("sub2");   	
    	sub3=rs1.getInt("sub3");  	
    	sub4=rs1.getInt("sub4");
    	sub5=rs1.getInt("sub5");
    	sub6=rs1.getInt("sub6");
    	}
		int oid=Integer.parseInt(oldid);
		int f=0;
	  	  String subcode=null;
	  	  	   if(sub1==oid){
	  	  		   f=1;
	  	  	     subcode="sub1";
	  	  	    }else if(sub2==oid){
	  	  	   		 f=1;
	  	  	    	subcode="sub2";
	  	  	  	}else if(sub3==oid){
	  	  	  		f=1;
	  	    	  	subcode="sub3";
	  	  	  	}else if(sub4==oid){
	  	  	  		f=1;
	  	  	  		subcode="sub4";
	  	  	  	}else if(sub5==oid){
	  	  	  		f=1;
	  	  	  		subcode="sub5";
	  	  	  	}else if(sub6==oid){
	  	  	  		f=1;
	  	  	  		subcode="sub6";
	  	  	  	}else{
	  	  	  	%>	<dialog open>
	  			<h1>FAILED</h1>
	  			<h3>Old Teacher Doesnot have That Class<h3>
	  			  </dialog>
	  	  	  	<%
	  	  	  	}
	  	  	String ac=dprt+"-"+yr+"-"+subcode;
	  	  	PreparedStatement ps=con.prepareStatement("select * from faculty where FacultyID=? ;");
			ps.setString(1, newid);
			ResultSet rs=ps.executeQuery();
			
			String class1="noclass";
			String class2="noclass";
			String class3="noclass";
	    while(rs.next()) {
	   		 class1=rs.getString("AllotedClass1SubjectCode");
	   		 class2=rs.getString("AllotedClass2SubjectCode");
	   		 class3=rs.getString("AllotedClass3SubjectCode");
	    	}
		    int x=0,f1=0;
		    String up=null;
				    if(class1==null) {
				    	f1=1;
						  up="update faculty set AllotedClass1SubjectCode='"+ac+"' where FacultyID="+newid+";";
			    }else if(class2==null) {
					  up="update faculty set AllotedClass2SubjectCode='"+ac+"' where FacultyID="+newid+";";
					  f1=1;
			    }else if(class3==null) {
			    	f1=1;  
			    	up="update faculty set AllotedClass3SubjectCode='"+ac+"' where FacultyID="+newid+";";
			    }else {
			    	%>	<dialog open>
		  			<h1>FAILED</h1>
		  			<h3>ALL CLASSES FILLED FOR Teacher<h3>
		  			  </dialog>
		  	  	  	<%
			    }
				    
			
			 if(f==1&&f1==1){
	    		PreparedStatement pss=con.prepareStatement(up);
	    		x=pss.executeUpdate();
	    		
	    		String g="update classAllotment set "+subcode+"="+newid+" where Branch=? and Year=?;";
	    		  PreparedStatement ps2=con.prepareStatement(g);
	  			ps2.setString(1, dprt);
	  			ps2.setString(2, yr);
	  			ps2.executeUpdate();
	  			
	  			PreparedStatement ps4=con.prepareStatement("select * from faculty where FacultyID=? ;");
				ps.setInt(1, oid);
				ResultSet rs4=ps.executeQuery();
				String classs1="noclass";
				String classs2="noclass";
				String classs3="noclass";
		    while(rs4.next()) {
		   		 classs1=rs4.getString("AllotedClass1SubjectCode");
		   		 classs2=rs4.getString("AllotedClass2SubjectCode");
		   		 classs3=rs4.getString("AllotedClass3SubjectCode");
		    	}
	  			
		     int f4=0;
		    String up4=null;
				    if(classs1.equalsIgnoreCase(ac)) {
				    	f4=1;
						  up4="update faculty set AllotedClass1SubjectCode=NULL where FacultyID="+oid+";";
			    }else if(classs2.equalsIgnoreCase(ac)) {
					  up4="update faculty set AllotedClass2SubjectCode=NULL where FacultyID="+oid+";";
					  f4=1;
			    }else if(classs3.equalsIgnoreCase(ac)) {
			    	f4=1;  
			    	up4="update faculty set AllotedClass3SubjectCode=NULL where FacultyID="+oid+";";
			    }else{
			    	 
			    }
				    if(f4==1){
				    	PreparedStatement p7ss=con.prepareStatement(up4);
			    		x=p7ss.executeUpdate();
				    }
				    if(x!=0){%>
		 			<dialog open>
				 <h1>Teacher Replaced</h1>
					<p>Faculty id =<%= newid%></p>
					<p>Class =<%=dprt%>-<%=yr%></p>
				  </dialog>
				<%}else{%>
				 <dialog open>
				<h1>FAILED</h1>
				  </dialog>
	   <%}
				}
			 }catch(Exception e){
			System.out.println(e);
		}%>