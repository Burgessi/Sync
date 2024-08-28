<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>휴가신청서 상세</title>
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
							<c:choose>
								<c:when test="${loginDto.emp_id eq approvalDetail.requester_id}">
									<button type="button" id="modifyApproval" class="btn btn-sm btn-primary">수정</button>
									<button type="button" id="deleteApproval" class="btn btn-sm btn-danger">회수</button>
								</c:when>
								<c:otherwise>
									<c:forEach var="line" items="${approvalDetail.lineList}">
										<c:if test="${loginDto.emp_id eq line.recipient_id && line.step > 0}">
											<button type="button" id="decisionApproval" onclick="decisionApproval('${line.signature}')" class="btn btn-sm btn-primary">승인</button>
											<button type="button" id="rejectionApproval" class="btn btn-sm btn-danger">반려</button>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							
							<input type="hidden" id="approvalId" value="${approvalDetail.approval_id}">
						</div>		
						<h4 style="text-align: center;">휴가신청서</h4>
							
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
																		결재대기
																		<input type="hidden" id="lineFlag" value="false">
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/signature001.png">
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
																${approvalDetail.request_date}
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
																		결재대기
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/signature002.png">
																	</div>
																</c:if>
																<c:if test="${line.status eq 2}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																	</div>
																</c:if>
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${approvalDetail.request_date}
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
																		결재대기
																	</div>
																</c:if>
																<c:if test="${line.status eq 1}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/signature003.png">
																	</div>
																</c:if>
																<c:if test="${line.status eq 2}">
																	<div style="width: 133px; height: 90px; border: 1px solid #e0e0e0; border-bottom:none; display: flex; justify-content: center; align-items: center;">
																		<img style="width:100%; height:100%;" alt="" src="${root}/resources/img/signature/reject.jpg">
																	</div>
																</c:if>
															<div style="width: 133px; height: 20px; border: 1px solid #e0e0e0; border-top:none; font-size: 0.7em;">
																${approvalDetail.request_date}
															</div>
															<div style="width: 133px; height: 25px; border: 1px solid #e0e0e0;">
																${line.recipient_name}
															</div>
														</div>
													</c:if>
												</c:forEach>
										
										
											<!-- 결재서명 -->
<!-- 											<div style="padding: 10px; display: inline-block;"> -->
<!-- 												<table class="table table-bordered approval-line-signature-table" style="display: inline-block;"> -->
<!-- 											        <thead> -->
<%-- 											        	<c:forEach var="detail" items="${approvalDetail}"> --%>
<%-- 													         <c:forEach var="line" items="${detail.lineList}"> --%>
<!-- 													            <tr> -->
<!-- <!-- 													            	<th class="unique-merged-column" rowspan="3">결재</th> -->
<%-- 													            	<c:if test="${line.step eq 1}"> --%>
<%-- 														                <th id="approval-line-rank1" class="approval-line-rank">${detail.rank_name}</th> --%>
<%-- 																	</c:if> --%>
<%-- 																	<c:if test="${line.step eq 2}"> --%>
<!-- 													             	   <th id="approval-line-rank2" class="approval-line-rank">직급2</th> -->
<%-- 													                </c:if> --%>
<!-- 	<!-- 												                <th id="approval-line-rank3" class="approval-line-rank">직급3</th> -->
<!-- 													            </tr> -->
<!-- 													            <tr> -->
<%-- 													            	<c:if test="${line.step eq 1}"> --%>
<!-- 													                	<th id="approval-line-signature1" class="approval-line-signature">서명</th> -->
<%-- 													                </c:if>	 --%>
<%-- 													                <c:if test="${line.step eq 2}"> --%>
<!-- 													               	 <th id="approval-line-signature2" class="approval-line-signature">서명2</th> -->
<%-- 													               	</c:if> --%>
<!-- 	<!-- 												                <th id="approval-line-signature3" class="approval-line-signature">서명3</th> -->
<!-- 													            </tr> -->
<!-- 													            <tr> -->
<%-- 													            	<c:if test="${line.step eq 1}"> --%>
<%-- 													            		<th id="approval-line-approvalDate1" class="approval-line-approvalDate">${detail.request_date}</th> --%>
<%-- 													            	</c:if> --%>
<%-- 													            	<c:if test="${line.step eq 2}"> --%>
<!-- 													            		<th id="approval-line-approvalDate2" class="approval-line-approvalDate"></th> -->
<%-- 													            	</c:if> --%>
<!-- 	<!-- 												            	<th id="approval-line-approvalDate3" class="approval-line-approvalDate"></th> -->
<!-- 													            </tr> -->
<!-- 													            <tr> -->
<%-- 													            	<c:if test="${line.step eq 1}"> --%>
<%-- 													                	<th id="approval-line-name1" class="approval-line-name">${detail.recipient_name}</th> --%>
<%-- 													               	</c:if> --%>
<%-- 													               	<c:if test="${line.step eq 2}"> --%>
<!-- 													                	<th id="approval-line-name2" class="approval-line-name">Subheader 3</th> -->
<%-- 													                </c:if> --%>
<!-- 	<!-- 												                <th id="approval-line-name3" class="approval-line-name">Subheader 4</th> -->
<!-- 													            </tr> -->
<%-- 													    	</c:forEach> --%>
<%-- 											            </c:forEach> --%>
<!-- 											        </thead> -->
<!-- 											    </table> -->
<!-- 											</div> -->
											<!-- 결재서명 -->
										</div>					
									</div>
									
									<div style="margin-top: 40px;">
										<table class="table table-bordered approval-table">
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">제목</th>
												<td>
													<input type="hidden" id="documentType" name="documentType" value="휴가신청서">
													<span id="title">${approvalDetail.approval_title}</span>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">휴가기간</th>
												<td>
													<div style="display: inline-flex;">
														<span id="startDate"></span>&nbsp;~&nbsp;<span id="endDate"></span>&nbsp;(&nbsp;총&nbsp;<span id="totalDay"></span>&nbsp;일&nbsp;)
													</div>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">연차일수</th>
												<td>
													잔여연차:&nbsp;<span id="remainingLeave"></span>&nbsp;/&nbsp;신청연차:&nbsp;<span id="applicationLeave"></span>
												</td>
											</tr>
											<tr style="height: 150px;">
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">휴가사유</th>
												<td>
													<div id="content"></div>
												</td>
											</tr>
											<tr>
												<th style="width: 80px;background: #F2F2F2;font: 0.8em sans-serif; font-weight: bold;">첨부파일</th>
												<td>
													파일 없음
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
					</div>				
				</div>
			
		
		</div>
	</div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <div class="modal fade" tabindex="-1" role="dialog" id="signatureModal">
			 <div class="modal-dialog modal-dialog-centered" role="document">
				 <div class="modal-content rounded-4 shadow">
					<div class="modal-header p-5 pb-4 border-bottom-0">
						<h4>서명 입력</h4>
					</div>
					<div class="modal-body p-5 pt-0" style="text-align: center;">
						<!--  -->
						<canvas id="signature" style="border: 1px solid #ddd;"></canvas>
						<br>
						<button id="clear-signature">초기화</button>
						<button id="save-signature">저장</button>
							
						<!--  -->
				</div>
			</div>
		</div>
	</div>
    
    
    
    
</body>
<script src="${root}/resources/js/approvalSign.js"></script>
<script type="text/javascript">



	//승인버튼
	function decisionApproval(lineSign){
		
		if(lineSign == ""){
			console.log("sign 없음");
			const modal = new bootstrap.Modal($("#signatureModal"));
			modal.show();
		} else{
			console.log("sign 있음");
			console.log(signature);
		}
		
	}


	//수정버튼
	$("#modifyApproval").on("click",function(){
		
		let flag = $("#lineFlag").val();
		let approvalId = $("#approvalId").val();
		let documentType = $("#documentType").val();
		
		if(flag == 'true'){
			toastr.error("결재가 진행된 문서는 수정할 수 없습니다.");
			return;
		}
		
		location.href="./modifyApproval.do?approval_id="+approvalId+"&document_type="+documentType;
		
	})


	//삭제버튼
	$("#deleteApproval").on("click",function(){
	
		let flag = $("#lineFlag").val();
		let approvalId = $("#approvalId").val();
		console.log(flag);
		
		if(flag == 'false'){
			
			Swal.fire({
				  title: "작성한 문서를 회수하시겠습니까?",
				  icon: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#3085d6",
				  cancelButtonColor: "#d33",
				  confirmButtonText: "저장",
				  cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						location.href="./deleteApproval.do?approval_id="+approvalId;
				  }
				});
				
			
		} else{
			toastr.error("결재가 진행된 문서는 회수할 수 없습니다.");
			return;
		}
		
		
	});


	
	$(document).ready(function(){
		var approvalContent = ${approvalDetail.approval_content};
		
		
		$("#startDate").text(approvalContent.startDate);
		$("#endDate").text(approvalContent.endDate);
		$("#totalDay").text(approvalContent.totalDay);
		$("#remainingLeave").text(approvalContent.remainingLeave);
		$("#applicationLeave").text(approvalContent.applicationLeave);
		$("#content").text(approvalContent.content);
		
		
		
		    
		    
		
	})

	
	
	
	
	
</script>
</html>