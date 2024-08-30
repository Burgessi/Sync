<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>출장보고서 상세</title>
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
						<!--  -->
						<div style="text-align: right;">
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
							
							<input type="hidden" id="temp_save_flag" value="${approvalDetail.temp_save_flag}">
							<input type="hidden" id="approvalId" value="${approvalDetail.approval_id}">
						</div>	
						
						<h4 style="text-align: center;">출장보고서</h4>
							
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
										<div class="col-md-5" style="text-align: right; display: flex; justify-content: flex-end;">
												<c:forEach var="line" items="${approvalDetail.lineList}">
													<!-- 결재라인 step1 서명 시작-->
													<c:if test="${line.step eq 1}">
														<div class="approval-line-signature">
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.rank_name}
															</div>
																<c:if test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<input type="hidden" id="lineFlag" value="false">
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
																</c:if>
																<c:if test="${line.status eq 2}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																		<input type="hidden" id="lineFlag" value="true">
																	</div>
																</c:if>
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
																<c:if test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																	</div>
																</c:if>
																<c:if test="${line.status eq 2}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																	</div>
																</c:if>
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${line.approval_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>
													<c:if test="${line.step eq 3}">
														<div class="approval-line-signature">
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.rank_name}
															</div>
																<c:if test="${line.status eq 0}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/${line.signature}">
																	</div>
																</c:if>
																<c:if test="${line.status eq 2}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																	</div>
																</c:if>
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${line.approval_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>					
									</div>
									
									<div style="margin-top: 40px;">
										<table class="table table-bordered approval-table">
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
												<td>
													<input type="hidden" id="documentType" name="documentType" value="출장보고서">
													<span id="title">${approvalDetail.approval_title}</span>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장지</th>
												<td>
													<span id="businessTripDestination"></span>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장기간</th>
												<td>
													<span id="startDate"></span>&nbsp;~&nbsp;<span id="endDate"></span>&nbsp;(&nbsp;총&nbsp;<span id="totalDay"></span>&nbsp;일&nbsp;)
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">출장목적</th>
												<td>
													<span id="businessTripPurpose"></span>
												</td>
											</tr>
										</table>
										<h5>보고사항</h5>
										<table class="table table-bordered approval-table businessTrip-table">
											<tr>
												<th>항목</th>
												<th style="width: 45%;">내용</th>
												<th>비고</th>
											<tr>
											<tr>
												<td id="reportItem1"></td>
												<td id="contentDetails1"></td>
												<td id="additionalRemarks1"></td>
											</tr>
											<tr>
												<td id="reportItem2"></td>
												<td id="contentDetails2"></td>
												<td id="additionalRemarks2"></td>
											</tr>
											<tr>
												<td id="reportItem3"></td>
												<td id="contentDetails3"></td>
												<td id="additionalRemarks3"></td>
											</tr>
											<tr>
												<td id="reportItem4"></td>
												<td id="contentDetails4"></td>
												<td id="additionalRemarks4"></td>
											</tr>
											<tr>
												<td id="reportItem5"></td>
												<td id="contentDetails5"></td>
												<td id="additionalRemarks5"></td>
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
															<textarea style="border:none; background: none; width:100%; height: 150px; resize: none; padding: 15px;" disabled>${list.rejection}</textarea>
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
									<input type="hidden" name="recipient_id" value="${infoDto.emp_id}">
									<input type="hidden" name="approval_id" value="${approvalDetail.approval_id}">
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
	
	$("#businessTripDestination").text(approvalContent.businessTripDestination);
	$("#startDate").text(approvalContent.startDate);
	$("#endDate").text(approvalContent.endDate);
	$("#totalDay").text(approvalContent.totalDay);
	$("#businessTripPurpose").text(approvalContent.businessTripPurpose);
	
	$("#reportItem1").text(approvalContent.reportItem1);
	$("#reportItem2").text(approvalContent.reportItem2);
	$("#reportItem3").text(approvalContent.reportItem3);
	$("#reportItem4").text(approvalContent.reportItem4);
	$("#reportItem5").text(approvalContent.reportItem5);
	
	$("#contentDetails1").text(approvalContent.contentDetails1);
	$("#contentDetails2").text(approvalContent.contentDetails2);
	$("#contentDetails3").text(approvalContent.contentDetails3);
	$("#contentDetails4").text(approvalContent.contentDetails4);
	$("#contentDetails5").text(approvalContent.contentDetails5);

	$("#additionalRemarks1").text(approvalContent.additionalRemarks1);
	$("#additionalRemarks2").text(approvalContent.additionalRemarks2);
	$("#additionalRemarks3").text(approvalContent.additionalRemarks3);
	$("#additionalRemarks4").text(approvalContent.additionalRemarks4);
	$("#additionalRemarks5").text(approvalContent.additionalRemarks5);
	
	
})
</script>
</html>