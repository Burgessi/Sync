<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.css" rel="stylesheet">
<title>전체 예약 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.fc-v-event .fc-event-time{
	color:black;
}
.fc-sticky{
	color:black;
}
</style>
</head>
<body>

<div id="calendar"></div>





<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.10/index.global.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    if (calendarEl) {
    	
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            locales: 'ko',
            events: [
            	 <c:forEach items="${revList}" var="rev">
	                 {
	                     id: "${rev.rev_id}",
	                     title: "${rev.fcl_name}",
	                     start: "${rev.rev_start}",
	                     end: "${rev.rev_end}",
	                     color: "${rev.color}"
	                 }
                 <c:if test="${not empty rev}" >,</c:if>
             </c:forEach>
            ],
            selectable: true,
            dayMaxEvents: true,
            views: {
                timeGridWeek: {
                    slotMinTime: '09:00:00',
                    slotMaxTime: '22:00:00',
                }
            },
           
        });

        calendar.render();
    }
});



</script>
</body>
</html>