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
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f4f8; /* 연한 회색 */
}

.container {
    padding: 20px;
}

/* 카드 스타일 */
.card {
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background: #ffffff;
    overflow: hidden;
    margin-bottom: 20px;
}

.card-header {
    background: #007bff; /* 블루 색상 */
    color: #ffffff;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #0056b3; /* 어두운 블루 보더 */
}

.card-header span {
    font-size: 24px;
    font-weight: 600;
}

.card-body {
    padding: 20px;
}

/* 이미지 컨테이너 스타일 */
.image-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}

.image-container img {
    border-radius: 8px;
    width: 100%;
    height: auto;
    max-width: 600px;
    object-fit: cover;
}

/* 테이블 스타일 */
.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table thead {
    background-color: #007bff; /* 블루 색상 */
    color: #ffffff;
}

.table th, .table td {
    padding: 14px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

.table th {
    font-weight: 600;
}

.table tbody tr:nth-child(even) {
    background-color: #f9f9f9; /* 짝수 행 배경색 */
}

.table tbody tr:hover {
    background-color: #e3f2fd; /* 호버 시 배경색 */
}

/* 버튼 스타일 */
.btn-container {
    display: flex;
    justify-content: center;
    gap: 15px; /* 버튼 간격 */
    margin-top: 20px;
}

.Bprimary {
    	background-color: white;
    	border: 2px solid #007bff;
        color: #007bff; /* 현재 btn-primary 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
    .Bdanger {
   		background-color: white;
   		border: 2px solid #dc3545;
        color: #dc3545; /* 현재 btn-danger 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
    .Bsecondary {
   		background-color: white;
   		border: 2px solid #9e9e9e;
        color: #9e9e9e; /* 현재 btn-danger 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }

.Bprimary:hover {
    background-color: #0056b3; /* 어두운 블루 */
}


.Bdanger:hover {
    background-color: #c82333; /* 어두운 빨강 */
}


.Bsecondary:hover {
    background-color: #5a6268; /* 어두운 회색 */
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .btn-container {
        flex-direction: column;
    }

    .btn {
        width: 100%;
        margin-bottom: 10px;
    }

    .image-container img {
        max-width: 100%;
        height: auto;
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
			<div class="container">
				<div class="card">
					<div class="card-header">
						<span>회의실 정보</span>
					</div>
					<div class="card-body">
						<section class="section d-flex">
							<div class="emp-info" style="flex: 1; margin-right: 20px;">
								<div class="image-container">
									<c:if test="${not empty detailVo.fcl_pic}">
										<img id="imagePreview" src="${detailVo.fcl_pic}" alt="회의실 이미지" />
									</c:if>
									<c:if test="${empty detailVo.fcl_pic}">
										<p>이미지가 없습니다.</p>
									</c:if>
								</div>
							</div>

							<div class="emp-info" style="flex: 1;">
								<table class="table table-borderless">
									<tr>
										<td><strong>회의실 번호</strong></td>
										<td>${detailVo.fcl_id}</td>
									</tr>
									<tr>
										<td><strong>회의실 이름</strong></td>
										<td>${detailVo.fcl_name }</td>
									</tr>
									<tr>
										<td><strong>사용여부</strong></td>
										<td>${detailVo.fcl_able}</td>
									</tr>
									<tr>
										<td><strong>회의실 설명</strong></td>
										<td>${detailVo.fcl_content}</td>
									</tr>
								</table>
							</div>
						</section>
						<form action="${root}/fcl/updateFcl.do" method="post" >
							<input type="hidden" name="fcl_id" value="${detailVo.fcl_id}">
							<div class="btn-container">
								<input type="button" class="Bprimary" value="이용가능" onclick="able(event)"> 
								<input type="submit" class="Bdanger" value="이용불가" > 
								<input type="button" class="Bdanger" value="삭제" onclick="deleteFcl()"> 
								<input type="button" class="Bsecondary" value=" 뒤로가기" onclick="javascript:history.back(-1)">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
<script type="text/javascript">
function deleteFcl(){
	
	var id = ${detailVo.fcl_id}
	location.href="${root}/fcl/deleteFcl.do?fcl_id="+id;
}

function able(event){
	event.preventDefault();
	
	var frm = document.forms[0];
	var id = document.querySelector("input[name=fcl_id]").value;
	
	frm.action="${root}/fcl/disposableFcl.do?fcl_id="+id;
	frm.method="get";
	frm.submit();
}

</script>
</html>