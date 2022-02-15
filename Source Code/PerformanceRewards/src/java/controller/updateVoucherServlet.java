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
import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;

import bean.rewardsBean;
import dao.updateVoucherDao;

public class updateVoucherServlet extends HttpServlet {
    
    public updateVoucherServlet() {
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if(request.getParameter("btnUpdateVoucher") != null) {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            // String image = request.getParameter("image");
            String category = request.getParameter("category");
            int additional = Integer.parseInt(request.getParameter("additional"));
            int total = Integer.parseInt(request.getParameter("total")) + additional;

            rewardsBean rewardsbean = new rewardsBean();
            
            rewardsbean.setId(id);
            rewardsbean.setName(name);
            rewardsbean.setDescription(description);
            //rewardsbean.setImage(image);
            rewardsbean.setCategory(category);
            rewardsbean.setTotal(total);
            
            updateVoucherDao updatevoucherdao = new updateVoucherDao();
            
            String updateVoucher = updatevoucherdao.updateVoucher(rewardsbean);
            
            if(updateVoucher.equals("Success")) {
                request.setAttribute("UpdateVoucherSuccessMsg", updateVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("UpdateVoucherErrorMsg", updateVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        }
    }
}
