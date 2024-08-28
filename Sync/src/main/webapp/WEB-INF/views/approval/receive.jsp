<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수신문서함</title>
<style type="text/css">
	.table-hover>tbody:hover{
		cursor: pointer;
	}
</style>
</head>
<body>

	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
		
				
				<div class="container">
				<h4 style="padding: 5px;">수신문서함</h4>
					<div class="card">
							<!-- table div -->
							<div class="card">
								<div class="card-header">
									<div style="float: right; text-align: right;">
										<div style="float: right;">
											<div class="typeSelect" style="display: inline-block;">
												<select class="form-select" style="font: 0.8em sans-serif;">	
													<option>기안일자</option>
													<option>제목</option>
													<option>상태</option>
												</select>
											</div>
											<input type="text" class="form-control" style="display: inline-block; width: 40%; font-size: 0.8em; padding-bottom: 3px;" placeholder="검색">
											<button class="btn btn-sm btn-primary" style="display: inline-block; margin-top: -2px; margin-left: 4px;">검색</button>	
										</div>
									</div>
								</div>
								
								<div class="card-body">
								
									<table class="table table-bordered table-hover" style="text-align: center; font: 0.8em sans-serif;">
										<thead class="table-secondary">
											<tr>
												<th>기안일자</th>
												<th>결재번호</th>
												<th>문서양식</th>
												<th>제목</th>
												<th>기안자</th>
												<th>결재상태</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(myApprovalList) == 0}">
													<tr>
														<td colspan="5">결재문서가 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
												<c:forEach var="approvalList" items="${myApprovalList}">
													<tr onclick="getApproval('${approvalList.approval_id}', '${approvalList.requester_id}','${approvalList.document_type}')">
														<td>${approvalList.request_date}</td>
														<td>${approvalList.approval_id}</td>
														<td>${approvalList.document_type}</td>
														<td>${approvalList.approval_title}</td>
														<td>${approvalList.requester_name}</td>
														<td>
									                    	  <!-- 상태를 초기화 -->
											                    <c:set var="overallStatus" value="completed" />
											                    <c:set var="hasInProgress" value="false" />
											                    <c:set var="hasRejected" value="false" />
											                    <c:set var="loop_flag" value="false" />
											                    <!-- 상태 점검 -->
											                    <c:forEach var="line" items="${approvalList.lineList}">
											                    	<c:if test="${line.step > 0}">
											                    		<c:choose>
											                            <c:when test="${line.status == 0}">
											                                <!-- 진행중 상태가 발견된 경우 -->
											                                <c:set var="hasInProgress" value="true" />
											                            </c:when>
											                            <c:when test="${line.status == 2}">
											                                <!-- 반려 상태가 발견된 경우 -->
											                                <c:set var="hasRejected" value="true" />
											                                <!-- 반려 상태 발견 시 이후 체크는 필요 없음 -->
											                               <c:set var="loop_flag" value="true"/>
											                            </c:when>
											                        </c:choose>
											                        </c:if>
											                    </c:forEach>
											                    
											                    <!-- 최종 상태 결정 -->
											                    <c:choose>
											                        <c:when test="${hasRejected}">
											                            <span class="badge bg-danger">결재반려</span>
											                        </c:when>
											                        <c:when test="${hasInProgress}">
											                            <span class="badge bg-warning">결재진행중</span>
											                        </c:when>
											                        <c:otherwise>
											                            <span class="badge bg-success">결재완료</span>
											                        </c:otherwise>
											                    </c:choose>
														</td>	
													</tr>
												</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						
						
						
						
						
					</div>
		
		
				</div>			
		
		
		</div>
	 
	</div>


	 <%@ include file="/WEB-INF/views/common/footer.jsp" %> 
</body>
<script type="text/javascript">
	//완료시 메세지
	var message = '${message}';
	var details = '${details}';
	if(message){
		toastr.success(details, message);
	}

	
	function getApproval(approvalId, requesterId, documentType) {
	//		const url = location.href;
	//		console.log(url);
	
		const encodedDocumentType = encodeURIComponent(documentType);
		
		console.log(approvalId);
		console.log(documentType);
		location.href='./getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+requesterId;
	}

</script>
</html>