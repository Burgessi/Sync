//조직도 jsTree
			
			//임시저장 결재상신버튼
			function approvalRequestee(event){
				event.preventDefault();
				let frm = $("#modifyForm");
				
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
								frm.attr('action','./tempApprovalSubmit.do');
								frm.submit();
							} else{
								toastr.error("결재자를 선택해주세요..");
								return ;
							}
						
						
						}
						
					});
				
		
			}
			
			
			


			
			//jstree 시작
			var menu_json = null;
			
			// 서버에 데이터 요청
			$.ajax({
			   	type : "POST",
			   	url : './approvalJstree.do',
			   	success: function(data){
				
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
				 if(selectedNodes.length > 3){
					 $('#approvalLine').jstree(true).deselect_node(data.node);
					 toastr.info("3명만 선택 가능합니다.");
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
			        toastr.info("추가할 수 있는 결재자가 없습니다.");
			        $('#approvalLine').jstree("deselect_all");
			        return false;
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
					                    '<td>' + name.substring(0,name.indexOf(" (")) + '</td>' +
					                    '<td>' + selectedNodes[i].original.rank + '</td>' +
					                    '<td style="width: 125px;">' + selectedNodes[i].original.team + '</td>' +
					                    '<td>' +
			                                '<input type="button" class="removeLineBtn">' +
			                                '<input type="hidden" name="approvalLine' + lineIdx+1 + '" value="' + selectedNodes[i].id + '">' +
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
				
				
				let currentRowCount02 = $("#referrerTable>tbody>tr").length;
				let maxRowCount = 5;
				
				let rowsToAdd = Math.min(selectedNodes.length, maxRowCount - currentRowCount02);
				
				if(rowsToAdd <=0){
					toastr.warning("추가할 수 있는 참조자가 없습니다.");
					$('#approvalLine').jstree("deselect_all");
					return false;
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