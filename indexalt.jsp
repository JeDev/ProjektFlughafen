 <head><link rel="stylesheet" type="text/css" href="/FlughafenProjekt/css/style.css"></head>


<%@page import="java.sql.*" %>
<%@page import="Flughafen.Flughafen.*" %>
<%@page import="java.util.*" %>



<% 

		Connection conn = null;
		Statement stmt = null;
		
        String sort_column = "1";
        String sort_order = "asc";

        if (request.getParameter("sort") != null) sort_column = request.getParameter("sort");
        if (request.getParameter("sortdir") != null) sort_order = request.getParameter("sortdir");

	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection ("jdbc:mysql://localhost:3306/flughafendb", "flughafen","flug");
	
		stmt = conn.createStatement(); 
		
		String the_sql =    " select * from flughafen" +
                            " order by " + sort_column + " " + sort_order + ";";	



		PreparedStatement pstmt = conn.prepareStatement (the_sql);
		/*pstmt.setInt("limite",6);
		pstmt.setInt("active",0);*/
                            
		ResultSet res = pstmt.executeQuery();
		
		out.println ("<h3>Flughafen </h3>");
		int rowcont = 0;
        out.println("<table id='Flughafenliste' <tr> <th>Kuerzel</th> <th>Bezeichnung</th> <th>IP-Adresse</th> </tr>");

		while(res.next()){
            out.println("<tr>");
			out.print("<td> " +res.getString(1) + ": </td>");
			out.println("<td>" + res.getString(2) + "</td>");
			out.println("<td>" + res.getString(3) + "</td></tr>");

		}
			out.println("</table>"); 

	}

		catch(SQLException e){
		out.println ("<hr><b class='error'> JDBC Schrott: "+ e.getMessage()+"</b><br>");
	}	
		


    
	    /*if(angemeldet als Admin)
            {*/
            
			out.println(" <br><form action='index.jsp' method='POST' target='_self'> <input name='getButtonValue' class='button' type='submit' value='add'>");
			out.println(" <input class='button' name='getButtonValue' type='submit' value='delete'>");			
			out.println(" <input class='button' name='getButtonValue' type='submit' value='edit'> </form>");			

			String ButtonValue = "start";

			if (request.getParameter("getButtonValue") != null)  {
        		ButtonValue = request.getParameter("getButtonValue");
    }
			
			switch(ButtonValue) {

				case"add": %> 
					<jsp:include page="AddAirport.jsp" flush="true"/><%; break;

				case"delete": %> 
					<jsp:include page="DeleteAirport.jsp" flush="true"/><%; break;

				case"edit": %> 
					<jsp:include page="EditAirport.jsp" flush="true"/><%; break;
					
			}

			%>