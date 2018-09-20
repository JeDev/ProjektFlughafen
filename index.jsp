 <head><link rel="stylesheet" type="text/css" href="/FlughafenProjekt/css/style.css"></head>


<%@page import="java.sql.*" %>


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
        
        out.println("<form action='index.jsp' method='POST' target='_self'>");
        out.println("<table id='Flughafenliste' <tr> <th> </th> <th>Kuerzel</th> <th>Bezeichnung</th> <th>IP-Adresse</th> </tr>");



        while(res.next()){
            
            out.println("<tr><td><input type='radio' name='radio' value='" + res.getString(1) + "'></td>");
            out.println("<td> " +res.getString(1) + ": </td>");
            out.println("<td>" + res.getString(2) + "</td>");
            out.println("<td>" + res.getString(3) + "</td></tr>");

        }

		out.println("</table>"); 
        out.println("<br><input name='senden' class='button' type='submit' value='Add'>");
        out.println("<input name='senden' class='button' type='submit' value='L\u00f6schen'>");
        out.println("<input name='senden' class='button' type='submit' value='Edit'></form>");

        String sql_query;

        
        if(request.getParameter("senden") != null) {
            switch(request.getParameter("senden")) {
                case"L\u00f6schen": {
                    sql_query = "Delete from flughafen" +
                                " Where Kurzel='" + (request.getParameter("radio")) + "';";

            		stmt = conn.createStatement(); 
                    PreparedStatement pstmt1 = conn.prepareStatement (sql_query);
                    pstmt1.executeUpdate();

                    out.println("<br><form action='index.jsp' method='POST' target='_self'><h3>Der Datensatz " + 
                    (request.getParameter("radio")) + " wurde erfolgreich gel\u00f6scht</h3>" + 
                    "<input name='Ok' class='button' type='submit' value='Ok'></form>");
                }
                break;

                case"Add": {
                    if(request.getParameter("getKuerzel") == null) {

                        out.println("<br><h2> Flughafen hinzuf&uumlgen </h2>");

                        out.println("<div class='formular'>");
                        out.println("<form action='AddAirport.jsp' method='POST' target='_self'>");
                        out.println("K&uumlrzel: <input name='getKuerzel' type='text'>");
                        out.println("Bezeichnung: <input name='getBezeichnung' type='text'>");
                        out.println("IP-Adresse: <input name='getIP' type='text'>");
                        out.println("<br><input name='senden' type='submit' value='Senden'></form>");
                        out.println("</div>");

                    }

                    else if(request.getParameter("getKuerzel") != null) {

                        String kuerzel = request.getParameter("getKuerzel");
                        String bezeichnung = request.getParameter("getBezeichnung");
                        String IP = request.getParameter("getIP");
                    
                        sql_query = " INSERT INTO flughafen " +
                                    " VALUES ('" + kuerzel + "', '" + bezeichnung + "', '" + IP + "');";

                        PreparedStatement pstmtAdd = conn.prepareStatement (sql_query);
                        pstmtAdd.executeUpdate();
                    }
                    
                }
            }
        }
	}

    catch(SQLException e){
    out.println ("<hr><b class='error'> JDBC Schrott: "+ e.getMessage()+"</b><br>");
	}	

    %>