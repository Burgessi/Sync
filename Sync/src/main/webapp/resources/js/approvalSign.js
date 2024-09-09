		
		
		
		var recipientId = $("#save-signature").val();
		var dataURL = "";
		var approvalId = $("#approvalId").val();
		var documentType = $("#documentType").val();		
		
		function pdf(name){
			
			
				let documentType = document.getElementById('documentType').value;
				var element = document.getElementById('pdfDownload');
				var opt = {
				  margin:       1,
				  filename:     documentType + '_' + name + '.pdf',
				  image:        { type: 'jpeg', quality: 0.98 },
				  html2canvas:  { scale: 2 },
				  jsPDF:        { unit: 'in', format: [10, 15], orientation: 'portrait' }
				};
			
				// New Promise-based usage:
				html2pdf().set(opt).from(element).save();
			
				// Old monolithic-style usage:
				html2pdf(element, opt);
				
			}
				
				
		$(document).ready(function(){
			
			console.log(documentType);
			
			
			
			//문서 결재 상태
			let approvalStatus = $("#approvalStatus").val();
			
			//문서 결재 상태가 1인경우 바로 최종 결재 상태 업데이트
			if(approvalStatus == 1 && approvalStatus != undefined && approvalStatus != null && approvalStatus != ""){
				
				let approvalStatusForm = new FormData();
				let emp_id = $("#requesterId").val();
				
				
				approvalStatusForm.append("approval_id", approvalId);
				approvalStatusForm.append("approval_status", approvalStatus);
				approvalStatusForm.append("emp_id", emp_id);
				approvalStatusForm.append("document_type", documentType);
				
				
				if(documentType == "휴가신청서" ){
					
					let off_reason = $("#content").text();
					let remainingLeave = $("#remainingLeave").text();
					let totalDay = $("#totalDay").text();
					let startDate = new Date($("#startDate").text());
					let endDate = new Date($("#endDate").text());
					let dates = [];
					
					while (startDate <= endDate) {
				        // 날짜를 'YYYY-MM-DD' 형식으로 변환
				        let year = startDate.getFullYear();
				        let month = String(startDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
				        let day = String(startDate.getDate()).padStart(2, '0');
				        
				        dates.push(`${year}-${month}-${day}`);
				        
				        // 다음 날짜로 넘어가기
				        startDate.setDate(startDate.getDate() + 1);
				    }
					
					
					//신청후 사원 남은 휴가 날짜 update - >employee vo에
					let total_off = (parseInt(remainingLeave) - parseInt(totalDay));
					console.log(total_off);
					approvalStatusForm.append("total_off", total_off);
					
					//off_date : 신청한 날짜 array
					approvalStatusForm.append("off_date", dates);
					
					//off_reason : 휴가사유
					approvalStatusForm.append("off_reason", off_reason);
					
					
				}
				
				
				
				console.log('모든 결재자 승인 완료');
				
				
				$.ajax({
					url:"updateApprovalStatus.do?approval_id="+approvalId+"&approval_status="+approvalStatus,
					type:"post",
					data: approvalStatusForm,
					processData: false, // 데이터 처리 비활성화
        			contentType: false,
					success:function(response){
						console.log("최종 결재 상태 변경 성공", response);
					}
					
					
				})		
				
						
			}			
			
			
			
			console.log("approvalStatus :",approvalStatus);
			//사인
			 var canvas = document.getElementById("signature");
			 var signaturePad = new SignaturePad(canvas);
			 
			 //초기화버튼
			$('#clear-signature').on('click', function(){
			        signaturePad.clear();
			 });
	
			//확인버튼
			$("#save-signature").on('click',function(){
				
				
				
				if(signaturePad.isEmpty()){
					toastr.warning("서명을 입력해주세요.");
					return;
				} 
				
				// 서명을 이미지 URL로 변환
				dataURL = signaturePad.toDataURL();
				
				//ajax로 이미지 저장 요청
				$.ajax({
		            url: './completeApproval.do', // 서버의 URL
		            method: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({ 
						image: dataURL,
						approvalId: approvalId,
						recipientId: recipientId
					}),
		            success: function(response) {
			
						console.log(response);
		                toastr.success("결재 승인 완료");
		                signaturePad.clear();//화면 새로고침
						setTimeout(function() {
						    window.location.reload(true);
						}, 2000);
		                console.log("새로고침");
		                
		                $('#signatureModal').modal('hide');
		                
		            }
		        });
				
				
			});
			
		})
			
	//승인버튼
	function decisionApprov(lineSign) {
		
		let modal = new bootstrap.Modal($("#signatureModal"));
		
		if(lineSign == ""){
			console.log("sign 없음");
			modal.show();
		} else{
			
		    Swal.fire({
				  title: "서명이 존재합니다.",
				  text: "새로 입력하시겠습니까?",
				  icon: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#3085d6",
				  cancelButtonColor: "#28a745",
				  confirmButtonText: "서명 변경",
				  cancelButtonText: "문서 승인",
				  showCloseButton: true,
				  allowOutsideClick: false
				  
				  }).then((result) => {
					if (result.isConfirmed) {
						modal.show();
				   } else if(result.dismiss === Swal.DismissReason.cancel){
					
					 // 서명그대로 사용할경우. 바로 승인.  
					 //ajax로 이미지 저장 요청
						$.ajax({
				            url: './completeApproval.do', // 서버의 URL
				            method: 'POST',
				            contentType: 'application/json',
				            data: JSON.stringify({ 
								image: dataURL,
								approvalId: approvalId,
								recipientId: recipientId
							}),
				            success: function(response) {
					
					
									
								console.log(response);
				                toastr.success("결재 승인 완료");
								setTimeout(function() {
								    window.location.reload(true);
								}, 2500);
				                console.log("새로고침");
				                
				            }
				        });
				   }
				});
			
		}
		
	}
	
	//반려버튼
	$("#rejectionApproval").on("click",function(){
		
		let modal = new bootstrap.Modal($("#rejectionModal"));
		modal.show();
		
	})

	//반려 제출
	$('#rejectionForm').on('submit', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작 방지
        
        let formData = new FormData(this); // 현재 폼의 데이터를 FormData 객체로 변환
        
        $.ajax({
            url: './rejectionApproval.do', // 서버의 엔드포인트 URL
            type: 'POST', // HTTP 메소드
            data: formData, // FormData 객체를 데이터로 전송
            processData: false, // jQuery가 데이터 처리하지 않도록 설정
            contentType: false, // 기본 Content-Type 헤더를 설정하지 않도록 설정
            success: function(response) {
                // 요청이 성공했을 때의 콜백
                console.log('Success:', response);
                
                toastr.warning("결재 반려 완료");
                $('#rejectionModal').modal('hide');
				setTimeout(function() {
				    window.location.reload(true);
				}, 2500);
                
            }
        });
    });

	

	//임시저장 계속작성버튼
	$("#continueTempApproval").on("click",function(){
		let approvalId = $("#approvalId").val();
		
		let temp_save_flag = $("#temp_save_flag").val();
		
		location.href="./modifyApproval.do?approval_id="+approvalId+"&document_type="+documentType+"&temp_save_flag="+temp_save_flag;
	})
	
	
	//임시저장 회수 버튼
	$("#deleteTempApproval").on("click",function(){
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
	})	
	
	//일반 상세보기 수정버튼
	$("#modifyApproval").on("click",function(){
		let flag = $("#lineFlag").val();
		let approvalId = $("#approvalId").val();
		let documentType = $("#documentType").val();
		let temp_save_flag = $("#temp_save_flag").val();
		
		if(flag == 'true'){
			toastr.error("결재가 진행된 문서는 수정할 수 없습니다.");
			return;
		}
		location.href="./modifyApproval.do?approval_id="+approvalId+"&document_type="+documentType+"&temp_save_flag="+temp_save_flag;
		
	})
	
	//일반 상세보기 회수 버튼
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
			
	
	
	
	
			 