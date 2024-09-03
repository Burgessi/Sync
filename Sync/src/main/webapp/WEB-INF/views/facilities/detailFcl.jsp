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
.emp-info {
	padding: 20px; /* 위아래 간격을 벌리는 방법 */
	font-size: 20px;
}

.table {
	margin-bottom: 20px; /* 테이블과 다른 요소 사이의 간격을 벌리는 방법 */
}

.table td {
	padding: 10px; /* 각 셀의 위아래 간격을 벌리는 방법 */
}

.btn-container {
	text-align: center;
}
</style>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>
			<div class="container">
				<div class="card">
					<div class="card-header"></div>
					<div class="card-body">
						<section class="section d-flex">
							<div class="emp-info pic" style="width: 50%;">
								<div class="image-container">
									<c:if test="${not empty detailVo.fcl_pic}">
										<img id="imagePreview"
											style="border-radius: 5%; width: 600px; height: 400px; object-fit: cover"
											src="${detailVo.fcl_pic}" alt="회의실 이미지" />
									</c:if>
									<c:if test="${empty detailVo.fcl_pic}">
										<p>이미지가 없습니다.</p>
									</c:if>
								</div>
							</div>

							<div class="emp-info ">
								<table class="table table-borderless">
									<tr>
										<td>회의실 번호</td>
										<td>${detailVo.fcl_id}</td>
									</tr>
									<tr>
										<td>회의실 이름</td>
										<td>${detailVo.fcl_name }</td>
									</tr>
									<tr>
										<td>사용여부</td>
										<td>${detailVo.fcl_able}</td>
									</tr>
									<tr>
										<td>회의실 설명</td>
										<td>${detailVo.fcl_content}</td>
									</tr>
								</table>
							</div>
						</section>
						<form action="${root}/fcl/updateFcl.do" method="post" >
							<input type="hidden" name="fcl_id" value="${detailVo.fcl_id}">
							<div class="btn-container">
								<input type="submit" style="width: 10%" class="btn btn-info"
									value="이용불가" > 
								<input type="button" style="width: 10%" class="btn btn-info"
									value="이용가능" onclick="able(event)"> 
								<input type="button" style="width: 10%" class="btn btn-danger"
									value="삭제" onclick="deleteFcl()"> 
								<input type="button"style="width: 10%" class="btn btn-secondary" 
									value="뒤로가기" onclick="javascript:history.back(-1)">
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