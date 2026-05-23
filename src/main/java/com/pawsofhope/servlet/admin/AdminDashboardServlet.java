package com.pawsofhope.servlet.admin;

import com.pawsofhope.dao.AnimalDAO;
import com.pawsofhope.dao.InquiryDAO;
import com.pawsofhope.dao.UserDAO;
import com.pawsofhope.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            AnimalDAO animalDAO = new AnimalDAO();
            InquiryDAO inquiryDAO = new InquiryDAO();

            request.setAttribute("totalUsers", userDAO.getAllUsers().size());
            request.setAttribute("totalAnimals", animalDAO.getAllAnimals().size());
            request.setAttribute("totalInquiries", inquiryDAO.getAllInquiries().size());

            request.getRequestDispatcher("/pages/admin/admin-dashboard.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}