<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PawsOfHope - Find Your Furry Friend</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<!-- Hero Section -->
<div class="hero-section text-white text-center">
    <div class="container py-5" style="position: relative; z-index: 1;">
        <div style="font-size: 4rem; margin-bottom: 10px;">🐾</div>
        <h1 class="display-4 fw-bold mb-3">Find Your Furry Friend!</h1>
        <p class="lead mb-4">
            Give a stray animal a second chance at life.<br>
            Adopt, don't shop! Every pet deserves a loving home. 💙
        </p>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/browse"
               class="btn btn-warning btn-lg px-5">
                🐾 Browse Pets
            </a>
            <a href="${pageContext.request.contextPath}/post-animal"
               class="btn btn-outline-light btn-lg px-5">
                ➕ Post an Animal
            </a>
        </div>
    </div>
</div>

<!-- Pet Types Section -->
<div class="container my-5">
    <div class="text-center mb-5">
        <h2 class="section-title">Find Your Perfect Pet 💙</h2>
        <p class="text-white mt-4" style="text-shadow: 1px 1px 8px rgba(0,0,0,0.7);">
            Browse through our adorable animals waiting for a home
        </p>
    </div>
    <div class="row g-4">
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/browse?type=dog"
               class="text-decoration-none">
                <div class="stat-card h-100">
                    <div style="font-size: 3.5rem;">🐶</div>
                    <h4 class="fw-bold mt-2" style="color: #0d47a1;">Dogs</h4>
                    <p class="text-muted small">Loyal companions waiting for you</p>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/browse?type=cat"
               class="text-decoration-none">
                <div class="stat-card h-100">
                    <div style="font-size: 3.5rem;">🐱</div>
                    <h4 class="fw-bold mt-2" style="color: #0d47a1;">Cats</h4>
                    <p class="text-muted small">Purring friends looking for love</p>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/browse?type=bird"
               class="text-decoration-none">
                <div class="stat-card h-100">
                    <div style="font-size: 3.5rem;">🐦</div>
                    <h4 class="fw-bold mt-2" style="color: #0d47a1;">Birds</h4>
                    <p class="text-muted small">Cheerful birds to brighten your day</p>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/browse?type=rabbit"
               class="text-decoration-none">
                <div class="stat-card h-100">
                    <div style="font-size: 3.5rem;">🐰</div>
                    <h4 class="fw-bold mt-2" style="color: #0d47a1;">Rabbits</h4>
                    <p class="text-muted small">Fluffy bunnies full of joy</p>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- How It Works -->
<div class="how-it-works-bg py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">How It Works 🐾</h2>
            <p class="text-white mt-4" style="text-shadow: 1px 1px 8px rgba(0,0,0,0.7);">
                Simple steps to find your perfect companion
            </p>
        </div>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="step-box">
                    <div class="step-icon">🔍</div>
                    <h5 class="fw-bold mt-3" style="color: #0d47a1;">Browse</h5>
                    <p class="text-muted small">Search through available pets</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-box">
                    <div class="step-icon">❤️</div>
                    <h5 class="fw-bold mt-3" style="color: #0d47a1;">Choose</h5>
                    <p class="text-muted small">Find the perfect match</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-box">
                    <div class="step-icon">📋</div>
                    <h5 class="fw-bold mt-3" style="color: #0d47a1;">Apply</h5>
                    <p class="text-muted small">Fill adoption inquiry form</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-box">
                    <div class="step-icon">🏠</div>
                    <h5 class="fw-bold mt-3" style="color: #0d47a1;">Adopt</h5>
                    <p class="text-muted small">Welcome your new friend home</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CTA Section -->
<div class="container text-center my-5 py-4">
    <div class="card p-5"
         style="background: rgba(26,115,232,0.75) !important;
                backdrop-filter: blur(10px);
                border-radius: 30px !important;">
        <h3 class="fw-bold text-white mb-2">🐾 Found a stray animal?</h3>
        <p class="text-white mb-4" style="opacity: 0.9;">
            Help us find them a forever home by posting their details
        </p>
        <div>
            <a href="${pageContext.request.contextPath}/post-animal"
               class="btn btn-light btn-lg