<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>지출결의서 수정</title>
</head>
<body>
	<div id="app">
			<!-- 사이드바 include -> 메뉴 이동 -->
	      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
			<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
	        <%@ include file="/WEB-INF/views/common/header.jsp" %>
	        <form id="modifyForm" action="./modifyApproval.do" method="post">
				<div class="container">
					<div class="card">
						<div class="card-body">
							<c:choose>
							<c:when test="${approval.temp_save_flag eq 'N'}">
								<div style="text-align: right;">
									<input type="hidden" name="requester_id" value="${approval.requester_id}">
									<input type="hidden" name="temp_save_flag" value="${approval.temp_save_flag}">
									<button id="modifyApproval" class="btn btn-sm btn-primary" onclick="modify(event)">완료</button>
								</div>	
							</c:when>
						</c:choose>
								<h4 style="text-align: center;">지출결의서</h4>
									<div>
										<div class="row">
											<div class="col-md-4">
												<table class="table table-bordered approval-table approval-drafter-info">
													<tr>
														<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안자</th>
														<td>
															<div id="requesterId">${approval.requester_name}</div>
														</td>
													</tr>
													<tr>
														<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안부서</th>
														<td>
															<div id="requesterTeam">${approval.team_name}</div>
														</td>
													</tr>
													<tr>
														<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안일</th>
														<td>
															<div id="requsterDate">${approval.request_date}</div>
														</td>
													</tr>
												</table>
											</div>
										</div>
										
										<table class="table table-bordered approval-table" style="margin-top: 40px;">
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
												<td>
													<input type="hidden" name="approvalId" value="${approval.approval_id}">
													<input type="hidden" name="documentType" value="지출결의서">
													<input class="approval-input form-control" type="text" id="title" name="title" placeholder="제목" value="${approval.approval_title}">
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">지출사유</th>
												<td>
													<textarea class="form-control approval-input" autocomplete="off" rows="5" style="resize: none;" id="expenseReason" name="expenseReason" placeholder="지출사유"></textarea>
												</td>
											</tr>
										</table>
										
										<div>
											<table class="table table-bordered approval-table">
												<tr>
													<th style="width: 15%">지출일자</th>
													<th style="width: 15%">지출구분</th>
													<th>지출내역</th>
													<th style="width: 15%">금액</th>
													<th style="width: 20%">비고</th>
												</tr>
												<tr>
													<td><input type="text" autocomplete="off" id="expenseDate1" name="expenseDate1" class="form-control expenseDate approval-input"></td>
													<td style="text-align: center;">
														<select class="form-control approval-input approval-select" id="expenseCategory1" name="expenseCategory1">
															<option style="color: #c4c4c4;" disabled selected>선택하세요</option>
															<option value="travel">출장비</option>
															<option value="officeSupplies">사무용품</option>
															<option value="training">교육 및 훈련비</option>
															<option value="meeting">회의비</option>
															<option value="welfare">복리후생비</option>
														</select>
													</td>
													<td><input type="text" autocomplete="off" id="expenseReport1" name="expenseReport1" class="form-control approval-input"></td>
													<td><input type="text" autocomplete="off" id="expenseAmount1" name="expenseAmount1" class="form-control expenseAmount approval-input" style="text-align: right;"></td>
													<td><input type="text" autocomplete="off" id="remarks1" name="remarks1" class="form-control approval-input"> </td>
												</tr>
												<tr>
													<td><input type="text" autocomplete="off" id="expenseDate2" name="expenseDate2" class="form-control expenseDate approval-input"></td>
													<td style="text-align: center;">
														<select class="form-control approval-input approval-select" id="expenseCategory2" name="expenseCategory2">
															<option style="color: #c4c4c4;" disabled selected>선택하세요</option>
															<option value="travel">출장비</option>
															<option value="officeSupplies">사무용품</option>
															<option value="training">교육 및 훈련비</option>
															<option value="meeting">회의비</option>
															<option value="welfare">복리후생비</option>
														</select>
													</td>
													<td><input type="text" autocomplete="off" id="expenseReport2" name="expenseReport2" class="form-control approval-input"></td>
													<td><input type="text" autocomplete="off" id="expenseAmount2" name="expenseAmount2" class="form-control expenseAmount approval-input" style="text-align: right;"></td>
													<td><input type="text" autocomplete="off" id="remarks" name="remarks" class="form-control approval-input"> </td>
												</tr>
												<tr>
													<td><input type="text" autocomplete="off" id="expenseDate3" name="expenseDate3" class="form-control expenseDate approval-input"></td>
													<td style="text-align: center;">
														<select class="form-control approval-input approval-select" id="expenseCategory3" name="expenseCategory3">
															<option style="color: #c4c4c4;" disabled selected>선택하세요</option>
															<option value="travel">출장비</option>
															<option value="officeSupplies">사무용품</option>
															<option value="training">교육 및 훈련비</option>
															<option value="meeting">회의비</option>
															<option value="welfare">복리후생비</option>
														</select>
													</td>
													<td><input type="text" autocomplete="off" id="expenseReport3" name="expenseReport3" class="form-control approval-input"></td>
													<td><input type="text" autocomplete="off" id="expenseAmount3" name="expenseAmount3" class="form-control expenseAmount approval-input" style="text-align: right;"></td>
													<td><input type="text" autocomplete="off" id="remarks3" name="remarks3" class="form-control approval-input"> </td>
												</tr>
												<tr>
													<td><input type="text" autocomplete="off" id="expenseDate4" name="expenseDate4" class="form-control expenseDate approval-input"></td>
													<td style="text-align: center;">
														<select class="form-control approval-input approval-select" id="expenseCategory4" name="expenseCategory4">
															<option style="color: #c4c4c4;" disabled selected>선택하세요</option>
															<option value="travel">출장비</option>
															<option value="officeSupplies">사무용품</option>
															<option value="training">교육 및 훈련비</option>
															<option value="meeting">회의비</option>
															<option value="welfare">복리후생비</option>
														</select>
													</td>
													<td><input type="text" autocomplete="off" id="expenseReport4" name="expenseReport4" class="form-control approval-input"></td>
													<td><input type="text" autocomplete="off" id="expenseAmount4" name="expenseAmount4" class="form-control expenseAmount approval-input" style="text-align: right;"></td>
													<td><input type="text" autocomplete="off" id="remarks4" name="remarks4" class="form-control approval-input"> </td>
												</tr>
												<tr>
													<td><input type="text" autocomplete="off" id="expenseDate5" name="expenseDate5" class="form-control expenseDate approval-input"></td>
													<td style="text-align: center;">
														<select class="form-control approval-input approval-select" id="expenseCategory5" name="expenseCategory5">
															<option style="color: #c4c4c4;" disabled selected>선택하세요</option>
															<option value="travel">출장비</option>
															<option value="officeSupplies">사무용품</option>
															<option value="training">교육 및 훈련비</option>
															<option value="meeting">회의비</option>
															<option value="welfare">복리후생비</option>
														</select>
													</td>
													<td><input type="text" autocomplete="off" id="expenseReport5" name="expenseReport5" class="form-control approval-input"></td>
													<td><input type="text" autocomplete="off" id="expenseAmount5" name="expenseAmount5" class="form-control expenseAmount approval-input" style="text-align: right;"></td>
													<td><input type="text" autocomplete="off" id="remarks5" name="remarks5" class="form-control approval-input"> </td>
												</tr>
											</table>
										</div>
										
								</div>
							
						
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">

//json데이터
var jsonData = ${approval.approval_content};


//input의 값이 변경됐는지 확인하기.
function valueChangeCheck(data) {
	
	// 제목, 휴가사유
	
	var approvalTitle = '${approval.approval_title}'; //공통
	var approvalContent = jsonData.content; //공통
	var title = $("#title").val(); //공통
	
	var expenseReason = $("#expenseReason").val(); //지출사유
	
	let changeChk = "N"	
	console.log(approvalTitle);	
	console.log(approvalContent);	
	console.log(title);	
	
	
  $("input").each(function() {
      // 현재 input 요소
      let input = $(this);
      
      // input 요소의 name 속성 가져오기
      let inputName = input.attr("name");	        
      // data 객체의 키 목록 가져오기
      let keys = Object.keys(data);
      
      if (keys.includes(inputName)) {
      
	        if (data[inputName] != input.val()) {
              console.log("변화발견", inputName);
              changeChk = "Y";
          } 
      }
      
  });
  
  
  if(approvalTitle != title){
  	console.log("제목 변화발견");
  	changeChk = "Y";
  }
  
  
	console.log("바깥")
  console.log(changeChk);
  return changeChk;
}

//수정완료 버튼
function modify(event){
	event.preventDefault();
	var frm = $("#modifyForm");
	
	if(valueChangeCheck(jsonData)=="N"){
		toastr.error("변경된 내용이 없습니다.");
		return;
	} else{
		frm.attr("action","./modifyApproval.do")
		frm.submit();
	}

}


//datepicker 설정
$(function() {
	$(".expenseDate").datepicker({
		showOtherMonths: true,
		changeMonth: true,
		maxDate: "+1Y",
		beforeShowDay: function(date){				
			var day = date.getDay();				
			return [(day != 0 && day != 6)];			
		}	
	});
	
	language: 'ko';
});


//input 태그 name 가져와서 db 내용과 일치하는 input에 value 넣기
	function inputValue(data){
		
		$("input").each(function() {
	        // 현재 input 요소
	        let input = $(this);
	        
	        // input 요소의 name 속성 가져오기
	        let inputName = input.attr("name");
	        
	        // JSON 데이터에서 해당 name 속성의 값 가져오기
	        if (data[inputName] !== undefined) {
	            // input 요소에 값 설정하기
	            input.val(data[inputName]);
	        }
	    });
		
		
	}
	
	
	$(document).ready(function(){
		console.log(jsonData);
		//로드 후 값 입력
		inputValue(jsonData);
		
		//지출사유 입력
		$("#expenseReason").text(jsonData.expenseReason);
		
		
		
		
		// 금액에 , 추가
		$(".expenseAmount").on("input", function(){
			let rawValue = $(this).val().replace(/,/g, '').replace(/\D/g, '');
			let formattedValue = rawValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			$(this).val(formattedValue);
		})
		
		
		//지출구분 선택하기.
		for(let i=1; i<=5; i++){
			var category = jsonData['expenseCategory' + i];
			if(category != undefined){
				$('#expenseCategory' + i).val(category);
				console.log(category);
			}
		}
		
		 
		
	});
</script>	
</html>