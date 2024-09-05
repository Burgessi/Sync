<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.css" rel="stylesheet">
<style>
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #div-calendar {
   width: 100%; 
    max-width: 1000px; 
    height: 45vh; 
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
  	color: #25396f;
  	font-size: 15px;
  	padding: 8px 5px;
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
.fc .fc-toolbar-title{
	font-size: 22px;
}
  
</style>


<div style="padding: 0px 30px;">
	<div id='div-calendar'></div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.10/index.global.min.js"></script>
<script type="text/javascript" src="./fullcalendar/packages/core/locales/ko.global.min.js"></script>
<script>
var calendar;

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('div-calendar');

    if (calendarEl) {
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridWeek',
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
</script>