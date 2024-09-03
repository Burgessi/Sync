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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<title>Home</title>

<style>
/* 테이블 전체 컨테이너 스타일 */
.table-container {
	max-height: 500px; /* 테이블의 최대 높이 설정 */
	overflow-y: auto; /* 세로 스크롤 적용 */
	display: block; /* 블록 디스플레이로 스크롤 적용 */
	position: relative;
}

/* 테이블 헤더 고정 */
.table-fixed-header thead th {
	position: -webkit-sticky; /* Safari */
	position: sticky;
	top: 0; /* 페이지 상단에 고정 */
	background-color: #fff; /* 배경색 */
	z-index: 10; /* 스크롤 시 헤더가 위에 있도록 설정 */
}

/* 기본적으로 가로 스크롤을 없앰 */
.table-container {
	overflow-x: hidden; /* 기본 상태에서는 가로 스크롤 숨김 */
}

/* 화면 너비가 1200px 이하일 때 가로 스크롤 적용 */
@media ( max-width : 1200px) {
	.table-container {
		overflow-x: auto; /* 가로 스크롤 적용 */
	}
}

/* 테이블 스타일 */
.table {
	width: 100%; /* 테이블 너비를 100%로 설정 */
	table-layout: fixed; /* 고정 너비 테이블 */
	border-collapse: collapse; /* 테두리 중복 방지 */
}

/* 테이블 헤더와 데이터 셀 스타일 */
.table th, .table td {
	white-space: nowrap; /* 줄바꿈 방지 */
	overflow: hidden; /* 넘치는 내용 숨기기 */
	text-overflow: ellipsis; /* 생략 부호 표시 */
	width: 150px; /* 각 열의 너비 설정 */
	font-size: 14.5px;
	height: 50px; /* 행의 높이를 고정 */
	vertical-align: middle; /* 내용 중앙 정렬 */
}

/* 테이블의 모든 행 높이 고정 */
.table tr {
	height: 50px; /* 행의 높이를 고정 */
}

/* 버튼이 없는 경우에도 행의 높이를 유지하기 위해 빈 셀에 스타일 추가 */
.table td:empty {
	height: 50px; /* 빈 셀의 높이 설정 */
}

.action-buttons {
	display: flex; /* 버튼들을 가로로 배치 */
	justify-content: center; /* 버튼들을 가운데 정렬 */
	gap: 5px; /* 버튼 간격 설정 */
}

#hireDateHeader {
	cursor: pointer;
	position: relative;
}

#sortIcon {
	margin-left: 5px; /* 아이콘과 텍스트 간의 간격 */
	transition: transform 0.2s; /* 아이콘의 변환 애니메이션 */
}

.sorted-asc #sortIcon {
	transform: rotate(180deg); /* 오름차순일 때 아이콘을 아래로 회전 */
}

.sorted-desc #sortIcon {
	transform: rotate(0deg); /* 내림차순일 때 아이콘을 기본 상태로 */
}

.table .resigned {
	background-color: #d0d0d0;
}

/*상세모달 css 시작*/
.field-container {
	display: flex;
	align-items: center;
	margin-bottom: 15px; /* 요소들 간의 간격 */
}

.field-container label {
	margin-right: 10px; /* 레이블과 입력 필드 사이의 간격 */
	min-width: 80px; /* 레이블의 최소 너비 설정, 필요에 따라 조정 가능 */
	text-align: right; /* 레이블 텍스트를 오른쪽 정렬 */
	font-weight: bold; /* 레이블 텍스트 굵게 */
}

.field-container input {
	flex-grow: 1; /* 입력 필드가 남은 공간을 차지하도록 */
	padding: 8px; /* 입력 필드 내부 여백 */
	border-radius: 4px; /* 둥근 모서리 */
	border: 1px solid #ddd; /* 테두리 색상 */
	background-color: #f8f9fa; /* 배경색 설정 */
}

.modal-content {
	border-radius: 12px; /* 모달의 둥근 모서리 */
	padding: 20px; /* 모달 내부 여백 */
	background-color: #ffffff; /* 모달 배경색 */
}

.modal-header {
	border-bottom: none; /* 헤더 아래쪽 테두리 제거 */
	padding-bottom: 0; /* 헤더 아래쪽 패딩 제거 */
}

.modal-header h4 {
	color: #333; /* 제목 색상 */
	font-weight: 600; /* 제목 두께 */
}

.modal-body {
	padding-top: 0; /* 모달 본문 위쪽 패딩 제거 */
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
							<div class="col-12 col-md-6 order-md-2 order-first text-right">

								<!-- 본부별 조회 드롭다운 -->
								<select id="divisionFilter" class="btn btn-secondary ml-2">
									<option value="">본부</option>
									<option value="전략기획본부">전략기획본부</option>
									<option value="음악사업본부">음악사업본부</option>
									<option value="홍보마케팅본부">홍보마케팅본부</option>
									<option value="매니지먼트본부">매니지먼트본부</option>
								</select>
								<!-- 재직상태별 조회 드롭다운 -->
								<select id="statusFilter" class="btn btn-secondary ml-2">
									<option value="">재직상태</option>
									<option value="승인대기">승인대기</option>
									<option value="재직">재직</option>
									<option value="퇴사">퇴사</option>
								</select>
							</div>
						</div>
					</div>

					<div class="card" style="min-height: 700px">
						<div class="card-header m-0 p-4 pt-3">
							<div class="mt-4">
								<!-- 사원 등록 버튼 -->
								<input type="button" value="사원 등록"
									class="btn btn-outline-secondary btn-register"
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
							<div class="table-container">
								<table class="table" id="member-table"
									style="text-align: center">
									<thead class="table-fixed-header">
										<tr>
											<th style="width: 120px;">사원번호</th>
											<th style="width: 120px;">이름</th>
											<th style="width: 120px;">본부</th>
											<th style="width: 120px;">팀</th>
											<th style="width: 120px;">직급</th>
											<th style="width: 120px;">이메일</th>
											<th style="width: 120px;" id="hireDateHeader"
												data-order="desc">입사일 <i class="fa-solid fa-sort-down"
												id="sortIcon"></i>
											</th>
											<th style="width: 120px;">재직상태</th>
											<th style="width: 120px;"></th>
											<th style="width: 120px;"></th>
										</tr>
									</thead>
									<tbody>
										<!-- 사원 리스트 반복 출력 -->
										<c:forEach items="${employeeList}" var="e">
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
													</c:choose> <!-- 사원 상세 정보 모달 -->
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

																<div class="modal-body p-5 pt-0">
																	<!-- 사원 상세 정보 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																		
																		<!-- 이미지 아직 안됨 -->
																		<img id="empPic" style="border-radius: 50%; width: 70px; height: 70px; object-fit: cover" src="${infoDto.emp_profile_pic}" alt="Profile Picture" class="img-fluid"/>
																	</div>
																	</div>
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="empId">사원번호</label> <input type="text"
																				class="form-control" id="empId"
																				value="${employeeVo.emp_id}" readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="empName">이름</label> <input type="text"
																				class="form-control" id="empName"
																				value="${employeeVo.emp_name}" readonly="readonly">
																		</div>
																	</div>

																	<!-- 본부, 팀 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="divisionName" id="divisionName2">본부</label>
																			<input type="text" class="form-control"
																				id="divisionName"
																				value="${employeeVo.division_name}"
																				readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="teamName" id="teamName2">팀</label> <input
																				type="text" class="form-control" id="teamName"
																				value="${employeeVo.team_name}" readonly="readonly">
																		</div>
																	</div>

																	<!-- 직급, 직책 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="rankName">직급</label> <input type="text"
																				class="form-control" id="rankName"
																				value="${employeeVo.rank_name}" readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="empPosition">직책</label> <input
																				type="text" class="form-control" id="empPosition"
																				value="${employeeVo.emp_lead}" readonly="readonly">
																		</div>
																	</div>

																	<!-- 이메일, 입사일 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="empEmail">이메일</label> <input type="email"
																				class="form-control" id="empEmail"
																				value="${employeeVo.emp_email}" readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="empHireDate">입사일</label> <input
																				type="text" class="form-control" id="empHireDate"
																				value="${employeeVo.hire_date}" readonly="readonly">
																		</div>
																	</div>

																	<!-- 재직 상태, 권한 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="empStatus">재직 상태</label> <input
																				type="text" class="form-control" id="empStatus"
																				value="${employeeVo.emp_status}" readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="empAuthority">권한</label> <input
																				type="text" class="form-control" id="empAuthority"
																				value="${employeeVo.authority}" readonly="readonly">
																		</div>
																	</div>

																	<!-- 은행명, 예금주 -->
																	<div class="form-group row">
																		<div class="col-md-6 field-container">
																			<label for="bankName">은행명</label> <input type="text"
																				class="form-control" id="bankName"
																				value="${employeeVo.bank_name}" readonly="readonly">
																		</div>
																		<div class="col-md-6 field-container">
																			<label for="accountNum">계좌번호</label> <input
																				type="text" class="form-control" id="accountNum"
																				value="${employeeVo.account_num}"
																				readonly="readonly">
																		</div>
																	</div>

																	<!-- 주소 -->
																	<input type="hidden" id="addr1"> <input
																		type="hidden" id="addr2">
																	<div class="form-group field-container">
																		<label for="fullAddress">주소</label> <input type="text"
																			class="form-control" id="fullAddress"
																			value="${employeeVo.full_address}"
																			readonly="readonly" disabled>
																	</div>
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
														<td style="color: red;">퇴사</td>
													</c:when>
													<c:otherwise>
														<td>재직중</td>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${e.emp_status eq 'D'}">
														<td></td>
														<td></td>
													</c:when>
													<c:otherwise>
														<td>
															<!-- 														<a --> <%-- 															href="${root}/registForm.do?emp_id=${e.emp_id}" --%>
															<!-- 															class="btn btn-outline-secondary"> 수정 </a></td> -->
															<!-- 														<td> --> <%-- 															<a href="${root}/deleteEmployee.do?emp_id=${e.emp_id}" --%>
															<!-- 															class="btn btn-outline-danger">삭제</a> -->
															<!-- 															<button class="btn btn-outline-danger" -->
															<%-- 																onclick="deleteEmployee('${e.emp_id}')">삭제</button> --%>

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
					
					//const employee = response.employee;
					
					//console.log(response);
// 					// 받은 사원 상세 정보를 모달에 표시
					$('#empPic').val(employee.emp_profile_pic);
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

		function deleteEmployee(empId) {
			if (confirm('퇴사 처리 하시겠습니까?')) {
				var form = document.createElement('form');
				form.method = 'POST';
				form.action = '${root}/deleteEmployee.do';

				var input = document.createElement('input');
				input.type = 'hidden';
				input.name = 'emp_id';
				input.value = empId;
				form.appendChild(input);

				document.body.appendChild(form);
				form.submit();
			}
		}

		var message = '${message}';
		if(message && message.trim()!==""){
			toastr.info(message);
		}
		
		
		// 페이지가 로드될 때 설정
		document.addEventListener('DOMContentLoaded', function() {
			updateTeams();
			
		    const hireDateHeader = document.getElementById('hireDateHeader');
		    if (hireDateHeader) {
		        hireDateHeader.addEventListener('click', function() {
		            sortByHireDate();
		        });
		    }
		    
		    document.getElementById('divisionFilter').addEventListener('change', filterTable);
		    document.getElementById('statusFilter').addEventListener('change', filterTable);

		});
		
// 		document.getElementById('divisionFilter').addEventListener('change', function() {
// 		    filterTable();
// 		});


		function filterTable() {
		    const division = document.getElementById('divisionFilter').value;
		    const status = document.getElementById('statusFilter').value;
		 
		    const table = document.getElementById('member-table');
		    const tbody = table.querySelector('tbody');
		    const rows = Array.from(tbody.getElementsByTagName('tr')); 
		    //tbody에 있는 모든 행 가져옴

		    rows.forEach(row => { //모든 행
		        const divisionCell = row.querySelector('td:nth-child(3)').innerText; //현재 행의 본부 열의 텍스트 값
		        const statusCell = row.querySelector('td:nth-child(8)').innerText.trim();//현재 행의 재직상태 열의 텍스트 값
		        
		        let isVisible = true;

		        //각 행의 본부 값과 필터링한 값이 일치하지 않으면 행 숨김
		        if (division && division !== divisionCell) {
		            isVisible = false;
		        }
		        if (status && status !== statusCell) {
		            isVisible = false;
		        }
    
		        //isValid 여부에 따라 표시 여부 결정
		        row.style.display = isVisible ? '' : 'none';
		    });
		}
		
		function sortByHireDate() {
		    const table = document.getElementById('member-table');
		    const tbody = table.querySelector('tbody');
		    const rows = Array.from(tbody.getElementsByTagName('tr'));
		    const header = document.getElementById('hireDateHeader');
		    
		    //현재 정렬 방향
		    let order = header.getAttribute('data-order');
		    
		    //정렬 방향
		    order=(order === 'desc')?'asc':'desc';
		    header.setAttribute('data-order', order);
		    
		    //입사일을 기준으로 행 정렬
		    rows.sort((a, b) => {
		        const hireDateA = new Date(a.querySelector('td:nth-child(7)').innerText);
		        const hireDateB = new Date(b.querySelector('td:nth-child(7)').innerText);
		        return (order === 'desc' ? hireDateB - hireDateA : hireDateA - hireDateB);
		    	//Date 객체로 변환해서 비교
		    	//hireDateB - hireDateA 내림차순
		    	//hireDateA - hireDateB 오름차순
		    
		    });
		    
		    //정렬된 행들 tbody에 추가
		    rows.forEach(row => {
		        tbody.appendChild(row);
		    });
		    
		    //아이콘 상태 업데이트
		    if (order === 'asc') {
		        header.classList.remove('sorted-desc'); //지정한 클래스 요소에서 제거
		        header.classList.add('sorted-asc');
		    } else {
		        header.classList.remove('sorted-asc');
		        header.classList.add('sorted-desc');
		    }
		}
		
		
		// emp_lead 코드와 직책명을 매핑하는 객체
		const positionMap = {
		  'T': '팀장',  
		  'D': '본부장',  
		  'N': '일반사원'  
		};
		
		//emp_status와 상태 매핑
		const statusMap = {
				  'A': '승인대기',  
				  'B': '재직',  
				  'C': '휴직',  
				  'D': '퇴사'  
		};
		
		//authority와 권한 매핑
		const authorityMap = {
				  'U': '사용자',  
				  'A': '인사관리자'  
		};
	</script>
</body>
</html>