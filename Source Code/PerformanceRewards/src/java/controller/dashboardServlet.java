/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.dashboardBean;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import util.dbConnection;

/**
 *
 * @author fauzi
 */
public class dashboardServlet extends HttpServlet {
    
        public dashboardServlet() {
    }
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {  
            
        dashboardBean dashboardbean = new dashboardBean();

        try {
            Connection con = dbConnection.createConnection();
            Statement cstmt = null;
            cstmt = (Statement) con.createStatement();
            cstmt.executeQuery("            SELECT  c.reward_name AS \"Reward\", \n"
                    + "            c.description AS \"Description\",\n"
                    + "            c.category AS \"Category\",\n"
                    + "            c.total AS \"Total\",\n"
                    + "            (SELECT COALESCE(SUM(o.amount), 0)\n"
                    + "            FROM REWARDSAPP.REWARDS_CLAIMED o\n"
                    + "            WHERE o.REWARD_ID = c.REWARD_ID) AS \"Claimed\",\n"
                    + "            c.total - (SELECT COALESCE(SUM(o.amount), 0)\n"
                    + "            FROM REWARDSAPP.REWARDS_CLAIMED o\n"
                    + "            WHERE o.REWARD_ID = c.REWARD_ID) AS \"Available\"\n"
                    + "            FROM REWARDSAPP.REWARDS c \n"
                    + "            WHERE c.status = 'active' \n"
                    + "            ORDER BY reward_id ASC");
            ResultSet rs = cstmt.getResultSet();
            if (rs.next()) {
                dashboardbean.setReward(rs.getString(1));
                dashboardbean.setDescription(rs.getString(2));
                dashboardbean.setCategory(rs.getString(3));
                dashboardbean.setTotalVoucher(rs.getInt(4));
                dashboardbean.setTotalClaimed(rs.getInt(5));
                dashboardbean.setAvailable(rs.getInt(6));
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        try {
            Connection con = dbConnection.createConnection();
            Statement cstmt = null;
            cstmt = (Statement) con.createStatement();
            cstmt.executeQuery("            SELECT EMPLOYEE_NAME AS \"Staff Name\",\n" +
"            COUNT(CLAIM.CLAIM_ID) AS \"Number of Claim Request\",\n" +
"            SUM(REWARDS_CLAIMED.AMOUNT) AS \"Total Rewards Claimed\"\n" +
"            FROM EMPLOYEE\n" +
"            LEFT JOIN CLAIM ON CLAIM.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID\n" +
"            LEFT JOIN REWARDS_CLAIMED ON CLAIM.CLAIM_ID = REWARDS_CLAIMED.CLAIM_ID\n" +
"            GROUP BY EMPLOYEE_NAME");
            ResultSet rs = cstmt.getResultSet();
            if (rs.next()) {
                dashboardbean.setName(rs.getString(1));
                dashboardbean.setTotalRequest(rs.getInt(2));
                dashboardbean.setTotalAmount(rs.getInt(3));
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
            request.setAttribute("reward", dashboardbean.getReward());
            request.setAttribute("description", dashboardbean.getDescription());
            request.setAttribute("category", dashboardbean.getCategory());
            request.setAttribute("totalvoucher", dashboardbean.getTotalVoucher());
            request.setAttribute("totalclaimed", dashboardbean.getTotalClaimed());
            request.setAttribute("available", dashboardbean.getAvailable());
            request.setAttribute("name", dashboardbean.getName());
            request.setAttribute("totalrequest", dashboardbean.getTotalRequest());
            request.setAttribute("totalamount", dashboardbean.getTotalAmount());
            request.setAttribute("message", "hello");
            
                RequestDispatcher view=request.getRequestDispatcher("dashboard.jsp");
                view.forward(request,response);
}
}
