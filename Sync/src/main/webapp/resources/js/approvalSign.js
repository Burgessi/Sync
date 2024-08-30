		
		
		var approvalId = $("#approvalId").val();
		var recipientId = $("#save-signature").val();
		var dataURL = "";
		
		$(document).ready(function(){
			
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
		let documentType = $("#documentType").val();
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
			
	
	
	
	
			 