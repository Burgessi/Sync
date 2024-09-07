<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<div>
	<!-- 개인정보 수정 영역 -->
	<div class="card-header mt-1 py-3">
		<h4 class="mb-0">개인정보 수정</h4>
	</div>
	<div class="card-body" style="max-width: 900px">
		<section class="section d-flex">
			<div class="emp-info change" style="width: 100%;">
<!-- 				<form id="updateForm" action="./updateMyInfo.do" method="post"> -->
				<form id="updateForm" class="form-horizontal" >
					<table class="form-horizontal" >
						<tr>
							<td style="width: 210px;">이메일</td>
							<td>
								<!-- 이메일을 '@'를 기준으로 분리 --> 
								<c:set var="emailId" value="${fn:substringBefore(infoDto.emp_email, '@')}" /> 
								<c:set var="emailDomain" value="${fn:substringAfter(infoDto.emp_email, '@')}" /> 
								<!-- 아이디 부분을 input 필드에 초기화 -->
								<input class="form-control" type="text" name="emailId" value="${emailId}" style="width: 150px; display: inline; margin: 5px 5px 5px 0px;" /> @ 
								<!-- 도메인 부분을 select 필드에 초기화 --> 
								<select class="form-select" name="emailDomain" style="width:150px; display: inline; margin: 5px 5px 5px 0px;">
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
								</select> <!-- 사용자 지정 도메인을 위한 input field --> 
								<input class="form-control" type="text" name="customDomain" value="${emailDomain}"
									style=" margin: 5px 5px 5px 0px; display: ${emailDomain != 'gmail.com' && emailDomain != 'naver.com' && emailDomain != 'daum.net' && emailDomain != 'yahoo.com' ? 'inline' : 'none'};"
									id="customDomainInput" />
							</td>
						</tr>
						<tr>
							<td>휴대전화</td>
							<td>
								<c:set var="phone1" value="${fn:substring(infoDto.emp_phone,0,3) }" /> 
								<c:set var="phone2" value="${fn:substring(infoDto.emp_phone,3,7) }" />
								<c:set var="phone3" value="${fn:substring(infoDto.emp_phone,7,11) }" /> 
								<input class="form-control" type="tel" name="phone1" value="${phone1}" maxlength="3" style="width: 55px; display: inline; margin: 5px 5px 5px 0px;"> - 
								<input class="form-control" type="tel" name="phone2" value="${phone2}" maxlength="4" style="width: 55px; display: inline; margin: 5px 5px 5px 0px;"> -
								<input class="form-control" type="tel" name="phone3" value="${phone3}" maxlength="4" style="width: 55px; display: inline; margin: 5px 5px 5px 0px;">
							</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>
								
								<input class="form-control" type="text" name="addr1" id="sample6_address" class="d_form large" placeholder="주소" value="${infoDto.addr1}" style="width: 250px; display: inline; margin: 5px 5px 5px 0px;">
								<input  type="button" onclick="sample6_execDaumPostcode()" value="주소 검색" class="form-control btn-secondary" style="width: 100px; display: inline; margin: 5px 5px 5px 0px;"><br>
								<input class="form-control" type="text" name="addr2" id="sample6_detailAddress" class="d_form" placeholder="상세주소" value="${infoDto.addr2}" style="width: 250px; display: inline; margin: 5px 5px 5px 0px;">
								<input class="form-control" type="text" id="sample6_extraAddress" class="d_form" placeholder="참고항목" style="width: 150px; display: inline;  margin: 5px 5px 5px 0px;">
							</td>
						</tr>
					</table>
					<div style="text-align: right; margin-top: 10px;">
					<button class="btn btn-primary" type="button" id="submitBtn">수정</button>
					</div>
				</form>
			</div>
		</section>
	</div>
</div>

<script>
	const selectElement = document.querySelector('select[name="emailDomain"]');
	const customDomainInput = document.getElementById('customDomainInput');

	selectElement.addEventListener('change', function() {
		if (this.value === 'custom') {
			customDomainInput.style.display = 'inline';
			customDomainInput.value = '';
		} else {
			customDomainInput.style.display = 'none';
			customDomainInput.value = this.value;
		}
	});
</script>


<script>
var themeObj = {
		   bgColor: "#223055", //바탕 배경색
		   //searchBgColor: "", //검색창 배경색
		   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
		   //pageBgColor: "", //페이지 배경색
		   //textColor: "", //기본 글자색
		   //queryTextColor: "", //검색창 글자색
		   //postcodeTextColor: "", //우편번호 글자색
		   emphTextColor: "#223055" //강조 글자색
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
$(document).ready(function(){
    $('#submitBtn').on('click', function() {
        var formData = $('#updateForm').serialize();  // 폼 데이터를 시리얼라이즈하여 문자열로 변환

        $.ajax({
            type: 'POST',
            url: './updateMyInfo.do',  // 경로를 명확하게 설정
            data: formData,
            success: function(response) {
                toastr.success('정보가 성공적으로 업데이트되었습니다!');
            },
            error: function(xhr, status, error) {
                toastr.error('업데이트 중 오류가 발생했습니다: ' + error);
                console.log(xhr.responseText); // 에러 상세 로그
            }
        });
    });
});
</script>


<script>
// $(document).ready(function(){
//     $('#submitBtn').on('click', function() {
//         var formData = $('#updateForm').serialize();  // 폼 데이터를 시리얼라이즈하여 문자열로 변환

//         $.ajax({
//             type: 'POST',
//             url: './updateMyInfo.do',  // 경로를 명확하게 설정
//             data: formData,
//             success: function(response) {
//                 alert('정보가 성공적으로 업데이트되었습니다!');
//             },
//             error: function(xhr, status, error) {
//                 alert('업데이트 중 오류가 발생했습니다: ' + error);
//                 console.log(xhr.responseText); // 에러 상세 로그
//             }
//         });
//     });
// });


</script>
<script>
$(document).ready(function () {
    $('body').scrollspy({ target: '#simple-list-example' });
});

</script>   