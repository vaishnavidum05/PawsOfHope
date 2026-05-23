package com.pawsofhope.dao;

import com.pawsofhope.model.Inquiry;
import com.pawsofhope.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InquiryDAO {

    public boolean addInquiry(Inquiry inquiry) throws SQLException {
        String sql = "INSERT INTO inquiries (animal_id, user_id, message) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, inquiry.getAnimalId());
            ps.setInt(2, inquiry.getUserId());
            ps.setString(3, inquiry.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Inquiry> getAllInquiries() throws SQLException {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, u.name as applicant_name, u.email as applicant_email, " +
                "u.phone as applicant_phone, a.name as animal_name " +
                "FROM inquiries i " +
                "JOIN users u ON i.user_id = u.id " +
                "JOIN animals a ON i.animal_id = a.id";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapInquiry(rs));
            }
        }
        return list;
    }

    public List<Inquiry> getInquiriesByUser(int userId) throws SQLException {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, u.name as applicant_name, u.email as applicant_email, " +
                "u.phone as applicant_phone, a.name as animal_name, " +
                "o.name as owner_name, o.email as owner_email, o.phone as owner_phone " +
                "FROM inquiries i " +
                "JOIN users u ON i.user_id = u.id " +
                "JOIN animals a ON i.animal_id = a.id " +
                "JOIN users o ON a.posted_by = o.id " +
                "WHERE i.user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Inquiry inquiry = mapInquiry(rs);
                inquiry.setOwnerName(rs.getString("owner_name"));
                inquiry.setOwnerEmail(rs.getString("owner_email"));
                inquiry.setOwnerPhone(rs.getString("owner_phone"));
                list.add(inquiry);
            }
        }
        return list;
    }

    public List<Inquiry> getInquiriesByAnimalOwner(int ownerId) throws SQLException {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, u.name as applicant_name, u.email as applicant_email, " +
                "u.phone as applicant_phone, a.name as animal_name " +
                "FROM inquiries i " +
                "JOIN users u ON i.user_id = u.id " +
                "JOIN animals a ON i.animal_id = a.id " +
                "WHERE a.posted_by = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapInquiry(rs));
            }
        }
        return list;
    }

    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE inquiries SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Inquiry mapInquiry(ResultSet rs) throws SQLException {
        Inquiry inquiry = new Inquiry();
        inquiry.setId(rs.getInt("id"));
        inquiry.setAnimalId(rs.getInt("animal_id"));
        inquiry.setUserId(rs.getInt("user_id"));
        inquiry.setMessage(rs.getString("message"));
        inquiry.setStatus(rs.getString("status"));
        inquiry.setCreatedAt(rs.getString("created_at"));
        try { inquiry.setApplicantName(rs.getString("applicant_name")); } catch (Exception e) {}
        try { inquiry.setApplicantEmail(rs.getString("applicant_email")); } catch (Exception e) {}
        try { inquiry.setApplicantPhone(rs.getString("applicant_phone")); } catch (Exception e) {}
        try { inquiry.setAnimalName(rs.getString("animal_name")); } catch (Exception e) {}
        return inquiry;
    }
}