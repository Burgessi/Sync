<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 개인정보 조회 영역 -->
<div class="card-header mt-1 py-3" >
	<h4 class="mb-0">내 정보 조회</h4>
</div>
<div class="card-body" style="max-width: 900px">
	<section class="section d-flex">
			<div class="emp-info pic" style="width: 50%;">
			    <c:choose>
			        <c:when test="${not empty infoDto.emp_profile_pic}">
			            <img id="imagePreview"
			                style="border-radius: 5%; width: 150px; height: 200px; object-fit: cover"
			                src="${infoDto.emp_profile_pic}" 
			                alt="이미지" onclick="showForm()" />
			        </c:when>
			        <c:otherwise>
			            <img id="imagePreview"
			                style="border-radius: 5%; width: 150px; height: 200px; object-fit: cover"
			                src="${root}/resources/img/member-imgs/cloud.jpeg" 
			                alt="profile" onclick="showForm()"/>
			        </c:otherwise>
			    </c:choose>
			</div>

		<div class="emp-info ">
			<table class="table">

				<tr>
					<td>이름</td>
					<td>${infoDto.emp_name}</td>
				</tr>
				<tr>
					<td>본부</td>
					<td>${infoDto.division_name }</td>
				</tr>
				<tr>
					<td>팀</td>
					<td>${infoDto.team_name }</td>
				</tr>
				<tr>
					<td>직급</td>
					<td>${infoDto.rank_name }</td>
				</tr>
				<tr>
					<td>입사일</td>
					<td>${infoDto.emp_hire_date}</td>
				</tr>
				<tr>
					<td>주민등록번호</td>
					<td>${infoDto.emp_ssn }</td>
				</tr>
			</table>
		</div>
	</section>
	<form id="profileForm" style="visibility: hidden;">
		<input type="file" name="profilePic" accept="image/*" onchange="chooseImage(this)"/>
		<button type="button" onclick="updateImage()">저장</button>
	</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    function showForm() {
        document.getElementById('profileForm').style.visibility = 'visible';
    }
</script>

<script>
function chooseImage(obj){
	console.log(obj.files);
	console.log(obj.files[0]);
	var file = obj.files[0];
	if(!file.type.match("image.*")){
	     alert("이미지를 등록해야 합니다.")
	     return;
	}
	let reader = new FileReader();
	reader.readAsDataURL(file);
	reader.onload = function (e){ 
		  // 콜백함수를 등록 readAsDataURL 끝나면 다음 함수를 실행해라 !
		  	   console.log(e);
		       $('#imagePreview').attr("src",e.target.result);
		    }
}

function updateImage() {
    let profileForm = $('#profileForm')[0];
    console.log(profileForm);
    
    let profileformData = new FormData(profileForm);
    $.ajax({
        type: "post",
        url: "./updateProfilePic.do",
        contentType: false,
        processData: false,
        data: profileformData,
        enctype: "multipart/form-data",
        dataType: "json"
    }).done((res) => {
        console.log("Success Response: ", res);  // 서버에서 반환된 응답 확인
        alert(res.msg || "프로필 이미지가 성공적으로 업데이트되었습니다.");
        location.href = "/";
    }).fail((err) => {
        console.log("Error Response: ", err);  // 서버에서 반환된 에러 응답 확인
        alert(err.responseJSON?.msg || "프로필 이미지 업데이트 중 오류가 발생했습니다.");
    });
}

</script>
