<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재직증명서</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
<style>
@page {
    size: A4;
    margin: 10mm; /* A4 용지 여백 */
}

.container {
/*     width: 100%; */
	width: 210mm;
	height: 297mm;
    margin: 0 auto;
    border: 1px solid #000; /* 전체 컨테이너 테두리 추가 */
    padding: 10mm; /* 내용과 테두리 사이의 여백 추가 */
    box-sizing: border-box;
    position: relative; /* 자식 요소의 절대 위치 기준 */
}

#pdfContent {
     width: 680px; 
     height: 842px; 
    margin: 0 auto; 
/* width:100%; */
/* height:100%; */
    position: relative; /* 도장과 텍스트의 배치를 위해 relative 추가 */
}

h2 {
    text-align: center;
    margin-top: 100px; /* 제목과 페이지 상단 사이의 여백 조정 */
}

.table {
    width: 100%;
    margin-top: 40px; /* 테이블의 위쪽 여백을 조정하여 제목과의 거리 조정 */
    border-collapse: collapse;
    border: 1px solid #000; /* 테이블의 전체 테두리 */
}

.table th, .table td {
    border: 1px solid #000; /* 셀별 테두리 */
    padding: 10px;
    text-align: center;
    font-size: 0.9em;
}

.table th {
    background: #F2F2F2;
    font-weight: bold;
}

.table input[type="text"] {
    width: 90%;
    padding: 5px;
    box-sizing: border-box;
}

.bottom {
    position: absolute;
    bottom: 20mm; /* A4 용지 하단 여백 */
    right: 20mm; /* A4 용지 오른쪽 여백 */
    width: 250px;
    font-size: 0.9em;
    text-align: center;
}

.bottom .d-flex {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: absolute; /* 도장 위치를 고정하기 위해 absolute 사용 */
    bottom: 20mm; /* 정확한 하단 위치 */
    right: 20mm; /* 정확한 오른쪽 위치 */
}

.bottom .picture1 {
    margin-top: 10px;
    position: relative;
}

.bottom .picture1 span {
    display: block;
    margin: 2px 0;
    position: absolute; /* 절대 위치 설정으로 이미지와 겹치도록 조정 */
    top: 40px; /* 글씨가 이미지와 겹치는 높이 조절 */
    left: 30px; /* 글씨가 이미지와 겹치는 좌우 조절 */
    color: black; /* 텍스트 색상 설정 */
    background-color: transparent; /* 배경 투명하게 설정 */
}

.bottom img {
    width: 100px; /* 도장 이미지 크기 조절 */
    position: relative; /* 상대적 위치 조정 */
    z-index: 1; /* 이미지가 텍스트 아래에 있도록 조정 */
}

p {
    margin-top: 80px; /* 위쪽 여백을 조정하여 텍스트가 페이지 하단에 더 가까이 위치하도록 조정 */
    text-align: center;
}


</style>
</head>
<body>

    <div class="container" id="pdfContent">

        <h2 style="text-align: center;  margin-top: 50px;">재직증명서</h2>

        <table class="center table">
            <tr>
                <th rowspan="2">인적사항</th>
                <th>성 명</th>
                <td>${infoDto.emp_name}</td>
                <th>주민등록번호</th>
                <td>${infoDto.emp_ssn}</td>
            </tr>
            <tr>
                <th>회사 주소</th>
                <td colspan="3">서울특별시 금천구 가산디지털2로 95(가산동, km타워) 2층, 3층</td>
            </tr>
            <tr>
                <th rowspan="3">재직사항</th>
                <th>본 부</th>
                <td>${infoDto.division_name}</td>
                <th>팀</th>
                <td>${infoDto.team_name}</td>
            </tr>
            <tr>
                <th>직 급</th>
                <td>${infoDto.rank_name}</td>
                <th>직 책</th>
                <td><span class="lead-title">${infoDto.emp_lead}</span></td>
            </tr>
            <tr>
                <th>재직기간</th>
                <td colspan="3">${infoDto.emp_hire_date}- <c:if
                        test="${infoDto.emp_leaving_date == null}">
                        현재
                    </c:if> 
                    <c:if test="${infoDto.emp_leaving_date != null}">
                        ${infoDto.emp_leaving_date}
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>발급용도</th>
                <td colspan="4"><span class="purpose-title">${infoDto.certi_type}</span>
                </td>
            </tr>
        </table>

        <p style="font-weight: bold;">위와 같이 재직하고 있음을
            증명합니다.</p>

        <!-- 새로운 도장 및 날짜 영역 추가 -->
        <div class="bottom">
            
            <div class="d-flex flex-column right picture1">
                <img src="./resources/img/stamp.png" alt="도장 이미지">
                <!-- 도장 이미지 파일 경로 -->

                <span class="span1" style="z-index: 2; top: 40px; left: 30px; font-weight: bold;">구디 아카데미</span> 
                <span class="span1" style="z-index: 2; top: 60px; left: 30px; font-weight: bold;">대표 이승엽</span>
            </div>
        </div>
    </div>


	<script>
		function getLeadTitle(empLead) {
			// emp_lead 값에 따른 한글 직급 매핑
			const leadMapping = {
				'N' : '일반사원',
				'D' : '본부장',
				'T' : '팀장',
			};

			return leadMapping[empLead.toUpperCase()] || '일반사원'; // 기본값 '일반사원'
		}

		function getPurposeTitle(certiType) {
			// certi_type 값에 따른 한글 발급용도 매핑
			const purposeMapping = {
				'A' : '관공서 제출용',
				'B' : '공공기관 제출용',
				'C' : '회사 제출용',
				'D' : '기타'
			};

			return purposeMapping[certiType.toUpperCase()] || '기타'; // 기본값 '기타'
		}

		function updateLeadTitle() {
			// emp_lead 값 가져오기
			const empLead = '${infoDto.emp_lead}';
			// 매핑된 값을 한글로 변환
			const leadTitle = getLeadTitle(empLead);

			// HTML에 직급을 삽입
			const leadElement = document.querySelector('.lead-title');
			if (leadElement) {
				leadElement.innerText = leadTitle;
			}
		}

		function updatePurposeTitle() {
			// certi_type 값 가져오기
			const certiType = '${infoDto.certi_type}';
			// 매핑된 값을 한글로 변환
			const purposeTitle = getPurposeTitle(certiType);

			// HTML에 발급용도를 삽입
			const purposeElement = document.querySelector('.purpose-title');
			if (purposeElement) {
				purposeElement.innerText = purposeTitle;
			}
		}

		function downloadPDF() {
			const element = document.getElementById('pdfContent');

			// HTML2PDF 옵션 설정
			const opt = {
				//margin : 1,
				margin: [10, 10, 10, 10],
				filename : '재직증명서.pdf',
				image : {
					type : 'jpeg',
					quality : 0.98
				},
				html2canvas : {
					scale : 2
				},
				jsPDF : {
					//unit : 'in',
					//format : 'a4',
					unit: 'mm',
            		format: [210, 297],
					orientation : 'portrait'
				}
			};

			// 콘텐츠를 PDF로 변환
			html2pdf().from(element).set(opt).save()
			.then(() => {
				setTimeout(() => {
					 window.history.back();  
	            }, 3000);  //3초
	        });

		    
		}

		window.onload = function() {
			updateLeadTitle();
			updatePurposeTitle();
			downloadPDF();
		};
	</script>
</body>
</html>
