		
		$(document).ready(function(){
			//사인
			 var canvas = document.getElementById("signature");
			 var signaturePad = new SignaturePad(canvas);
//			 signaturePad.minWidth = 5;
//			 signaturePad.maxWidth = 10;
//			 signaturePad.penColor = "rgb(66, 133, 244)";
			 
			 
			  $('#clear-signature').on('click', function(){
			        signaturePad.clear();
			 });
	
			$("#save-signature").on('click',function(){
				if(signaturePad.isEmpty()){
					toastr.warning("서명을 입력해주세요.");
					return;
				} 
				
				// 서명을 이미지 URL로 변환
				var dataURL = signaturePad.toDataURL();
				
				$.ajax({
		            url: './saveSignature.do', // 서버의 URL
		            method: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({ 
						image: dataURL
					}),
		            success: function(response) {
		                toastr.success("서명이 저장되었습니다.");
		            }
		        });
				
				 
//		        var link = document.createElement('a');
//		        link.href = dataURL;
//		        link.download = 'signature.png'; // 다운로드할 파일 이름
//		        link.click(); // 링크 클릭으로 다운로드 트리거
				
			});
			
			 // 서명 이미지를 데이터 URL 형식으로 반환합니다 (가능한 매개변수 목록은 https://mdn.io/todataurl에서 확인할 수 있습니다).
//			 signaturePad.toDataURL(); // 이미지를 PNG 형식으로 저장
//	
//			 // 데이터 URL로부터 서명 이미지를 그립니다 (주로 https://mdn.io/drawImage 메서드를 사용합니다).
//			 // NOTE: 이 메서드는 내부 데이터 구조를 채우지 않으므로 #fromDataURL 사용 후 #toData는 제대로 작동하지 않습니다.
//			 signaturePad.fromDataURL("data:image/png;base64,iVBORw0K...");
//	
//			 // 데이터 URL로부터 서명 이미지를 그리고 주어진 옵션으로 수정합니다.
//			 signaturePad.fromDataURL("data:image/png;base64,iVBORw0K...", { ratio: 1, width: 400, height: 200, xOffset: 100, yOffset: 50 });
//	
//			 // 서명 이미지를 포인트 그룹 배열로 반환합니다.
//			 const data = signaturePad.toData();
//	
//			 // 포인트 그룹 배열로부터 서명 이미지를 그립니다.
//			 signaturePad.fromData(data);
//	
//			 // 포인트 그룹 배열로부터 서명 이미지를 그리며 기존 이미지를 지우지 않습니다 (기본적으로 clear는 true입니다).
//			 signaturePad.fromData(data, { clear: false });
//	
//			 // 캔버스가 비어 있으면 true를 반환하고, 그렇지 않으면 false를 반환합니다.
//			 signaturePad.isEmpty();
//	
//			 // 모든 이벤트 핸들러의 바인딩을 해제합니다.
//			 signaturePad.off();
//	
//			 // 모든 이벤트 핸들러의 바인딩을 다시 설정합니다.
//			 signaturePad.on();
		})
			
			
			
			 