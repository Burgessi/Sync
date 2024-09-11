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
/* 기본 리셋 및 폰트 설정 */
body {
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #e9ecef; /* 부드러운 회색 배경 */
}

.container {
    padding: 20px;
}

/* 카드 스타일 */
.card {
    border-radius: 10px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    background: #ffffff;
    overflow: hidden;
}

#cheader {
    background-color:#E2E3E5;
    color: #223055;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #9c27b0; /* 보라색 보더 */
}

.card-header span {
    font-size: 22px;
    font-weight: 600;
}

.Cbutton {
    background-color: #6c757d; 
    border: none;
    color: #ffffff;
    padding: 12px 24px;
    border-radius: 6px;
    text-align:center;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.btn-primary:hover {
    background-color: #e64a19; /* 버튼 호버 시 어두운 오렌지색 */
}

/* 테이블 스타일 */
.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.table thead {
    background-color: #E2E3E5; /* 다크 블루 배경색 */
    color: #223055;
}

.table th, .table td {
    padding: 14px;
    text-align: center; /* 가운데 정렬 */
    border-bottom: 1px solid #e0e0e0;
}

.table th {
    font-weight: 600;
}

.table tbody tr:hover {
    background-color: #f1f1f1; /* 부드러운 회색 */
}

.table a {
    color: #3f51b5; /* 다크 블루 */
    text-decoration: none;
    font-weight: 500;
}

.table a:hover {
    text-decoration: underline;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .table, .card-header {
        font-size: 14px;
    }

    .btn-primary {
        font-size: 14px;
        padding: 10px 20px;
    }
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
                <div class="card-header" id="cheader">
                    <span>회의실 목록</span>
                    <input class="Cbutton" value="회의실 생성" onclick="location.href='${root}/fcl/insertFcl.do'">
                </div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>회의실 번호</th>
                                <th>회의실 이름</th>
                                <th>사용여부</th>
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