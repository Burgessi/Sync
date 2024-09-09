<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.pro.sync.employee.vo.EmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.css" rel="stylesheet">
<html>
<head>
<title>SYNC</title>
<style>
.input-size {
	max-width: 350px;
}

.img-edit-plus {
	top: -10px;
}

.info-flex {
	display: flex;
	flex-direction: column;
}

.info-span {
	padding-bottom: 25px;
}

.user-edit {
	margin-left: 20px;
}

#profile {
	position: absolute;
}

#profile-img {
	margin-left: 5px;
	bottom: 5px;
}

#profile-edit {
	position: relative;
	top: 22px;
	right: 25px;
	width: 30px;
	height: 30px;
	background-color: #ffffff;
	border: 1px solid #eeeeee;
	border-radius: 50%;
	padding-top: 5px;
	padding-left: 5px;
}

#profile-edit:hover {
	border: 1px solid #d3d3d3;
}
/* 게시판 */
.notice-tag {
	display: inline-block;
	padding: 4px 8px;
	background-color: #ff6d72;
	color: #fff;
	border-radius: 3px;
	font-size: 12px;
	font-weight: bold;
	margin-left: 8px;
	vertical-align: middle;
	text-align: center;
}
/* 캘린더 */
 #div-calendar {
   width: 100%; 
    max-width: 1000px; 
    height: 40vh; 
    max-height: 900px; 
    margin: 0 auto; 
    box-sizing: content-box; 
  }
    .ko_event{
  	background: #F78181 !important;
  	text-align: center !important;
  	border: none;
  }
  .fc-event-time {
 	 display: none; /* 시간 표시를 숨김 */
  }
</style>
</head>


<body>
	<div id="app">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>
			<div class="page-heading">
				<div class="page-title">
					<div class="row">
						<div class="col-12 col-md-6 order-md-1 order-last mt-2 mb-4">
							<h3>메인</h3>
						</div>
					</div>
				</div>
				<div class="page-content">

					<!-- 섹션1 -->
					<section class="section d-flex" style="height: 500px;">
						<div class="card"
							style="width: 30%; min-width: 300px; padding: 5px;">
							<div class="card-header mt-1">
								<h4>출퇴근 기록</h4>
							</div>
							<div class="card-body">
								<!--                   컨텐츠 내용 -->
								<%@ include file="/WEB-INF/views/main-content/att-record.jsp"%>
							</div>
						</div>
						<div class="card"
							style="width: 100%; min-width: 600px; padding: 5px; margin-left: 10px;">
							<div class="card-header mt-1" style="padding-bottom: 0px;">
								<h4>주간 일정</h4>
							</div>
							<div class="card-body">
								<!--                   컨텐츠 내용 -->
								<div style="padding: 0px 30px;">
									<div id='div-calendar'></div>
								</div>
							</div>
						</div>
					</section>

					<!-- 섹션2 -->
					<section class="section d-flex" style="height: 550px;">
						<div class="card"
							style="width: 100%; min-width: 500px; padding: 5px;">
							<div class="card-header mt-1">
								<h4>근태 현황</h4>
							</div>
							<div class="card-body">
								<!--                   컨텐츠 내용 -->
								<%@ include
									file="/WEB-INF/views/main-content/main-att-chart.jsp"%>
							</div>
						</div>

					</section>

					<!-- 섹션3 -->
					<section class="section d-flex" style="height: 500px;">

						<div class="card" style="width: 50%; min-width: 500px; padding: 5px;">
							<div class="card-header mt-1" style="display: flex; justify-content: space-between; align-items: center;">
								<h4>공지사항</h4>
								<a href="${root}/notice/noticeBoard.do" style="margin-left: auto; text-decoration: none; color: #007bff;">+더보기</a>
							</div>
							<div class="card-body">
								<table class="table table-hover">
									<thead>
										<tr style="text-align: center; background-color: #e0ffff">
											<th>게시물</th>
											<th>작성자</th>
											<th style="width: 40%">제목</th>
											<th>작성일자</th>
										</tr>
									</thead>
									<c:forEach items="${noList}" var="no" varStatus="vs">
									<c:if test="${vs.index < 8}">
										<tbody>
											<c:set var="bgColor" value="${no.notice_pinbtn eq 'Y' ? '#F2F2F2': '#FFFFFF'}" /> 
											<tr style="background-color: ${bgColor}"> 
												<td>${vs.index+1}</td>
												<td>${no.employee_name}</td>
												<td>
													<c:if test="${no.notice_pinbtn eq 'Y'}">
														<span class="notice-tag">공지</span>
												</c:if> 
												<a href="${root}/notice/detailNotice.do?notice_seq=${no.notice_seq}">${no.notice_title}</a> 
												</td>
												<td>
													<fmt:parseDate var="cDate" value="${no.notice_regdate}" pattern="yyyy-MM-dd"></fmt:parseDate>
													<fmt:formatDate value="${cDate}" />
												</td>
											</tr>
										</tbody>
									</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
						<div class="card"
							style="width: 50%; min-width: 400px; padding: 5px; margin-left: 10px;">
							<div class="card-header mt-1">
								<h4>결재현황</h4>
							</div>
							<div class="card-body">
								<!--                   컨텐츠 내용 -->
				        		<%@ include file="/WEB-INF/views/main-content/main-approval.jsp"%>			
								<!--  -->
							</div>
						</div>
					</section>

				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<!-- 비밀번호 변경 모달 -->
	<div class="modal fade" id="passwordChangeModal" tabindex="-1"
		aria-labelledby="passwordChangeModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="passwordChangeModalLabel">비밀번호 변경</h5>
				</div>
				<div class="modal-body">
					<form id="passwordChangeForm" action="./changePassword.do"
						method="post">
						<div class="mb-3">
							<label for="newPassword" class="form-label">새 비밀번호</label> <input
								type="password" class="form-control" id="newPassword"
								name="newPassword" required>
						</div>
						<div class="mb-3">
							<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
								type="password" class="form-control" id="confirmPassword"
								name="confirmPassword" required>
						</div>
						<button type="submit" class="btn btn-primary">변경</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 비밀번호 변경 성공 모달 -->
	<div class="modal fade" id="passwordChangeSuccessModal" tabindex="-1"
		aria-labelledby="passwordChangeSuccessModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="passwordChangeSuccessModalLabel">비밀번호
						변경 완료</h5>
				</div>
				<div class="modal-body">비밀번호가 변경되었습니다. 다시 로그인해주세요.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="confirmButton">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- JavaScript code -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.10/index.global.min.js"></script>
<script type="text/javascript" src="./fullcalendar/packages/core/locales/ko.global.min.js"></script>
<script>
    $(document).ready(function() {
<%--         <%  --%>
//             EmployeeVo loginDto = (EmployeeVo) request.getAttribute("loginDto");
//             EmployeeVo infoDto = (EmployeeVo) request.getAttribute("infoDto");
//             if (loginDto != null && "A".equals(infoDto.getEmp_status())) {
<%--          %> --%>
//             $('#passwordChangeModal').modal('show');
<%--         <%  --%>
//             } 
<%--          %> --%>

		if("${infoDto.emp_status}" =="A"){
			$('#passwordChangeModal').modal('show');
		}
			
        // 비밀번호 유효성 검사 함수
        function isValidPassword(password) {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
            return passwordRegex.test(password);
        }

        // 비밀번호 변경 폼 유효성 검사 후 제출
        $('#passwordChangeForm').on('submit', function(event) {
            event.preventDefault(); // 기본 폼 제출 막기

            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();

            // 비밀번호 유효성 검사
            if (!isValidPassword(newPassword)) {
            	toastr.error('비밀번호는 영문 대소문자와 숫자를 포함하여 8자 이상이어야 합니다.');
                return; // 유효성 검사를 통과하지 못하면 제출 중단
            }

            // 비밀번호와 비밀번호 확인이 일치하는지 확인
            if (newPassword !== confirmPassword) {
            	toastr.error('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                return; // 유효성 검사를 통과하지 못하면 제출 중단
            }

            // 유효성 검사를 통과했을 경우 폼을 실제로 제출
            $.post($(this).attr('action'), $(this).serialize(), function(response) {
                $('#passwordChangeModal').modal('hide'); // 비밀번호 변경 모달 숨기기
                $('#passwordChangeSuccessModal').modal('show'); // 성공 모달 보여주기
            });
        });

        // 성공 모달에서 확인 버튼 클릭 시 로그인 페이지로 리다이렉트
        
        $('#confirmButton').on('click', function() {
            window.location.href = './'; // 로그인 페이지 URL로 변경
        });
    });


var calendar;

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('div-calendar');

    if (calendarEl) {
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridWeek',
            locales: 'ko',
			events: [
				<c:forEach items="${sList}" var="sc">
				<c:if test="${infoDto.team_code == sc.team_code}">
					{
				      id: "${sc.scd_no}",
		              title: "${sc.scd_title}",
		              start: "${sc.scd_start}",
		              end: "${sc.scd_end}",
		              extendedProps: {
		                team: "${sc.team_code}",
		                content: "${sc.scd_content}"
		              }
		            }
		            <c:if test="${not empty sc}" >,</c:if>
		          </c:if>  
		          </c:forEach>
			],
            selectable: true,
            dayMaxEvents: true,
            googleCalendarApiKey: 'AIzaSyBx07rpTSuaNl8y6PWEeQNRRkBly-8Y1Nw',
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

</body>
</html>
