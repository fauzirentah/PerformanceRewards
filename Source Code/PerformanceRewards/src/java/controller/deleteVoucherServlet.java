/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

/**
 *
 * @author fauzi
 */
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.rewardsBean;
import dao.deleteVoucherDao;

public class deleteVoucherServlet extends HttpServlet {
    
    public deleteVoucherServlet() {
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if(request.getParameter("btnDeleteVoucher") != null) {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            String category = request.getParameter("category");
            
            rewardsBean rewardsbean = new rewardsBean();
            
            rewardsbean.setId(id);
            rewardsbean.setName(name);
            rewardsbean.setDescription(description);
            rewardsbean.setImage(image);
            rewardsbean.setCategory(category);
            
            deleteVoucherDao deletevoucherdao = new deleteVoucherDao();
            
            String deleteVoucher = deletevoucherdao.deleteVoucher(rewardsbean);
            
            if(deleteVoucher.equals("Success")) {
                request.setAttribute("DeleteVoucherSuccessMsg", deleteVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("DeleteVoucherErrorMsg", deleteVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        }
    }
}
