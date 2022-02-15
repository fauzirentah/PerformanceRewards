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
import bean.rewardsBean;
import util.dbConnection;

public class updateVoucherDao {
    
    public String updateVoucher(rewardsBean rewardsbean) {
        
        int id = rewardsbean.getId();
        String name = rewardsbean.getName();
        String description = rewardsbean.getDescription();
        String image = rewardsbean.getImage();
        String category = rewardsbean.getCategory();
        int total = rewardsbean.getTotal();
        
        try {
            Connection con = dbConnection.createConnection();
            PreparedStatement pstmt = null;
                       
            if ((name != null) && (description != null) && (category != null)) {
            pstmt = con.prepareStatement("UPDATE REWARDS SET REWARD_NAME = ?, DESCRIPTION = ?, CATEGORY = ?, TOTAL = ? WHERE REWARD_ID = ?");
            pstmt.setInt(5, id);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setString(3, category);
            pstmt.setInt(4, total);
            pstmt.executeUpdate();
            
            pstmt.close();
            con.close();
            
            return "Success";
            }
            else
                return "Failed to update";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Failed to update";

    }
}
