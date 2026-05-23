<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - My Listings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<div class="container my-5">

    <!-- My Animals Section -->
    <h2 class="fw-bold mb-4 text-white"
        style="text-shadow: 1px 1px 8px rgba(0,0,0,0.7);">
        My Listings 🐾
    </h2>

    <c:choose>
        <c:when test="${empty animals}">
            <div class="card text-center py-5 mb-5">
                <h4 class="text-muted">You have not posted any animals yet</h4>
                <p class="text-muted">Help a stray find a home by posting their details</p>
                <div>
                    <a href="${pageContext.request.contextPath}/post-animal"
                       class="btn btn-warning mt-2">Post an Animal</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row mb-5">
                <c:forEach var="animal" items="${animals}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <c:choose>
                                <c:when test="${animal.image != null && !animal.image.isEmpty()}">
                                    <img src="${pageContext.request.contextPath}/images/uploads/${animal.image}"
                                         class="card-img-top"
                                         style="height: 200px; object-fit: cover;"
                                         alt="${animal.name}">
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4 bg-light"
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
                                    <h5 class="fw-bold mb-0">${animal.name}</h5>
                                    <span class="badge bg-warning text-capitalize">
                                        ${animal.type}
                                    </span>
                                </div>
                                <p class="text-muted small mb-2">
                                    🐾 ${animal.breed} &nbsp;|&nbsp;
                                    ${animal.age} yr &nbsp;|&nbsp;
                                    ${animal.gender}
                                </p>
                                <span class="badge ${animal.status == 'available' ?
                                    'bg-success' : 'bg-secondary'} text-capitalize mb-2">
                                    ${animal.status}
                                </span>
                            </div>
                            <div class="card-footer bg-transparent border-0 pb-3">
                                <a href="${pageContext.request.contextPath}/animal?id=${animal.id}"
                                   class="btn btn-warning btn-sm w-100 mb-2">
                                    View Details
                                </a>
                                <c:if test="${animal.status == 'available'}">
                                    <form action="${pageContext.request.contextPath}/my-listings"
                                          method="post">
                                        <input type="hidden" name="animalId" value="${animal.id}">
                                        <input type="hidden" name="action" value="markAdopted">
                                        <button type="submit"
                                                class="btn btn-success btn-sm w-100">
                                            ✅ Mark as Adopted
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${animal.status == 'adopted'}">
                                    <form action="${pageContext.request.contextPath}/my-listings"
                                          method="post">
                                        <input type="hidden" name="animalId" value="${animal.id}">
                                        <input type="hidden" name="action" value="markAvailable">
                                        <button type="submit"
                                                class="btn btn-outline-secondary btn-sm w-100">
                                            🔄 Mark as Available
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- My Sent Requests Section -->
    <h2 class="fw-bold mb-4 text-white"
        style="text-shadow: 1px 1px 8px rgba(0,0,0,0.7);">
        My Adoption Requests 💙
    </h2>

    <c:choose>
        <c:when test="${empty sentInquiries}">
            <div class="card text-center py-4 mb-5">
                <h5 class="text-muted">You have not sent any adoption requests yet</h5>
                <p class="text-muted small">Browse pets and send an adoption request!</p>
                <div>
                    <a href="${pageContext.request.contextPath}/browse"
                       class="btn btn-warning btn-sm mt-2">Browse Pets</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row mb-5">
                <c:forEach var="inquiry" items="${sentInquiries}">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between
                                            align-items-center mb-3">
                                    <h5 class="fw-bold mb-0">
                                        ${inquiry.animalName}
                                    </h5>
                                    <span class="badge
                                        ${inquiry.status == 'pending' ? 'bg-warning' :
                                        inquiry.status == 'approved' ? 'bg-success' :
                                        'bg-danger'} text-capitalize">
                                        ${inquiry.status}
                                    </span>
                                </div>

                                <p class="text-muted small mb-3">
                                    📅 Requested on: ${inquiry.createdAt}
                                </p>

                                <p class="mb-3">
                                    <strong>Your Message:</strong> ${inquiry.message}
                                </p>

                                <c:if test="${inquiry.status == 'approved'}">
                                    <!-- Owner Contact Details shown only on approval -->
                                    <div class="p-3 rounded mb-3"
                                         style="background: rgba(66,165,245,0.15);
                                                border: 1px solid rgba(66,165,245,0.3);">
                                        <h6 class="fw-bold mb-2" style="color: #0d47a1;">
                                            🎉 Approved! Contact the Owner
                                        </h6>
                                        <p class="mb-1 small">
                                            <strong>Name:</strong> ${inquiry.ownerName}
                                        </p>
                                        <p class="mb-1 small">
                                            <strong>Email:</strong>
                                            <a href="mailto:${inquiry.ownerEmail}">
                                                ${inquiry.ownerEmail}
                                            </a>
                                        </p>
                                        <p class="mb-0 small">
                                            <strong>Phone:</strong>
                                            <a href="tel:${inquiry.ownerPhone}">
                                                ${inquiry.ownerPhone}
                                            </a>
                                        </p>
                                    </div>
                                    <div class="alert alert-success py-2 mb-0 text-center fw-bold">
                                        🐾 Your adoption was approved! Contact the owner above.
                                    </div>
                                </c:if>

                                <c:if test="${inquiry.status == 'pending'}">
                                    <div class="alert alert-warning py-2 mb-0 text-center">
                                        ⏳ Your request is pending approval from the owner.
                                    </div>
                                </c:if>

                                <c:if test="${inquiry.status == 'rejected'}">
                                    <div class="alert alert-danger py-2 mb-0 text-center">
                                        ❌ Unfortunately your request was rejected.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Received Adoption Requests Section -->
    <h2 class="fw-bold mb-4 text-white"
        style="text-shadow: 1px 1px 8px rgba(0,0,0,0.7);">
        Received Adoption Requests 📋
    </h2>

    <c:choose>
        <c:when test="${empty receivedInquiries}">
            <div class="card text-center py-4">
                <h5 class="text-muted">No adoption requests received yet</h5>
                <p class="text-muted small">
                    When someone requests to adopt your pet it will appear here
                </p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="inquiry" items="${receivedInquiries}">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between
                                            align-items-center mb-3">
                                    <h5 class="fw-bold mb-0">
                                        Request for ${inquiry.animalName}
                                    </h5>
                                    <span class="badge
                                        ${inquiry.status == 'pending' ? 'bg-warning' :
                                        inquiry.status == 'approved' ? 'bg-success' :
                                        'bg-danger'} text-capitalize">
                                        ${inquiry.status}
                                    </span>
                                </div>

                                <p class="text-muted small mb-3">
                                    📅 ${inquiry.createdAt}
                                </p>

                                <p class="mb-3">
                                    <strong>Message:</strong> ${inquiry.message}
                                </p>

                                <!-- Applicant Contact Details -->
                                <div class="p-3 rounded mb-3"
                                     style="background: rgba(66,165,245,0.15);
                                            border: 1px solid rgba(66,165,245,0.3);">
                                    <h6 class="fw-bold mb-2" style="color: #0d47a1;">
                                        👤 Applicant Details
                                    </h6>
                                    <p class="mb-1 small">
                                        <strong>Name:</strong> ${inquiry.applicantName}
                                    </p>
                                    <p class="mb-1 small">
                                        <strong>Email:</strong>
                                        <a href="mailto:${inquiry.applicantEmail}">
                                            ${inquiry.applicantEmail}
                                        </a>
                                    </p>
                                    <p class="mb-0 small">
                                        <strong>Phone:</strong>
                                        <a href="tel:${inquiry.applicantPhone}">
                                            ${inquiry.applicantPhone}
                                        </a>
                                    </p>
                                </div>

                                <!-- Action Buttons -->
                                <c:if test="${inquiry.status == 'pending'}">
                                    <div class="d-flex gap-2">
                                        <form action="${pageContext.request.contextPath}/admin/manage-inquiries"
                                              method="post" class="flex-fill">
                                            <input type="hidden" name="id" value="${inquiry.id}">
                                            <input type="hidden" name="status" value="approved">
                                            <button type="submit"
                                                    class="btn btn-success btn-sm w-100">
                                                ✅ Approve
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/manage-inquiries"
                                              method="post" class="flex-fill">
                                            <input type="hidden" name="id" value="${inquiry.id}">
                                            <input type="hidden" name="status" value="rejected">
                                            <button type="submit"
                                                    class="btn btn-danger btn-sm w-100">
                                                ❌ Reject
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                                <c:if test="${inquiry.status == 'approved'}">
                                    <div class="alert alert-success py-2 mb-0 text-center">
                                        🎉 Approved! Contact the applicant above.
                                    </div>
                                </c:if>
                                <c:if test="${inquiry.status == 'rejected'}">
                                    <div class="alert alert-danger py-2 mb-0 text-center">
                                        ❌ This request was rejected.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../components/footer.jsp" %>