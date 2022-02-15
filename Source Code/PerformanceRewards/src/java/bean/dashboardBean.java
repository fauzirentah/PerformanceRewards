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
public class dashboardBean {
    
    private String reward;
    private String description;
    private String category;
    private int totalvoucher;
    private int totalclaimed;
    private int available;
    private String name;
    private int totalrequest;
    private int totalamount;
    
    public dashboardBean() {
    }

    public String getReward() {
        return reward;
    }
    
    public String getDescription() {
        return description;
    }
    
    public String getCategory() {
        return category;
    }
    
    public int getTotalVoucher() {
        return totalvoucher;
    }
        
    public int getTotalClaimed() {
        return totalclaimed;
    }    
    public int getAvailable() {
        return available;
    }
    public String getName() {
        return name;
    }
        
    public int getTotalRequest() {
        return totalrequest;
    }
        
    public int getTotalAmount() {
        return totalamount;
    }
    
    public void setReward(String reward) {
        this.reward = reward;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public void setTotalVoucher(int totalvoucher) {
        this.totalvoucher = totalvoucher;
    }
    public void setTotalClaimed(int totalclaimed) {
        this.totalclaimed = totalclaimed;
    }
    public void setAvailable(int available) {
        this.available = available;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setTotalRequest(int totalrequest) {
        this.totalrequest = totalrequest;
    }
    public void setTotalAmount(int totalamount) {
        this.totalamount = totalamount;
    }
    
}
