<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>출장보고서 수정</title>
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
							
							<h4 style="text-align: center;">출장보고서</h4>
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
												<input type="hidden" name="documentType" value="출장보고서">
												<input class="approval-input form-control" type="text" id="title" name="title" placeholder="제목" value="${approval.approval_title}">
											</td>
										</tr>
										<tr>
											<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장지</th>
											<td>
												<input autocomplete="off" class="form-control datepicker approval-input" type="text" id="businessTripDestination" name="businessTripDestination" placeholder="출장지">
											</td>
										</tr>
										<tr>
											<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장기간</th>
											<td>
												<div style="display: inline-flex;">
													<div class="input-group">
													     <input type="text" autocomplete="off" id="startDate" name="startDate" class="form-control datepicker approval-input" placeholder="시작날짜">
													</div>
														<span>~</span>
													<div class="input-group">
													     <input type="text" style="margin-left: 10px;" autocomplete="off" id="endDate" name="endDate" class="form-control datepicker approval-input" placeholder="종료날짜">
													</div>
												</div>
												<div style="display: inline-flex;">
													<span style="display: inline-flex;"> (<input type="text" id="totalDay" name='totalDay' class="form-control approval-input" readonly="readonly" style="width: 70px; margin-left:10px; text-align: center;">) </span>&nbsp;일
												</div>
											</td>
										</tr>
										<tr>
											<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장목적</th>
											<td>
												<input autocomplete="off" class="form-control datepicker approval-input" type="text" id="businessTripPurpose" name="businessTripPurpose" placeholder="출장목적">
											</td>
										</tr>
									</table>
									
									<div>
										<h5>보고사항</h5>
										<table class="table table-bordered approval-table">
											<tr>
												<th>항목</th>
												<th>내용</th>
												<th>비고</th>
											</tr>
											<tr>
												<td><input type="text" autocomplete="off" id="reportItem1" name="reportItem1" class="form-control datepicker approval-input"> </td>
												<td><input type="text" autocomplete="off" id="contentDetails1" name="contentDetails1" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="additionalRemarks1" name="additionalRemarks1" class="form-control datepicker approval-input"></td>
											</tr>
											<tr>
												<td><input type="text" autocomplete="off" id="reportItem2" name="reportItem2" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="contentDetails2" name="contentDetails2" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="additionalRemarks2" name="additionalRemarks2" class="form-control datepicker approval-input"></td>
											</tr>
											<tr>
												<td><input type="text" autocomplete="off" id="reportItem3" name="reportItem3" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="contentDetails3" name="contentDetails3" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="additionalRemarks3" name="additionalRemarks3" class="form-control datepicker approval-input"></td>
											</tr>
											<tr>
												<td><input type="text" autocomplete="off" id="reportItem4" name="reportItem4" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="contentDetails4" name="contentDetails4" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="additionalRemarks4" name="additionalRemarks4" class="form-control datepicker approval-input"></td>
											</tr>
											<tr>
												<td><input type="text" autocomplete="off" id="reportItem5" name="reportItem5" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="contentDetails5" name="contentDetails5" class="form-control datepicker approval-input"></td>
												<td><input type="text" autocomplete="off" id="additionalRemarks5" name="additionalRemarks5" class="form-control datepicker approval-input"></td>
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

// input의 값이 변경됐는지 확인하기.
function valueChangeCheck(data) {
	
	// 제목, 휴가사유
	
	var approvalTitle = '${approval.approval_title}'; //공통
	var approvalContent = jsonData.content; //공통
	var title = $("#title").val(); //공통
	
	
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

// input 태그 name 가져와서 db 내용과 일치하는 input에 value 넣기
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
		
		//로드 후 값 입력
		inputValue(jsonData);
		
		
		$(function() {
			$("#startDate").datepicker({
				showOtherMonths: true,
				changeMonth: true,
				maxDate: "+1Y",
				onSelect : function() {
					UpdateWeekdays();
                },
				beforeShowDay: function(date){				
					var day = date.getDay();				
					return [(day != 0 && day != 6)];			
				}	
			});
			
			language: 'ko';

		});
		
		
		$(function() {
			$("#endDate").datepicker({
				showOtherMonths: true,
				changeMonth: true,
				maxDate: "+1Y",
				onSelect : function() {
					UpdateWeekdays();
                },
				beforeShowDay: function(date){				
					var day = date.getDay();				
					return [(day != 0 && day != 6)];			
				}	
			});
			language: 'ko';
		});
		
		
		// 주말 제외 일자 count
		function calculateWeekdays(startDate, endDate) {
            let count = 0;
            let currentDate = new Date(startDate);

          //시작날짜가 마지막날짜보다 작거나 같을때까지 반복
            while (currentDate <= endDate) { 
                let dayOfWeek = currentDate.getDay();
                
                if (dayOfWeek != 0 && dayOfWeek != 6) {
                    //주말이 아닐때만 count +1씩
                	count++;
                }
                currentDate.setDate(currentDate.getDate() + 1);
            }
            return count;
        }
		
		
		 //datepicker 요일 업데이트
		 function UpdateWeekdays() 	{
			 let startDate = $("#startDate").datepicker("getDate");
             let endDate = $("#endDate").datepicker("getDate");

             if (startDate && endDate) {
                 startDate = new Date(startDate);
                 endDate = new Date(endDate);

                 if (startDate > endDate) {
                	 toastr.error("종료날짜는 시작날짜 이후로 선택해주세요.");
                	 $('#startDate').datepicker('setDate', 'today');
                	 $("#endDate").datepicker("setDate", null);
                	 $("#totalDay").val("");
                	 $("#startDate").blur();
                 } else {
                     let weekdays = calculateWeekdays(startDate, endDate);
                     $("#totalDay").val(weekdays);
                 }
       		  }   
		 }
		
		
		
	});
	
	
</script>
</html>