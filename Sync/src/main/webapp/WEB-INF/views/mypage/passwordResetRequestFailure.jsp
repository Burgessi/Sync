<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.pro.sync.employee.vo.EmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>SYNC</title>
<script src="https://kit.fontawesome.com/3a92c85ff9.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>

<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css" />

<link rel="stylesheet"
	href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet"
	href="resources/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css" />

<link rel="stylesheet"
	href="${root}/resources/css/member/login-style.css" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
	background-color: #fff;
}
</style>
<body>
	<div class="container"
     style="display: flex; justify-content: center; align-items: center; height: 100vh;">
    <div style="text-align: center; display: flex; flex-direction: column; justify-content: center; align-items: center;">
        <h1 class="title">SYNC</h1>
        <label>아이디와 이메일을 확인해주세요.</label>
        <button class="login-btn solid" style="width: 320px; margin-top: 20px;" onclick="location.href=${root}/">메인으로 돌아가기</button>
    </div>
</div>

</body>
</html>
