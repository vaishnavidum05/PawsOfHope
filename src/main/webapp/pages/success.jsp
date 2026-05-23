<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Success Stories</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<div class="container my-5">

    <!-- Page Header -->
    <div class="text-center mb-5">
        <h2 class="fw-bold">Success Stories 🎉</h2>
        <p class="text-muted lead">
            Meet the happy pets who found their forever homes through PawsOfHope
        </p>
    </div>

    <!-- Success Cards -->
    <c:choose>
        <c:when test="${empty animals}">
            <div class="text-center py-5">
                <div style="font-size: 5rem;">🐾</div>
                <h4 class="text-muted mt-3">No success stories yet</h4>
                <p class="text-muted">
                    Be the first to give a stray animal a forever home!
                </p>
                <a href="${pageContext.request.contextPath}/browse"
                   class="btn btn-warning mt-2">Browse Pets</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="animal" items="${animals}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm border-0">
                            <c:choose>
                                <c:when test="${animal.image != null && !animal.image.isEmpty()}">
                                    <img src="${pageContext.request.contextPath}/images/uploads/${animal.image}"
                                         class="card-img-top"
                                         style="height: 220px; object-fit: cover;"
                                         alt="${animal.name}">
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5 bg-light"
                                         style="font-size: 4rem;">
                                        <c:choose>
                                            <c:when test="${animal.type == 'dog'}">🐶</c:when>
                                            <c:when test="${animal.type == 'cat'}">🐱</c:when>
                                            <c:when test="${animal.type == 'bird'}">🐦</c:when>
                                            <c:when test="${animal.type == 'rabbit'}">🐰</c:when>
                                            <c:otherwise>🐾</c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="card-body text-center">
                                <h5 class="fw-bold">${animal.name} 🏠</h5>
                                <p class="text-muted small text-capitalize">
                                    ${animal.type} &nbsp;|&nbsp; ${animal.breed}
                                </p>
                                <div class="alert alert-success py-2 mb-0">
                                    🎉 Successfully Adopted!
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- CTA -->
    <div class="text-center mt-5">
        <h4 class="fw-bold">Want to add to these success stories?</h4>
        <p class="text-muted">Browse available pets and give them a loving home</p>
        <a href="${pageContext.request.contextPath}/browse"
           class="btn btn-warning btn-lg me-3">Browse Pets</a>
        <a href="${pageContext.request.contextPath}/post-animal"
           class="btn btn-outline-warning btn-lg">Post an Animal</a>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>