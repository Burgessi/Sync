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
			    <div class="image-container" onclick="showForm()" >
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
			        <div class="hover-text">클릭하여 이미지 수정</div>
			    </div>
			</div>


		<div class="emp-info ">
			<table class="table table-borderless">

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
	<form class="form-horizontal" id="profileForm" style="visibility: hidden;">
		<input type="file" name="profilePic" accept="image/*" onchange="chooseImage(this)" style="width: 300px;"/>
		<button class="btn btn-primary" type="button" onclick="updateImage()">저장</button>
	</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    function showForm() {
        document.getElementById('profileForm').style.visibility = 'visible';
    }
</script>

<script>
// function checkImageAndSetSrc(imgElement, imgUrl, defaultImgUrl) {
//     var img = new Image();
//     img.onload = function() {
//         // 이미지가 존재하는 경우
//         $(imgElement).attr('src', imgUrl);
//     };
//     img.onerror = function() {
//         // 이미지가 존재하지 않는 경우
//         $(imgElement).attr('src', defaultImgUrl);
//     };
//     img.src = imgUrl;
// }

// $(document).ready(function() {
//     var imgElement = '#imagePreview';
//     var defaultImgUrl = '${root}/resources/img/member-imgs/cloud.jpeg';

//     // 전역 변수로 저장된 profilePicUrl을 사용
//     var profilePicUrl = window.profilePicUrl || '${infoDto.emp_profile_pic}';

//     console.log("Initial profilePicUrl: ", profilePicUrl); // 초기 값 확인
//     checkImageAndSetSrc(imgElement, profilePicUrl, defaultImgUrl);
// });

function chooseImage(obj) {
    var file = obj.files[0];
    if (!file.type.match("image.*")) {
        alert("이미지를 등록해야 합니다.");
        return;
    }
    let reader = new FileReader();
    reader.readAsDataURL(file);
    //사이드바,헤더이미지도 바꿀수잇나
    reader.onload = function (e) {
        $('#imagePreview').attr("src", e.target.result);
        $('#headerPreview').attr("src", e.target.result);
        $('#sidebarPreview').attr("src", e.target.result);
    }
}

function updateImage() {
    let profileForm = $('#profileForm')[0];
    let profileFormData = new FormData(profileForm);
    
    $.ajax({
        type: "post",
        url: "./updateProfilePic.do",
        contentType: false,
        processData: false,
        data: profileFormData,
        dataType: "json"
    }).done((res) => {
        // 성공적으로 업데이트된 경우
        if (res.fileUrl) {
            console.log(res.fileUrl);
            // 이미지 URL 업데이트
            $('#imagePreview').attr('src', res.fileUrl);
        }
        toastr.success(res.msg || "프로필 이미지가 성공적으로 업데이트되었습니다.");
    }).fail((err) => {
        // 에러가 발생한 경우
        console.log("Error Response: ", err);
        toastr.error('프로필 이미지 업데이트 중 오류가 발생했습니다.');
//         alert("프로필 이미지 업데이트 중 오류가 발생했습니다.");
    });
}


</script>

