<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Toastify CSS for notifications -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
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
	font-size: 14.5px;
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
				<!-- 사원 리스트 -->
				<div class="page-heading">
					<div class="page-title">
						<div class="row">
							<div class="col-12 col-md-6 order-md-1 order-last">
								<h3>사원 목록</h3>
								<!-- 								<p class="text-subtitle text-muted p-1">사원 목록 조회, 수정, 삭제</p> -->
							</div>
						</div>
					</div>

					<div class="card" style="min-height: 700px">
						<div class="card-header m-0 p-4 pt-3">
							<div class="mt-4">
								<!-- 사원 등록 버튼 -->
								<input type="button" value="사원 등록"
									class="btn btn-outline-secondary"
									style="margin-left: auto; display: block; position: absolute; right: 30px; top: 33px; width: 100px; height: 35px;"
									onclick="location.href='./registForm.do'">
								<h5>사원 조회</h5>
							</div>
							<div class="d-flex align-items-center justify-content-between">
								<!-- search bar -->
								<div class="email-fixed-search flex-grow-1 mt-2"></div>
								<!-- pagination and page count -->
								<div class="d-flex align-items-center">
									<!-- Pagination Logic (unchanged) -->
								</div>
							</div>
						</div>

						<div class="card-body"
							style="padding-left: 20px; max-width: 2000px;">
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
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<!-- 사원 리스트 반복 출력 -->
									<c:forEach items="${employeeList}" var="e">
										<tr>
											<td>
												<!-- 사원 상세보기 모달 트리거 링크 --> <a href="#"
												onclick="showEmployeeDetail('${e.emp_id}')"
												data-bs-toggle="modal" data-bs-target="#employeeDetailModal">${e.emp_id}</a>


												<!-- 사원 상세 정보 모달 -->
												<div class="modal fade" tabindex="-1" role="dialog"
													id="employeeDetailModal">
													<div class="modal-dialog modal-dialog-centered modal-lg"
														role="document">
														<div class="modal-content rounded-4 shadow">
															<div class="modal-header p-5 pb-4 border-bottom-0">
																<h4 class="fw-bold mb-0 fs-4">사원 상세</h4>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>

															<form id="employeeDetailForm" method="post" action="">

																<div class="modal-body p-5 pt-0">


																	<!-- 사원 상세 정보 -->
																	<div class="form-group">
																		<!-- 프로필 사진 -->
																		<div style="display: flex; align-items: center;">
																			<!-- 																		<div style="margin-right: 20px;"> -->
																			<!-- 																			<img id="empProfilePic" src="#" alt="사원 프로필 사진" -->
																			<!-- 																				class="img-thumbnail" -->
																			<!-- 																				style="width: 70px; height: 70px;"> -->
																			<!-- 																		</div> -->
																			<div style="flex-grow: 1;">
																				<div class="form-group row">
																					<div class="col-md-6">
																						<label for="empId">사원번호</label> <input type="text"
																							class="form-control" id="empId"
																							readonly="readonly">
																					</div>
																					<div class="col-md-6">
																						<label for="empName">이름</label> <input type="text"
																							class="form-control" id="empName"
																							readonly="readonly">
																					</div>
																				</div>


																			</div>
																		</div>
																	</div>

																	<!-- 본부, 팀 -->
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label for="divisionName" id="divisionName2">본부</label>

																			<select id="divisionName" class="form-control"
																				onchange="updateTeams()">

																				<!-- 																			본부 옵션들, 본부 값에 따라 팀 옵션이 달라지도록 설정 -->

																				<option value="전략기획본부"
																					${employeeVo.division_name == '전략기획본부' ? 'selected' : ''}>전략기획본부</option>
																				<option value="음악사업본부"
																					${employeeVo.division_name == '음악사업본부' ? 'selected' : ''}>음악사업본부</option>
																				<option value="홍보마케팅본부"
																					${employeeVo.division_name == '홍보마케팅본부' ? 'selected' : ''}>홍보마케팅본부</option>
																				<option value="매니지먼트본부"
																					${employeeVo.division_name == '매니지먼트본부' ? 'selected' : ''}>매니지먼트본부</option>
																			</select>
																		</div>
																		<div class="col-md-6">
																			<label for="teamName" id="teamName2">팀</label> <select
																				id="teamName" class="form-control">
																			</select>
																		</div>
																	</div>

																	<!-- 직급, 직책 -->
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label for="rankName">직급</label> <select
																				class="form-control" id="rankName">
																				<option value="부장"
																					${employeeVo.rank_name == '부장' ? 'selected' : ''}>부장</option>
																				<option value="과장"
																					${employeeVo.rank_name == '과장' ? 'selected' : ''}>과장</option>
																				<option value="대리"
																					${employeeVo.rank_name == '대리' ? 'selected' : ''}>대리</option>
																				<option value="사원"
																					${employeeVo.rank_name == '사원' ? 'selected' : ''}>사원</option>
																			</select>
																		</div>
																		<div class="col-md-6">
																			<label for="empPosition">직책</label> <select
																				class="form-control" id="empPosition">
																				<option value="N"
																					${employeeVo.emp_lead == 'N' ? 'selected' : ''}>없음</option>
																				<option value="D"
																					${employeeVo.emp_lead == 'D' ? 'selected' : ''}>본부장</option>
																				<option value="T"
																					${employeeVo.emp_lead == 'T' ? 'selected' : ''}>팀장</option>
																			</select>
																		</div>
																	</div>

																	<!-- 이메일, 입사일 -->
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label for="empEmail">이메일</label> <input type="email"
																				class="form-control" id="empEmail"
																				value="${employeeVo.emp_email}" readonly="readonly">
																		</div>
																		<div class="col-md-6">
																			<label for="empHireDate">입사일</label> <input
																				type="text" class="form-control" id="empHireDate"
																				readonly="readonly">
																		</div>
																	</div>

																	<!-- 재직 상태, 권한 -->
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label for="empStatus">재직 상태</label> <select
																				class="form-control" id="empStatus"
																				style="pointer-events: none;">
																				<option value="A"
																					${employeeVo.emp_status == 'A' ? 'selected' : ''}>승인대기</option>
																				<option value="B"
																					${employeeVo.emp_status == 'B' ? 'selected' : ''}>재직중</option>
																				<option value="C"
																					${employeeVo.emp_status == 'C' ? 'selected' : ''}>휴직</option>
																				<option value="D"
																					${employeeVo.emp_status == 'D' ? 'selected' : ''}>퇴사</option>
																			</select>
																		</div>
																		<div class="col-md-6">
																			<label for="empAuthority">권한</label> <select
																				class="form-control" id="empAuthority">
																				<option value="U"
																					${employeeVo.authority == 'U' ? 'selected' : ''}>사용자</option>
																				<option value="A"
																					${employeeVo.authority == 'A' ? 'selected' : ''}>인사총무팀</option>

																			</select>
																		</div>
																	</div>

																	<!-- 은행명, 예금주 -->
																	<div class="form-group row">
																		<div class="col-md-6">
																			<label for="bankName">은행명</label> <input type="text"
																				class="form-control" id="bankName"
																				value="${employeeVo.bank_name}" readonly="readonly">
																		</div>
																		<div class="col-md-6">
																			<label for="relationToEmp">예금주와의 관계</label> <input
																				type="text" class="form-control" id="relationToEmp"
																				value="${employeeVo.relation_to_emp}"
																				readonly="readonly">
																		</div>
																	</div>

																	<!-- 주소 -->
																	<input type="hidden" id="addr1"> <input
																		type="hidden" id="addr2">
																	<div class="form-group">
																		<label for="fullAddress">주소</label> <input type="text"
																			class="form-control" id="fullAddress"
																			readonly="readonly" disabled>
																	</div>



																	<!-- 																<input type="text" name="empId" id="empId2"> -->



																</div>
															</form>
														</div>
													</div>
												</div>
											</td>
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
													<td style="color: red;">퇴사</td>
												</c:when>
												<c:otherwise>
													<td>재직중</td>
												</c:otherwise>
											</c:choose>
											<td>
												<a href="${root}/registForm.do?emp_id=${e.emp_id}"
													class="btn btn-outline-secondary">수정</a>
											</td>
											<td>
												<a href="${root}/deleteEmployee.do?emp_id=${e.emp_id}"
													class="btn btn-outline-danger">삭제</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer include -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<!-- JavaScript Libraries -->
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
		// 본부별 팀 리스트
		const teamsByDivision = {
			"전략기획본부" : [ "경영기획팀", "인사총무팀", "사업전략팀", "재무회계팀" ],
			"음악사업본부" : [ "콘텐츠제작팀", "프로듀싱팀", "글로벌비즈니스팀", "캐스팅팀", "트레이닝팀" ],
			"홍보마케팅본부" : [ "언론홍보팀", "영상제작팀", "마케팅팀", "광고마케팅팀" ],
			"매니지먼트본부" : [ "가수팀", "배우팀" ]
		};

		// 팀 옵션을 업데이트하는 함수
		function updateTeams() {
			const divisionSelect = document.getElementById('divisionName');
			const teamSelect = document.getElementById('teamName');

			const selectedDivision = divisionSelect.value;

			// 팀 목록 초기화
			teamSelect.innerHTML = '';

			// 선택한 본부에 따른 팀 목록 가져오기
			const teams = teamsByDivision[selectedDivision];

			if (teams) {
				// 팀 목록에 각 팀 추가
				teams.forEach(function(team) {
					const option = document.createElement('option');
					option.value = team;
					option.textContent = team;
					teamSelect.appendChild(option);
				});
			}
		}

		// 페이지가 로드될 때 팀 옵션을 설정
		document.addEventListener('DOMContentLoaded', function() {
			updateTeams();

		});

		// 사원 상세 정보를 서버에서 비동기로 받아와서 모달에 표시하는 함수
		window.showEmployeeDetail = function(empId) {
			console.log("검색요청ID", empId)
			$.ajax({
				url : './employeeDetail.do',
				type : 'GET',
				data : {
					emp_id : empId
				},
				success : function(employee) {
					console.log(employee);
					// 받은 사원 상세 정보를 모달에 표시
					$('#empId').val(employee.emp_id);
					$('#empId2').val(employee.emp_id);
					$('#empName').val(employee.emp_name);
					$('#empEmail').val(employee.emp_email);
					$('#rankName').val(employee.rank_name);
					$('#divisionName').val(employee.division_name);
					updateTeams();
					$('#teamName').val(employee.team_name);
					$('#empHireDate').val(employee.emp_hire_date);
					$('#addr1').val(employee.addr1);
					$('#addr2').val(employee.addr2);
					$('#empStatus').val(employee.emp_status);
					$('#empAuthority').val(employee.authority);
					$('#bankName').val(employee.bank_name);
					$('#relationToEmp').val(employee.relation_to_emp);
					$('#fullAddress')
							.val(employee.addr1 + " " + employee.addr2);

				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.error('사원 상세 정보를 가져오는 중 오류 발생:', textStatus,
							errorThrown);
					Toastify({
						text : "사원 상세 정보를 가져오는 데 실패했습니다.",
						duration : 3000,
						close : true,
						gravity : "top",
						position : "center",
						backgroundColor : "#e74c3c"
					}).showToast();
				}
			});
		};

		// 			// 수정 버튼 클릭 이벤트
		// 			$('#btnUpdate').on('click', function(event) {
		// 				event.preventDefault();
		// 				console.log("바보");

		// 				var formData = $('#employeeDetailForm').serialize(); // 폼 데이터를 시리얼라이즈하여 문자열로 변환
		// 				var a = "abc";

		// 				$.ajax({
		// 					type : 'POST',
		// 					url : './updateEmployee.do', 
		// 					data : formData,
		// 					success : function(response) {
		// 						alert('정보가 성공적으로 업데이트되었습니다!');
		// 						// 업데이트 후 모달 닫기
		// 						$('#employeeDetailModal').modal('hide');

		// 					},
		// 					error : function(xhr, status, error) {
		// 						alert('업데이트 중 오류가 발생했습니다: ' + error);
		// 						console.log(xhr.responseText); // 에러 상세 로그
		// 					}
		// 				});

		// 			// 삭제 버튼 클릭 이벤트
		// 			$('#btnDelete').on('click', function() {
		// 				if (confirm('정말 퇴사 처리하시겠습니까?')) {
		// 					var formData = $('#employeeDetailForm').serialize(); // 폼 데이터를 시리얼라이즈하여 문자열로 변환

		// 					$.ajax({
		// 						type : 'POST',
		// 						url : './deleteEmployee.do', 
		// 						data : formData,
		// 						success : function(response) {
		// 							alert('퇴사 처리가 완료되었습니다!');
		// 							// 삭제 후 모달 닫기
		// 							$('#employeeDetailModal').modal('hide');
		// 							// 추가로 페이지를 갱신하거나 테이블을 다시 로드하는 코드 추가 가능
		// 						},
		// 						error : function(xhr, status, error) {
		// 							alert('퇴사 처리 중 오류가 발생했습니다: ' + error);
		// 							console.log(xhr.responseText); // 에러 상세 로그
		// 						}
		// 					});
		// 				} else {
		// 					alert('삭제가 취소되었습니다.');
		// 				}
		// 			});
		// 		});
	</script>
</body>
</html>
