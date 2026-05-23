package com.pawsofhope.servlet;

import com.pawsofhope.dao.InquiryDAO;
import com.pawsofhope.model.Inquiry;
import com.pawsofhope.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/adopt")
public class AdoptServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int animalId = Integer.parseInt(request.getParameter("animalId"));
        String message = request.getParameter("message");

        Inquiry inquiry = new Inquiry();
        inquiry.setAnimalId(animalId);
        inquiry.setUserId(user.getId());
        inquiry.setMessage(message);

        try {
            InquiryDAO dao = new InquiryDAO();
            dao.addInquiry(inquiry);
            response.sendRedirect(request.getContextPath() + "/animal?id=" + animalId + "&success=true");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}