<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div>
	<!-- 비밀번호 영역 -->
	<div class="card-header mt-1 py-3">
		<h4 class="mb-0" id="simple-list-item-4">비밀번호 변경</h4>
	</div>
	<div class="card-body" style="max-width: 900px">
		<div class="emp-password" style="width: 100%;">
			<form id="emp-passwordChangeForm" action="" method="post">
			    <div class="mb-3">
			        <label for="newPassword" class="form-label">새 비밀번호</label>
			        <input type="password" class="form-control" id="newPassword" name="newPassword" required style="width: 50%">
			        <div id="passwordError" style="color: red; display: none;">비밀번호는 숫자와 영문 대/소문자를 포함하여 8자리 이상이어야 합니다.</div>
			    </div>
			    <div class="mb-3">
			        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
			        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required style="width: 50%">
			        <div id="confirmPasswordError" style="color: red; display: none;">비밀번호가 일치하지 않습니다.</div>
			    </div>
			    <button type="button" id="pwsubmitBtn">수정</button>
			</form>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
    $('#pwsubmitBtn').on('click', function() {
        var newPassword = $('#newPassword').val();
        var confirmPassword = $('#confirmPassword').val();

        var passwordError = $('#passwordError');
        var confirmPasswordError = $('#confirmPasswordError');

        // 비밀번호 유효성 검사: 숫자, 대문자, 소문자를 포함한 8자리 이상
        var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;

        if (!passwordRegex.test(newPassword)) {
            passwordError.show();
            return; // 유효성 검사 실패 시 Ajax 요청 막기
        } else {
            passwordError.hide();
        }

        // 비밀번호 일치 여부 확인
        if (newPassword !== confirmPassword) {
            confirmPasswordError.show();
            return; // 일치하지 않을 경우 Ajax 요청 막기
        } else {
            confirmPasswordError.hide();
        }

        // 유효성 검사를 통과하면 Ajax로 비밀번호 변경 요청
        var formData_pw = $('#emp-passwordChangeForm').serialize();  // 폼 데이터를 시리얼라이즈하여 문자열로 변환

        $.ajax({
            type: 'POST',
            url: './updateMyPassword.do',  // 경로를 명확하게 설정
            data: formData_pw,
            success: function(response) {
                alert('비밀번호가 성공적으로 변경되었습니다!');
            },
            error: function(xhr, status, error) {
                alert('비밀번호 변경 중 오류가 발생했습니다: ' + error);
                console.log(xhr.responseText); // 에러 상세 로그
            }
        });
    });
});
</script>