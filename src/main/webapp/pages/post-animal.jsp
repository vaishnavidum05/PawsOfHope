<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PawsOfHope - Post an Animal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="../components/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h3 class="fw-bold mb-1">Post a Stray Animal 🐾</h3>
                    <p class="text-muted mb-4">
                        Help a stray find a forever home by posting their details
                    </p>

                    <c:if test="${sessionScope.user == null}">
                        <div class="alert alert-warning">
                            Please <a href="${pageContext.request.contextPath}/login">login</a>
                            to post an animal.
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.user != null}">
                        <form action="${pageContext.request.contextPath}/post-animal"
                              method="post" enctype="multipart/form-data">

                            <div class="mb-3">
                                <label class="form-label fw-bold">Animal Name</label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="e.g. Bruno, Whiskers" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Animal Type</label>
                                    <select name="type" class="form-select" required>
                                        <option value="">Select type</option>
                                        <option value="dog">Dog</option>
                                        <option value="cat">Cat</option>
                                        <option value="bird">Bird</option>
                                        <option value="rabbit">Rabbit</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Breed</label>
                                    <input type="text" name="breed" class="form-control"
                                           placeholder="e.g. Labrador, Persian">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Age (in years)</label>
                                    <input type="number" name="age" class="form-control"
                                           placeholder="e.g. 2" min="0" max="30" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Gender</label>
                                    <select name="gender" class="form-select" required>
                                        <option value="">Select gender</option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Description</label>
                                <textarea name="description" class="form-control" rows="4"
                                          placeholder="Describe the animal — behavior, health condition, where found..."
                                          required></textarea>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">Upload Photo</label>
                                <input type="file" name="image" class="form-control"
                                       accept="image/*">
                                <div class="form-text">
                                    Upload a clear photo of the animal (optional)
                                </div>
                            </div>

                            <button type="submit" class="btn btn-warning w-100 fw-bold btn-lg">
                                🐾 Post Animal
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>