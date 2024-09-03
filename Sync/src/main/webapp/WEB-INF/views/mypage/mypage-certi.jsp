<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>증명서 신청 및 출력</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
    <style>
        /* 스타일 추가 */
    </style>
</head>
<body>

<div>
    <br><br>
    <!-- 증명서 신청 영역 -->
    <div class="card-header mt-1 py-3">
        <h4 class="mb-0">증명서 신청</h4>
    </div>
    <div class="card-body" style="max-width: 900px">
        <div class="emp-certi-request" style="width: 100%;">
            <table class="table">
                <thead>
                    <tr>
                        <td>증명서명</td>
                        <td>언어</td>
                        <td>발급가능부수</td>
                        <td>신청부수</td>
                        <td>발급용도</td>
                        <td>신청</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>재직증명서</td>
                        <td>한글</td>
                        <td id="availableCopies">${infoDto.total_certi}</td> <!-- 발급 가능 부수를 설정합니다. -->
                        <td>
                            <input type="number" name="used_certi" id="requestCopies" min="1" value="1" style="width: 60px;">
                        </td>
                        <td>
                            <select name="certi_type" id="purposeSelect" style="width: 100%;">
                                <option value="A">관공서 제출용</option>
                                <option value="B">공공기관 제출용</option>
                                <option value="C">회사 제출용</option>
                                <option value="D">기타</option>
                            </select>
                        </td>
                        <td><button type="button" class="btn btn-primary" onclick="applyRequest()">신청</button></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 증명서 출력 목록 -->
        <div class="emp-certi" style="width: 100%;">
            <h5>증명서 출력</h5>
            <table class="table">
                <thead>
                    <tr>
                        <td>발급일</td>
                        <td>증명서명</td>
                        <td>발급부수</td>
                        <td>발급용도</td>
                        <td>출력</td>
                    </tr>
                </thead>
                <tbody id="issuedCertificates">
                    <!-- 신청된 증명서 리스트가 여기에 추가됩니다. -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
//발급 용도
var purposeMapping={
		 "A": "관공서 제출용",
	     "B": "공공기관 제출용",
	     "C": "회사 제출용",
// 	     "D": "기타"	
};

function applyRequest() {
    var requestCopies = parseInt(document.getElementById("requestCopies").value); //신청부수
    var availableCopiesElement = document.getElementById("availableCopies"); //신청가능부수
    var availableCopies = parseInt(availableCopiesElement.innerText); 
    var purposeCode = document.getElementById("purposeSelect").value; //발급용도
    var purposeText = purposeMapping[purposeCode];

    if (requestCopies <= availableCopies) {
        var isConfirmed = confirm("재직증명서 " + requestCopies + "부를 발급하시겠습니까?");

        if (isConfirmed) {
            availableCopies = availableCopies- requestCopies;
            availableCopiesElement.innerText = availableCopies;
            

            var issuedCertificatesElement = document.getElementById("issuedCertificates");

            for (let i = 0; i < requestCopies; i++) {
                var newRow = issuedCertificatesElement.insertRow();
                var today = new Date();
                var issueDate = today.getFullYear() + "-" + (today.getMonth() + 1).toString().padStart(2, '0') + "-" + today.getDate().toString().padStart(2, '0');

                newRow.innerHTML = 
                    "<td>"+issueDate+"</td>"+
                    "<td>재직증명서</td>"+
                    "<td>1</td>"+
//                     "<td>"+$("#requestCopies").val()+"</td>"+
                    "<td>"+document.getElementById("purposeSelect").options[document.getElementById("purposeSelect").selectedIndex].text+"</td>"+
                    "<td><button class='btn btn-primary' onclick='submitForm(this)'>출력</button></td>";
					
            }
          
            document.getElementById("requestCopies").value = 1;
        } else {
            alert("신청이 취소되었습니다.");
        }
    } else {
        alert("신청 부수가 발급 가능 부수를 초과할 수 없습니다.");
    }
}


function submitForm(button) {
    // 부모 행을 가져옵니다.
    var row = button.parentNode.parentNode;

    // 행의 데이터를 폼 데이터로 전송합니다.
    var issueDate = row.cells[0].innerText;
    var certiName = row.cells[1].innerText;
    var certiCount = row.cells[2].innerText; //발급 부수
    var purpose = row.cells[3].innerText; //발급 용도

    
    var purposeCode = Object.keys(purposeMapping).find(key => purposeMapping[key] === purposeText) || "";
    
    // 폼 생성
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = './certificate.do';

    // 입력 필드 생성
    var inputs = [
        { name: 'issueDate', value: issueDate },
        { name: 'certiName', value: certiName },
        { name: 'certiCount', value: certiCount },
        { name: 'purpose', value: purposeCode }
    ];

    // 폼에 입력 필드 추가
    inputs.forEach(function(input) {
        var inputElement = document.createElement('input');
        inputElement.type = 'hidden';
        inputElement.name = input.name;
        inputElement.value = input.value;
        form.appendChild(inputElement);
    });

    // 폼을 문서에 추가하고 전송합니다.
    document.body.appendChild(form);
    form.submit();
}
</script>

</body>
</html>
