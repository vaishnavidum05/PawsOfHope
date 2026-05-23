package com.pawsofhope.servlet;

import com.pawsofhope.dao.AnimalDAO;
import com.pawsofhope.dao.InquiryDAO;
import com.pawsofhope.model.Animal;
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
import java.util.List;

@WebServlet("/my-listings")
public class MyListingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            AnimalDAO animalDAO = new AnimalDAO();
            InquiryDAO inquiryDAO = new InquiryDAO();

            List<Animal> animals = animalDAO.getAnimalsByUser(user.getId());
            List<Inquiry> receivedInquiries = inquiryDAO.getInquiriesByAnimalOwner(user.getId());
            List<Inquiry> sentInquiries = inquiryDAO.getInquiriesByUser(user.getId());

            request.setAttribute("animals", animals);
            request.setAttribute("receivedInquiries", receivedInquiries);
            request.setAttribute("sentInquiries", sentInquiries);
            request.getRequestDispatcher("/pages/my-listings.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int animalId = Integer.parseInt(request.getParameter("animalId"));

        try {
            AnimalDAO dao = new AnimalDAO();
            if (action.equals("markAdopted")) {
                dao.updateStatus(animalId, "adopted");
            } else if (action.equals("markAvailable")) {
                dao.updateStatus(animalId, "available");
            }
            response.sendRedirect(request.getContextPath() + "/my-listings");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}