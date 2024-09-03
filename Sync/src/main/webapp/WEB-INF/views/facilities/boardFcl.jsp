<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회의실 관리</title>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f7f9;
        margin: 0;
        padding: 0;
    }

    #main {
        padding: 20px;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card {
        border: none;
        border-radius: 8px;
        overflow: hidden;
    }

    .card-header {
        background-color: #007bff;
        color: #ffffff;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .btn-primary {
        background-color: #007bff;
        border: none;
        color: #ffffff;
        padding: 10px 20px;
        font-size: 13px;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease;
        width: 11%;
        text-align: center;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        transform: scale(1.05);
    }

    .btn-primary:focus {
        outline: none;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }

    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #007bff;
        color: #ffffff;
        font-weight: bold;
        position: -webkit-sticky; /* For Safari */
        position: sticky;
        top: 0;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    a {
        color: #007bff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    .card-body {
        padding: 20px;
    }
</style>
</head>
<body>
    <div id="app">
        <!-- 사이드바 include -> 메뉴 이동 -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
        <!-- 헤더 include -> 상단 로그인정보 등 -->
        <div id="main">
            <%@ include file="/WEB-INF/views/common/header.jsp"%>
            <h3>회의실 관리</h3>
            <div class="container">
                <div class="card">
                    <div class="card-header">
                        <span>회의실 목록</span>
                        <input class="btn-primary" value="회의실 생성"
                            onclick="location.href='${root}/fcl/insertFcl.do'">
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                                <tr style="background-color: lightblue;">
                                    <th style="width: 20%; color: black;">회의실 번호</th>
                                    <th style="width: 40%; color: black;">회의실 이름</th>
                                    <th style="width: 40%; color: black;">사용여부</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${fclList}" var="fcl" varStatus="vs">
                                    <tr>
                                        <td>${fcl.fcl_id}</td>
                                        <td><a href="${root}/fcl/detailFcl.do?fcl_id=${fcl.fcl_id}">${fcl.fcl_name}</a></td>
                                        <td>${fcl.fcl_able}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>