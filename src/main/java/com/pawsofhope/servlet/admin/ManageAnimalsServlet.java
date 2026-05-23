package com.pawsofhope.servlet.admin;

import com.pawsofhope.dao.AnimalDAO;
import com.pawsofhope.model.Animal;
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

@WebServlet("/admin/manage-animals")
public class ManageAnimalsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            AnimalDAO dao = new AnimalDAO();
            List<Animal> animals = dao.getAllAnimals();
            request.setAttribute("animals", animals);
            request.getRequestDispatcher("/pages/admin/manage-animals.jsp")
                    .forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            AnimalDAO dao = new AnimalDAO();
            if (action.equals("delete")) {
                dao.deleteAnimal(id);
            } else if (action.equals("adopted")) {
                dao.updateStatus(id, "adopted");
            }
            response.sendRedirect(request.getContextPath() + "/admin/manage-animals");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}