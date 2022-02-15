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
import java.sql.Statement;
import bean.rewardsBean;
import util.dbConnection;
import java.io.InputStream;

public class insertVoucherDao {
    
    public String insertVoucher(rewardsBean rewardsbean) {
        
        int id = 0;
        String name = rewardsbean.getName();
        String description = rewardsbean.getDescription();
        String image = rewardsbean.getImage();
        String category = rewardsbean.getCategory();
        InputStream inputstream = rewardsbean.getInputStream();
        int total = rewardsbean.getTotal();
        
        try {
            Connection con = dbConnection.createConnection();
            PreparedStatement pstmt = null;
            Statement cstmt = null;
            
            cstmt = (Statement) con.createStatement();
            
        try {
        cstmt.executeQuery("SELECT MAX(REWARD_ID) AS \"MaxId\" FROM REWARDSAPP.REWARDS");
        ResultSet rs = cstmt.getResultSet();
        if (rs.next()) {
        id = 1+(rs.getInt(1));
}
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
            
            pstmt = con.prepareStatement("INSERT INTO rewards (reward_id, reward_name, description, image, category, img, total) values (?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, id);
            pstmt.setString(2, name);
            pstmt.setString(3, description);
            pstmt.setString(4, image);
            pstmt.setString(5, category);
            pstmt.setBlob(6, inputstream);
            pstmt.setInt(7, total);
            pstmt.executeUpdate();
            
            pstmt.close();
            con.close();
            
            return "Success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Failed to insert";

    }
}
