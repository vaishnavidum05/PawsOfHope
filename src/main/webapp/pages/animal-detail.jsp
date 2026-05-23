<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - ${animal.name}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<div class="container my-5">

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            🎉 Your adoption inquiry has been submitted successfully! We will contact you soon.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${animal == null}">
            <div class="text-center py-5">
                <h3 class="text-muted">Animal not found 🐾</h3>
                <a href="${pageContext.request.contextPath}/browse"
                   class="btn btn-warning mt-3">Back to Browse</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <!-- Animal Image -->
                <div class="col-md-5">
                    <c:choose>
                        <c:when test="${animal.image != null && !animal.image.isEmpty()}">
                            <img src="${pageContext.request.contextPath}/images/uploads/${animal.image}"
                                 class="img-fluid rounded shadow"
                                 style="width: 100%; height: 400px; object-fit: cover;"
                                 alt="${animal.name}">
                        </c:when>
                        <c:otherwise>
                            <div class="text-center bg-light rounded p-5"
                                 style="font-size: 8rem; height: 400px;
                                 display: flex; align-items: center;
                                 justify-content: center;">
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
                </div>

                <!-- Animal Details -->
                <div class="col-md-7">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <h2 class="fw-bold mb-0">${animal.name}</h2>
                        <span class="badge bg-warning text-dark fs-6 text-capitalize">
                            ${animal.type}
                        </span>
                        <span class="badge ${animal.status == 'available' ?
                            'bg-success' : 'bg-secondary'} fs-6 text-capitalize">
                            ${animal.status}
                        </span>
                    </div>

                    <table class="table table-borderless">
                        <tr>
                            <td class="fw-bold text-muted">Breed</td>
                            <td>${animal.breed}</td>
                        </tr>
                        <tr>
                            <td class="fw-bold text-muted">Age</td>
                            <td>${animal.age} year(s)</td>
                        </tr>
                        <tr>
                            <td class="fw-bold text-muted">Gender</td>
                            <td class="text-capitalize">${animal.gender}</td>
                        </tr>
                        <tr>
                            <td class="fw-bold text-muted">Status</td>
                            <td class="text-capitalize">${animal.status}</td>
                        </tr>
                        <tr>
                            <td class="fw-bold text-muted">Posted On</td>
                            <td>${animal.createdAt}</td>
                        </tr>
                    </table>

                    <h5 class="fw-bold mt-3">About ${animal.name}</h5>
                    <p class="text-muted">${animal.description}</p>

                    <c:if test="${animal.status == 'available'}">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <button class="btn btn-warning btn-lg fw-bold"
                                        data-bs-toggle="modal"
                                        data-bs-target="#adoptModal">
                                    🐾 Adopt ${animal.name}
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login"
                                   class="btn btn-warning btn-lg fw-bold">
                                    Login to Adopt
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <c:if test="${animal.status == 'adopted'}">
                        <button class="btn btn-secondary btn-lg fw-bold" disabled>
                            Already Adopted
                        </button>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/browse"
                       class="btn btn-outline-secondary btn-lg ms-2">
                        Back to Browse
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Adopt Modal -->
<div class="modal fade" id="adoptModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #ff6b35;">
                <h5 class="modal-title text-white fw-bold">
                    🐾 Adopt ${animal.name}
                </h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="text-muted">
                    Please tell us a little about yourself and why you want
                    to adopt ${animal.name}.
                </p>
                <form action="${pageContext.request.contextPath}/adopt" method="post">
                    <input type="hidden" name="animalId" value="${animal.id}">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Your Name</label>
                        <input type="text" class="form-control"
                               value="${sessionScope.user.name}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Your Email</label>
                        <input type="text" class="form-control"
                               value="${sessionScope.user.email}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            Why do you want to adopt ${animal.name}?
                        </label>
                        <textarea name="message" class="form-control" rows="4"
                                  placeholder="Tell us about your home, experience with pets..."
                                  required></textarea>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 fw-bold">
                        Submit Adoption Request
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>