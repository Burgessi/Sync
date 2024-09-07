<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
        /* 기본적으로 customDomainInput 숨기기 */
        #customDomainInput {
            display: none;
        }
    </style>
<div>
	<!-- 급여 계좌 영역 -->
	<div class="card-header mt-1 py-3">
		<h4 class="mb-0" id="simple-list-item-3">급여 계좌 설정</h4>
		
	</div>
	<div class="card-body" style="max-width: 900px">
		<section class="section d-flex">
			<div class="emp-account" style="width: 100%;">
				<form class="form-horizontal" id="updateAccountForm">
					<table  class="form-horizontal">
						<tr>
							<td style="width: 210px;">은행명</td>
							<td>
							    <select class="form-select" name="bank_name" id="bankSelect" style="width: 200px; display: inline; margin: 5px 5px 5px 0px;">
							        <option value="국민은행" ${accDto.bank_name == '국민은행' ? 'selected' : ''}>국민은행</option>
							        <option value="우리은행" ${accDto.bank_name == '우리은행' ? 'selected' : ''}>우리은행</option>
							        <option value="하나은행" ${accDto.bank_name == '하나은행' ? 'selected' : ''}>하나은행</option>
							        <option value="농협은행" ${accDto.bank_name == '농협은행' ? 'selected' : ''}>농협은행</option>
							        <option value="custom" ${accDto.bank_name != '국민은행' && accDto.bank_name != '우리은행' && accDto.bank_name != '하나은행' && accDto.bank_name != '농협은행' ? 'selected' : ''}>--직접입력--</option>
							    </select>
							    <!-- 사용자 지정 도메인을 위한 input field --> 
							    <input class="form-control" type="text" name="customBankName" id="customBankNameInput" placeholder="ex)국민은행" style="display:none; width: 200px;" value="${accDto.bank_name }"/>
							
							</td>
						</tr>
						<tr>
							<td>계좌번호</td>
							<td><input class="form-control" style="width: 200px; display: inline; margin: 5px 5px 5px 0px;" name="account_num" type="tel" value="${accDto.account_num }">
							</td>
						</tr>
						<tr>
							<td>예금주</td>
							<td><input class="form-control" style="width: 200px; display: inline; margin: 5px 5px 5px 0px;" name="account_holder" type="text" value="${accDto.account_holder }">
							</td>
						</tr>
						<tr>
							<td>예금주와의 관계</td>
							<td><input class="form-control" style="width: 200px; display: inline; margin: 5px 5px 5px 0px;" name="relation_to_emp" type="text" value="${accDto.relation_to_emp }">
							</td>
						</tr>
					</table>
					 <div style="text-align: right; margin-top: 10px;">
		                <button class="btn btn-primary" type="button" id="accsubmitBtn">수정</button>
		            </div>
				</form>
			</div>
		</section>
	</div>
</div>
    

<script>
    $(document).ready(function() {
        // 'custom' 옵션이 선택되면 입력 필드를 보이게 하고, 그렇지 않으면 숨김
        $('#bankSelect').on('change', function() {
            if ($(this).val() === 'custom') {
                $('#customBankNameInput').show();
            } else {
                $('#customBankNameInput').hide();
            }
        });

        

        // 초기 로드 시 customBankNameInput 필드 표시 여부 결정
        if ($('#bankSelect').val() === 'custom') {
            $('#customBankNameInput').show();
        }
    });
</script>
    
 <script>
$(document).ready(function(){
    $('#accsubmitBtn').on('click', function() {
    	
        var formData_acc = $('#updateAccountForm').serialize();  // 폼 데이터를 시리얼라이즈하여 문자열로 변환

        $.ajax({
            type: 'POST',
            url: './updateMyAccount.do',  // 경로를 명확하게 설정
            data: formData_acc,
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