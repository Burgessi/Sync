
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

function validateForm() {
//    var form = document.getElementById(formId);
    //var form = document.getElementById(formId);
//    var ssnInput = form.querySelector('input[name="emp_ssn"]'); 
    //var errorMessage = form.querySelector('#error-message');
       
 
//    var nameInput = form.querySelector('#emp_name');
//    //var genderInputs = form.querySelectorAll('input[name="emp_gender"]');
//    var divisionSelect = form.querySelector('select[name="division"]');
//    var teamSelect = form.querySelector('select[name="team_code"]');
//    var rankSelect = form.querySelector('select[name="rank_id"]');
//    var hireDateInput = form.querySelector('input[name="emp_hire_date"]');
    
    //var isValid = true;
	var nameInput = $('#emp_name');
	var ssnInput = $('#emp_ssn');  
	var genderInput = $('#emp_gender');
	var divisionInput = $('#division');
	var teamInput = $('#team_code');
	var rankInput = $('#rank_id');
    var hireDate = $('#emp_hire_date');
	var authority = $("#authority");

	var date = new Date();
	var year = date.getFullYear();
	var month = (date.getMonth() + 1) < 10 ? "0"+(date.getMonth() + 1).toString() : (date.getMonth() + 1);
	var day = date.getDate() < 10 ? "0"+date.getDate().toString() : date.getDate();
	var today = year + "-" + month + "-" + day;
	
	//오늘날짜 숫자형
	var numericTodayDate = today.replace(/-/g, "");
	var numericHireDate = hireDate.val().replace(/-/g, "");
	console.log(today);



    // 이름 검사
    if(nameInput.val().trim() === '') {	
        nameInput.css({"border" : "2px solid red"});
        toastr.error("이름을 입력해주세요.");
        return;
    } else if(nameInput.val().length < 2){
		toastr.error("이름은 2글자 이상 입력해주세요.");
		nameInput.css({"border" : "2px solid red"});
        return;
	} else {
		nameInput.css({"border" : ""});
    }
    
    // 주민등록번호 검사
    if(ssnInput.val().trim() === '') {
        ssnInput.css({"border" : "2px solid red"});
        toastr.error("주민등록번호를 입력해주세요.");
        return;
    } else if(ssnInput.val().trim().length != 14){
		ssnInput.css({"border" : "2px solid red"});
		toastr.error("주민등록번호 형식이 맞지 않습니다. 13자리 숫자를 입력해 주세요.");
		return;
	}else {
		ssnInput.css({"border" : ""});
    }
    
    //성별 검사
    if(genderInput.val().trim() === ''){
		genderInput.css({"border" : "2px solid red"});
		toastr.error("성별을 선택해주세요.");
		return;
	} else{
		genderInput.css({"border" : ""});
	}
	
	
    //본부 검사
    if(divisionInput.val().trim() === ''){
		divisionInput.css({"border" : "2px solid red"});
		toastr.error("본부를 선택해주세요.");
		return;
	} else{
		divisionInput.css({"border" : ""});
	}
 	   
    //팀 검사
    if(teamInput.val().trim() === ''){
		teamInput.css({"border" : "2px solid red"});
		toastr.error("팀을 선택해주세요.");
		return;
	} else{
		teamInput.css({"border" : ""});
	}
	
	//팀 검사
    if(rankInput.val().trim() === ''){
		rankInput.css({"border" : "2px solid red"});
		toastr.error("직급을 선택해주세요.");
		return;
	} else{
		rankInput.css({"border" : ""});
	}
    
    //입사일 검사
    if(hireDate.val().trim() === ''){
		hireDate.css({"border" : "2px solid red"});
		toastr.error("입사일을 선택해주세요.");
		return;
	} else if (numericTodayDate > numericHireDate){
		hireDate.css({"border" : "2px solid red"});
		toastr.error("입사일은 오늘 이후로 선택 가능합니다. 다시 선택해 주세요.");
		return;
	} else {
		hireDate.css({"border" : ""});
	}
    
    //권한 검사
    if(authority.val().trim() === ''){
		authority.css({"border" : "2px solid red"});
		toastr.error("권한을 선택해주세요.");
		return;
	} else{
		authority.css({"border" : ""});
	}
    
}
    
    
// 
    
    // 성별 검사
//    var genderChecked = Array.from(genderInputs).some(input => input.checked);
//    if (!genderChecked) {
//        genderInputs.forEach(input => input.style.outline = '2px solid red');
//        isValid = false;
//    } else {
//        genderInputs.forEach(input => input.style.outline = '');
//    }
    
    // 본부 검사
//    if (divisionSelect.value === '') {
//        divisionSelect.style.borderColor = 'red';
//        isValid = false;
//    } else {
//        divisionSelect.style.borderColor = '';
//    }
//
//    // 팀 검사
//    if (teamSelect.value === '') {
//        teamSelect.style.borderColor='red';
//        isValid = false;
//    } else {
//        teamSelect.style.borderColor='';
//    }
//
//    // 직급 검사
//    if (rankSelect.value === '') {
//        rankSelect.style.borderColor='red';
//        isValid = false;
//    } else {
//        rankSelect.style.borderColor='';
//    }
//
//    // 입사일 검사
//    if (hireDateInput && hireDateInput.value === '') {
//        hireDateInput.style.borderColor='red';
//        isValid = false;
//    } else if (hireDateInput) {
//        hireDateInput.style.borderColor='';
//    }
    
    // 주민등록번호 검사
//      if (ssnInput) {
//        var ssn = ssnInput.value.replace(/\D/g, ''); // 숫자만 추출
//        if (ssn.length !== 13) {
//            errorMessage.textContent = '주민등록번호는 13자리여야 합니다.';
//            ssnInput.style.borderColor = 'red';
//            isValid = false;
//        } else {
//            errorMessage.textContent = ''; // 에러 메시지 제거
//            ssnInput.style.borderColor = '';
//        }
//    }
//    
//    return isValid;
//}

//유효성 검사 및 주민등록번호 포맷
//document.addEventListener('DOMContentLoaded', function() {
//    var form = document.getElementById('regist-form');
//    //var ssnInput = document.getElementById('emp_ssn'); // id로 선택
//    //var errorMessage = document.getElementById('error-message');
//
//    // 폼 제출 시 유효성 검사
//    form.addEventListener('submit', function(event) {
//        if (!validateForm('regist-form')) {
//            event.preventDefault(); // 유효하지 않으면 제출 방지
//        }
//    });
//
//    // 주민등록번호 입력 시 포맷
//    var ssnInput = document.querySelector('input[name="emp_ssn"]');
//    if (ssnInput) {
//        ssnInput.addEventListener('input', function() {
//            formatSSN(this); // 주민등록번호 입력할 때만 호출
//        });
//    }
//});

