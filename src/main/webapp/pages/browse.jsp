<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Browse Pets</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<div class="container my-5">
    <h2 class="fw-bold mb-4">Browse Available Pets 🐾</h2>

    <!-- Filter Bar -->
    <form action="${pageContext.request.contextPath}/browse" method="get" class="mb-4">
        <div class="row g-2 align-items-center">
            <div class="col-md-3">
                <select name="type" class="form-select">
                    <option value="">All Pets</option>
                    <option value="dog" ${selectedType == 'dog' ? 'selected' : ''}>Dogs</option>
                    <option value="cat" ${selectedType == 'cat' ? 'selected' : ''}>Cats</option>
                    <option value="bird" ${selectedType == 'bird' ? 'selected' : ''}>Birds</option>
                    <option value="rabbit" ${selectedType == 'rabbit' ? 'selected' : ''}>Rabbits</option>
                    <option value="other" ${selectedType == 'other' ? 'selected' : ''}>Others</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-warning w-100">Filter</button>
            </div>
        </div>
    </form>

    <!-- Animal Cards -->
    <div class="row">
        <c:choose>
            <c:when test="${empty animals}">
                <div class="col-12 text-center py-5">
                    <h4 class="text-muted">No pets available right now 🐾</h4>
                    <p>Check back later or post a stray animal you found!</p>
                    <a href="${pageContext.request.contextPath}/post-animal"
                       class="btn btn-warning">Post an Animal</a>
                </div>
            </c:when>
            <c:otherwise>
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
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <h5 class="card-title fw-bold mb-0">${animal.name}</h5>
                                    <span class="badge bg-warning text-dark text-capitalize">
                                        ${animal.type}
                                    </span>
                                </div>
                                <p class="text-muted small mb-1">
                                    🐾 ${animal.breed} &nbsp;|&nbsp;
                                    ${animal.age} year(s) &nbsp;|&nbsp;
                                    ${animal.gender}
                                </p>
                                <p class="card-text small text-muted">
                                    ${animal.description.length() > 80 ?
                                    animal.description.substring(0, 80).concat('...') :
                                    animal.description}
                                </p>
                            </div>
                            <div class="card-footer bg-white border-0 pb-3">
                                <a href="${pageContext.request.contextPath}/animal?id=${animal.id}"
                                   class="btn btn-warning w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>