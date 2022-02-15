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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.loginBean;
import dao.loginDao;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.dbConnection;

public class loginServlet extends HttpServlet {

    public loginServlet() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = 0;
        String name = null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = null;

        loginBean loginbean = new loginBean();

        loginbean.setUsername(username);
        loginbean.setPassword(password);

        loginDao logindao = new loginDao();

        String uservalidate = logindao.authenticateUser(loginbean);

        if (uservalidate.equals("Success")) {
            try {
                Connection con = dbConnection.createConnection();
                Statement cstmt = null;
                cstmt = (Statement) con.createStatement();
                cstmt.executeQuery("SELECT EMPLOYEE_ID, EMPLOYEE_NAME, ROLE FROM REWARDSAPP.EMPLOYEE WHERE USERNAME =  \'" + username + "\'");
                ResultSet rs = cstmt.getResultSet();
                if (rs.next()) {
                    id = rs.getInt(1);
                    name = rs.getString(2);
                    role = rs.getString(3);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            HttpSession session = request.getSession();
            session.setAttribute("login", loginbean.getUsername());
            session.setAttribute("id", id);
            session.setAttribute("name", name);
            session.setAttribute("role", role);
            request.getRequestDispatcher("/main.jsp").forward(request, response);
        } else {
            request.setAttribute("WrongLoginErr", uservalidate);
            request.setAttribute("username", username);
            request.getRequestDispatcher("/failedLogin.jsp").forward(request, response);
        }
    }
}
