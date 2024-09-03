<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 출퇴근 기록 -->
<style>
        /* 출근 시각을 표시하는 영역을 기본적으로 숨김 */
        #checkInTime {
            display: none;
        }
        /* 퇴근 시각을 표시하는 영역을 기본적으로 숨김 */
        #checkOutTime {
            display: none;
        }
</style>

<div class="card-body" style="max-width: 900px">
	<section class="section d-flex">
			<div class="attendance-record" style="width: 50%;">
			    <div >
			         <button id="check-in-btn">출근</button>
					 <p id="checkInTime">출근 시각: </p>			         
			         <button id="check-out-btn">퇴근</button>
			         <p id="checkOutTime">퇴근 시각: </p>		
			         <p id="workDuration">총 근무 시간: </p> <!-- 근무 시간 표시 -->
			    </div>
			</div>


	</section>
	<form class="form-horizontal" id="profileForm" style="visibility: hidden;">
		<input type="file" name="profilePic" accept="image/*" onchange="chooseImage(this)"/>
		<button class="btn btn-primary" type="button" onclick="updateImage()">저장</button>
	</form>
</div>

<script>
$(document).ready(function() {
    const emp_id = '${loginDto.emp_id}'; // 실제 emp_id는 서버에서 가져오거나 다른 방법으로 설정

    let startTime, endTime, timerInterval;

    // 페이지 로드 시 출근 시각 조회
    $.ajax({
        type: 'GET',
        url: './get-check-in-time.do',
        data: { emp_id: emp_id },
        success: function(response) {
            if (response) {
                $('#checkInTime').text("출근 시각: " + response).show();
            }
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });

    $.ajax({
        type: 'GET',
        url: './get-check-out-time.do',
        data: { emp_id: emp_id },
        success: function(response) {
            if (response) {
                $('#checkOutTime').text("퇴근 시각: " + response).show();
            }
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });

    // 페이지 로드 시 타이머 복원
    function restoreTimer() {
        const savedStartTime = localStorage.getItem('timerStartTime');
        if (savedStartTime) {
            startTime = new Date(savedStartTime);
            const elapsedTime = new Date() - startTime;
            startTimer(elapsedTime); // 타이머를 복원
        }

        const savedWorkDuration = localStorage.getItem('workDuration');
        if (savedWorkDuration) {
            $('#workDuration').text("총 근무 시간: " + savedWorkDuration).show();
        }
    }

    function startTimer(elapsedTime = 0) {
        timerInterval = setInterval(function() {
            const currentTime = new Date();
            const duration = currentTime - startTime + elapsedTime;
            const hours = Math.floor((duration / (1000 * 60 * 60)) % 24);
            const minutes = Math.floor((duration / (1000 * 60)) % 60);
            const seconds = Math.floor((duration / 1000) % 60);

            $('#workDuration').text("총 근무 시간: " + hours + "시간 " + minutes + "분 " + seconds + "초").show();
        }, 1000);

        // 타이머 상태를 localStorage에 저장
        localStorage.setItem('timerStartTime', startTime.toISOString());
    }

    $('#check-in-btn').click(function() {
        startTime = new Date(); // 출근 시각 기록
        $('#checkInTime').text("출근 시각: " + startTime.toLocaleTimeString()).show();

        // 타이머 시작
        startTimer();

        // 출근 정보 서버에 전송
        $.ajax({
            type: 'POST',
            url: './check-in.do',
            contentType: 'application/json',
            data: JSON.stringify({ emp_id: emp_id }), // JSON 형태로 데이터 전송
            success: function(response) {
                toastr.success('출근 처리가 완료되었습니다.');
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                toastr.error(xhr.responseText);
            }
        });
    });

    $('#check-out-btn').click(function() {
        endTime = new Date(); // 퇴근 시각 기록
        clearInterval(timerInterval); // 타이머 멈춤

        // 총 근무 시간 계산
        const duration = endTime - startTime;
        const hours = Math.floor((duration / (1000 * 60 * 60)) % 24);
        const minutes = Math.floor((duration / (1000 * 60)) % 60);
        const seconds = Math.floor((duration / 1000) % 60);

        $('#checkOutTime').text("퇴근 시각: " + endTime.toLocaleTimeString()).show();
        $('#workDuration').text("총 근무 시간: " + hours + "시간 " + minutes + "분 " + seconds + "초").show();

        // 퇴근 정보와 근무 시간을 서버에 전송
        $.ajax({
            type: 'POST',
            url: './check-out.do',
            contentType: 'application/json',
            data: JSON.stringify({ 
                emp_id: emp_id,
                work_duration: hours + ":" + minutes + ":" + seconds // 시간 형식으로 근무 시간 전송
            }),
            success: function(response) {
                toastr.success('퇴근 처리가 완료되었습니다.');

                // 타이머 상태 및 근무 시간 제거
                localStorage.removeItem('timerStartTime');
                localStorage.removeItem('workDuration');
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                toastr.error(xhr.responseText);
            }
        });
    });

    // 페이지 로드 시 타이머 복원
    restoreTimer();
});
</script>
