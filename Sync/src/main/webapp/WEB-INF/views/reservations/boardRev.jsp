<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script> -->
<title>회의실 예약</title>
<script type="text/javascript" src="${root}/resources/js/common/checkbox.js"></script>
<style>
body {
	margin: 0;
	padding: 20px;
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
}

.container {
	display: flex;
	gap: 10px;
}

.left-column {
	flex: 1 1 70%; /* 전체 너비의 70% 차지 */
	display: flex;
	flex-direction: column;
}

.right-column {
	flex: 1 1 30%; /* 전체 너비의 30% 차지 */
	display: flex;
	flex-direction: column;
	gap: 10px; /* 위, 아래 카드 간의 간격 */
}

.card {
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.card-header {
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 10px;
}

.large-card {
	flex: 1;
	height: 600px; /* 원하는 높이로 조정 */
}

.small-card {
	flex: 1;
	height: calc(50% - 5px); /* 위, 아래 두 카드의 높이를 50%로 설정 */
}

.table th, .table td {
	font-size: 12.3px; padding : 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	padding: 0.75rem;
}

.table tbody+tbody {
	border-top: 2px solid #dee2e6;
}

.table .table {
	background-color: #fff;
}
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px; /* Optional: adjust spacing between header and table */
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
			<h3>회의실 예약</h3>
			<div class="container">
				<div class="left-column" style="height: 800px; width:">
					<div class="card large-card">
						<div class="header-container">
							<h5>회의실 목록</h5>
							<input type="button" value="전체예약현황" class="btn btn-primary" onclick="allSelect(event)">
						</div>
						<div class="card-body">
							<!-- 큰 영역의 컨텐츠 내용 -->
							<div class="row">
								<c:forEach var="fcl" items="${flist}">
									<div class="col-md-4">
										<div class="card-body"
											style="display: flex; flex-direction: column; align-items: center;">
											<!-- 이미지 중앙 정렬 -->
											<div style="display: flex; justify-content: center; align-items: center; height: 150px;">
												<img alt="회의실" src="${fcl.fcl_pic}" style="width: 200px; height: 150px;">
											</div>
											<!-- 카드 제목 -->
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted">${fcl.fcl_name}</h6>
											<input type="hidden" value="${fcl.fcl_id}">
											<!-- 카드 내용 -->
											<h6 style="font-size: 12px; text-align: center;">${fcl.fcl_content}</h6>
											<!-- 버튼 중앙 정렬 -->
											<c:if test="${fcl.fcl_able eq 'Y'}">
												<input type="button" value="예약"
													onclick="reservations(event, '${fcl.fcl_id}')"
													class="btn btn-success" style="margin-top: 10px;">
											</c:if>
											<c:if test="${fcl.fcl_able eq 'N'}">
												<input type="button" value="예약" onclick="unable(event)" class="btn btn-danger" style="margin-top: 10px;">
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<div class="right-column">
					<div class="card small-card">
						<form action="./deleteRev.do" method="post" onsubmit="return checkSubmit(event)">
						<div class="header-container">
						    <h6>내 예약 목록</h6>
						    <input type="submit" class="btn btn-danger" value="삭제" onclick="" style="width: 50px; height:30px; text-align: center; font-size: 11px;">
						</div>
						<table class="table table-striped">
							<thead>
								<tr>
									<th style="width: 1%"><input type="checkbox" id="chkAll" onclick="allCheck(this.checked)"></th>
									<th>회의실 이름</th>
									<th>시작 시간</th>
									<th>종료 시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${mylist}" var="my">
									<tr>
										<td><input type="checkbox" name="chk" value="${my.rev_id}"></td>
										<td>${my.fcl_name}</td>
										<td>${my.revStartFormatted}</td>
										<td>${my.revEndFormatted}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</form>
					</div>

					<div class="card small-card">
						<h6>현재 사용 중</h6>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>회의실 이름</th>
									<th>팀</th>
									<th>시작 시간</th>
									<th>종료 시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${useList}" var="use">
								<c:if test="${use.rev_end > currentTime && use.rev_start < currentTime}">
									<tr>
										<td>${use.fcl_name}</td>
										<td>${use.team_name}</td>
										<td>${use.revStartFormatted}</td>
										<td>${use.revEndFormatted}</td>
									</tr>
								</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<!-- 등록 -->
	<div class="modal fade" id="insertRev" tabindex="-1"
		aria-labelledby="insertModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="insertModalLabel">회의실 예약</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- 모달 내용 -->
					<form action="./insertRev.do" method="post">
						<div class="mb-3">
							<input type="hidden" class="form-control" id="emp_id"
								name="emp_id" value="${loginDto.emp_id}" required> <input
								type="hidden" class="form-control" id="fcl_id" name="fcl_id"
								required>
						</div>
						<div class="mb-3">
							<label for="start" class="form-label">시작일</label> <input
								type="datetime-local" class="form-control" id="rev_start"
								name="rev_start" required>
						</div>
						<div class="mb-3">
							<label for="end" class="form-label">종료일</label> <input
								type="datetime-local" class="form-control" id="rev_end"
								name="rev_end" required>
						</div>
						<div class="modal-footer">
							<button id="btn-save" type="submit" class="btn btn-primary">예약하기</button>
							<button id="btn-close" type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">뒤로가기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>






</body>
<script type="text/javascript">
	//예약 모달
	function reservations(event, fclId) {
		event.preventDefault();

		// 모달에 회의실 ID 설정
		document.getElementById('fcl_id').value = fclId;

		let today = new Date().toISOString().slice(0, 16);

		document.getElementById('rev_start').value = today;
		document.getElementById('rev_end').value = today;

		var modalElement = document.getElementById('insertRev');
		var modal = new bootstrap.Modal(modalElement);
		modal.show();
	}

	function unable(e) {
		e.preventDefault();

		Swal.fire({
			title : '회의실',
			text : '현재 사용할 수 없습니다.',
			icon : 'error',
			confirmButtonText : '확인'
		});

	}

	document.addEventListener('DOMContentLoaded', function() {
		<c:if test="${not empty message}">
		Swal.fire({
			title : '회의실',
			text : '${message}',
			icon : '${messageType}',
			confirmButtonText : '확인'
		});
		</c:if>
	});
	
//삭제
function checkSubmit(event){
    event.preventDefault();

    var cnt = checkCount(); // 이 함수가 정의되어 있는지 확인
    if(cnt > 0){
        Swal.fire({
            title: "선택한 예약을 취소하시겠습니까?",
            icon: "warning",
            showDenyButton: true,
            confirmButtonText: "삭제",
            denyButtonText: "취소"
        }).then((result) => {
            if(result.isConfirmed){
                Swal.fire("삭제되었습니다!", "", "success").then(() => {
                    document.querySelector('form').submit();
                });
            } else if(result.isDenied){
                Swal.fire("취소되었습니다", "", "info");
            }
        });
    } else {
        Swal.fire("선택된 공지글이 없습니다");
    }
}

function allSelect(e){
	e.preventDefault();
	
	window.open("${root}/rev/allSelectRev.do","","width=1050px,height=700px");
}
	
</script>

</html>