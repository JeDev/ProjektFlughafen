package com.company;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.*;
import java.sql.*;

public class Server {
    private ServerSocket server;

    public Server(int port)
    {
        try {
            server = new ServerSocket(port);
            server.setSoTimeout(100000);
        }
        catch(SocketException e){
            e.printStackTrace();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    public void laufen(){
        while (true)
        {
            try{
                System.out.println("Waiting for Client " + server.getLocalPort());
                Socket client = server.accept();
                DataInputStream input = new DataInputStream(client.getInputStream());
               String JSON = input.readUTF();

        //***************************************
                //insert into ankünfte
                Connection conn = null;
                Statement stmt = null;
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection ("jdbc:mysql://localhost:3306/flughafendb", "flughafen","flug");
                stmt = conn.createStatement();
                String sqlString = "INSERT INTO ANKUNFTE " +
                                    "(ADRESS_ID, HERKUNFT, ZEITSTEMPEL, CARGO_JSON) "+
                                    "VALUES(?,?,NOW(),?);";

                PreparedStatement pstmt = conn.prepareStatement(sqlString);
                pstmt.setInt(1, 1);
                pstmt.setString(2, "MAX");
                pstmt.setString(3, JSON);


               pstmt.executeUpdate();

        //****************************************
                System.out.println(client.getRemoteSocketAddress());
                DataOutputStream output = new DataOutputStream(client.getOutputStream());
                output.writeUTF("Hallo");
                client.close();
                }
                
            catch (IOException e) {
                e.printStackTrace();
                break;
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public static void main(String[] args)
    {
        Server s = new Server(1337);
        s.laufen();
    }
}