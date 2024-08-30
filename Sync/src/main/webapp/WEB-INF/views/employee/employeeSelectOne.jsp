<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Employee Detail</title>
</head>
<body>
    <div id="app">
        <!-- 사이드바 include -->
        <%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
        <div id="main">
            <%@ include file="/WEB-INF/views/common/header.jsp"%>
            <div class="container">
                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                    <img src="assets/img/${employeeVo.emp_profile_pic}" alt="Profile" class="rounded-circle">
                    <h2>${employeeVo.emp_name}</h2>
                    <h3>${employeeVo.rank_name}</h3>
                </div>

                <div class="card-body pt-30">
                    <!-- Bordered Tabs -->
                    <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" data-bs-toggle="tab"
                                    data-bs-target="#profile-overview" aria-selected="true"
                                    role="tab">사원 정보</button>
                        </li>

                        <li class="nav-item" role="presentation">
                            <button class="nav-link" data-bs-toggle="tab"
                                    data-bs-target="#profile-edit" aria-selected="false"
                                    tabindex="-1" role="tab">정보 수정</button>
                        </li>
                    </ul>

                    <div class="tab-content pt-30">
                        <!-- Profile Overview Tab -->
                        <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                            <h5 class="card-title">Profile</h5>
                            
                            <!-- 사원번호 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">사원번호</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.emp_id}</div>
                            </div>
                            
                            <!-- 이름 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">이름</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.emp_name}</div>
                            </div>

                            <!-- 본부 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">본부</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.division_name}</div>
                            </div>

                            <!-- 팀 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">팀</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.team_name}</div>
                            </div>

                            <!-- 직급 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">직급</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.rank_name}</div>
                            </div>

                            <!-- 직책 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">직책</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.emp_lead}</div>
                            </div>

                            <!-- 이메일 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">이메일</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.emp_email}</div>
                            </div>

                            <!-- 입사일 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">입사일자</div>
                                <div class="col-lg-9 col-md-8">
                                    <fmt:parseDate var="hireDate" value="${employeeVo.emp_hire_date}" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate value="${hireDate}" pattern="yyyy-MM-dd" />
                                </div>
                            </div>

                            <!-- 재직상태 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">재직상태</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.emp_status}</div>
                            </div>

                            <!-- 은행명 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">은행명</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.bank_name}</div>
                            </div>

                            <!-- 예금주 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">예금주</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.account_holder}</div>
                            </div>

                            <!-- 주소 -->
                            <div class="row" style="margin-bottom: 10px;">
                                <div class="col-lg-3 col-md-4 label">주소</div>
                                <div class="col-lg-9 col-md-8">${employeeVo.addr1} ${employeeVo.addr2}</div>
                            </div>
                        </div>
                        
                        <!-- Profile Edit Tab -->
                        <div class="tab-pane fade profile-edit pt-3" id="profile-edit" role="tabpanel">
                            <form action="./employeeSelectOne.do" method="post">
                                <input type="hidden" name="emp_id" value="${employeeVo.emp_id}">

                                <!-- 본부 수정 -->
                                <div class="row mb-3">
                                    <label for="division" class="col-md-4 col-lg-3 col-form-label">본부</label>
                                    <div class="col-md-8 col-lg-9">
                                        <select class="form-select" name="division_name" id="division" onchange="updateTeams()">
                                            <option value="SPD" ${employeeVo.division_name == '전략기획본부' ? 'selected' : ''}>전략기획본부</option>
                                            <option value="MBD" ${employeeVo.division_name == '음악사업본부' ? 'selected' : ''}>음악사업본부</option>
                                            <option value="PRD" ${employeeVo.division_name == '홍보마케팅본부' ? 'selected' : ''}>홍보마케팅본부</option>
                                            <option value="MGD" ${employeeVo.division_name == '매니지먼트본부' ? 'selected' : ''}>매니지먼트본부</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- 팀 수정 -->
                                <div class="row mb-3">
                                    <label for="team" class="col-md-4 col-lg-3 col-form-label">팀</label>
                                    <div class="col-md-8 col-lg-9">
                                        <select class="form-select" name="team_name" id="team_code">
                                            <!-- 팀 목록 동적 설정 -->
                                        </select>
                                    </div>
                                </div>

                                <!-- 직급 수정 -->
                                <div class="row mb-3">
                                    <label for="rank" class="col-md-4 col-lg-3 col-form-label">직급</label>
                                    <div class="col-md-8 col-lg-9">
                                        <select class="form-select" name="rank_name">
                                            <option value="RANK003" ${employeeVo.rank_name == '부장' ? 'selected' : ''}>부장</option>
                                            <option value="RANK004" ${employeeVo.rank_name == '과장' ? 'selected' : ''}>과장</option>
                                            <option value="RANK005" ${employeeVo.rank_name == '대리' ? 'selected' : ''}>대리</option>
                                            <option value="RANK006" ${employeeVo.rank_name == '사원' ? 'selected' : ''}>사원</option>
                                           
                                        </select>
                                    </div>
                                </div>

                                <!-- 직책 수정 -->
                                <div class="row mb-3">
                                    <label for="lead" class="col-md-4 col-lg-3 col-form-label">직책</label>
                                    <div class="col-md-8 col-lg-9">
                                        <select class="form-select" name="emp_lead">
                                            <option value="N" ${employeeVo.emp_lead == '없음' ? 'selected' : ''}>없음</option>
                                            <option value="D" ${employeeVo.emp_lead == '본부장' ? 'selected' : ''}>본부장</option>
                                            <option value="T" ${employeeVo.emp_lead == '팀장' ? 'selected' : ''}>팀장</option>
                                            
                                        </select>
                                    </div>
                                </div>

                                <!-- 이메일 수정 -->
                                <div class="row mb-3">
                                    <label for="email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                                    <div class="col-md-8 col-lg-9">
                                        <input type="email" class="form-control" id="email" name="emp_email" value="${employeeVo.emp_email}">
                                    </div>
                                </div>

                              

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">수정 저장</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- End Bordered Tabs -->
                </div>
            </div>
            <%@ include file="/WEB-INF/views/common/footer.jsp"%>
        </div>
    </div>

    <!-- JavaScript for dynamically updating the team options -->
    <script>
 
	
 // 팀 목록을 본부별로 정의 (code와 name 포함)
    var teams = {
        "SPD": [
            { code: "BP", name: "경영기획팀" },
            { code: "HR", name: "인사총무팀" },
            { code: "BS", name: "사업전략팀" },
            { code: "FA", name: "재무회계팀" }
        ],
        "MBD": [
            { code: "CC", name: "콘텐츠제작팀" },
            { code: "PD", name: "프로듀싱팀" },
            { code: "GB", name: "글로벌비즈니스팀" },
            { code: "CT", name: "캐스팅팀" },
            { code: "TR", name: "트레이닝팀" }
        ],
        "PRD": [
            { code: "PR", name: "언론홍보팀" },
            { code: "VP", name: "영상제작팀" },
            { code: "MT", name: "마케팅팀" },
            { code: "AM", name: "광고마케팅팀" }
        ],
        "MGD": [
            { code: "ST", name: "가수팀" },
            { code: "AT", name: "배우팀" }
        ]
    };

    function updateTeams() {
        const divisionSelect = document.getElementById("division");
        const teamSelect = document.getElementById("team_code");
        const selectedDivision = divisionSelect.value;

        // 현재 선택된 팀 코드 가져오기
        const currentTeamCode = "${employeeVo.team_code}"; // 팀 코드로 비교해야 합니다.

        // 팀 선택 초기화
        teamSelect.innerHTML = "";

        // 해당 본부의 팀 목록 가져오기
        const teamsForDivision = teams[selectedDivision];

        // 팀 목록을 드롭다운에 추가
        for (const team of teamsForDivision) {
            const option = document.createElement("option");
            option.value = team.code; // 팀의 코드가 value로 사용됩니다.
            option.textContent = team.name; // 팀의 이름이 사용자에게 표시됩니다.

            // 현재 팀 코드와 일치하는 경우 선택 상태로 설정
            if (team.code === currentTeamCode) {
                option.selected = true;
            }

            teamSelect.appendChild(option);
        }
    }

    // 페이지 로드 시 초기화
    window.onload = updateTeams;
    
    var message = '${message}';
	if(message && message.trim()!==""){
		toastr.info(message);
	}

    </script>
</body>
</html>
