package com.pawsofhope.servlet.admin;

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
import java.util.List;

@WebServlet("/admin/manage-users")
public class ManageUsersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserDAO dao = new UserDAO();
            List<User> users = dao.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/pages/admin/manage-users.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            UserDAO dao = new UserDAO();
            dao.deleteUser(id);
            response.sendRedirect(request.getContextPath() + "/admin/manage-users");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}