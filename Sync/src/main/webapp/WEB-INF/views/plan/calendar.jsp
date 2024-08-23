<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${root}/fullcalendar/cal.css" />
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #div-calendar {
   width: 80%; 
    max-width: 1000px; 
    height: 90vh; 
    max-height: 900px; 
    margin: 0 auto; 
    box-sizing: content-box; 
  }
  .fc-event {
	 background-color: #FFB7CA !important; 
	 border: none !important; 
	 padding: 4px 8px !important; 
	 color: white !important; 
	 text-align: center;
	 font-size: 12px;
	 font-family: sans-serif;
	 height: 20px;
  }
  .fc-daygrid-event-dot {
  	display: none !important; /*점 없애기*/
  }
  .fc-event-time {
 	 display: none; /* 시간 표시를 숨김 */
  }
   .fc-daygrid-block-event .fc-event-title{
  	flex-grow: 1;
    flex-shrink: 1;
    font-weight: 700;
    min-width: 0px;
    overflow: hidden;
  }
  .fc-event-title-container{
  	margin-top: -4px;
  }
  /* 일정이 표시되는 셀 안에서의 스타일 설정 */
  .fc-daygrid-day > .fc-daygrid-day-frame .fc-daygrid-day-events .fc-event {
	 border-radius: 5px; !important; 
  }  
  .ko_event{
  	background: #f24080 !important;
  	text-align: center;
  }
  .group{
  	background: #51a1ed;
  	text-align: center;
  	
  }
  .fc .fc-col-header-cell-cushion{
  	color: black;
  	font-size: 12px;
   } 
  .fc .fc-daygrid-day-number{
  	color: black;
  	font-size: 11px;
  }
  .toast-success {
    background-color: #28a745 !important; /* 성공 메시지의 배경색을 녹색으로 설정 */
  }
  .toast-error {
    background-color: #dc3545 !important; /* 오류 메시지의 배경색을 빨간색으로 설정 */
  }
  .toast-info {
    background-color: #17a2b8 !important; /* 정보 메시지의 배경색을 파란색으로 설정 */
  }
  .toast-warning {
    background-color: #ffc107 !important; /* 경고 메시지의 배경색을 노란색으로 설정 */
  }
  .toast {
  min-width: 300px; /* 최소 너비 설정 */
  max-width: 600px; /* 최대 너비 설정 */
  padding: 15px;
  border-radius: 8px;
}

  
</style>
</head>
<body>
	
	<div id="app">
		 <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>	
		<div id="main">
        	 <%@ include file="/WEB-INF/views/common/header.jsp" %>
        	<h3>일정</h3> 
        	<div class="container"> 
        		<div class="card"> 
        			<div style="padding: 30px; height: 950px;">
						<div id='div-calendar'></div>
					</div>
				</div> 
			</div> 
		</div><!-- #main -->
	</div><!-- #app -->
	 <%@ include file="/WEB-INF/views/common/footer.jsp" %> 
	 
	 <!-- 일정 등록 -->
	 
	 <form id="inschedule">
     <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
       <div class="modal-dialog">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title">일정 추가</h5>
                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                       <div class="mb-3">
                           <label for="title" class="form-label">제목</label>
                           <input type="text" class="form-control" id="scd_title" name="scd_title" required>
                       </div>
                       <div class="mb-3">
                           <label for="dept" class="form-label">부서</label>
                           <input type="text" class="form-control" id="team_code" name="team_code" required>
                       </div>
                       <div class="mb-3">
                           <label for="dept" class="form-label">아티스트</label>
                           <input type="text" class="form-control" id="artist_id" name="artist_id" required>
                       </div>
                       <div class="mb-3">
                           <label for="start" class="form-label">시작일</label>
                           <input type="datetime-local" class="form-control" id="scd_start" name="scd_start" required>
                       </div>
                       <div class="mb-3">
                           <label for="end" class="form-label">종료일</label>
                           <input type="datetime-local" class="form-control" id="scd_end" name="scd_end" required>
                       </div>
<!--                        <div class="mb-3"> -->
<!--                            <label for="category" class="form-label">카테고리</label> -->
<!--                            <select id="category" name="category" class="form-select"> -->
<!--                                <option value="work" selected>업무</option> -->
<!--                                <option value="team-meeting">회의</option> -->
<!--                                <option value="business-meeting">미팅</option> -->
<!--                                <option value="outing">외근</option> -->
<!--                                <option value="business-trip">출장</option> -->
<!--                            </select> -->
<!--                        </div> -->
<!--                        <div class="mb-3"> -->
<!--                            <label for="color" class="form-label">일정색상</label> -->
<!--                            <select id="color" name="color" class="form-select" style="width: 100%;"> -->
<!--                              <option value="gray"   style="color:#808080;" selected>회색</option> -->
<!--                              <option value="red"    style="color:#FF0000;">빨간색</option> -->
<!--                              <option value="orange" style="color:#FFA500;">주황색</option> -->
<!--                              <option value="green"  style="color:#008000;">초록색</option> -->
<!--                              <option value="blue"   style="color:#0000FF;">파란색</option> -->
<!--                              <option value="indigo" style="color:#000080;">남색</option> -->
<!--                              <option value="purple" style="color:#800080;">보라색</option> -->
<!--                            </select> -->
<!--                        </div> -->
                       <div class="mb-3">
                           <label for="contents" class="form-label">내용</label>
                           <textarea class="form-control" id="scd_content" name="scd_content" style="width: 100%;" rows="3"></textarea> 
                       </div>
                       <!-- 세션 정보 -->
<%--                       <input type="hidden" name="empNo" value="${loginEmployee.empNo}">  --%>
                 
                   <div class="modal-footer">
                       <button id="btn-save" type="submit" class="btn btn-primary">일정등록</button>
                       <button id="btn-close" type="button" class="btn btn-secondary" data-bs-dismiss="modal">뒤로가기</button>
                   </div>   
                   </div>
               </div>
           </div>
       </div>
   </form>
   
   
 <!-- 상세보기  -->  
 <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h5 id="sTitle"></h5>
                <p>부서: <span id="sTeam"></span></p>
                <p>일정기간: <span id="sTime"></span></p>
                <p>아티스트: <span id="sArtist"></span></p>
                <p>내용: <span id="sContent"></span></p>
            </div>
            <div class="modal-footer">
                <button id="btn-edit" type="button" class="btn btn-primary">수정</button>
                <button id="btn-remove" type="button" class="btn btn-danger">삭제</button>
                <input type="hidden" id="scd_no" name="scd_no"> 
            </div>
        </div>
    </div>
</div>


<!-- 일정 수정 -->
<form id="modifyschedule">
	 <div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 수정</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	               <div class="modal-body">
	                   <div class="mb-3">
	                       <label for="modify_subject" class="form-label">제목</label>
	                       <input type="text" class="form-control" id="mTitle" name="scd_title" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify_subject" class="form-label">부서</label>
	                       <input type="text" class="form-control" id="mTeam" name="team_code" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify_subject" class="form-label">아티스트</label>
	                       <input type="text" class="form-control" id="mArtist" name="artist_id" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify-start" class="form-label">시작일</label>
	                       <input type="datetime-local" class="form-control" id="mStart" name="scd_start" required>
	                   </div>
	                   <div class="mb-3">
	                       <label for="modify-end" class="form-label">종료일</label>
	                       <input type="datetime-local" class="form-control" id="mEnd" name="scd_end" required>
	                   </div>
	                    <div class="mb-3">
	                        <label for="modify-contents" class="form-label">내용</label>
	                        <textarea class="form-control" id="mContent" name="scd_content" style="width: 100%;" rows="3"></textarea>
	                    </div>
	                    <input type="hidden" id="mScdno" name="scd_no">
	                </div>
	                <div class="modal-footer">
	                    <button id="btn-modify-skd" type="submit" class="btn btn-primary">저장</button>
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                </div>
	          </div>
	      </div>
	  </div>
 </form>


<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.10/index.global.min.js"></script>
<script type="text/javascript" src="./fullcalendar/packages/core/locales/ko.global.min.js"></script>
<script>


toastr.options.escapeHtml = true;
toastr.options.closeButton = true;
toastr.options.newestOnTop = false;
toastr.options.progressBar = true;
toastr.options.positionClass = 'toast-top-center';

var calendar;

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('div-calendar');

    if (calendarEl) {
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locales: 'ko',
			events: [
				<c:forEach items="${lists}" var="event">
					{
				      id: "${event.scd_no}",
		              title: "${event.scd_title}",
		              start: "${event.scd_start}",
		              end: "${event.scd_end}",
		              extendedProps: {
		                team: "${event.team_code}",
		                content: "${event.scd_content}"
		              }
		            }
		            <c:if test="${not empty event}" >,</c:if>
		          </c:forEach>
			],
//             editable: true,
            selectable: true,
            dayMaxEvents: true,
            googleCalendarApiKey: 'AIzaSyBx07rpTSuaNl8y6PWEeQNRRkBly-8Y1Nw',
            dateClick: function(info) {
                document.getElementById('scd_title').value = '';
                document.getElementById('team_code').value = '';
                document.getElementById('artist_id').value = '';
                document.getElementById('scd_start').value = info.dateStr + "T09:00";
                document.getElementById('scd_end').value = info.dateStr + "T18:00";
                document.getElementById('scd_content').value = '';
                var modal = new bootstrap.Modal(document.getElementById('insertModal'));
                modal.show();
            },
            eventClick: function(info){
            	detailschedule(info);
            },
            eventSources: [
                {
                    googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
                    className: 'ko_event'
                }
            ]
            
        });

        calendar.render();

    } else {
        console.error('Element with ID "div-calendar" not found.');
    }
});




//일정 등록
$(document).ready(function() {
		$('#inschedule').on('submit', function(e) {
			e.preventDefault(); // 기본 폼 제출 동작 방지
			
			var startDate = new Date($('#scd_start').val());
	        var endDate = new Date($('#scd_end').val());

	        // 날짜 검증
	        if (startDate >= endDate) {
	            // 오류 표시
	             toastr.error('종료일은 시작일 이후여야 합니다.');
	            return;
	        }

			// 폼 데이터 배열로 직렬화
			var formData = $(this).serializeArray();

			// AJAX 요청
			$.ajax({
				type : 'POST',
				url : './insertScd.do', // 서버에 데이터를 보낼 URL
				data : formData,
				dataType : 'json', // 서버에서 반환할 데이터 형식
				success : function(resData) {
					if (resData.insertSkdCount === 1) {
						$('#insertModal').modal('hide'); // 모달 숨기기

						// 새 일정 객체 생성
						var newEvent = {
						    id: resData.scd_no,
							title : $('#scd_title').val(),
							start : $('#scd_start').val(),
							end : $('#scd_end').val(),
							extendedProps : {
								artist : $('#artist_id').val(),
								teamcode : $('#team_code').val(),
								contents : $('#scd_content').val()
							}
						};

						// FullCalendar에 새 일정 추가
						if (typeof calendar !== 'undefined' && calendar) {
							calendar.addEvent(newEvent);
						} else {
							console.error('Calendar 객체가 정의되지 않았습니다.');
						}

						// 폼과 결과 초기화
						$('#inschedule')[0].reset();
						// Toast 띄우기
						toastr.success('일정이 성공적으로 등록되었습니다.');
											
					} else {
						toastr.error('일정 등록 실패했습니다.');
						$('#inschedule')[0].reset(); // 폼 초기화
					}
				},
				error : function(jqXHR) {
					toastr.error('알 수 없는 오류가 떴습니다');
				}
			});
		});
	});
	
//상세보기
function detailschedule(info) {

	
	var scheduleNo = info.event.id;
	
	$.ajax({
		type:"GET",
		url:"./detailschedule.do",
		data: {scd_no :scheduleNo},
		dataType:"json",
		success:function(schedule){

			$('#scd_no').val(schedule.scd_no);
			$('#sTitle').text(schedule.scd_title);
			$('#sTeam').text(schedule.team_code);
			$('#sTime').text(schedule.scd_start + '~' + schedule.scd_end);
			$('#sArtist').text(schedule.artist_id);
			$('#sContent').text(schedule.scd_content);
			
			var modal = new bootstrap.Modal(document.getElementById('detailModal'));
		    modal.show();
		},
		error:function(e){
			toastr.error('알 수 없는 오류가 떴습니다');
		}
	});
	
}


//상세 보기 모달에서 일정 수정버튼 클릭 
$('#btn-edit').on('click', function(){
	var scheduleNo = $('#scd_no').val();
	
	$.ajax({
		type: "GET",
		url: "./detailschedule.do",
		data: {scd_no:scheduleNo},
		success:function(schedule){
			$('#mTitle').val(schedule.scd_title);
			$('#mTeam').val(schedule.team_code);
			$('#mArtist').val(schedule.artist_id);
			$('#mStart').val(schedule.scd_start);
			$('#mEnd').val(schedule.scd_end);
			$('#mContent').val(schedule.scd_content);
			$('#mScdno').val(schedule.scd_no);
			
			$('#detailModal').modal('hide');
			$('#modifyModal').modal('show');
			
		},
		error:function(e){
			toastr.error('알 수 없는 오류가 발생했습니다.');
		}
	});
	
});

$('#modifyschedule').on('submit', function(e) {
    e.preventDefault();
    
    var formData = $(this).serializeArray();
    
    $.ajax({
        type: 'POST',
        url: './modifyScd.do',
        data: formData,
        dataType: 'json',
        success: function(success){
            if(success){
                $('#modifyModal').modal('hide');
                
                var event = calendar.getEventById($('#mScdno').val());
                if(event){
                    event.setProp('title', $('#mTitle').val());
                    event.setStart($('#mStart').val());
                    event.setEnd($('#mEnd').val());
                    event.setExtendedProp('team', $('#mTeam').val());
                    event.setExtendedProp('artist', $('#mArtist').val());
                    event.setExtendedProp('content', $('#mContent').val());
                }
                
                toastr.success('일정이 성공적으로 수정되었습니다!');
            }else{
                toastr.warning('일정을 수정하지 못했습니다.');
            }   
        },
        error: function(e){
            toastr.error('알 수 없는 오류가 발생했습니다.');            
        }
    });
});



var detailModal = new bootstrap.Modal(document.getElementById('detailModal'));

//일정 삭제 
$('#btn-remove').on('click', function() {
    if (confirm('일정을 삭제할까요?')) {
        var scd_no = $('#scd_no').val();

        $.ajax({
            type: "POST",
            url: "./delScd.do",
            data: {scd_no: scd_no},
            success: function(del) {
                if (del === 1) { // 서버가 1을 반환 해야함
                    var event = calendar.getEventById(scd_no);
                    if (event) {
                        event.remove();
                    }
                    $('#detailModal').modal('hide');
                    toastr.success("삭제되었습니다!");
                } else {
                    toastr.error('삭제 실패: 해당 일정이 없습니다.');
                }
            },
            error: function(e) {
                toastr.error('일정을 삭제하지 못했습니다.');
            }
        });
    }
});

	
	
	
</script>
</body>
</html>
