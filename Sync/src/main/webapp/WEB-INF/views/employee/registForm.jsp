<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Employee Registration</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${root}/resources/css/member/join-style.css" />
<link rel="stylesheet" href="${root}/resources/css/regist.css" />
<script type="text/javascript"
	src="${root}/resources/js/employee/formValidation.js"></script>


</head>
<body>
	<div id="app">
		<!-- 사이드바 include -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="main">
			<div id="card">
				<!-- 헤더 include -->
				<%@ include file="/WEB-INF/views/common/header.jsp"%>


				<div class="container">
					<div class="regist">
						<form id="regist-form" action="./regist.do" method="post">
							<h3 class="sub-title">사원 등록</h3>
							<table>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input name="emp_name" type="text" autocomplete="off"
											placeholder="Name" required /></td>
									</tr>
									<tr>
										<th>주민등록번호</th>
										<td><input name="emp_ssn" type="text" maxlength="14"
											placeholder="SSN" required oninput="formatSSN(this)" /></td>
									</tr>
									<tr>
										<th>성별</th>
										<td><select name="emp_gender" required>
												<option value="">성별 선택</option>
												<option value="M">남</option>
												<option value="F">여</option>
										</select></td>
									</tr>
									<tr>
										<th>본부</th>
										<td><select name="division" id="division" required
											onchange="updateTeams()">
												<option value="">본부 선택</option>
												<option value="SPD">전략기획본부</option>
												<option value="MBD">음악사업본부</option>
												<option value="PRD">홍보마케팅본부</option>
												<option value="MGD">매니지먼트본부</option>
										</select></td>
									</tr>
									<tr>
										<th>팀</th>
										<td><select name="team_code" id="team_code" required>
												<option value="">팀 선택</option>
										</select></td>
									</tr>
									<tr>
										<th>직급</th>
										<td><select name="rank_id" required>
												<option value="">직급 선택</option>
												<option value="RANK003">부장</option>
												<option value="RANK004">과장</option>
												<option value="RANK005">대리</option>
												<option value="RANK006">사원</option>
										</select></td>
									</tr>
									<tr>
										<th>직책</th>
										<td><select name="emp_lead" required>
												<option value="N">없음</option>
												<option value="D">본부장</option>
												<option value="T">팀장</option>
										</select></td>
									</tr>
									<tr>
										<th>입사일</th>
										<td><input type="date" name="emp_hire_date" required /></td>
									</tr>
								</tbody>
							</table>

							<!-- 제출 버튼 -->
							<input type="submit" value="등록" class="btn btn-info" /> <input
								class="btn btn-secondary" onclick="javascript:history.back(-1)"
								value="취소" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
		function formatSSN(input) {
			var value = input.value.replace(/\D/g, ''); // 숫자 외 문자 제거
			if (value.length <= 6) {
				input.value = value; // 6자리 이하일 경우, 그냥 입력
			} else if (value.length <= 13) {
				input.value = value.slice(0, 6) + '-' + value.slice(6); // 6자리 후 하이픈 추가
			} else {
				input.value = value.slice(0, 6) + '-' + value.slice(6, 13); // 13자리까지만 입력
			}
		}
		function updateTeams() {
			var division = document.getElementById('division').value;
			var teamSelect = document.getElementById('team_code');

			// 팀 옵션 초기화
			teamSelect.innerHTML = '<option value="">선택하세요</option>';

			// 본부에 따른 팀 목록 정의
			var teams = {
				"SPD" : [ {
					code : "BP",
					name : "경영기획팀"
				}, {
					code : "HR",
					name : "인사총무팀"
				}, {
					code : "BS",
					name : "사업전략팀"
				}, {
					code : "FA",
					name : "재무회계팀"
				} ],
				"MBD" : [ {
					code : "CC",
					name : "콘텐츠제작팀"
				}, {
					code : "PD",
					name : "프로듀싱팀"
				}, {
					code : "GB",
					name : "글로벌비즈니스팀"
				}, {
					code : "CT",
					name : "캐스팅팀"
				}, {
					code : "TR",
					name : "트레이닝팀"
				} ],
				"PRD" : [ {
					code : "PR",
					name : "언론홍보팀"
				}, {
					code : "VP",
					name : "영상제작팀"
				}, {
					code : "MT",
					name : "마케팅팀"
				}, {
					code : "AM",
					name : "광고마케팅팀"
				} ],
				"MGD" : [ {
					code : "ST",
					name : "가수팀"
				}, {
					code : "AT",
					name : "배우팀"
				} ]
			};

			// 선택된 본부에 따른 팀 목록 추가
			if (teams[division]) {
				teams[division].forEach(function(team) {
					var option = document.createElement('option');
					option.value = team.code;
					option.textContent = team.name;
					teamSelect.appendChild(option);
				});
			}
		}
	</script>

</body>
</html>