<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>휴가신청서 수정</title>
</head>
<body>
	<form id="modifyForm" method="post">
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
		
			
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
							<c:otherwise>
								<div style="text-align: right;">
									<input type="hidden" name="requester_id" value="${approval.requester_id}">
									<input type="hidden" name="temp_save_flag" value="${approval.temp_save_flag}">
									<button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#approvalLineModal">결재선</button>
									<button type="button" class="btn btn-sm btn-secondary" onclick="approvalRequestee(event)">결재 상신</button>
								</div>
							</c:otherwise>
						</c:choose>
						
						<h4 style="text-align: center;">휴가신청서</h4>
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
								<div class="col-md-3"></div>
								<div class="col-md-5">
								</div>					
							</div>
							
							<table class="table table-bordered approval-table" style="margin-top: 40px;">
								<tr>
									<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
									<td>
										<input type="hidden" name="approvalId" value="${approval.approval_id}">
										<input type="hidden" name="documentType" value="휴가신청서">
										<input class="approval-input form-control" type="text" id="title" name="title" placeholder="제목" value="${approval.approval_title}">
									</td>
								</tr>
								<tr>
									<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">휴가기간</th>
									<td>
										<div style="display: inline-flex;">
											<div class="input-group">
											     <input type="text" autocomplete="off" id="startDate" name="startDate" class="form-control datepicker approval-input" placeholder="시작날짜">
											</div>
												<span>~</span>
											<div class="input-group">
											     <input type="text" autocomplete="off" id="endDate" style="margin-left: 10px;"  name="endDate" class="form-control datepicker approval-input" placeholder="종료날짜">
											</div>
										</div>
										<div style="display: inline-flex;">
											<span style="display: inline-flex;"> (총<input type="text" id="totalDay" name='totalDay' class="form-control approval-input" readonly="readonly" style="width: 70px; margin-left:10px; text-align: center;">일) </span>
										</div>
									</td>
								</tr>
								<tr>
									<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">연차일수</th>
									<td>
										
										<div>
											<div style="display: inline;">
												<span style="font-size: 0.8em; margin-left: 10px;">잔여연차:&nbsp;</span>
											</div>
											<div class="input-group" style="width: 200px; display: inline;">
											     <input style="display: inline; width: 100px; text-align: center;" type="text" id="remainingLeave" name='remainingLeave' class="form-control approval-input" readonly="readonly" value="${loginVo.total_off}">
											</div>
											
											<div style="display: inline;">
												<span style="font-size: 0.8em;"	>&nbsp;신청연차:&nbsp;</span>
											</div>
											
											<div class="input-group" style=" width: 200px; display: inline;">
											     <input style="display: inline; width: 100px; text-align: center;" type="text" id="applicationLeave" name='applicationLeave' class="form-control approval-input" readonly="readonly">
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">휴가사유</th>
									<td>
										<textarea rows="5" class="approval-input form-control" id="content" name="content" style="resize: none;" placeholder="휴가사유를 입력해주세요."></textarea>
									</td>
								</tr>
								<tr>
									<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">첨부파일</th>
									<td>
										<input type="file" class="form-control" style="font-size: 0.8em;">
									</td>
								</tr>
							</table>
						
					</div>
					
				</div>
				
			
			</div>
		</div>
	</div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <div class="modal fade" tabindex="-1" role="dialog" id="approvalLineModal">
			 <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
				 <div class="modal-content rounded-4 shadow">
						<div class="modal-header p-5 pb-4 border-bottom-0">
							<h4 class="fw-bold mb-0 fs-4">결재선 지정</h4>
<!-- 							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
						</div>
						<div class="modal-body p-5 pt-0">
							<jsp:include page="../approvalTree.jsp"></jsp:include>
							<div style="text-align: right; margin-top: 5px; margin-right: 5px;">
								<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
								<button type="button" id="lineRemoveBtn" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
						
				</div>
			</div>
		</div>
    
    </form>
    
    
</body>
<script src="${root}/resources/js/approvalTree.js"></script>
<script type="text/javascript">
	
	//json데이터
	var jsonData = ${approval.approval_content};
	
	// input의 값이 변경됐는지 확인하기.
	function valueChangeCheck(data) {
		
		// 제목, 휴가사유
		
		var approvalTitle = '${approval.approval_title}';
		var approvalContent = jsonData.content;
		var title = $("#title").val();
		var content = $("#content").val();
		
		
		let changeChk = "N"	
		console.log(approvalTitle);	
		console.log(approvalContent);	
		console.log(title);	
		console.log(content);	
		
		
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
	    
	    if(approvalContent != content){
	    	console.log("휴가사유 변화발견");
	    	changeChk = "Y";
	    }
	    
		console.log("바깥")
	    console.log(changeChk);
	    return changeChk;
	}
	
	
	
	//수정완료 버튼
	function modify(event){
		event.preventDefault();
		let frm = $("#modifyForm");
		
		if(valueChangeCheck(jsonData)=="N"){
			toastr.error("변경된 내용이 없습니다.");
			return;
		} else{
			frm.attr("action","./modifyApproval.do")
			frm.submit();
		}
		
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
	
	
	$(document).ready(function(){
		
		//로드 후 값 입력
		inputValue(jsonData);
		
		//사유는 textarea로 따로 입력..
		$("#content").text(jsonData.content);
		
		$(function() {
			$("#startDate").datepicker({
				showOtherMonths: true,
				changeMonth: true,
				minDate: "0",
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
				minDate: "0",
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
                	 $("#applicationLeave").val("");
                	 $("#totalDay").val("");
                	 $("#startDate").blur();
                 } else {
                     let weekdays = calculateWeekdays(startDate, endDate);
                     $("#applicationLeave").val(weekdays);
                     $("#totalDay").val(weekdays);
                 }
       		  }   
		 }
		
		
	})

	
	
	
	//jstree 및 form 요청 
	
	
	
	
</script>
</html>