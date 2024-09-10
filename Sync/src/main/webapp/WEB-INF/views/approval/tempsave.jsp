<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>임시저장함</title>
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
			
					<h4 style="padding: 5px;">임시저장함</h4>
					<div class="card">
							<div class="card">
									<!-- table div -->
									<div class="card">
<!-- 										<div class="card-header"> -->
<!-- 											<div style="float: right; text-align: right;"> -->
<!-- 												<div style="float: right;"> -->
<!-- 													<div class="typeSelect" style="display: inline-block;"> -->
<!-- 														<select id="searchSelect" class="form-select" style="font: 0.8em sans-serif;">	 -->
<!-- 															<option value="documentType">구분</option> -->
<!-- 															<option value="title">제목</option> -->
<!-- 															<option value="requesterDate">기안일자</option> -->
<!-- 														</select> -->
<!-- 													</div> -->
<!-- 													<input type="text" id="searchInputBox" class="form-control" style="display: inline-block; width: 40%; font-size: 0.8em; padding-bottom: 3px;" placeholder="검색"> -->
<!-- 													<button id="searchBtn" class="btn btn-sm btn-primary" style="display: inline-block; margin-top: -2px; margin-left: 4px;">검색</button>	 -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
										<div class="card-body">
										
											<table id="tempTable" class="table table-bordered table-hover" style="text-align: center; font: 0.8em sans-serif;">
												<thead class="table-secondary">
													<tr>
														<th>결재번호</th>
														<th>구분</th>
														<th style="width: 40%">제목</th>
														<th>기안자</th>
														<th>기안일자</th>
														<th>상태</th>
													</tr>
												</thead>
												<tbody>
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${fn:length(tempApproval) == 0}"> --%>
<!-- 															<tr> -->
<!-- 																<td colspan="6">결재문서가 존재하지 않습니다.</td> -->
<!-- 															</tr> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
														<c:forEach var="list" items="${tempApproval}">
															<tr onclick="getApproval('${list.approval_id}', '${list.requester_id}','${list.document_type}','${list.temp_save_flag }')">
																<td>${list.approval_id}</td>
																<td>${list.document_type}</td>
																<td>${list.approval_title}</td>
																<td>${list.requester_name}</td>
																<td>${list.request_date}</td>
																<td>
																	<span class="badge bg-secondary">임시저장</span>
																</td>
															</tr>
														</c:forEach>
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
												</tbody>
											</table>
										</div>
									</div>
								
								
								
								
								
							</div>
					</div>
		
		
				</div>			
		
		
		</div>
	 
	</div>


	 <%@ include file="/WEB-INF/views/common/footer.jsp" %> 
</body>
<script type="text/javascript">
// //검색버튼 클릭시
// $("#searchBtn").on("click", function() {
// 	//선택된 셀렉트 값
// 	var selected = $("#searchSelect").val();
// 	//검색어 값
// 	var searchInputBox = $("#searchInputBox").val();
// 	console.log("dd");
	
// 		//table의 행 반복
// 		$('.table tbody tr').each(function() {
			
// 			//한행의 모든 행
// 			var row = $(this);
			
// 			var cellText = '';
			
// 			//선택된 값의 경우에 따라 td3,4,5번째 text cellText에 담기
// 			//없다면 그냥 없다면 그냥 빈값..
// 			switch (selected) {
//             case 'documentType':
//                 cellText = row.find('td:nth-child(2)').text();
//                 break;
//             case 'title':
//                 cellText = row.find('td:nth-child(3)').text();
//                 break;
//             case 'requesterDate':
//                 cellText = row.find('td:nth-child(5)').text();
//                 break;
//             default:
//                 cellText = '';
//         }
		
// 		//담은 text에 검색어의 단어가 포함되어 있거나, 아무것도 입력하지 않았다면
// 		// 해당 row 보여줌
// 		if (cellText.includes(searchInputBox) || searchInputBox === '') {
//             row.show(); // 일치하면 행을 표시
//         } else {
//             row.hide(); // 일치하지 않으면 행을 숨김
//         }
	
// 	});
// });


function getApproval(approvalId, empId, documentType, flag) {
	//		const url = location.href;
	//		console.log(url);
	
		const encodedDocumentType = encodeURIComponent(documentType);
		
		console.log(approvalId);
		console.log(documentType);
		console.log(empId);
		location.href='./getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+empId+'&temp_save_flag='+flag;
}



$("#tempTable").DataTable({
	
	// 표시 건수기능 숨기기
    lengthChange: false,
    //한페이지 출력개수
    pageLength: 10,
    // 검색 기능 숨기기
    searching: true,
    // 정렬 기능 숨기기
    ordering: true,
    // 정보 표시 숨기기
    info: false,
    
    order: [[0, 'desc']],
    // 페이징 기능 숨기기
    paging: true,
    //텍스트 언어설정
    language: {
        search: "<button id='tableSearchBtn' class='btn btn-primary btn-sm' style='margin:0;'>검색</button>",
        lengthMenu: "_MENU_ 항목 보기",
        paginate: {
            previous: "<",   // "Previous" 
            next: ">"        // "Next" 
        },
        searchPlaceholder : "검색어를 입력하세요.",
        zeroRecords: "검색 결과가 없습니다.",
        emptyTable: "수신 문서가 없습니다."
    },
    drawCallback: function(settings) {
    	var api = this.api();
        
        // 전체 데이터가 없거나 필터링된 결과가 없을 때 페이징 숨기기
        if (api.rows({ filter: 'applied' }).data().length === 0) {
            $('.dataTables_paginate').hide();  // 페이징 숨기기
        } else {
            $('.dataTables_paginate').show();  // 페이징 보이기
        }
    }
	
})		



$(document).ready(function(){

var table = $('#tempTable').DataTable();

//dataTables 기본 검색 막기
$('.dataTables_filter input').off();


// 버튼 클릭 시 DataTables 검색 실행
$('#tableSearchBtn').on('click', function() {
    var searchTerm = $('.dataTables_filter input').val(); // 기본 검색 상자에서 검색어 가져오기
    table.search(searchTerm).draw(); // 검색어 전달하고 테이블 다시 그리기
});


// table 다시 그릴때마다 css 설정하기!!
table.on('draw', function() {
	draw();
});


function draw(){
	
    	$(".paginate_button").addClass("btn btn-outline-secondary");
		$(".btn-outline-secondary").removeClass("paginate_button");
		$(".next").css("padding","3px 7px 3px 7px");
		$(".next").css("margin-left","11px");
		$(".previous").css("margin-right","11px");
		$(".previous").css("padding","3px 7px 3px 7px");
		$(".dataTable").css("border-bottom","1px solid #e0e0e0");
		$(".dataTables_paginate").css("text-align","center");
		$(".dataTables_paginate").css("float","none");
		$(".dataTables_paginate").css("margin-top","15px");
    }
    
    $("input[type=search]").addClass("form-control");
	$("input[type=search]").css("width", "150px");
	$("input[type=search]").css("font-size", "0.8em");
	$("input[type=search]").css("margin-left", "10px");
	$("input[type=search]").closest("label").css("display","flex");
	$("input[type=search]").closest("label").css("margin-bottom","15px");
	$("input[type=search]").closest("label").css("flex-direction","row-reverse");
	$("input[type=search]").closest("label").css("justify-content","space-between");
	$("#tempTable_filter").css("width","220px");
	
	draw();
	
})



</script>
</html>