/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import bean.claimBean;
import dao.claimVoucherDao;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.dbConnection;

/**
 *
 * @author fauzi
 */
public class claimVoucherServlet extends HttpServlet {
    
    public claimVoucherServlet() {
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if(request.getParameter("btnClaimVoucher") != null) {

            int reward_id = Integer.parseInt(request.getParameter("id"));
            int employee_id = Integer.parseInt(request.getParameter("empid"));
            int amount = 0;
            
            if(request.getParameter("amountV") == null && request.getParameter("amountS") != null) {
                amount = Integer.parseInt(request.getParameter("amountS"));
            }
            else if (request.getParameter("amountS") == null && request.getParameter("amountV") != null) {
                amount = Integer.parseInt(request.getParameter("amountV"));
            }
            else {
                amount = 0;
            }                    
            
            LocalDateTime currentDate = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE;
            String formattedDateTime = currentDate.format(formatter);
            
            int claim_id = 0;
            int reward_claimed_id = 0;
            
                   try {
                Connection con = dbConnection.createConnection();
                Statement cstmt = null;
                cstmt = (Statement) con.createStatement();
                cstmt.executeQuery("SELECT MAX(CLAIM_ID) AS \"MaxId\" FROM REWARDSAPP.CLAIM");
                ResultSet rs = cstmt.getResultSet();
                if (rs.next()) {
                    claim_id = 1+rs.getInt(1);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
                   try {
                Connection con = dbConnection.createConnection();
                Statement cstmt = null;
                cstmt = (Statement) con.createStatement();
                cstmt.executeQuery("SELECT MAX(REWARD_CLAIMED_ID) AS \"MaxId\" FROM REWARDSAPP.REWARDS_CLAIMED");
                ResultSet rs = cstmt.getResultSet();
                if (rs.next()) {
                    reward_claimed_id = 1+rs.getInt(1);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            claimBean claimbean = new claimBean();
            
            claimbean.setRewardId(reward_id);
            claimbean.setEmployeeId(employee_id);
            claimbean.setAmount(amount);
            claimbean.setDate(formattedDateTime);
            claimbean.setClaimId(claim_id);
            claimbean.setRewardClaimedId(reward_claimed_id);
            
            claimVoucherDao claimvoucherdao = new claimVoucherDao();
            
            String claimVoucher = claimvoucherdao.claimVoucher(claimbean);
            
            if(claimVoucher.equals("Success")) {
                request.setAttribute("ClaimVoucherSuccessMsg", claimVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("ClaimVoucherErrorMsg", claimVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        }
    }
}
