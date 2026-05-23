package com.pawsofhope.servlet;

import com.pawsofhope.dao.AnimalDAO;
import com.pawsofhope.model.Animal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/animal")
public class AnimalDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            AnimalDAO dao = new AnimalDAO();
            Animal animal = dao.getAnimalById(id);
            request.setAttribute("animal", animal);
            request.getRequestDispatcher("/pages/animal-detail.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}