<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Manage Animals</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../../components/header.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Animals 🐾</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <c:choose>
        <c:when test="${empty animals}">
            <div class="text-center py-5">
                <h4 class="text-muted">No animals found</h4>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Breed</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="animal" items="${animals}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td class="fw-bold">${animal.name}</td>
                                <td class="text-capitalize">${animal.type}</td>
                                <td>${animal.breed}</td>
                                <td>${animal.age} yr</td>
                                <td class="text-capitalize">${animal.gender}</td>
                                <td>
                                    <span class="badge ${animal.status == 'available' ?
                                        'bg-success' : 'bg-secondary'} text-capitalize">
                                        ${animal.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/animal?id=${animal.id}"
                                       class="btn btn-sm btn-warning me-1">View</a>

                                    <c:if test="${animal.status == 'available'}">
                                        <form action="${pageContext.request.contextPath}/admin/manage-animals"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="id" value="${animal.id}">
                                            <input type="hidden" name="action" value="adopted">
                                            <button type="submit"
                                                    class="btn btn-sm btn-success me-1">
                                                Mark Adopted
                                            </button>
                                        </form>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/admin/manage-animals"
                                          method="post" class="d-inline"
                                          onsubmit="return confirm('Delete this animal?')">
                                        <input type="hidden" name="id" value="${animal.id}">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit"
                                                class="btn btn-sm btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../../components/footer.jsp" %>