<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>기안서 작성</title>
<style type="text/css">
	.highlight{
		color: skyblue;
	}
	.no-checkbox > .jstree-anchor > .jstree-checkbox {
	    display: none !important; /* 체크박스를 완전히 숨김 */
	}
	
	.alert-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 65vh;
        }

        .alert-message {
            padding: 30px 40px;
            background: #ffffff;
            border: 1px solid #dcdcdc;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 80%;
            width: 400px;
            animation: fadeInUp 1s ease-out;
            position: relative;
            margin-bottom: 35px;
        }

        .alert-message::before {
            content: "⚠️";
            position: absolute;
            top: 10px;
            left: -1%;
            transform: translateX(-50%);
            font-size: 70px;
            color: #ff9800;
            animation: bounce 1s infinite;
        }

        .alert-message h2 {
            margin: 0;
            font-size: 22px;
            color: #333333;
            font-weight: 600;
        }

        .alert-message p {
            margin-top: 10px;
            font-size: 16px;
            color: #666666;
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }
	
</style>
</head>
<body>

<form id="approvalForm" method="post">
	<div id="app">
     	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
		
			<main>
				
				<div class="container">
					
					<div class="main-header">
							<h4>기안서 작성</h4>
					</div>		
					
					
					<div class="card">
								
								
						<div class="row">
							
							<!-- 메인 왼쪽 양식 검색 -->
							<div class="col-md-3">
								<div class="card-header">
									<div class="approval-searchBox">
										<span><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256" class="text-choco-700"><path d="M226.83,221.17l-52.7-52.7a84.1,84.1,0,1,0-5.66,5.66l52.7,52.7a4,4,0,0,0,5.66-5.66ZM36,112a76,76,0,1,1,76,76A76.08,76.08,0,0,1,36,112Z"></path></svg></span>
										<input class="approval-input" type="text" style="border: none;" placeholder="양식명 검색">
									</div>
								</div>
								
								<div class="card-body">
									<div class="approval-searchContent">
										<ul style="padding: 0; margin: 0;">
											<li class="search-list" id="form001">
												<div class="search-div">
													<p class="search-p">휴가신청서</p>
												</div>
											</li>
											<li class="search-list" id="form002">
												<div class="search-div">
													<p class="search-p">출장보고서</p>
												</div>
											</li>
											<li class="search-list" id="form003">
												<div class="search-div">
													<p class="search-p">지출결의서</p>
												</div>
											</li>
											<li class="search-list" id="form004">
												<div class="search-div">
													<p class="search-p">휴가휴가휴가</p>
												</div>
											</li>
										</ul>
									</div>
								</div>
								
							</div>
							
							
							
							<!-- 메인 오른쪽 content 영역 -->
							<div class="col-md-9">
								
									<div class="card-header">
										<div style="text-align: right; display: none;" id="approvalBtn">
											<button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#approvalLineModal">결재선 지정</button>
											<button type="button" class="btn btn-sm btn-info" onclick="temporarySave(event)">임시 저장</button>
											<button type="button" class="btn btn-sm btn-secondary" onclick="approvalRequest(event)">결재 상신</button>
										</div>		
									</div>
									
									<div class="card-body">
										<!-- 검색된 양식의 html 출력 -->
										<div id="document-content">
										
												<div class="alert-container">
											        <div class="alert-message">
											            <h2>양식 선택</h2>
											            <p>양식을 선택하여 진행해 주세요.</p>
											        </div>
											    </div>
										</div>
									</div>
								
							</div>
						</div>
						
						
						
					</div>
					
		
		
				</div>			
		
			</main>
		
		</div>
	  
	</div>   
        
        
        
        
     <!-- 결재선 지정 modal -->  
        
        <div class="modal fade" tabindex="-1" role="dialog" id="approvalLineModal">
			 <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
				 <div class="modal-content rounded-4 shadow">
						<div class="modal-header p-5 pb-4 border-bottom-0">
							<h4 class="fw-bold mb-0 fs-4">결재선 지정</h4>
<!-- 							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
						</div>
						<div class="modal-body p-5 pt-0">
							<jsp:include page="./approvalTree.jsp"></jsp:include>
							<div style="text-align: right; margin-top: 5px; margin-right: 5px;">
								<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
								<button type="button" id="lineRemoveBtn" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
						
				</div>
			</div>
		</div>
		
</form>
        
        
        
        
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>   

</body>
<script type="text/javascript">
	
	//현재날짜
	var nowDate = new Date();
	var year = nowDate.getFullYear();
	var month = nowDate.getMonth() +1;
	var day = nowDate.getDate();
	
	month = month < 10 ? '0' + month : month;
	day = day < 10 ? '0' + day : day;
	
	
	var today = year+"-"+month+"-"+day;
	
	

	//저장, 상신 완료시 띄울 메세지
	var message = '${message}';
	var details = '${details}';
	if(message){
		toastr.success(details, message);
	}
	
	//jstree 및 form 요청 
	var menu_json = null;


	$(document).ready(function(){
		
		var empId = '${loginVo.emp_id}';
		
		let formNo = "${formNo}";
		console.log(formNo);
		//상신일자 입력
		
		if(formNo != "false"){
			//페이지 로드시 바로 ajax요청 -> form 띄우기
	 		$.ajax({
	 			url:'./form.do',
	 			type: 'get',
	 			data: {form:formNo},
	 			success:function(data){
	 				$("#document-content").html(data);
	 				$("#requsterDate").text(today);
	 			}
	 		})
		}
		
		
			
		
		//선택한 form 열기
		$(".search-list").click(function(event){
			event.preventDefault();
			
			//선택된li의 id 탐색
			var selected = $(this).attr("id");
			//선택된div
			var selectedDiv = $(this).children();
			
			$(".search-div").removeClass("search-div-selected");
			selectedDiv.addClass("search-div-selected");
			
			$.ajax({
				url: './form.do',
				type: "get",
				data: {form : selected},
				success : function(data){
					
					$("#approvalBtn").show();
					
					$("#document-content").html(data);
					//상신일자 입력
					$("#requsterDate").text(today);
				}
				
			})
			
		});
		
		
		//검색한 단어 찾기
		$(".approval-input").on("input", function(){
			
			//input에 쓴 단어
			var search = $(this).val();
			
			//list 탐색
			$(".search-list").each(function(){
			
				var text = $(this).text();
				//list의 text 가 input의 search와 같다면
				if(text.indexOf(search) != -1){
					$(this).show();
				} else{
					$(this).hide();
				}
				
			});
			
		});
		
			//조직도 jsTree
			
			// 서버에 데이터 요청
			$.ajax({
			   	type : "POST",
			   	url : './approvalJstree.do',
			   	success: function(data){
			   		var url = location.href;
				        menu_json = data;
				        CreateJSTrees();
			    }
			});
			
			// 서버에서 가져온 데이터로 JSTree 만듦
			function CreateJSTrees(){
// 				console.log('22');
// 				console.log(menu_json);
				
				$('#approvalLine').jstree({
					  'core' : {
					    'data' : menu_json,
					    
					    "check_callback" : true
					
					  },
					  'checkbox' : {
					        'three_state': false
					    },
					  "search": {
					        "show_only_matches": true,
					        "show_only_matches_children": true
					   },
					   "themes" : {
				            "responsive": true
				        },
					  "plugins" : ["search", "checkbox"],
					 
				});
			}
			
			
			// 검색 상자
			var to = false;
			$('#treeSearchInput').keyup(function () {
			    if(to) { clearTimeout(to); }
			    to = setTimeout(function () {
			        var v = $('#treeSearchInput').val();
			        $('#approvalLine').jstree(true).search(v);
			    }, 250);
			});
			
			
			
			// 서버에 값 보낼때 필요하기 때문에 전역변수로
			var selectedNodes = "";
			
			
			// 체크박스 선택 값 담기 -> 체크 변할때마다
			// 결재선이 선택될때마다 변경 이벤트
			 $('#approvalLine').on("changed.jstree", function (e, data) {
//		 		 console.log($('#tree').jstree("get_selected", true));
//		 		 console.log($('#tree').jstree("get_checked", true));
				 
				 //현재 선택된 모든 노드
		         selectedNodes = $('#approvalLine').jstree("get_selected", true);
				 console.log(selectedNodes);
				 
				 let rowCount = $("#approvalTable>tbody>tr").length;
				 let addCount = 3-rowCount; //추가가능한 행의 수
				 
				 
				 //선택된 노드 개수 제한하기 최대 3개만 가능
				 if(selectedNodes.length > 1){
					 $('#approvalLine').jstree(true).deselect_node(data.node);
					 toastr.info("한 명씩 추가할 수 있습니다.");
					 //error , success 
				 }
				 
			 }); 
			
			
			
			
			
			var lineIdx = 1;
			
			//결재선 추가 버튼
			$("#addLine").on("click", function(){
				
				let currentRowCount01 = $("#approvalTable>tbody>tr").length;
				let maxRow = 3 - currentRowCount01; //추가가능한 행의 수
				
				//선택노드 갯수 vs 추가가능한 row 중 작은 것 선택
				let rowsToAdd = Math.min(selectedNodes.length, maxRow);
				
				if (rowsToAdd <= 0) {
			        toastr.info("결재자는 최대 3명만 지정할 수 있습니다.");
			        $('#approvalLine').jstree("deselect_all");
			        return false;
			    }
				
				let myRankId = '${infoDto.rank_id}';
				let myRank = parseInt(myRankId.slice(-1));
				console.log(myRank);
				//자기자신 추가 막기
				for(let i=0; i<selectedNodes.length; i++){
					
					if(empId.includes(selectedNodes[i].id)){
						toastr.error("자신을 결재자/참조자로 추가할 수 없습니다.");
						$('#approvalLine').jstree("deselect_all");
						return;
					}
				}
				
				//본인보다 직급이 낮다면 선택 불가능
				if(selectedNodes.length > 0 && myRank < parseInt(selectedNodes[0].original.rankId.slice(-1)) && selectedNodes != undefined){
					toastr.error("자신보다 낮은 직급의 사원을 결재자로 선택할 수 없습니다.");
					return;
				}
				
				
				
				
				
				
				let lines = [];
				let approvalLine1 = $("input[name=approvalLine1]").val();
				let approvalLine2 = $("input[name=approvalLine2]").val();
				let approvalLine3 = $("input[name=approvalLine3]").val();
				let referrer = document.querySelectorAll("input[name=referrer]");
				
				let rankId = document.querySelectorAll(".rankId");
				
				
				//이전에 선택된 결재자보다 같거나 높을때만 추가할 수 있음.
				if(rankId.length > 0 && selectedNodes.length > 0){
					let id = rankId[0].value.slice(-1);
					if(id < selectedNodes[0].original.rankId.slice(-1)){
						toastr.error('두 번째 결재자는 첫 번째 결재자보다 같거나 높은 직급이어야 합니다.');
						return;
					}
				}
				
				if(rankId.length > 1 && selectedNodes.length > 0){
					let id = rankId[1].value.slice(-1);
					if(id < selectedNodes[0].original.rankId.slice(-1)){
						toastr.error('세 번째 결재자는 두 번째 결재자보다 같거나 높은 직급이어야 합니다.');
						return;
					}
				}
				
				
				for(let i=0; i<referrer.length; i++){
					lines.push(referrer[i].value);
				}
				
				lines.push(approvalLine1);
				lines.push(approvalLine2);
				lines.push(approvalLine3);
				console.log("lines", lines);
				
				//이미 추가된 사원 추가막기
				for(let i=0; i<selectedNodes.length; i++){
					
					if(lines.includes(selectedNodes[i].id)){
						toastr.error("같은 사원을 중복으로 추가할 수 없습니다.");
						return;
					}
				}
				
				console.log(lineIdx);
				
// 				// 결재선 3명만 선택가능
// 				if(currentRowCount01 >= 3){
// 					toastr.info("최대 3명까지 추가할 수 있습니다.");
// 					return;
// 				}
				
// 				let addRow = Math.min(selectedNodes.length, maxRow);
				 
				// 선택한 row append	
				for(let i=0; i<rowsToAdd; i++){
					
					let name = selectedNodes[i].text;
					console.log(lineIdx);
					 var appendRow = '<tr>' +
					                    '<td>' + lineIdx + '</td>' +
					                    '<td>' + name.substring(0, name.indexOf(" (")) + '</td>' +
					                    '<td>' + selectedNodes[i].original.rank + '</td>' +
					                    '<td style="width: 125px;">' + selectedNodes[i].original.team + '</td>' +
					                    '<td>' +
			                                '<input type="button" class="removeLineBtn">' +
			                                '<input type="hidden" name="approvalLine' + lineIdx+1 + '" value="' + selectedNodes[i].id + '">' +
			                                '<input type="hidden" class="rankId" value="' + selectedNodes[i].original.rankId + '">' +
		                            	'</td>' +
					                 '</tr>';
					 $("#approvalTable>tbody").append(appendRow);
					 
				 }
				 
				console.log(lineIdx);
				lineIdx++;
				 
				 //jstree 선택 없애기.
				 $('#approvalLine').jstree("deselect_all");
				 
				 //인덱스 갱신
				 updateRowIndices();
				 
			});
			
			
			//결재모달 취소 버튼 (결재자, 참조자 전부 취소 후 모달 닫기)
			$("#lineRemoveBtn").on("click", function(){
				console.log('dddddd');
				$("#approvalTable>tbody").html("");
				//인덱스 초기화
				lineIdx = 1;
				$("#referrerTable>tbody").html("");
				$('#approvalLine').jstree("deselect_all");
				
			});
			
			
			//결재선 취소 < 이미지 클릭
			$("#removeLine").on("click", function(){
				$("#approvalTable>tbody").html("");
				//인덱스 초기화
				lineIdx = 1;
				$('#approvalLine').jstree("deselect_all");
				
			});
			
			
			//각 사원 정보 옆 x 버튼
			$(document).on("click", ".removeLineBtn", function(){
				$(this).closest("tr").remove();
				//인덱스 갱신
				updateRowIndices();
// 				lineIndex = $(this).find("td:").text
			})
			
			//행 index 재설정.
			function updateRowIndices() {
				let index = 1;
			    $("#approvalTable>tbody>tr").each(function() {
			        $(this).find("td:first").text(index);
			        $(this).find("input[type='hidden']").attr("name", "approvalLine" + index); // name 속성 업데이트
			        index++;
			    });
			    lineIdx = index;
			    
			}
			
			
			
			
			
			//참조 추가
			$("#addReferrer").on("click", function(){
				
				
				for(let i=0; i<selectedNodes.length; i++){
					
					if(empId.includes(selectedNodes[i].id)){
						toastr.error("자신을 결재자/참조자로 추가할 수 없습니다.");
						$('#approvalLine').jstree("deselect_all");
						return;
					}
				}
				
				
				let currentRowCount02 = $("#referrerTable>tbody>tr").length;
				let maxRowCount = 5;
				
				let rowsToAdd = Math.min(selectedNodes.length, maxRowCount - currentRowCount02);
				
				if(rowsToAdd <=0){
					toastr.info("참조자는 최대 5명만 지정할 수 있습니다.");
					$('#approvalLine').jstree("deselect_all");
					return false;
				}
				
				let lines = [];
				let approvalLine1 = $("input[name=approvalLine1]").val();
				let approvalLine2 = $("input[name=approvalLine2]").val();
				let approvalLine3 = $("input[name=approvalLine3]").val();
				let referrer = document.querySelectorAll("input[name=referrer]");
				for(let i=0; i<referrer.length; i++){
					lines.push(referrer[i].value);
				}
				console.log(referrer);
				
				lines.push(approvalLine1);
				lines.push(approvalLine2);
				lines.push(approvalLine3);
				console.log("lines", lines);
				
				for(let i=0; i<selectedNodes.length; i++){
					
					if(lines.includes(selectedNodes[i].id)){
						toastr.error("같은 사원을 중복으로 추가할 수 없습니다.");
						return;
					}
				}
				
				
				
				
				for(let i=0; i<rowsToAdd; i++){
					let name = selectedNodes[i].text;
					 var appendRow = '<tr>' +
					                    '<td>' + name.substring(0, name.indexOf(" (")) + '</td>' +
					                    '<td>' + selectedNodes[i].original.rank + '</td>' +
					                    '<td style="width: 125px;">' + selectedNodes[i].original.team + '</td>' +
					                    '<td style="width: 35px;">' +
			                                '<input type="button" class="removeLineBtn">' +
			                                '<input type="hidden" name="referrer" value="' + selectedNodes[i].id + '">' +
		                            	'</td>' +
					                 '</tr>';
					 $("#referrerTable>tbody").append(appendRow);
					 
				 }
				
				$('#approvalLine').jstree("deselect_all");
			});
			
			
			//참조 취소 버튼
			$("#removeReferrer").on("click", function(){
				$("#referrerTable>tbody").html("");
				$('#approvalLine').jstree("deselect_all");
			});
			
			
		
	})
	//end
	
	
	
	//임시저장버튼
function temporarySave(event){
	event.preventDefault();
	
	var line = $("#approvalLineForm");
	var approval = $("#approvalForm");
	
	
	Swal.fire({
		  title: "임시저장 하시겠습니까?",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "저장",
		  cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
			  
			if($("#title").val() ==""){
				toastr.error("작성중인 내용이 없습니다.");
				return ;
			}
			 
			approval.attr('action','./approvalTemporarySave.do');
			approval.submit();
		  }
		});
	
}


//결재상신버튼
function approvalRequest(event){
	event.preventDefault();
	
	console.log('결재상신');
	
	var line = $("#approvalLineForm");
	var approval = $("#approvalForm");
	
	var remainingLeave = $("#remainingLeave").val();
	var applicationLeave = $("#applicationLeave").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var content = $("#content").val();
	
	
	Swal.fire({
		  title: "결재를 요청합니다",
		  icon: "success",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "확인",
		  cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
			  
				//유효성검사 공통
				if($("#title").val() == ""){
					toastr.error("제목을 입력해주세요.");
					$("#title").focus();
					return;
				} else if(startDate == "") {
					toastr.error("시작날짜를 입력해주세요.");
					return;
				} else if(endDate == ""){
					toastr.error("종료날짜를 입력해주세요.");
					return;
				} 
				
				//휴가신청서
				if(content == ""){
					toastr.error("휴가사유를 입력해주세요.");
					$("#content").focus();
					return;
				}
				
				if(parseInt($("#remainingLeave").val()) < parseInt($("#applicationLeave").val())){
					toastr.error("잔여연차보다 신청연차가 많습니다.");
					$("#endDate").focus();
					return;
				}
				
				
				//출장보고서
				if($("#businessTripDestination").val() == ""){
					toastr.error("출장지를 입력해주세요.");
					return;
				} else if($("#businessTripPurpose").val() == ""){
					toastr.error("출장목적을 입력해주세요.");
					return;
				} else if($("#reportItem1").val() == ""){
					toastr.error("보고항목을 입력해주세요.");
					return;
				} else if($("#contentDetails1").val() == ""){
					toastr.error("보고내용을 입력해주세요.");
					return;
				} 
				
				
				
				//결재선이 있는지 확인후 전송 없다면 전송불가
				var approvalTableTr = $("#approvalTable>tbody>Tr");
				
				if(approvalTableTr.length > 0){
					approval.attr('action','./approvalSubmit.do');
					approval.submit();
				} else{
					toastr.error("결재자를 선택해주세요..");
					return ;
				}
			
			
			}
			
		});
	
}
	
</script>
</html>