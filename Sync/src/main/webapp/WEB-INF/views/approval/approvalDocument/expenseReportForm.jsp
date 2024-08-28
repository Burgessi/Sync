<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>

	<div class="container">
		
		<h4 style="text-align: center;">지출결의서</h4>
			<div>
				<div class="row">
					<div class="col-md-4">
						<table class="table table-bordered approval-table approval-drafter-info">
							<tr>
								<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안자</th>
								<td>
									<div id="requesterId">${loginVo.emp_name}</div>
								</td>
							</tr>
							<tr>
								<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안부서</th>
								<td>
									<div id="requesterTeam">${loginVo.team_name}</div>
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
				</div>
				
				<table class="table table-bordered approval-table" style="margin-top: 40px;">
					<tr>
						<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
						<td>
							<input type="hidden" name="documentType" value="지출결의서">
							<input class="approval-input form-control" type="text" id="title" name="title" placeholder="제목">
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
								<select class="form-control approval-input" id="expenseCategory1" name="expenseCategory1">
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
								<select class="form-control approval-input" id="expenseCategory2" name="expenseCategory2">
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
								<select class="form-control approval-input" id="expenseCategory3" name="expenseCategory3">
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
								<select class="form-control approval-input" id="expenseCategory4" name="expenseCategory4">
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
								<select class="form-control approval-input" id="expenseCategory5" name="expenseCategory5">
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

</body>
<script type="text/javascript">

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
		
		$(".expenseAmount").on("input", function(){

			let rawValue = $(this).val().replace(/,/g, '').replace(/\D/g, '');
			let formattedValue = rawValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			$(this).val(formattedValue);
		})
		
	});


</script>
</html>
	

