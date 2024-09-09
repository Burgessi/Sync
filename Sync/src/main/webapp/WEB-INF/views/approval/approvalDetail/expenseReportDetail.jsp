<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>지출결의서 상세</title>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
		
			
				
			<div class="container">
				<div class="card">
						
					<div class="card-body">
						<div style="text-align: right;">
							<c:if test="${approvalDetail.approval_status eq 0}">
							<c:choose>
								<c:when test="${loginDto.emp_id eq approvalDetail.requester_id && approvalDetail.temp_save_flag eq 'N'}">
									<button type="button" id="modifyApproval" class="btn btn-sm btn-primary">수정</button>
									<button type="button" id="deleteApproval" class="btn btn-sm btn-danger">회수</button>
								</c:when>
								<c:when test="${loginDto.emp_id != approvalDetail.requester_id && approvalDetail.temp_save_flag eq 'N'}">
									<c:forEach var="line" items="${approvalDetail.lineList}">
										<c:if test="${loginDto.emp_id eq line.recipient_id && line.step > 0 && line.status eq 0}">
											<button type="button" id="decisionApproval" onclick="decisionApprov('${line.signature}')" class="btn btn-sm btn-primary">승인</button>
											<button type="button" id="rejectionApproval" class="btn btn-sm btn-danger">반려</button>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<button type="button" id="continueTempApproval" class="btn btn-sm btn-outline-secondary">계속작성</button>
									<button type="button" id="deleteTempApproval" class="btn btn-sm btn-outline-danger">회수</button>
								</c:otherwise>
							</c:choose>
						</c:if>
						<!-- 결재완료상태 -->
						<c:if test="${approvalDetail.approval_status eq 1 && loginDto.emp_id eq approvalDetail.requester_id}">
							<button type="button" class="btn btn-outline-success" onclick="pdf('${approvalDetail.requester_name}')" style="margin-right: 10px;">pdf 저장</button> 
						</c:if>
							<input type="hidden" id="temp_save_flag" value="${approvalDetail.temp_save_flag}">
							<input type="hidden" id="approvalId" value="${approvalDetail.approval_id}">
						</div>		
			<div id="pdfDownload">						
						<h4 style="text-align: center;">지출결의서</h4>
							
							<div>
											
									<div class="row">
										<div class="col-md-4">
											<table class="table table-bordered approval-table approval-drafter-info">
												<tr>
													<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안자</th>
													<td id="requesterId">${approvalDetail.requester_name}</td>
												</tr>
												<tr>
													<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안부서</th>
													<td id="requesterTeam">${approvalDetail.team_name}</td>
												</tr>
												<tr>
													<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">기안일</th>
													<td id="requsterDate">${approvalDetail.request_date}</td>
												</tr>
											</table>
										</div>
										<div class="col-md-3"></div>
										
										
										<%-- 마지막 결재 라인의 상태에 따라 flag를 변경할 변수 선언 --%>
										<c:set var="isApproved" value="false" />
										<c:set var="isRejected" value="false" />
										
										<%-- 결재 라인의 마지막 항목 가져오기 --%>
										<c:set var="lastLine" value="${fn:length(approvalDetail.lineList) - 1}" />
										
										
										<div class="col-md-5" style="text-align: right; display: flex; justify-content: flex-end;">
												<c:forEach var="line" items="${approvalDetail.lineList}" varStatus="status">
													<!-- 결재라인 step1 서명 시작-->
													<c:if test="${line.step eq 1}">
														<div class="approval-line-signature">
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.rank_name}
															</div>
															<c:choose>
																<c:when test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<input type="hidden" id="lineFlag" value="false">
																	</div>
																</c:when>	
																<c:when test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isApproved" value="true" />
												                    </c:if>
																</c:when>	
																<c:when test="${line.status eq 2}">	
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isRejected" value="true" />
												                    </c:if>
																</c:when>
															</c:choose>	
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${line.approval_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>	
													<!-- 결재라인 step1 서명 끝 -->
													<!-- 결재라인 step2 서명 시작-->
													<c:if test="${line.step eq 2}">
														<div class="approval-line-signature">
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.rank_name}
															</div>
															<c:choose>
																<c:when test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<input type="hidden" id="lineFlag" value="false">
																	</div>
																</c:when>	
																<c:when test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isApproved" value="true" />
												                    </c:if>
																</c:when>	
																<c:when test="${line.status eq 2}">	
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isRejected" value="true" />
												                    </c:if>
																</c:when>
															</c:choose>	
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${line.approval_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>	
													<!-- 결재라인 3번 -->
													<c:if test="${line.step eq 3}">
														<div class="approval-line-signature">
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.rank_name}
															</div>
															<c:choose>
																<c:when test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<input type="hidden" id="lineFlag" value="false">
																	</div>
																</c:when>	
																<c:when test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isApproved" value="true" />
												                    </c:if>
																</c:when>	
																<c:when test="${line.status eq 2}">	
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
												                    <c:if test="${status.index eq lastLine}">
												                        <c:set var="isRejected" value="true" />
												                    </c:if>
																</c:when>
															</c:choose>	
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${line.approval_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>	
												</c:forEach>
											
												<c:if test="${approvalDetail.approval_status eq 0}">
												
												<!-- 결재상태 -->
												<c:choose>
												    <c:when test="${isApproved eq 'true'}">
												        <input type="hidden" id="approvalStatus" name="approvalStatus" value="1">
												    </c:when>
												    <c:when test="${isRejected eq 'true'}">
												        <input type="hidden" id="approvalStatus" name="approvalStatus" value="2">
												    </c:when>
												    <c:otherwise>
												        <input type="hidden" id="approvalStatus" name="approvalStatus" value="0">
												    </c:otherwise>
												</c:choose>
												</c:if>
											</div>
										</div>					
									</div>
									
									<div style="margin-top: 40px;">
										<table class="table table-bordered approval-table">
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
												<td>
													<input type="hidden" id="documentType" name="documentType" value="지출결의서">
													<span id="title">${approvalDetail.approval_title}</span>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">지출사유</th>
												<td>
													<textarea style="border:none; background: none; width:100%; height: 100px; resize: none; padding: 15px;" disabled id="expenseReason"></textarea>
<!-- 													<div style="height: 100px;" id="expenseReason"></div> -->
												</td>
											</tr>
										</table>
										<table class="table table-bordered approval-table businessTrip-table">
											<tr>
												<th style="width: 15%">지출일자</th>
												<th style="width: 15%">지출구분</th>
												<th>지출내역</th>
												<th style="width: 15%">금액</th>
												<th style="width: 20%">비고</th>
											<tr>
											<tr>
												<td id="expenseDate1"></td>
												<td id="expenseCategory1"></td>
												<td id="expenseReport1"></td>
												<td id="expenseAmount1"></td>
												<td id="remarks1"></td>
											</tr>
											<tr>
												<td id="expenseDate2"></td>
												<td id="expenseCategory2"></td>
												<td id="expenseReport2"></td>
												<td id="expenseAmount2"></td>
												<td id="remarks2"></td>
											</tr>
											<tr>
												<td id="expenseDate3"></td>
												<td id="expenseCategory3"></td>
												<td id="expenseReport3"></td>
												<td id="expenseAmount3"></td>
												<td id="remarks3"></td>
											</tr>
											<tr>
												<td id="expenseDate4"></td>
												<td id="expenseCategory4"></td>
												<td id="expenseReport4"></td>
												<td id="expenseAmount4"></td>
												<td id="remarks4"></td>
											</tr>
											<tr>
												<td id="expenseDate5"></td>
												<td id="expenseCategory5"></td>
												<td id="expenseReport5"></td>
												<td id="expenseAmount5"></td>
												<td id="remarks5"></td>
											</tr>
											
										</table>
									</div>
									
									<div style="margin-top: 30px;">
										<c:forEach var="list" items="${approvalDetail.lineList}">
											<c:if test="${list.status eq 2}">
												<h4>결재 의견</h4>
												<table class="table table-bordered approval-table">
													<tr>
														<th>결재자</th>
														<td>${list.recipient_name}</td>
													</tr>
													<tr>
														<th>반려 사유</th>
														<td>
															<textarea style="border:none; font:0.8em; background: none; width:100%; height: 150px; resize: none; padding: 15px;" disabled>${list.rejection}</textarea>
														</td>
													</tr>
												</table>
											</c:if>
										</c:forEach>
									</div>
									
								</div>
			
			
			
			
							</div>
					</div>				
				</div>
			
		
		</div>
	</div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <!-- 승인 모달 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="signatureModal" data-bs-backdrop="static">
			 <div class="modal-dialog modal-dialog-centered" role="document">
				 <div class="modal-content rounded-4 shadow">
					<div class="modal-header p-5 pb-4 border-bottom-0">
						<h4>서명 입력</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-5 pt-0" style="text-align: center;">
						<!--  -->
						<canvas id="signature" style="border: 1px solid #ddd;"></canvas>
						<br>
							<button id="clear-signature" class="btn btn-outline-danger">초기화</button>
							<button id="save-signature" class="btn btn-outline-secondary" value="${loginDto.emp_id}">승인</button>
						<!--  -->
				</div>
			</div>
		</div>
	</div>
	
	<!-- 반려모달 -->
	<div class="modal fade" tabindex="-1" role="dialog" id="rejectionModal" data-bs-backdrop="static">
			 <div class="modal-dialog modal-dialog-centered" role="document">
				 <div class="modal-content rounded-4 shadow">
				 	<form id="rejectionForm">
					<div class="modal-header p-5 pb-4 border-bottom-0">
						<h4>결재 의견 입력</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
					</div>
					<div class="modal-body p-5 pt-0" style="text-align: center;">
					
						<table class="table table-bordered">
							<tr>
								<th>결재자</th>
								<td>
									${infoDto.emp_name}
									<input type="hidden" name="emp_id" value="${approvalDetail.requester_id}">
									<input type="hidden" name="recipient_id" value="${infoDto.emp_id}">
									<input type="hidden" name="approval_id" value="${approvalDetail.approval_id}">
									<input type="hidden" name="document_type" value="${approvalDetail.document_type}">
								</td>
							</tr>
							<tr>
								<th style="vertical-align: middle;">결재 의견</th>
								<td>
									<textarea class="form-control" name="rejection" style="font-size: 0.8em; resize: none;" rows="7" cols="20"></textarea>
								</td>
							</tr>
						</table>
						<div style="text-align: right;">
							<button type="submit"  class="btn btn-outline-secondary">확인</button>
							<button type="button" id="rejectReset" class="btn btn-outline-danger" data-bs-dismiss="modal" aria-label="Close">취소</button>
						</div>
						<!--  -->
					</div>
					</form>	
			</div>
		</div>
	</div>
	
</body>
<script src="${root}/resources/js/approvalSign.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	var approvalContent = ${approvalDetail.approval_content};
	
	$("#expenseReason").text(approvalContent.expenseReason);
	
	$("#expenseDate1").text(approvalContent.expenseDate1);
	$("#expenseDate2").text(approvalContent.expenseDate2);
	$("#expenseDate3").text(approvalContent.expenseDate3);
	$("#expenseDate4").text(approvalContent.expenseDate4);
	$("#expenseDate5").text(approvalContent.expenseDate5);
	
	console.log(approvalContent.expenseCategory1);
	
	function getCategory1(){
		switch (approvalContent.expenseCategory1) {
	    case 'travel': return '출장비'
	    case 'officeSupplies': return '사무용품'
	    case 'training': return '교육 및 훈련비' 
	    case 'meeting': return '회의비' 
	    case 'welfare': return '복리후생비' 
	    default:
            return '알 수 없는 카테고리'; 
		}
	}
	
	function getCategory2(){
		switch (approvalContent.expenseCategory2) {
	    case 'travel': return '출장비' 
	    case 'officeSupplies': return '사무용품'
	    case 'training': return '교육 및 훈련비' 
	    case 'meeting': return '회의비' 
	    case 'welfare': return '복리후생비' 
		}
	}
	
	function getCategory3(){
		switch (approvalContent.expenseCategory3) {
	    case 'travel': return '출장비' 
	    case 'officeSupplies': return '사무용품' 
	    case 'training': return '교육 및 훈련비' 
	    case 'meeting': return '회의비' 
	    case 'welfare': return '복리후생비' 
		}
	}
	
	function getCategory4(){
		switch (approvalContent.expenseCategory4) {
	    case 'travel': return '출장비' 
	    case 'officeSupplies': return '사무용품' 
	    case 'training': return '교육 및 훈련비' 
	    case 'meeting': return '회의비' 
	    case 'welfare': return '복리후생비' 
		}
	}
	
	function getCategory5(){
		switch (approvalContent.expenseCategory5) {
	    case 'travel': return '출장비' 
	    case 'officeSupplies': return '사무용품'
	    case 'training': return '교육 및 훈련비' 
	    case 'meeting': return '회의비' 
	    case 'welfare': return '복리후생비' 
		}
	}
	
// 	console.log(getCategory1());
// 	console.log(getCategory2());
// 	console.log(getCategory3());
// 	console.log(getCategory4());
	
	
	$("#expenseCategory1").text(getCategory1());
	$("#expenseCategory2").text(getCategory2());
	$("#expenseCategory3").text(getCategory3());
	$("#expenseCategory4").text(getCategory4());
	$("#expenseCategory5").text(getCategory5());

	$("#expenseReport1").text(approvalContent.expenseReport1);
	$("#expenseReport2").text(approvalContent.expenseReport2);
	$("#expenseReport3").text(approvalContent.expenseReport3);
	$("#expenseReport4").text(approvalContent.expenseReport4);
	$("#expenseReport5").text(approvalContent.expenseReport5);
	
	$("#expenseAmount1").text(approvalContent.expenseAmount1);
	$("#expenseAmount2").text(approvalContent.expenseAmount2);
	$("#expenseAmount3").text(approvalContent.expenseAmount3);
	$("#expenseAmount4").text(approvalContent.expenseAmount4);
	$("#expenseAmount5").text(approvalContent.expenseAmount5);
	
	$("#remarks1").text(approvalContent.remarks1);
	$("#remarks2").text(approvalContent.remarks2);
	$("#remarks3").text(approvalContent.remarks3);
	$("#remarks4").text(approvalContent.remarks4);
	$("#remarks5").text(approvalContent.remarks5);
	
	
	
	
	
	
})
</script>
</html>