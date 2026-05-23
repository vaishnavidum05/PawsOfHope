package com.pawsofhope.dao;

import com.pawsofhope.model.Animal;
import com.pawsofhope.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {
    public boolean addAnimal(Animal animal) throws SQLException {
        String sql = "INSERT INTO animals (name, type, breed, age, gender, description, image, posted_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, animal.getName());
            ps.setString(2, animal.getType());
            ps.setString(3, animal.getBreed());
            ps.setInt(4, animal.getAge());
            ps.setString(5, animal.getGender());
            ps.setString(6, animal.getDescription());
            ps.setString(7, animal.getImage());
            ps.setInt(8, animal.getPostedBy());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Animal> getAllAnimals() throws SQLException {
        List<Animal> list = new ArrayList<>();
        String sql = "SELECT * FROM animals WHERE status = 'available'";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapAnimal(rs));
            }
        }
        return list;
    }

    public List<Animal> getAnimalsByType(String type) throws SQLException {
        List<Animal> list = new ArrayList<>();
        String sql = "SELECT * FROM animals WHERE status = 'available' AND type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapAnimal(rs));
            }
        }
        return list;
    }

    public Animal getAnimalById(int id) throws SQLException {
        String sql = "SELECT * FROM animals WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapAnimal(rs);
            }
        }
        return null;
    }

    public List<Animal> getAnimalsByUser(int userId) throws SQLException {
        List<Animal> list = new ArrayList<>();
        String sql = "SELECT * FROM animals WHERE posted_by = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapAnimal(rs));
            }
        }
        return list;
    }

    public boolean deleteAnimal(int id) throws SQLException {
        String sql = "DELETE FROM animals WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE animals SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Animal mapAnimal(ResultSet rs) throws SQLException {
        Animal animal = new Animal();
        animal.setId(rs.getInt("id"));
        animal.setName(rs.getString("name"));
        animal.setType(rs.getString("type"));
        animal.setBreed(rs.getString("breed"));
        animal.setAge(rs.getInt("age"));
        animal.setGender(rs.getString("gender"));
        animal.setDescription(rs.getString("description"));
        animal.setImage(rs.getString("image"));
        animal.setStatus(rs.getString("status"));
        animal.setPostedBy(rs.getInt("posted_by"));
        animal.setCreatedAt(rs.getString("created_at"));
        return animal;
    }
}
