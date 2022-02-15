/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author fauzi
 */
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.loginBean;
import util.dbConnection;

public class loginDao {
    
    public String authenticateUser(loginBean loginbean) {
        String username = loginbean.getUsername();
        String password = loginbean.getPassword();

        Connection con = null;
        Statement statement = null;
        ResultSet resultset = null;

        String usernameDB = "";
        String passwordDB = "";

        try {
            con = dbConnection.createConnection();
            statement = con.createStatement();
            resultset = statement.executeQuery("SELECT username, password FROM employee");

            while (resultset.next()) {
                usernameDB = resultset.getString("username");
                passwordDB = resultset.getString("password");

                if (username.equals(usernameDB) && password.equals(passwordDB)) {
                    return "Success";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Invalid username or password";

    }
}
