<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재직증명서</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
    <style>
    @page {
            size: A4;
            margin: 20mm; /* A4 용지 여백 */
        }
        .container {
            width: 100%;
            margin: 0 auto;
        }
        .table {
            width: 100%;
            margin-top: 40px;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #000;
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
    </style>
</head>
<body>

    <div class="container" id="pdfContent">

        <h4 style="text-align: center;">재직증명서</h4>

        <table class="table table-bordered certi-table">
            <tr>
                <th rowspan="2">인적사항</th>
                <th>성 명</th>
                <td>
                    ${infoDto.emp_name}
                </td>
                <th>주민등록번호</th>
                <td>
                    ${infoDto.emp_ssn}                     
                </td>
            </tr>
            <tr>
                <th>주 소</th>
                <td colspan="3">
                    서울특별시 금천구 가산디지털2로 95(가산동, km타워) 2층, 3층
                </td>
            </tr>
            <tr>
                <th rowspan="3">재직사항</th>
                <th>본 부</th>
                <td>
                    ${infoDto.division_name}
                </td>
                <th>팀</th>
                <td>
                    ${infoDto.team_name}
                </td>
            </tr>
            <tr>
                <th>직 급</th>
                <td>
                    ${infoDto.rank_name}
                </td>
                <th>직 책</th>
                <td>
                    <span class="lead-title">${infoDto.emp_lead}</span>
                </td>
            </tr>
            <tr>
                <th>재직기간</th>
                <td colspan="3">
                    ${infoDto.emp_hire_date} - 
                    <c:if test="${infoDto.emp_leaving_date == null}">
                        현재
                    </c:if>
                    <c:if test="${infoDto.emp_leaving_date != null}">
                        ${infoDto.emp_leaving_date}
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>발급용도</th>
                <td colspan="4">
                    ${infoDto.certi_type}
                </td>
            </tr>
        </table>

        <p style="margin-top: 20px; text-align: center;">위와 같이 재직하고 있음을 증명합니다.</p>

    </div>

    <script>
        function getLeadTitle(empLead) {
            // emp_lead 값에 따른 한글 직급 매핑
            const leadMapping = {
                'N': '일반사원',
                'D': '본부장',
                'T': '팀장',
            };
            
            return leadMapping[empLead.toUpperCase()] || '일반사원'; // 기본값 '일반사원'
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

        function downloadPDF() {
            const element = document.getElementById('pdfContent');

            // HTML2PDF 옵션 설정
            const opt = {
                margin: 1,
                filename: '재직증명서.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            };

            // 콘텐츠를 PDF로 변환
            html2pdf().from(element).set(opt).save();
        }

        window.onload = function() {
            updateLeadTitle();
            downloadPDF();
        };
    </script>
</body>
</html>
