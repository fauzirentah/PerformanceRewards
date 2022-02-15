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
import java.sql.PreparedStatement;
import bean.registerBean;
import java.sql.Statement;
import util.dbConnection;

public class registerDao {
    
    public String registerUser(registerBean registerbean) {
        
        int id = 0;
        String name = registerbean.getName();
        String username = registerbean.getUsername();
        String password = registerbean.getPassword();
        String role = registerbean.getRole();
        
        try {
            Connection con = dbConnection.createConnection();
            PreparedStatement pstmt = null;            
            Statement cstmt = null;
            
            cstmt = (Statement) con.createStatement();
            
        try {
        cstmt.executeQuery("SELECT MAX(EMPLOYEE_ID) AS \"MaxId\" FROM REWARDSAPP.EMPLOYEE");
        ResultSet rs = cstmt.getResultSet();
        if (rs.next()) {
        id = 1+(rs.getInt(1));
}
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
            
            pstmt = con.prepareStatement("INSERT INTO employee (employee_id, employee_name, username, password, role) values (?, ?, ?, ?, ?)");
            pstmt.setInt(1, id);
            pstmt.setString(2, name);
            pstmt.setString(3, username);
            pstmt.setString(4, password);
            pstmt.setString(5, role);
            pstmt.executeUpdate();
            
            pstmt.close();
            con.close();
            
            return "Success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Failed to regiser";

    }
}
