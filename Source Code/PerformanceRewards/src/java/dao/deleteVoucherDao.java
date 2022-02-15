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

public class deleteVoucherDao {
    
    public String deleteVoucher(rewardsBean rewardsbean) {
        
        int id = rewardsbean.getId();
        
        try {
            Connection con = dbConnection.createConnection();
            PreparedStatement pstmt = null;
                       
            if (id != 0) {
            pstmt = con.prepareStatement("UPDATE REWARDS SET STATUS = 'inactive' WHERE REWARD_ID = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            
            pstmt.close();
            con.close();
            
            return "Success";
            }
            else
                return "Failed to delete";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Failed to delete";

    }
}
