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
import java.util.List;

@WebServlet("/browse")
public class BrowseServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        try {
            AnimalDAO dao = new AnimalDAO();
            List<Animal> animals;
            if (type != null && !type.isEmpty()) {
                animals = dao.getAnimalsByType(type);
            } else {
                animals = dao.getAllAnimals();
            }
            request.setAttribute("animals", animals);
            request.setAttribute("selectedType", type);
            request.getRequestDispatcher("/pages/browse.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}