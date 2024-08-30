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
												<select id="searchSelect" class="form-select" style="font: 0.8em sans-serif;">	
													<option value="title">제목</option>
													<option value="requester">기안자</option>
													<option value="requesterDate">기안일자</option>
												</select>
											</div>
											<input type="text" id="searchInputBox" class="form-control" style="display: inline-block; width: 40%; font-size: 0.8em; padding-bottom: 3px;" placeholder="검색">
											<button id="searchBtn" class="btn btn-sm btn-primary" style="display: inline-block; margin-top: -2px; margin-left: 4px;">검색</button>	
										</div>
									</div>
								</div>
								
								<div class="card-body">
								
									<table class="table table-bordered table-hover" style="text-align: center; font: 0.8em sans-serif;">
										<thead class="table-secondary">
											<tr>
												<th>결재번호</th>
												<th>구분</th>
												<th style="width: 40%">제목</th>
												<th>기안자</th>
												<th>기안일자</th>
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
													<tr onclick="getApproval('${approvalList.approval_id}', '${approvalList.requester_id}','${approvalList.document_type}','${approvalList.temp_save_flag}')">
														<td>${approvalList.approval_id}</td>
														<td>${approvalList.document_type}</td>
														<td>${approvalList.approval_title}</td>
														<td>${approvalList.requester_name}</td>
														<td>${approvalList.request_date}</td>
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
	
	
	
	
	$("#searchBtn").on("click", function() {
		var selected = $("#searchSelect").val();
		var searchInputBox = $("#searchInputBox").val();
		console.log("dd");
		
			$('.table tbody tr').each(function() {
				
				var row = $(this);
				var cellText = '';
				
				switch (selected) {
	            case 'title':
	                cellText = row.find('td:nth-child(3)').text();
	                break;
	            case 'requester':
	                cellText = row.find('td:nth-child(4)').text();
	                break;
	            case 'requesterDate':
	                cellText = row.find('td:nth-child(5)').text();
	                break;
	            default:
	                cellText = '';
	        }
			
		
		
			if (cellText.includes(searchInputBox) || searchInputBox === '') {
	            row.show(); // 일치하면 행을 표시
	        } else {
	            row.hide(); // 일치하지 않으면 행을 숨깁니다.
	        }
		
		});
	});
	
	function getApproval(approvalId, requesterId, documentType, flag) {
	//		const url = location.href;
	//		console.log(url);
	
		const encodedDocumentType = encodeURIComponent(documentType);
		
		console.log(approvalId);
		console.log(documentType);
		location.href='./getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+requesterId+'&temp_save_flag='+flag;
	}

</script>
</html>