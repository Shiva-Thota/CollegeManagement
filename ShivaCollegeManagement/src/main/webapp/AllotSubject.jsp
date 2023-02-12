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
  		 String id=request.getParameter("id");
 	     String dprt=request.getParameter("Branch");
 	     String yr=request.getParameter("Year");
		 Connection con=null;
		 String url="jdbc:mysql://localhost:3306/collegeManagement";
		 String usrname="root";
		 String pswrd="Shiva@9948";
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
			   con = DriverManager.getConnection(url, usrname, pswrd);
		  	PreparedStatement ps=con.prepareStatement("select * from faculty where FacultyID=? ;");
 			ps.setString(1, id);
 			ResultSet rs=ps.executeQuery();
 			String subcode1=null;
 			String class1="noclass";
 			String class2="noclass";
 			String class3="noclass";
	    while(rs.next()) {
	   		 class1=rs.getString("AllotedClass1SubjectCode");
	   		 class2=rs.getString("AllotedClass2SubjectCode");
	   		 class3=rs.getString("AllotedClass3SubjectCode");
	    	}
	    
	    DatabaseMetaData dbm = con.getMetaData();
	      ResultSet tables = dbm.getTables(null, null, "classAllotment", null);
	      if (tables.next()) {
	     //   System.out.println("EXIXTS____________");
	      } else {
	    	  String tb="create table classAllotment(classNo int auto_increment,Branch varchar(30),Year varchar(30),sub1 int,sub2 int,sub3 int,sub4 int,sub5 int,sub6 int, primary key(classNo));";
	    	  PreparedStatement ps9999=con.prepareStatement(tb);
			     ps9999.executeUpdate(tb);
			   out.println("table created");
	      }
	      
	      
	    PreparedStatement ps9=con.prepareStatement("select  Branch from classAllotment where exists(select Branch where Branch=? and Year=?);");
	    ps9.setString(1, dprt);
		ps9.setString(2, yr);
		ResultSet rs9=ps9.executeQuery();
		String bb=null;
		while(rs9.next()){
		bb=rs9.getString("Branch");
		}
		if(bb!=null){
		}else{
		    PreparedStatement ps8=con.prepareStatement("insert into classAllotment(Branch,Year) values(?,?);");
					ps8.setString(1, dprt);
					ps8.setString(2, yr);
					ps8.executeUpdate();
		}
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
  	  int f=0;
  	  String subcode=null;
  	  	   if(sub1==0){
  	  		   f=1;
  	  	     subcode="sub1";
  	  	    }else if(sub2==0){
  	  	   		 f=1;
  	  	    	subcode="sub2";
  	  	  	}else if(sub3==0){
  	  	  		f=1;
  	    	  	subcode="sub3";
  	  	  	}else if(sub4==0){
  	  	  		f=1;
  	  	  		subcode="sub4";
  	  	  	}else if(sub5==0){
  	  	  		f=1;
  	  	  		subcode="sub5";
  	  	  	}else if(sub6==0){
  	  	  		f=1;
  	  	  		subcode="sub6";
  	  	  	}
  	  	  	
  	  	  	if(f==0){
  	  	  %>	<dialog open>
  			<h1>FAILED</h1>
  			<h3>ALL CLASSES FILLED FOR Students<h3>
  			  </dialog>
  	  	  	<%}
	    
  	  	 
  	  	   String ac=dprt+"-"+yr+"-"+subcode;
	    int x=0,f1=0;
	    String up=null;
			    if(class1==null) {
			    	f1=1;
					  up="update faculty set AllotedClass1SubjectCode='"+ac+"' where FacultyID="+id+";";
		    }else if(class2==null) {
				  up="update faculty set AllotedClass2SubjectCode='"+ac+"' where FacultyID="+id+";";
				  f1=1;
		    }else if(class3==null) {
		    	f1=1;  
		    	up="update faculty set AllotedClass3SubjectCode='"+ac+"' where FacultyID="+id+";";
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
    		
    		String g="update classAllotment set "+subcode+"="+id+" where Branch=? and Year=?;";
    		  PreparedStatement ps2=con.prepareStatement(g);
  			ps2.setString(1, dprt);
  			ps2.setString(2, yr);
  			ps2.executeUpdate();
  			if(x!=0){%>
 			<dialog open>
		 <h1>Class Alloted</h1>
			<p>Faculty id =<%=id%></p>
			<p>Class =<%=dprt%>-<%=yr%></p>
		  </dialog>
		<%}else{%>
		 <dialog open>
		<h1>FAILED</h1>
		  </dialog>
	<%
			    }
 		}}catch(Exception e){
			System.out.println(e);
		}
 	  %>