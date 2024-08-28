<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<title>Home</title>

<style>
.btn-right {
	position: absolute;
	right: 20px;
	top: 20px;
}

.table {
	width: 100%; /* 테이블을 페이지 너비에 맞게 설정 */
	table-layout: auto; /* 열 너비를 내용에 맞게 자동 조정 */
	border-collapse: collapse; /* 테이블 경계선 겹치기 방지 */
}

.table th, .table td {
	white-space: nowrap; /* 줄바꿈 방지 */
	overflow: hidden; /* 넘치는 내용 숨기기 */
	text-overflow: ellipsis; /* 생략 부호 표시 */
	width: 150px; /* 각 열의 너비 설정 */
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
<!-- 			<main> -->
				<div class="container">

					<!-- 사원 리스트 -->
					<div class="page-heading">
						<div class="page-title">
							<div class="row">
								<div class="col-12 col-md-6 order-md-1 order-last">
									<h3>사원 목록</h3>
									<p class="text-subtitle text-muted p-1">사원 목록 조회, 수정, 삭제</p>
								</div>
							</div>
						</div>

						<div class="card" style="min-height: 700px">
							<div class="card-header m-0 p-4 pt-3">
								<div class="mt-4">
									<input type="button" value="사원 등록" class="btn btn-outline-secondary"
										style="margin-left: auto; display: block; position: absolute; right: 30px; top: 33px; width: 100px; height: 35px;"
										onclick="location.href='./registForm.do'">
									<h5>사원 조회</h5>
								</div>
								<div class="d-flex align-items-center justify-content-between">
									<!-- search bar  -->
									<div class="email-fixed-search flex-grow-1 mt-2"></div>
									<!-- pagination and page count -->
									<div class="d-flex align-items-center">
										<!-- Pagination Logic (unchanged) -->
									</div>
								</div>
							</div>

							<div class="card-body" style="padding-left: 20px; max-width: 2000px;">
								<table class="table" id="member-table" style="text-align: center">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>이름</th>
											<th>본부</th>
											<th>팀</th>
											<th>직급</th>
											<th>이메일</th>
											<th>입사일</th>
											<th>재직상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${employeeList}" var="e">
											<tr>
												<td>
													<a href="#" onclick="showEmployeeDetail('${e.emp_id}')" data-bs-toggle="modal"
                                                       data-bs-target="#employeeDetailModal${e.emp_id}">${e.emp_id}
                                                    </a>

													<!-- 사원 상세 정보 모달 -->
													<div class="modal fade" tabindex="-1" role="dialog" id="employeeDetailModal${e.emp_id}">
														<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
															<div class="modal-content rounded-4 shadow">
																<div class="modal-header p-5 pb-4 border-bottom-0">
																	<h4 class="fw-bold mb-0 fs-4">사원 상세</h4>
																	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
																</div>

																<div class="modal-body p-5 pt-0">
																	<form id="employeeDetailForm">
																		<!-- 사원 상세 정보 -->
																		<div class="form-group">
																			<!-- 프로필 사진 -->
																			<div style="display: flex; align-items: center;">
																				<div style="margin-right: 20px;">
																					<img id="empProfilePic" src="#" alt="사원 프로필 사진"
																						class="img-thumbnail"
																						style="width: 70px; height: 70px;">
																				</div>
																				<div style="flex-grow: 1;">
																					<div class="form-group row">
																						<div class="col-md-6">
																							<label for="empId">사원번호</label> <input
																								type="text" class="form-control" id="empId"
																								value="XXXXXX" readonly>
																						</div>
																						<div class="col-md-6">
																							<label for="empName">이름</label> <input
																								type="text" class="form-control" id="empName"
																								value="홍길동" readonly>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>

																		<!-- 본부, 팀 -->
																		<div class="form-group row">
																			<div class="col-md-6">
																				<label for="divisionName">본부</label> <select
																					class="form-control" id="divisionName">
																					<option value="1">홍보마케팅본부</option>
																				</select>
																			</div>
																			<div class="col-md-6">
																				<label for="teamName">팀</label> <select
																					class="form-control" id="teamName">
																					<option value="1">언론홍보팀</option>
																				</select>
																			</div>
																		</div>

																		<!-- 직급, 직책 -->
																		<div class="form-group row">
																			<div class="col-md-6">
																				<label for="rankName">직급</label> <select
																					class="form-control" id="rankName">
																					<option value="1">사원</option>
																				</select>
																			</div>
																			<div class="col-md-6">
																				<label for="empPosition">직책</label> <select
																					class="form-control" id="empPosition">
																					<option value="1">팀장</option>
																				</select>
																			</div>
																		</div>

																		<!-- 이메일, 입사일 -->
																		<div class="form-group row">
																			<div class="col-md-6">
																				<label for="empEmail">이메일</label> <input
																					type="email" class="form-control" id="empEmail"
																					value="gildong@naver.com" readonly>
																			</div>
																			<div class="col-md-6">
																				<label for="empHireDate">입사일</label> <input
																					type="text" class="form-control" id="empHireDate"
																					value="2024.00.00" readonly>
																			</div>
																		</div>

																		<!-- 재직 상태 -->
																		<div class="form-group">
																			<label for="empStatus">재직 상태</label> <select
																				class="form-control" id="empStatus">
																				<option value="B" selected>재직중</option>
																			</select>
																		</div>

																		<!-- 은행명, 예금주 -->
																		<div class="form-group row">
																			<div class="col-md-6">
																				<label for="bankName">은행명</label> <input type="text"
																					class="form-control" id="bankName" value="국민은행"
																					readonly>
																			</div>
																			<div class="col-md-6">
																				<label for="accountHolder">예금주</label> <input
																					type="text" class="form-control" id="accountHolder"
																					readonly>
																			</div>
																		</div>

																		<!-- 주소 -->
																		<div class="form-group">
																			<label for="address">주소</label> <input type="text"
																				class="form-control" id="address" value="서울시 양천구"
																				readonly>
																		</div>

																		<!-- 수정, 삭제 버튼 -->
																		<div style="text-align: right;">
																			<button type="button" class="btn btn-primary">수정</button>
																			<button type="button" class="btn btn-danger">삭제</button>
																		</div>
																	</form>
																</div>
															</div>
														</div>
													</div></td>
												<td>${e.emp_name}</td>
												<td>${e.division_name}</td>
												<td>${e.team_name}</td>
												<td>${e.rank_name}</td>
												<td>${e.emp_email}</td>
												<td>${e.emp_hire_date}</td>
												<c:choose>
													<c:when test="${e.emp_status eq 'A'}">
														<td style="color: blue;">승인대기</td>
													</c:when>
													<c:when test="${e.emp_status eq 'C'}">
														<td style="color: green;">휴직</td>
													</c:when>
													<c:when test="${e.emp_status eq 'D'}">
														<td style="color: red;">퇴직</td>
													</c:when>
													<c:otherwise>
														<td>재직중</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 		</main> -->
	</div>

	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		
		//사원 상세 정보 표시 함수
		function showEmployeeDetail(empId) {
			$.ajax({
				url: '${root}/employee/getEmployeeDetail.do',
				type: 'GET',
				data: { emp_id: empId },
				success: function(data) {
					
					// 데이터를 모달에 채워넣기
				     $('#empProfilePic').attr('src', data.emp_profile_pic);
			            $('#empId').val(data.emp_id);
			            $('#empName').val(data.emp_name);
			            $('#divisionName').val(data.division_name);
			            $('#teamName').val(data.team_name);
			            $('#rankName').val(data.rank_name);
			            $('#empPosition').val(data.emp_position); 
			            $('#empEmail').text(data.emp_email);
			            $('#empHireDate').text(data.emp_hire_date);
			            $('#empStatus').val(data.emp_status);
			            $('#bankName').val(data.bank_name);
			            
			            $('#accountHolder').text(data.account_holder);
			            $('#address').val(`${data.addr1}, ${data.addr2}`);
			           
			            //모달창 열기
			            $('#employeeDetailModal'+empId).modal('show');
				},
				error: function() {
		            alert('사원 정보를 가져오는 데 실패했습니다.');
		        }
			});
		}

		// 사원 정보 수정 함수
		function updateEmployee() {
			var empData = {
				empId: $('#empId').val(),
				divisionName: $('#divisionName').val(),
				teamName: $('#teamName').val(),
				rankName: $('#rankName').val(),
				empPosition: $('#empPosition').val(),
				empStatus: $('#empStatus').val()
			};

			$.ajax({
				url: '${root}/employee/updateEmployeeDetail.do',
				type: 'POST',
				contentType: 'application/json; charset=utf-8'
				data: JSON.stringify(empData), //데이터 전송
				success: function(response) {
					alert('수정이 완료되었습니다.');
					$('#employeeDetailModal'+empData.empId).modal('hide');
				},
				error: function(err) {
					console.log(err);
					 alert('수정 중 오류가 발생하였습니다.');
				}
			});
		}
	</script>
</body>
</html>
