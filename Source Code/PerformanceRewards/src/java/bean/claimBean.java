/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author fauzi
 */
public class claimBean implements java.io.Serializable {
    
    private int reward_id;
    private int employee_id;
    private int amount;
    private String date;
    private int claim_id;
    private int reward_claimed_id;
    
    public claimBean() {
    }

    public int getRewardId() {
        return reward_id;
    }

    public int getEmployeeId() {
        return employee_id;
    }

    public int getAmount() {
        return amount;
    }
    
    public String getDate() {
        return date;
    }
    
    public int getClaimId() {
        return claim_id;
    }
    
    public int getRewardClaimedId() {
        return reward_claimed_id;
    }
    
    public void setRewardId(int reward_id) {
        this.reward_id = reward_id;
    }

    public void setEmployeeId(int employee_id) {
        this.employee_id = employee_id;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public void setClaimId(int claim_id) {
        this.claim_id = claim_id;
    }
    
    public void setRewardClaimedId(int reward_claimed_id) {
        this.reward_claimed_id = reward_claimed_id;
    }
}