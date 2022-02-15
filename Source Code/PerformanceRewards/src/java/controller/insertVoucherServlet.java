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
import java.io.InputStream;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

import bean.rewardsBean;
import com.oreilly.servlet.MultipartRequest;
import dao.insertVoucherDao;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

//@WebServlet("/insertVoucherServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class insertVoucherServlet extends HttpServlet {

    public insertVoucherServlet() {
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");

        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        if (request.getParameter("btnInsertVoucher") != null) {

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String image = ""; //request.getParameter("image");
            String category = request.getParameter("category");
            String total = request.getParameter("total");

            InputStream inputStream = null; // input stream of the upload file
            // obtains the upload file part in this multipart request
            Part filePart = request.getPart("img");
            if (filePart != null) {
                // prints out some information for debugging
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());
                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
            }

            //Folder upload
            Part filePartFolder = request.getPart("img");
            String path = "C:\\Users\\fauzi\\Documents\\NetBeansProjects\\PerformanceRewards\\web\\images";
            File file = new File(path);
            file.mkdir();
            String filename = getFileName(filePartFolder);

            OutputStream out = null;
            InputStream filecontent = null;

            PrintWriter writer = response.getWriter();
            try {
                out = new FileOutputStream(new File(path + File.separator + filename));
                filecontent = filePart.getInputStream();
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = filecontent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }
            } catch (Exception e) {
            }
            image = "images\\" + filename;
            
            rewardsBean rewardsbean = new rewardsBean();

            rewardsbean.setName(name);
            rewardsbean.setDescription(description);
            rewardsbean.setImage(image);
            rewardsbean.setCategory(category);
            rewardsbean.setInputStream(inputStream);
            rewardsbean.setTotal(Integer.parseInt(total));
            
            insertVoucherDao insertvoucherdao = new insertVoucherDao();

            String insertVoucher = insertvoucherdao.insertVoucher(rewardsbean);

            if (insertVoucher.equals("Success")) {
                request.setAttribute("InsertVoucherSuccessMsg", insertVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("InsertVoucherErrorMsg", insertVoucher);
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.include(request, response);
            }
        }
    }

}
