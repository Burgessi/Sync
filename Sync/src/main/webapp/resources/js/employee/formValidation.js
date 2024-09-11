
function validateForm() {
   
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
    
    //입사일 검사
    if(hireDate != "" || hireDate != null || hireDate != undefined){
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
   }
    
    //권한 검사
    if(authority.val().trim() === ''){
      authority.css({"border" : "2px solid red"});
      toastr.error("권한을 선택해주세요.");
      return;
   } else{
      authority.css({"border" : ""});
   }
   return true;
    
    
    
    
    
    
}
    
    

