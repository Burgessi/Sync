<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<head>
<title>SYNC_Mypage</title>
<style>
.section {
	display: flex;
	flex-direction: row;
}

/* 사이드바 조정 */
#mypage-sidebar {
	flex-shrink: 0; /* 사이드바가 줄어들지 않도록 설정 */
	width: 300px; /* 사이드바의 고정된 너비 설정 */
}

/* 카드 조정 */
.card {
	flex-grow: 1; /* 카드가 남은 공간을 차지하도록 설정 */
	min-width: 300px;
	
}

.emp-info.pic {
    display: flex;               /* Flexbox 사용 */
    justify-content: center;    /* 가로 중앙 정렬 */
    align-items: center;        /* 세로 중앙 정렬 */

}

	

</style>
</head>
<body>
	<div id="app">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>

			<div class="page-heading">
				<div class="page-title">
					<div class="row">
						<div class="col-12 col-md-6 order-md-1 order-last mt-2 mb-4">
							<h3>마이페이지</h3>
						</div>
					</div>
				</div>
				<div class="page-content">
					<section class="section">
						<%@ include file="/WEB-INF/views/mypage/mypage-sidebar.jsp"%>
						<div class="card">
							<!-- 개인정보 조회 영역 -->
							<div class="card-header mt-1 py-3">
								<h4 class="mb-0">내 정보 조회</h4>
							</div>
							<div class="card-body" style="max-width: 900px">
								<section class="section d-flex">
									<div class="emp-info pic" style="width: 50%;" >
										
											<c:choose>
												<c:when test="${not empty loginDto.emp_profile_pic}">
													<img
														style="border-radius: 5%; width: 150px; height: 200px; object-fit: cover"
														src="${root}/resources/upload/profile/${loginMember.empProfile}"
														alt="이미지" />
												</c:when>
												<c:otherwise>
													<img
														style="border-radius: 5%; width: 150px; height: 200px; object-fit: cover"
														src="${root}/resources/img/member-imgs/cloud.jpeg"
														alt="profile" />
												</c:otherwise>
											</c:choose>
							
									</div>
									<div class="emp-info ">
										<table class="table">
										
											<tr>
												<td>이름</td>
												<td>${loginDto.emp_name}</td>
											</tr>
											<tr>
												<td>본부</td>
												<td>${loginDto.division_name }</td>
											</tr>
											<tr>
												<td>팀</td>
												<td>${loginDto.team_name }</td>
											</tr>
											<tr>
												<td>직급</td>
												<td>${loginDto.rank_name }</td>
											</tr>
											<tr>
												<td>입사일</td>
												<td><fmt:formatDate value="${loginDto.emp_hire_date}"
														pattern="yyyy-MM-dd" /></td>
											</tr>
											<tr>
												<td>주민등록번호</td>
												<td>${loginDto.emp_ssn }</td>
											</tr>
										</table>
									</div>
								</section>
							</div>
							<div>
								<!-- 개인정보 수정 영역 -->
								<div class="card-header mt-1 py-3">
									<h4 class="mb-0">개인정보 수정</h4>
								</div>
								<div class="card-body" style="max-width: 900px">
									<section class="section d-flex">
										<div class="emp-info change" style="width: 100%;">
											<form id="updateForm" >
												<table class="table">
													<tr>
														<td style="width: 15%;">이메일</td>
														<td>
															<!-- 이메일을 '@'를 기준으로 분리 --> 
															<c:set var="emailId" value="${fn:substringBefore(loginDto.emp_email, '@')}" />
															<c:set var="emailDomain" value="${fn:substringAfter(loginDto.emp_email, '@')}" />

															<!-- 아이디 부분을 input 필드에 초기화 --> 
															<input type="text" name="emailId" value="${emailId}" style="width: 100px;"/> @ 
															<!-- 도메인 부분을 select 필드에 초기화 -->
															<select name="emailDomain">
																<option value="gmail.com"
																	${emailDomain == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
																<option value="naver.com"
																	${emailDomain == 'naver.com' ? 'selected' : ''}>naver.com</option>
																<option value="daum.net"
																	${emailDomain == 'daum.net' ? 'selected' : ''}>daum.net</option>
																<option value="yahoo.com"
																	${emailDomain == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
																<option value="custom"
																	${emailDomain != 'gmail.com' && emailDomain != 'naver.com' && emailDomain != 'daum.net' && emailDomain != 'yahoo.com' ? 'selected' : ''}>--직접입력--</option>
															</select> 
															<!-- 사용자 지정 도메인을 위한 input field --> 
															<input type="text" name="customDomain" value="${emailDomain}" 
																style="display: ${emailDomain != 'gmail.com' && emailDomain != 'naver.com' && emailDomain != 'daum.net' && emailDomain != 'yahoo.com' ? 'inline-block' : 'none'};"
																id="customDomainInput" />
														</td>
													</tr>
													<tr>
														<td>휴대전화</td>
														<td>
															<c:set var="phone1" value="${fn:substring(loginDto.emp_phone,0,3) }"/>
															<c:set var="phone2" value="${fn:substring(loginDto.emp_phone,3,7) }"/>
															<c:set var="phone3" value="${fn:substring(loginDto.emp_phone,7,11) }"/>
															<input type="tel" name="phone1" value="${phone1}" maxlength="3" style="width: 55px;"> - 
															<input type="tel" name="phone2" value="${phone2}"maxlength="4" style="width: 55px;"> - 
															<input type="tel" name="phone3" value="${phone3}"maxlength="4" style="width: 55px;">
														</td>
													</tr>
													<tr>
														<td>주소</td>
														<td>
															<input type="button" onclick="sample6_execDaumPostcode()" value="주소 검색" class="d_btn"><br>
															<input type="text" name="addressLine1" id="sample6_address" class="d_form large" placeholder="주소" value="${loginDto.addr1}"><br>
															<input type="text" name="addressLine2" id="sample6_detailAddress" class="d_form" placeholder="상세주소" value="${loginDto.addr2}">
															<input type="text" id="sample6_extraAddress" class="d_form" placeholder="참고항목">
														</td>
													</tr>
												</table>
												 <button type="button" onclick="updateInfo()">저장</button>
<!-- 												<input type="button" value="수정"> -->
											</form>
										</div>
									</section>
								</div>
							</div>
							<div>
								<!-- 급여 계좌 영역 -->
								<div class="card-header mt-1 py-3">
									<h4 class="mb-0">급여 계좌 설정</h4>
								</div>
								<div class="card-body" style="max-width: 900px">
									<section class="section d-flex">
										<div class="emp-info change" style="width: 100%;">
											<form action="updateEmployeeEmail" method="post">
												<table class="table">
													<tr>
														<td style="width: 50%;">은행명</td>
														<td>
															<input type="text" value="${loginDto.bank_name }">
														</td>
													</tr>
													<tr>
														<td>계좌번호</td>
														<td>
															<input type="tel" value="${loginDto.account_num }">
														</td>
													</tr>
													<tr>
														<td>예금주</td>
														<td>
															<input type="text" value="${loginDto.account_holder }">
														</td>
													</tr>
													<tr>
														<td>예금주와의 관계</td>
														<td>
															<input type="text" value="${loginDto.relation_to_emp }">
														</td>
													</tr>
												</table>
												<input type="button" value="수정">
											</form>
										</div>
									</section>
								</div>
							</div>
							<div>
								<!-- 비밀번호 영역 -->
								<div class="card-header mt-1 py-3">
									<h4 class="mb-0">비밀번호 변경</h4>
								</div>
								<div class="card-body" style="max-width: 900px">
										<div class="emp-password" style="width: 100%;">
											 <form id="emp-passwordChangeForm" action="" method="post">
						                        <div class="mb-3">
						                            <label for="newPassword" class="form-label">새 비밀번호</label>
						                            <input type="password" class="form-control" id="newPassword" name="newPassword" required style="width: 50%">
						                        </div>
						                        <div class="mb-3">
						                            <label for="confirmPassword" class="form-label">비밀번호 확인</label>
						                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required style="width: 50%">
						                        </div>
						                        <input type="button" value="변경"/>
						                    </form>
										</div>
								</div>
								<!-- 연차 영역 -->
								<div class="card-header mt-1 py-3">
									<h4 class="mb-0">연차 조회</h4>
								</div>
								<div class="card-body" style="max-width: 900px">
										<div class="emp-off" style="width: 100%;">
											<table class="table">
												<thead>
													<tr>
														<td>총 연차</td>
														<td>사용 연차</td>
														<td>잔여 연차</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>${loginDto.total_off }</td>
														<td>${loginDto.used_off }</td>
														<td>${loginDto.total_off - loginDto.used_off }</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="emp-off-history" style="width: 100%;">
											<h5>연차 사용 내역</h5>
											<table class="table">
												<thead>
													<tr>
														<td>No.</td>
														<td>연차사용일자</td>
														<td>내용</td>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="vo" items="${offVo}" varStatus="vs">
														<tr>
															<td>${fn:length(offVo) - vs.index}</td>
															<td>
																<fmt:formatDate value="${vo.off_date}" pattern="yyyy-MM-dd" />
														</td>
															<td>${vo.off_reason }</td>
															
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
<script>
	const selectElement = document.querySelector('select[name="emailDomain"]');
	const customDomainInput = document.getElementById('customDomainInput');

	selectElement.addEventListener('change', function() {
		if (this.value === 'custom') {
			customDomainInput.style.display = 'inline-block';
			customDomainInput.value = '';
		} else {
			customDomainInput.style.display = 'none';
			customDomainInput.value = this.value;
		}
	});
</script>

<script>
var themeObj = {
		   bgColor: "#FFE1E9", //바탕 배경색
		   //searchBgColor: "", //검색창 배경색
		   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
		   //pageBgColor: "", //페이지 배경색
		   //textColor: "", //기본 글자색
		   //queryTextColor: "", //검색창 글자색
		   //postcodeTextColor: "", //우편번호 글자색
		   emphTextColor: "#C01160" //강조 글자색
		   //outlineColor: "", //테두리
		};
		
    function sample6_execDaumPostcode() {
        new daum.Postcode({
        	theme: themeObj,
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
//                 document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script>
function updateInfo() {
    // 이메일 아이디와 도메인 결합
    const emailId = document.querySelector('input[name="emailId"]').value;
    const emailDomain = document.querySelector('select[name="emailDomain"]').value;
    const customDomain = document.querySelector('input[name="customDomain"]').value;
    const email = emailDomain === 'custom' ? `${emailId}@${customDomain}` : `${emailId}@${emailDomain}`;

    //전화번호 결합
    const phone1 = document.querySelector('input[name="phone1"]').value;
    const phone2 = document.querySelector('input[name="phone2"]').value;
    const phone3 = document.querySelector('input[name="phone3"]').value;
    const phone = `${phone1}${phone2}${phone3};
    
    // 폼 데이터 수집
    const formData = new FormData();
    formData.append('email', email);
    formData.append('phone', phone);
    formData.append('addressLine1', document.querySelector('input[name="addressLine1"]').value);
    formData.append('addressLine2', document.querySelector('input[name="addressLine2"]').value);

    // AJAX 요청
    fetch('/updateMyInfo', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('정보가 성공적으로 업데이트되었습니다.');
        } else {
            alert('정보 업데이트에 실패하였습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('정보 업데이트 중 오류가 발생하였습니다.');
    });
}

// 이메일 도메인 변경 시 사용자 지정 도메인 입력 필드의 표시 상태 조정
document.querySelector('select[name="emailDomain"]').addEventListener('change', function() {
    const customDomainInput = document.getElementById('customDomainInput');
    if (this.value === 'custom') {
        customDomainInput.style.display = 'inline-block';
        customDomainInput.value = '';
    } else {
        customDomainInput.style.display = 'none';
        customDomainInput.value = this.value;
    }
});
</script>
