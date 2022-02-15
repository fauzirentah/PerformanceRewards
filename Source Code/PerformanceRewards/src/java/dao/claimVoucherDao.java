/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bean.claimBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import util.dbConnection;

/**
 *
 * @author fauzi
 */
public class claimVoucherDao {
    
    public String claimVoucher(claimBean claimbean) {
        
        int reward_id = claimbean.getRewardId();
        int employee_id = claimbean.getEmployeeId();
        int amount = claimbean.getAmount();
        String date = claimbean.getDate();
        int claim_id = claimbean.getClaimId();
        int reward_claimed_id = claimbean.getRewardClaimedId();
                
        try {
            Connection con = dbConnection.createConnection();
            PreparedStatement pstmt1= null;
            PreparedStatement pstmt2= null;
                       
            if ((date != null) && (amount != 0)) {
            pstmt1 = con.prepareStatement("INSERT INTO claim (claim_id, claim_date, employee_id) values (?, ?, ?)");            
            pstmt1.setInt(1, claim_id);
            pstmt1.setString(2, date);
            pstmt1.setInt(3, employee_id);
            pstmt1.executeUpdate();
            pstmt1.close();
            pstmt2 = con.prepareStatement("INSERT INTO rewards_claimed (reward_claimed_id, claim_id, reward_id, amount) values (?, ?, ?, ?)");
            pstmt2.setInt(1, reward_claimed_id);
            pstmt2.setInt(2, claim_id);
            pstmt2.setInt(3, reward_id);
            pstmt2.setInt(4, amount);
            pstmt2.executeUpdate();
            pstmt2.close();
            con.close();
            
            return "Success";
            }
            else
                return "Failed to claim";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Failed to claim";

    }
}
