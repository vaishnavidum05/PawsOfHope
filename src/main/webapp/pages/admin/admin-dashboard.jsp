<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../../components/header.jsp" %>

<div class="container my-5">
    <h2 class="fw-bold mb-4">Admin Dashboard 🛡️</h2>

    <!-- Stats Cards -->
    <div class="row mb-5">
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm text-center p-4"
                 style="border-left: 5px solid #ff6b35 !important;">
                <div style="font-size: 3rem;">👥</div>
                <h2 class="fw-bold text-warning">${totalUsers}</h2>
                <p class="text-muted mb-0">Total Users</p>
                <a href="${pageContext.request.contextPath}/admin/manage-users"
                   class="btn btn-outline-warning btn-sm mt-2">Manage Users</a>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm text-center p-4"
                 style="border-left: 5px solid #ff6b35 !important;">
                <div style="font-size: 3rem;">🐾</div>
                <h2 class="fw-bold text-warning">${totalAnimals}</h2>
                <p class="text-muted mb-0">Total Animals</p>
                <a href="${pageContext.request.contextPath}/admin/manage-animals"
                   class="btn btn-outline-warning btn-sm mt-2">Manage Animals</a>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm text-center p-4"
                 style="border-left: 5px solid #ff6b35 !important;">
                <div style="font-size: 3rem;">📋</div>
                <h2 class="fw-bold text-warning">${totalInquiries}</h2>
                <p class="text-muted mb-0">Total Inquiries</p>
                <a href="${pageContext.request.contextPath}/admin/manage-inquiries"
                   class="btn btn-outline-warning btn-sm mt-2">Manage Inquiries</a>
            </div>
        </div>
    </div>

    <!-- Quick Links -->
    <h4 class="fw-bold mb-3">Quick Actions</h4>
    <div class="row">
        <div class="col-md-3 mb-3">
            <a href="${pageContext.request.contextPath}/admin/manage-animals"
               class="card border-0 shadow-sm text-decoration-none text-dark p-3 d-block text-center">
                <div style="font-size: 2rem;">🐾</div>
                <p class="mb-0 fw-bold">Manage Animals</p>
            </a>
        </div>
        <div class="col-md-3 mb-3">
            <a href="${pageContext.request.contextPath}/admin/manage-users"
               class="card border-0 shadow-sm text-decoration-none text-dark p-3 d-block text-center">
                <div style="font-size: 2rem;">👥</div>
                <p class="mb-0 fw-bold">Manage Users</p>
            </a>
        </div>
        <div class="col-md-3 mb-3">
            <a href="${pageContext.request.contextPath}/admin/manage-inquiries"
               class="card border-0 shadow-sm text-decoration-none text-dark p-3 d-block text-center">
                <div style="font-size: 2rem;">📋</div>
                <p class="mb-0 fw-bold">Manage Inquiries</p>
            </a>
        </div>
        <div class="col-md-3 mb-3">
            <a href="${pageContext.request.contextPath}/browse"
               class="card border-0 shadow-sm text-decoration-none text-dark p-3 d-block text-center">
                <div style="font-size: 2rem;">🔍</div>
                <p class="mb-0 fw-bold">Browse Pets</p>
            </a>
        </div>
    </div>
</div>

<%@ include file="../../components/footer.jsp" %>