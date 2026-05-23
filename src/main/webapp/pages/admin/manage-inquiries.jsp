<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Manage Inquiries</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../../components/header.jsp" %>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Inquiries 📋</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <c:choose>
        <c:when test="${empty inquiries}">
            <div class="text-center py-5">
                <h4 class="text-muted">No inquiries found</h4>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-warning">
                        <tr>
                            <th>#</th>
                            <th>Animal ID</th>
                            <th>User ID</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inquiry" items="${inquiries}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${inquiry.animalId}</td>
                                <td>${inquiry.userId}</td>
                                <td>
                                    ${inquiry.message.length() > 50 ?
                                    inquiry.message.substring(0, 50).concat('...') :
                                    inquiry.message}
                                </td>
                                <td>
                                    <span class="badge
                                        ${inquiry.status == 'pending' ? 'bg-warning text-dark' :
                                        inquiry.status == 'approved' ? 'bg-success' :
                                        'bg-danger'} text-capitalize">
                                        ${inquiry.status}
                                    </span>
                                </td>
                                <td>${inquiry.createdAt}</td>
                                <td>
                                    <c:if test="${inquiry.status == 'pending'}">
                                        <form action="${pageContext.request.contextPath}/admin/manage-inquiries"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="id" value="${inquiry.id}">
                                            <input type="hidden" name="status" value="approved">
                                            <button type="submit"
                                                    class="btn btn-sm btn-success me-1">
                                                Approve
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/manage-inquiries"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="id" value="${inquiry.id}">
                                            <input type="hidden" name="status" value="rejected">
                                            <button type="submit"
                                                    class="btn btn-sm btn-danger">
                                                Reject
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${inquiry.status != 'pending'}">
                                        <span class="text-muted small text-capitalize">
                                            ${inquiry.status}
                                        </span>
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