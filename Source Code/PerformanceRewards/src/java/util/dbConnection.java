/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

/**
 *
 * @author fauzi
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class dbConnection {

    public static Connection createConnection() {
        Connection con = null;
        String url = "jdbc:derby://localhost:1527/RewardsDB";
        String username = "rewardsapp";
        String password = "rewardsapp";

        //           String connectionString = "jdbc:derby://localhost:1527/AccountDB; create=true; user=app; password=app";
        try {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            con = DriverManager.getConnection(url, username, password);
            System.out.println("Printing connection object" + con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
