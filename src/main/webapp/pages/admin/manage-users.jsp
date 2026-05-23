<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Manage Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../../components/header.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Users 👥</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <c:choose>
        <c:when test="${empty users}">
            <div class="text-center py-5">
                <h4 class="text-muted">No users found</h4>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Joined</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td class="fw-bold">${user.name}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>
                                    <span class="badge ${user.role == 'admin' ?
                                        'bg-danger' : 'bg-primary'} text-capitalize">
                                        ${user.role}
                                    </span>
                                </td>
                                <td>${user.createdAt}</td>
                                <td>
                                    <c:if test="${user.role != 'admin'}">
                                        <form action="${pageContext.request.contextPath}/admin/manage-users"
                                              method="post" class="d-inline"
                                              onsubmit="return confirm('Delete this user?')">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger">Delete</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${user.role == 'admin'}">
                                        <span class="text-muted small">Protected</span>
                                    </c:if>
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