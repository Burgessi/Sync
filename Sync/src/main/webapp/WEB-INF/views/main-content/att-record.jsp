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
        
        .info-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        padding: 5px 0;
    }

    .info-item {
        
        font-size: 1.1em;
        color:#25396f;
    }

    .buttons {
        margin-top: 20px;
    }

    .btn {
        padding: 10px 20px;
        font-size: 16px;
        margin-right: 10px;
    }
</style>
		    
			<div class="attendance-record">
			<h3 id="currentDate"></h3>
			    <div class="info-item" style="width: 90px; height: 25px;">
		        	<strong id="currentTime"></strong>
		        </div>
			    <div class="info" style="margin-top: 40px;">
	                <div class="info-item">
	                    <strong>출근 시각</strong>
	                    <span id="checkInTime">-</span>
	                </div>
	                <div class="info-item">
	                    <strong>퇴근 시각</strong>
	                    <span id="checkOutTime">-</span>
	                </div>
	                <div class="info-item">
	                   <strong>총 근무 시간</strong>
	                    <span id="workDuration">-</span>
	                </div>
	            </div>
			    <div class="buttons">
			        <button id="check-in-btn" class="btn btn-secondary btn-block">출근</button>
			        <button id="check-out-btn" class="btn btn-secondary btn-block" style="display: none;">퇴근</button>
			    </div>
			    
			</div>



<script>
$(document).ready(function() {
	// 서버에서 시간 받아오기
    function fetchServerTime() {
      $.ajax({
        url: './getServerTime.do', // 서버에서 시간 가져오는 API
        method: 'GET',
        success: function(response) {
          const serverTime = new Date(response.serverTime);
          updateClock(serverTime);
        },
        error: function(err) {
          console.error('Error fetching server time:', err);
        }
      });
    }

    // 시계를 업데이트하는 함수
    function updateClock(currentTime) {
      setInterval(function() {
        currentTime.setSeconds(currentTime.getSeconds() + 1);
        const formattedTime = currentTime.toLocaleTimeString();
        $('#currentTime').text(formattedTime);
      }, 1000); // 1초마다 시간 업데이트
    }

    // 페이지 로드 시 서버 시간 받아오기
    fetchServerTime();

	// 현재 날짜 가져오기
    var now = new Date();
    // 요일 배열
    var daysOfWeek = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
    // 날짜 형식 설정 (예: 2024년 9월 4일 수요일)
    var currentDate = now.getFullYear() + '. ' + (now.getMonth() + 1) + '. ' + now.getDate() + ' ' + daysOfWeek[now.getDay()];
    // currentDate 요소에 텍스트 삽입
    $('#currentDate').text(currentDate);
	
    
    /* 출퇴근 기록 */
    const emp_id = '${loginDto.emp_id}'; // 실제 emp_id는 서버에서 가져오거나 다른 방법으로 설정
    // 페이지 로드 시 초기 데이터 설정
    function loadInitialData() {
        $.ajax({
            type: 'GET',
            url: './get-check-in-time.do',
            data: { emp_id: emp_id },
            success: function(response) {
                if (response && response !== "-") {
                    const timeParts = response.split(':');
                    const now = new Date();
                    const checkInTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 
                                                timeParts[0], timeParts[1], timeParts[2]);
                    localStorage.setItem('startTime', checkInTime);
                    $('#checkInTime').text(checkInTime.toLocaleTimeString('en-GB', { hour12: false })).show();
                    $('#check-in-btn').hide(); // 출근 시각이 기록되면 출근 버튼 숨김
                    $('#check-out-btn').show(); // 출근 시각이 기록되면 퇴근 버튼 보이기
                } else {
                    $('#checkInTime').text("-").show();
                    $('#check-in-btn').show(); // 출근 기록이 없으면 출근 버튼 보이기
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
                if (response.checkOutTime !== "-" && response.workDuration !== "-") {
                    $('#checkOutTime').text(response.checkOutTime).show();
                    $('#workDuration').text(response.workDuration).show();
//                     $('#check-out-btn').hide(); // 퇴근 처리된 경우 퇴근 버튼 숨김
                } else {
                    $('#checkOutTime').text("-").show();
                    $('#workDuration').text(response.workDuration).show();
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }

    // 초기 데이터 로드
    loadInitialData();

    // 출근 버튼 클릭 시 처리
    $('#check-in-btn').click(function() {
        $.ajax({
            type: 'GET',
            url: './get-check-in-time.do',
            data: { emp_id: emp_id },
            success: function(response) {
                if (response && response !== "-") {
                    toastr.info('이미 출근 처리가 완료되었습니다.');
                } else {
                    let startTime = new Date();
                    localStorage.setItem('startTime', startTime);

                    $.ajax({
                        type: 'POST',
                        url: './check-in.do',
                        contentType: 'application/json',
                        data: JSON.stringify({ emp_id: emp_id }),
                        success: function(response) {
                            $('#checkInTime').text(startTime.toLocaleTimeString('en-GB', { hour12: false })).show();
                            toastr.success('출근 처리가 완료되었습니다.');
                            $('#check-in-btn').hide(); // 출근 후 출근 버튼 숨김
                            $('#check-out-btn').show(); // 출근 후 퇴근 버튼 보이기
                        },
                        error: function(xhr, status, error) {
                            console.error('Error:', error);
                            toastr.error(xhr.responseText);
                        }
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    });

    // 퇴근 버튼 클릭 시 처리
    $('#check-out-btn').click(function() {
        const storedStartTime = localStorage.getItem('startTime');
        if (!storedStartTime) {
            toastr.info('이미 퇴근 처리가 완료되었습니다.');
//             $('#checkOutTime').text("-").show();
//             $('#workDuration').text("-").show();
            return;
        }

        $.ajax({
            type: 'GET',
            url: './get-check-out-time.do',
            data: { emp_id: emp_id },
            success: function(response) {
                if (response.checkOutTime !== "-" && response.workDuration !== "-") {
                    toastr.info('이미 퇴근 처리가 완료되었습니다.');
                } else {
                    let startTime = new Date(storedStartTime);
                    let endTime = new Date(); // 퇴근 시각 기록

                    const duration = endTime - startTime;
                    const hours = Math.floor((duration / (1000 * 60 * 60)) % 24);
                    const minutes = Math.floor((duration / (1000 * 60)) % 60);
                    const seconds = Math.floor((duration / 1000) % 60);

                    $('#checkOutTime').text(endTime.toLocaleTimeString('en-GB', { hour12: false })).show();
                    $('#workDuration').text(response.workDuration).show();

                    $.ajax({
                        type: 'POST',
                        url: './check-out.do',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                            emp_id: emp_id
//                             ,
//                             work_duration: hours + ":" + minutes + ":" + seconds
                        }),
                        success: function(response) {
                            toastr.success('퇴근 처리가 완료되었습니다.');
                         // 퇴근 후, 다시 데이터를 로드하여 업데이트된 근무시간을 화면에 표시
                            loadInitialData();
                            localStorage.removeItem('startTime');
//                             $('#check-out-btn').hide(); // 퇴근 후 퇴근 버튼 숨김
                            // 출근 버튼은 숨김 상태 유지
                        },
                        error: function(xhr, status, error) {
                            console.error('Error:', error);
                            toastr.error(xhr.responseText);
                        }
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    });
});
</script>
