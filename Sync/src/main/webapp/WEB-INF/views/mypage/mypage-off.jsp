<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<style>
    .center-align {
        text-align: center;
    }
    .right-align {
        text-align: right;
    }
</style>

<div>
	<!-- 연차 영역 -->
	<div class="card-header mt-1 py-3">
		<h4 class="mb-0">연차 조회</h4>
	</div>
	<div class="card-body" style="max-width: 900px">
		<div class="emp-off" style="width: 100%;">
			<table class="table">
				<thead>
					<tr>
						<td class="center-align">총 연차</td>
						<td class="center-align">사용 연차</td>
						<td class="center-align">잔여 연차</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="center-align">${infoDto.total_off }</td>
						<td class="center-align">${infoDto.used_off }</td>
						<td class="center-align">${infoDto.total_off - infoDto.used_off }</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="emp-off-history" style="width: 100%; margin-top: 50px;">
			<h5>연차 사용 내역</h5>
			<table id="progressTable" class="table" style="width: 100%;">
			    <thead>
								<tr>
									<td class="center-align">No.</td>
									<td class="center-align">연차사용일자</td>
									<td class="center-align">내용</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${offVo}" varStatus="vs">
									<tr>
										<td class="center-align">${fn:length(offVo) - vs.index}</td>
										<td class="center-align">${vo.off_date}</td>
										<td>${vo.off_reason }</td>
			
									</tr>
								</c:forEach>
							</tbody>
			</table>
		</div>
	</div>
</div>


<script>
$("#progressTable").DataTable({
    
    // 표시 건수기능 숨기기
     lengthChange: false,
     //한페이지 출력개수
     pageLength: 5,
     // 검색 기능 숨기기
     searching: false,
     // 정렬 기능 숨기기
     ordering: true,
     // 정보 표시 숨기기
     info: false,
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
         emptyTable: "기안 문서가 없습니다."
     }
    
})   
 
 

    $(document).ready(function(){
       
       var table = $('#progressTable').DataTable();

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
       $("#progressTable_filter").css("width","220px");
       
       draw();
       
    })
</script>
