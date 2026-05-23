package com.pawsofhope.servlet;

import com.pawsofhope.dao.AnimalDAO;
import com.pawsofhope.model.Animal;
import com.pawsofhope.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/post-animal")
@MultipartConfig
public class PostAnimalServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String breed = request.getParameter("breed");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String description = request.getParameter("description");

        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/images/uploads/");
        filePart.write(uploadPath + "/" + fileName);

        Animal animal = new Animal();
        animal.setName(name);
        animal.setType(type);
        animal.setBreed(breed);
        animal.setAge(age);
        animal.setGender(gender);
        animal.setDescription(description);
        animal.setImage(fileName);
        animal.setPostedBy(user.getId());

        try {
            AnimalDAO dao = new AnimalDAO();
            dao.addAnimal(animal);
            response.sendRedirect(request.getContextPath() + "/my-listings");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/post-animal.jsp").forward(request, response);
    }
}