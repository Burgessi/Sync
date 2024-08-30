
// 유효성 검사 안먹음/ 다시
//function formatSSN(input) {
//    var value = input.value.replace(/\D/g, ''); // 숫자 외 문자 제거
//    if (value.length <= 6) {
//        input.value = value; // 6자리 이하일 경우, 그냥 입력
//    } else if (value.length <= 13) {
//        input.value = value.slice(0, 6) + '-' + value.slice(6); // 6자리 후 하이픈 추가
//    } else {
//        input.value = value.slice(0, 6) + '-' + value.slice(6, 13); // 13자리까지만 입력
//    }
//}

function validateForm(formId) {
    var form = document.getElementById(formId);
    //var form = document.getElementById(formId);
    var ssnInput = form.querySelector('input[name="emp_ssn"]'); 
    //var errorMessage = form.querySelector('#error-message');
    
    var nameInput = form.querySelector('input[name="emp_name"]');
    //var genderInputs = form.querySelectorAll('input[name="emp_gender"]');
    var divisionSelect = form.querySelector('select[name="division"]');
    var teamSelect = form.querySelector('select[name="team_code"]');
    var rankSelect = form.querySelector('select[name="rank_id"]');
    var hireDateInput = form.querySelector('input[name="emp_hire_date"]');
    
    var isValid = true;

    // 이름 검사
    if (nameInput.value.trim() === '') {
		//alert('dddd');
        nameInput.style.borderColor = 'red';
        isValid = false;
    } else {
        nameInput.style.borderColor = '';
    }
    
    // 성별 검사
//    var genderChecked = Array.from(genderInputs).some(input => input.checked);
//    if (!genderChecked) {
//        genderInputs.forEach(input => input.style.outline = '2px solid red');
//        isValid = false;
//    } else {
//        genderInputs.forEach(input => input.style.outline = '');
//    }
    
    // 본부 검사
    if (divisionSelect.value === '') {
        divisionSelect.style.borderColor = 'red';
        isValid = false;
    } else {
        divisionSelect.style.borderColor = '';
    }

    // 팀 검사
    if (teamSelect.value === '') {
        teamSelect.style.borderColor='red';
        isValid = false;
    } else {
        teamSelect.style.borderColor='';
    }

    // 직급 검사
    if (rankSelect.value === '') {
        rankSelect.style.borderColor='red';
        isValid = false;
    } else {
        rankSelect.style.borderColor='';
    }

    // 입사일 검사
    if (hireDateInput && hireDateInput.value === '') {
        hireDateInput.style.borderColor='red';
        isValid = false;
    } else if (hireDateInput) {
        hireDateInput.style.borderColor='';
    }
    
    // 주민등록번호 검사
      if (ssnInput) {
        var ssn = ssnInput.value.replace(/\D/g, ''); // 숫자만 추출
        if (ssn.length !== 13) {
            errorMessage.textContent = '주민등록번호는 13자리여야 합니다.';
            ssnInput.style.borderColor = 'red';
            isValid = false;
        } else {
            errorMessage.textContent = ''; // 에러 메시지 제거
            ssnInput.style.borderColor = '';
        }
    }
    
    return isValid;
}

//유효성 검사 및 주민등록번호 포맷
document.addEventListener('DOMContentLoaded', function() {
    var form = document.getElementById('regist-form');
    //var ssnInput = document.getElementById('emp_ssn'); // id로 선택
    //var errorMessage = document.getElementById('error-message');

    // 폼 제출 시 유효성 검사
    form.addEventListener('submit', function(event) {
        if (!validateForm('regist-form')) {
            event.preventDefault(); // 유효하지 않으면 제출 방지
        }
    });

    // 주민등록번호 입력 시 포맷
    var ssnInput = document.querySelector('input[name="emp_ssn"]');
    if (ssnInput) {
        ssnInput.addEventListener('input', function() {
            formatSSN(this); // 주민등록번호 입력할 때만 호출
        });
    }
});