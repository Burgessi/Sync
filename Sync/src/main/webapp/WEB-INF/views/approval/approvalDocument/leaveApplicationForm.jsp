<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>	
<body>


	<div class="container">
		
		<h4 style="text-align: center;">휴가신청서</h4>
		
		<div>
						
				<div class="row">
					<div class="col-md-4">
						
					
						<table class="table table-bordered approval-table approval-drafter-info">
							<tr>
								<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안자</th>
								<td>
									<div id="requesterId">${infoDto.emp_name}</div>
								</td>
							</tr>
							<tr>
								<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안부서</th>
								<td>
									<div id="requesterTeam">${infoDto.team_name}</div>
								</td>
							</tr>
							<tr>
								<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안일</th>
								<td>
									<div id="requsterDate"></div>
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
							<input type="hidden" name="documentType" value="휴가신청서">
							<input class="approval-input form-control" type="text" id="title" name="title" placeholder="제목">
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
								     <input style="display: inline; width: 100px; text-align: center;" type="text" id="remainingLeave" name='remainingLeave' class="form-control approval-input" readonly="readonly" value="${infoDto.total_off}">
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


</body>


<script type="text/javascript">
	//폼
	var frm = $("form")[0];
	
	$(document).ready(function(){
		
		// datepicker 설정
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
			
			$('#startDate').datepicker('setDate', 'today');        

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
		
		
// 		$("#endDate").on("change",function(){
			
// 			var startDate = $("#startDate").datepicker("getDate");
// 			var endDate = $("#endDate").datepicker("getDate");
			
// 			endDate.setTime(endDate.getTime() + (1000 * 3600 * 9));
			
// 			console.log(startDate);
// 			console.log(endDate);
			
			
// 			//밀리초
// 			var ms = endDate - startDate;
			
// 			var totalDay = Math.ceil(ms/(1000 * 3600 * 24));
// 			console.log(totalDay);
// // 			var totalDay = startDate - endDate;
// 			$("#totalDay").val(totalDay);
// 			$("#applicationLeave").val(totalDay);
			
			
// 			console.log(totalDay);
// 		});
		
		
		
		
		
	});
	
	
	
	
	
	
	
		
</script>
</html>