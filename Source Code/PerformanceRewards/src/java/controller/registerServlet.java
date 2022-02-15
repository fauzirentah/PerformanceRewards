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

import bean.registerBean;
import dao.registerDao;

public class registerServlet extends HttpServlet {
    
    public registerServlet() {
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        if(request.getParameter("btnRegister") != null) {
            
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            
            registerBean registerbean = new registerBean();
            
            registerbean.setName(name);
            registerbean.setUsername(username);
            registerbean.setPassword(password);
            registerbean.setRole(role);
            
            registerDao registerdao = new registerDao();
            
            String registerUser = registerdao.registerUser(registerbean);
            
            if(registerUser.equals("Success")) {
                request.setAttribute("RegisterSuccessMsg", registerUser);
                RequestDispatcher rd = request.getRequestDispatcher("registerSuccess.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("RegisterErrorMsg", registerUser);
                RequestDispatcher rd = request.getRequestDispatcher("registerFailed.jsp");
                rd.include(request, response);
            }
        }
    }
}
