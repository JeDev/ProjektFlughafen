 <head><link rel="stylesheet" type="text/css" href="/FlughafenProjekt/css/style.css"></head>


<%@page import="java.sql.*" %>


<% 

Connection conn = null;
Statement stmt = null;

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

        if(request.getParameter("getKuerzel") != null) {


try {
		
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection ("jdbc:mysql://localhost:3306/flughafendb?user=root&password=12345678", "flughafen","flug");
    stmt = conn.createStatement(); 





    String kuerzel = request.getParameter("getKuerzel");
    String bezeichnung = request.getParameter("getBezeichnung");
    String IP = request.getParameter("getIP");

            
    String the_sql =    " INSERT INTO flughafen " +
                        " VALUES ('" + kuerzel + "', '" + bezeichnung + "', '" + IP + "');";	



    PreparedStatement pstmt = conn.prepareStatement (the_sql);

                        
    pstmt.executeUpdate();

    out.println("<h3>Sie haben folgenden Flughafen hinzugefügt</h3>");
    out.println("<table id='Flughafenliste'> <tr> <th>Kuerzel</th> <th>Bezeichnung</th> <th>IP-Adresse</th> </tr>");

    out.println("<tr>");
    out.print("<td> " + kuerzel + "</td>");
    out.println("<td>" + bezeichnung + "</td>");
    out.println("<td>" + IP + "</td></tr>");
    out.println("</table>");
    out.println("<br><form action='index.jsp'><input type='submit' class='button' value='zur\u00fcck auf die Flughafenseite' /></form>");

    }




	catch(SQLException e){
		out.println ("<hr><b class='error'> JDBC Schrott: "+ e.getMessage()+"</b><br>");
    }


        }


	

%>