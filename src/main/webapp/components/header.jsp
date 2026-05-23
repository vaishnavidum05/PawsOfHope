<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            🐾 PawsOfHope
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" style="border-color: rgba(255,255,255,0.5);">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">🏠 Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/browse">🐾 Browse Pets</a>
                </li>
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/post-animal">➕ Post Animal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/my-listings">📋 My Listings</a>
                    </li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">🛡️ Admin</a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <span class="nav-link text-white fw-bold">
                            👋 Welcome, ${sessionScope.user.name}!
                        </span>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-outline-light btn-sm"
                           href="${pageContext.request.contextPath}/logout">
                            Logout
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <li class="nav-item ms-2">
                        <a class="btn btn-outline-light btn-sm"
                           href="${pageContext.request.contextPath}/login">Login</a>
                    </li>
                    <li class="nav-item ms-1">
                        <a class="btn btn-sm fw-bold"
                           href="${pageContext.request.contextPath}/register"
                           style="background: linear-gradient(135deg, #42a5f5, #1a73e8);
                                  color: white; border-radius: 30px; padding: 8px 20px;">
                            Register
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>