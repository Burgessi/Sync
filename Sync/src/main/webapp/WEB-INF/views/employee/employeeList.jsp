<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

<title>Home</title>

<style>
.resigned {
	background-color: #d3d3d3 !important; /* 퇴사자 행을 연한 회색으로 설정 */
}

/*상세모달 css 시작*/
.field-container {
	display: flex;
	align-items: center;
	margin-bottom: 15px; /* 요소들 간의 간격 */
}

.field-container label {
	margin-right: 10px; /* 레이블과 입력 필드 사이의 간격 */
	min-width: 80px; /* 레이블의 최소 너비 설정 */
	text-align: right; /* 레이블 텍스트를 오른쪽 정렬 */
	font-weight: bold; /* 레이블 텍스트 굵게 */
}

.field-container input {
	flex-grow: 1; /* 입력 필드가 남은 공간을 차지하도록 */
	padding: 8px; /* 입력 필드 내부 여백 */
	border-radius: 4px;
	border: 1px solid #ddd;
	background-color: #f8f9fa;
}

.modal-content {
	border-radius: 12px; /* 모달의 둥근 모서리 */
	padding: 20px; /* 모달 내부 여백 */
	background-color: #ffffff;
}

.modal-header {
	border-bottom: none; /* 헤더 아래쪽 테두리 제거 */
	padding-bottom: 0; /* 헤더 아래쪽 패딩 제거 */
}

.modal-header h4 {
	color: #333;
	font-weight: 600;
}

.modal-body {
	padding-top: 0; /* 모달 본문 위쪽 패딩 제거 */
}

#member-table {
	font-size: 0.95rem;
}

#member-table th, #member-table td {
	padding: 8px; /* 셀의 패딩을 조정 */
}

#member-table th:nth-child(6), /* 이메일 열 */ #member-table td:nth-child(6)
	{
	width: 16%;
}

#member-table th:nth-child(3), /* 본부 열 */ #member-table td:nth-child(3)
	{
	width: 17%;
}

#member-table th:nth-child(4), /* 팀 열 */ #member-table td:nth-child(4) {
	width: 16%;
}

#member-table th:nth-child(5), #member-table td:nth-child(5) {
	width: 8%;
}

#member-table th:nth-child(8), #member-table td:nth-child(8) {
	width: 10%;
}

#member-table thead {
	background-color: #d9e0fa;
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
							</div>
						</div>
					</div>

					<div class="card" style="min-height: 700px">
						<div class="card-header m-0 p-4 pt-3">
							<div class="mt-4">
								<c:if
									test="${infoDto.team_code == 'HR' and infoDto.authority == 'A'}">
									<!-- 사원 등록 버튼 -->
									<input type="button" value="사원 등록"
										class="btn btn-outline-secondary btn-register"
										style="margin-left: auto; display: block; position: absolute; right: 30px; top: 33px; width: 100px; height: 35px;"
										onclick="location.href='./registForm.do'">
								</c:if>
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

						<div class="card-body" style="padding-left: 20px;">

							<table class="table table-bordered table-hover" id="member-table"
								style="text-align: center; white-space: nowrap;">
								<thead id="hireDateHeader" class="table-secondary">
									<tr>
										<th>사원번호</th>
										<th>이름</th>
										<th>본부</th>
										<th>팀</th>
										<th>직급</th>
										<th>이메일</th>
										<th data-order="desc">입사일 <i
											class="fa-solid fa-sort-down" id="sortIcon"></i>
										</th>
										<th>재직상태</th>

										<c:if
											test="${infoDto.team_code == 'HR' and infoDto.authority == 'A' }">
											<th></th>
										</c:if>

									</tr>
								</thead>
								<tbody id="employeeTable">
									<!-- 사원 리스트 반복 출력 -->
									<c:forEach items="${empList}" var="e">
										<tr class="${e.emp_status eq 'D' ? 'resigned' : ''}">
											<td><c:choose>
													<c:when test="${e.emp_status eq 'D'}">
														<span>${e.emp_id}</span>
														<!-- 링크 대신 텍스트로 표시 -->
													</c:when>

													<c:otherwise>
														<a href="#" onclick="showEmployeeDetail('${e.emp_id}')"
															data-bs-toggle="modal"
															data-bs-target="#employeeDetailModal">${e.emp_id}</a>
													</c:otherwise>
												</c:choose></td>
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

											<c:if
												test="${infoDto.team_code == 'HR' and infoDto.authority == 'A'}">
												<c:choose>
													<c:when test="${e.emp_status eq 'D'}">
														<td></td>
													</c:when>
													<c:otherwise>
														<td>
															<div class="action-buttons">
																<button type="button"
																	class="btn btn-outline-secondary btn-sm"
																	onclick="location.href='./registForm.do?emp_id=${e.emp_id}'">수정</button>
																<button type="button"
																	class="btn btn-outline-danger btn-sm"
																	onclick="deleteEmployee('${e.emp_id}')">삭제</button>
															</div>
														</td>
													</c:otherwise>
												</c:choose>
											</c:if>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- Modal for showing detailed info -->

				<div class="modal fade" tabindex="-1" role="dialog"
					id="employeeDetailModal">
					<div class="modal-dialog modal-dialog-centered modal-lg"
						role="document">
						<div class="modal-content rounded-4 shadow">
							<div class="modal-header p-5 pb-4 border-bottom-0">
								<h4 class="fw-bold mb-0 fs-4">사원 상세</h4>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>

							<div class="modal-body p-5 pt-0">
								<!-- 사원 상세 정보 -->
								<div class="form-group row">
									<div class="col-md-6 field-container">
												<img id="empPic"
													style="border-radius: 50%; width: 70px; height: 70px; object-fit: cover"
													src="${employeeVo.emp_profile_pic}" alt="Profile"
													class="img-fluid" />
									</div>
								</div>
								<div class="form-group row">
									<div class="col-md-6 field-container">
										<label for="empId" style="text-align: left">사원번호</label> <input
											type="text" class="form-control" id="empId"
											value="${employeeVo.emp_id}" readonly="readonly">
									</div>
									<div class="col-md-6 field-container">
										<label for="empName" style="text-align: left">이름</label> <input
											type="text" class="form-control" id="empName"
											value="${employeeVo.emp_name}" readonly="readonly">
									</div>
								</div>

								<!-- 본부, 팀 -->
								<div class="form-group row">
									<div class="col-md-6 field-container">
										<label for="divisionName" style="text-align: left">본부</label>
										<input type="text" class="form-control" id="divisionName"
											value="${employeeVo.division_name}" readonly="readonly">
									</div>
									<div class="col-md-6 field-container">
										<label for="teamName" style="text-align: left">팀</label> <input
											type="text" class="form-control" id="teamName"
											value="${employeeVo.team_name}" readonly="readonly">
									</div>
								</div>

								<!-- 직급, 직책 -->
								<div class="form-group row">
									<div class="col-md-6 field-container">
										<label for="rankName" style="text-align: left">직급</label> <input
											type="text" class="form-control" id="rankName"
											value="${employeeVo.rank_name}" readonly="readonly">
									</div>
									<div class="col-md-6 field-container">
										<label for="empPosition" style="text-align: left">직책</label> <input
											type="text" class="form-control" id="empPosition"
											value="${employeeVo.emp_lead}" readonly="readonly">
									</div>
								</div>

								<!-- 이메일, 입사일 -->
								<div class="form-group row">
									<div class="col-md-6 field-container">
										<label for="empEmail" style="text-align: left">이메일</label> <input
											type="email" class="form-control" id="empEmail"
											value="${employeeVo.emp_email}" readonly="readonly">
									</div>
									<div class="col-md-6 field-container">
										<label for="empHireDate" style="text-align: left">입사일</label>
										<input type="text" class="form-control" id="empHireDate"
											value="${employeeVo.hire_date}" readonly="readonly">
									</div>
								</div>

								<!-- 재직 상태, 권한 -->
								<div class="form-group row">
									<div class="col-md-6 field-container">
										<label for="empStatus" style="text-align: left">재직 상태</label>
										<input type="text" class="form-control" id="empStatus"
											value="${employeeVo.emp_status}" readonly="readonly">
									</div>
									<div class="col-md-6 field-container">
										<label for="empAuthority" style="text-align: left">권한</label>
										<input type="text" class="form-control" id="empAuthority"
											value="${employeeVo.authority}" readonly="readonly">
									</div>
								</div>

								<c:if
									test="${infoDto.team_code == 'HR' and infoDto.authority == 'A'}">
									<!-- 은행명, 예금주 -->
									<div class="form-group row">
										<div class="col-md-6 field-container">
											<label for="bankName" style="text-align: left">은행명</label> <input
												type="text" class="form-control" id="bankName"
												value="${employeeVo.bank_name}" readonly="readonly">
										</div>
										<div class="col-md-6 field-container">
											<label for="accountNum" style="text-align: left">계좌번호</label>
											<input type="text" class="form-control" id="accountNum"
												value="${employeeVo.account_num}" readonly="readonly">
										</div>
									</div>

									<!-- 주소 -->
									<input type="hidden" id="addr1">
									<input type="hidden" id="addr2">
									<div class="form-group field-container">
										<label for="fullAddress" style="text-align: left">주소</label> <input
											type="text" class="form-control" id="fullAddress"
											value="${employeeVo.full_address}" readonly="readonly"
											disabled>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




	<!-- 사원 상세 정보 모달 -->
	<div class="modal fade" tabindex="-1" role="dialog"
		id="employeeDetailModal">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			role="document">
			<div class="modal-content rounded-4 shadow">
				<div class="modal-header p-5 pb-4 border-bottom-0">
					<h4 class="fw-bold mb-0 fs-4">사원 상세</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body p-5 pt-0">
					<!-- 사원 상세 정보 -->
					<div class="form-group row">
						<div class="col-md-6 field-container">


							<img id="empPic"
								style="border-radius: 50%; width: 70px; height: 70px; object-fit: cover"
								src="${employeeVo.emp_profile_pic}" alt="Profile Picture"
								class="img-fluid" />
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 field-container">
							<label for="empId" style="text-align: left">사원번호</label> <input
								type="text" class="form-control" id="empId"
								value="${employeeVo.emp_id}" readonly="readonly">
						</div>
						<div class="col-md-6 field-container">
							<label for="empName" style="text-align: left">이름</label> <input
								type="text" class="form-control" id="empName"
								value="${employeeVo.emp_name}" readonly="readonly">
						</div>
					</div>

					<!-- 본부, 팀 -->
					<div class="form-group row">
						<div class="col-md-6 field-container">
							<label for="divisionName" id="divisionName2"
								style="text-align: left">본부</label> <input type="text"
								class="form-control" id="divisionName"
								value="${employeeVo.division_name}" readonly="readonly">
						</div>
						<div class="col-md-6 field-container">
							<label for="teamName" id="teamName2" style="text-align: left">팀</label>
							<input type="text" class="form-control" id="teamName"
								value="${employeeVo.team_name}" readonly="readonly">
						</div>
					</div>

					<!-- 직급, 직책 -->
					<div class="form-group row">
						<div class="col-md-6 field-container">
							<label for="rankName" style="text-align: left">직급</label> <input
								type="text" class="form-control" id="rankName"
								value="${employeeVo.rank_name}" readonly="readonly">
						</div>
						<div class="col-md-6 field-container">
							<label for="empPosition" style="text-align: left">직책</label> <input
								type="text" class="form-control" id="empPosition"
								value="${employeeVo.emp_lead}" readonly="readonly">
						</div>
					</div>

					<!-- 이메일, 입사일 -->
					<div class="form-group row">
						<div class="col-md-6 field-container">
							<label for="empEmail" style="text-align: left">이메일</label> <input
								type="email" class="form-control" id="empEmail"
								value="${employeeVo.emp_email}" readonly="readonly">
						</div>
						<div class="col-md-6 field-container">
							<label for="empHireDate" style="text-align: left">입사일</label> <input
								type="text" class="form-control" id="empHireDate"
								value="${employeeVo.hire_date}" readonly="readonly">
						</div>
					</div>

					<!-- 재직 상태, 권한 -->
					<div class="form-group row">
						<div class="col-md-6 field-container">
							<label for="empStatus" style="text-align: left">재직 상태</label> <input
								type="text" class="form-control" id="empStatus"
								value="${employeeVo.emp_status}" readonly="readonly">
						</div>
						<div class="col-md-6 field-container">
							<label for="empAuthority" style="text-align: left">권한</label> <input
								type="text" class="form-control" id="empAuthority"
								value="${employeeVo.authority}" readonly="readonly">
						</div>
					</div>

					<c:if
						test="${infoDto.team_code == 'HR' and infoDto.authority == 'A'}">
						<!-- 은행명, 예금주 -->
						<div class="form-group row">
							<div class="col-md-6 field-container">
								<label for="bankName" style="text-align: left">은행명</label> <input
									type="text" class="form-control" id="bankName"
									value="${employeeVo.bank_name}" readonly="readonly">
							</div>
							<div class="col-md-6 field-container">
								<label for="accountNum" style="text-align: left">계좌번호</label> <input
									type="text" class="form-control" id="accountNum"
									value="${employeeVo.account_num}" readonly="readonly">
							</div>
						</div>

						<!-- 주소 -->
						<input type="hidden" id="addr1">
						<input type="hidden" id="addr2">
						<div class="form-group field-container">
							<label for="fullAddress" style="text-align: left">주소</label> <input
								type="text" class="form-control" id="fullAddress"
								value="${employeeVo.full_address}" readonly="readonly" disabled>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>

	
	$("#member-table").DataTable({
	      
	      // 표시 건수기능 숨기기
	       lengthChange: false,
	       //한페이지 출력개수
	       pageLength: 15,
	       // 검색 기능 숨기기
	       searching: true,
	       // 정렬 기능 숨기기
	       ordering: true,
	       // 정보 표시 숨기기
	       info: false,
	       // 페이징 기능 숨기기
	       paging: true,
	       //텍스트 언어설정
	       order: [[7,'asc']],
	       language: {
	           search: "<button id='tableSearchBtn' class='btn btn-primary btn-sm' style='margin:0;'>검색</button>",
	           lengthMenu: "_MENU_ 항목 보기",
	           paginate: {
	               previous: "<",   // "Previous" 
	               next: ">"        // "Next" 
	           },
	           searchPlaceholder : "검색어를 입력하세요.",
	           zeroRecords: "해당 사원이 없습니다."
	           
	       }
	      
	}); 
	   
	   

	      $(document).ready(function(){
	         
	         var table = $('#member-table').DataTable();

	         //dataTables 기본 검색 막기
	         $('.dataTables_filter input').off();
	         
	         
	          // 버튼 클릭 시 DataTables 검색 실행
	          $('#tableSearchBtn').on('click', function() {
	              var searchTerm = $('.dataTables_filter input').val(); // 기본 검색 상자에서 검색어 가져오기
	              table.search(searchTerm).draw(); // 검색어 전달하고 테이블 다시 그리기
	          });
	         
	          
	          // table 다시 그릴때마다 css 설정하기!!
	          table.on('draw', function() {
	            draw();
	          });
	          
	          
	          function draw(){
	             
	            $(".paginate_button").addClass("btn btn-outline-secondary");
	            $(".btn-outline-secondary").removeClass("paginate_button");
	            $(".paginate_button").css("margin", "0 15px");	            
	            $(".next").css("padding","3px 7px 3px 7px");
	            $(".next").css("margin-left","11px");
	            $(".previous").css("margin-right","11px");
	            $(".previous").css("padding","3px 7px 3px 7px");
	            $(".dataTable").css("border-bottom","1px solid #e0e0e0");
	            $(".dataTables_paginate").css("text-align","center");
	            $(".dataTables_paginate").css("float","none");
	            $(".dataTables_paginate").css("margin-top","15px");
	            $(".current").addClass('active');
	            $('.active').css('backrground','#6c757d');
	            
	          }
	          
	          $("input[type=search]").addClass("form-control");
	          $("input[type=search]").css("width", "150px");
	          $("input[type=search]").css("font-size", "0.8em");
	          $("input[type=search]").css("margin-left", "10px");
	          $("input[type=search]").css("margin-right", "10px");
	          $("input[type=search]").closest("label").css("display","flex");
	          $("input[type=search]").closest("label").css("margin-bottom","15px");
	          $("input[type=search]").closest("label").css("flex-direction","row-reverse");
	          $("input[type=search]").closest("label").css("justify-content","space-between");
	          $("#progressTable_filter").css("width","220px");
	         
	         draw();
	         
	      });

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

		// 사원 상세 정보를 서버에서 비동기로 받아와서 모달에 표시하는 함수

		function showEmployeeDetail(empId) {
			console.log("검색요청ID", empId)
			$.ajax({
				url : './employeeDetail.do',
				type : 'GET',
				data : {
					emp_id : empId
				},
				success : function(employee) {

					// 받은 사원 상세 정보를 모달에 표시

					//$('#empPic').val(employee.emp_profile_pic);

					if (employee.emp_profile_pic) {
   					$('#empPic').attr('src', employee.emp_profile_pic);
					} else {
    				$('#empPic').attr('src', '${root}/resources/img/member-imgs/user.png');
}
					$('#empId').val(employee.emp_id);
					//$('#empId2').val(employee.emp_id);
					$('#empName').val(employee.emp_name);
					$('#empEmail').val(employee.emp_email);
					$('#rankName').val(employee.rank_name);
					$('#divisionName').val(employee.division_name);
					updateTeams();
					$('#teamName').val(employee.team_name);
					$('#empHireDate').val(employee.emp_hire_date);
					$('#addr1').val(employee.addr1);
					$('#addr2').val(employee.addr2);
					//$('#empStatus').val(employee.emp_status);
					$('#empStatus').val(statusMap[employee.emp_status]);
					//$('#empAuthority').val(employee.authority);
					$('#empAuthority').val(authorityMap[employee.authority]);
					//$('#empPosition').val(employee.emp_lead);
					$('#empPosition').val(positionMap[employee.emp_lead]); // 매핑된 직책명 사용

					$('#bankName').val(employee.bank_name);
					$('#accountNum').val(employee.account_num);

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

// 		function deleteEmployee(empId) {
// 			if (confirm('퇴사 처리 하시겠습니까?')) {
// 				var form = document.createElement('form');
// 				form.method = 'POST';
// 				form.action = '${root}/deleteEmployee.do';

// 				var input = document.createElement('input');
// 				input.type = 'hidden';
// 				input.name = 'emp_id';
// 				input.value = empId;
// 				form.appendChild(input);

// 				document.body.appendChild(form);
// 				form.submit();
// 			}
// 		}
function deleteEmployee(empId) {
    Swal.fire({
        title: '확인',
        text: '퇴사 처리 하시겠습니까?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '예',
        cancelButtonText: '아니요',
        dangerMode: true
    }).then((result) => {
        if (result.isConfirmed) {
          
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${root}/deleteEmployee.do'; // 실제 경로에 맞게 수정

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'emp_id';
            input.value = empId;
            form.appendChild(input);

            document.body.appendChild(form);
            form.submit();

           
            //Swal.fire('처리 완료', '퇴사 처리가 완료되었습니다.', 'success');
        } else {
         
            Swal.fire('취소됨', '퇴사 처리가 취소되었습니다.', 'error');
        }
    });
}


		var message = '${message}';
		if (message && message.trim() !== "") {
			toastr.info(message);
		}

		// 페이지가 로드될 때 설정
// 		document.addEventListener('DOMContentLoaded', function() {
// 			updateTeams();

// 			const hireDateHeader = document.getElementById('hireDateHeader');
// 			if (hireDateHeader) {
// 				hireDateHeader.addEventListener('click', function() {
// 					sortByHireDate();
// 				});
// 			}

// 		});

		// emp_lead 코드와 직책명을 매핑하는 객체
		const positionMap = {
			'T' : '팀장',
			'D' : '본부장',
			'N' : '일반사원'
		};

		//emp_status와 상태 매핑
		const statusMap = {
			'A' : '승인대기',
			'B' : '재직',
			'C' : '휴직',
			'D' : '퇴사'
		};

		//authority와 권한 매핑
		const authorityMap = {
			'U' : '사용자',
			'A' : '인사관리자'
		};
	</script>

</body>
</html>
