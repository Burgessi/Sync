<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<link rel="stylesheet" href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css"/>
<style>
  #main {
    padding-top: 0.8rem;
  }
  .ch{
     width: 25px;
     height: 25px;    
     margin-top: 25%
  }
  
 /* 전체 너비를 조정하는 부모 요소의 스타일 */
.dropdown-menu {
    max-width: 100%; /* 부모 요소의 너비를 제한하지 않음 */
    min-width: 20rem;
}

/* hover 상태 색상 */
.dropdown-item:hover {
    color: #000; /* hover 시 텍스트 색상 */
    background-color: #e6ecf2; /* hover 시 배경색 */
    border-radius: 5px;
}

/* 알림 컨테이너 스타일 */
.notification-container {
    max-height: 250px; /* 원하는 높이로 설정 */
    max-width: 1200px !important; /* 최대 너비를 강제로 설정 */
    overflow-y: auto;  /* 수직 스크롤을 허용 */
    overflow-x: hidden; /* 가로 스크롤 제거 */
    border: 1px solid #ddd; /* 테두리 추가 */
    padding: 10px; /* 내부 여백 */
    background: #fff; 
    margin: 0; /* 여백 제거 */
}

/* 스크롤바 스타일 */
.notification-container::-webkit-scrollbar {
    width: 10px; /* 스크롤바 너비 */
}

.notification-container::-webkit-scrollbar-thumb {
    background-color: #223055; /* 스크롤바 색상 */
    border-radius: 8px; /* 둥근 스크롤바 */
}

.notification-container::-webkit-scrollbar-track {
    background-color: #e8e8e8; /* 스크롤바 트랙 색상 */
    border-radius: 8px; /* 둥근 스크롤바 트랙 */
}

/* 알림 항목 스타일 */
.notification-item {
    margin-bottom: 10px; /* 항목 간 간격 */
    padding-left: 0; /* 왼쪽 여백 제거 */
    font-size: 0.9rem; /* 폰트 크기 줄이기 */
}


/* 알림 텍스트 스타일 */
.notification-text {
    flex: 1;
    padding-left: 0; /* 왼쪽 여백 제거 */
   
}

.notification-title {
    font-size: 0.9rem;
}

.notification-subtitle {
    font-size: 0.8rem; 
}
.notification-icon {
    font-size: 1.1rem; /* 아이콘 크기 조정 */
    color: #223055; /* 아이콘 색상 */
}


  
</style>
<%@ include file="/WEB-INF/views/common/toastify.jsp" %>
<header style="width: 100%">
  <nav class="navbar navbar-expand navbar-light navbar-top" style="padding-left: 0; padding-right: 5px;">
    <div class="container-fluid p-0" >
      <a href="#" class="burger-btn d-block">
        <i class="bi bi-justify fs-3"></i>
      </a>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-lg-0">
        

          
          <!-- 알림 -->
          <li class="nav-item dropdown me-3">	
          	<a class="nav-link" style="margin-right: -8px; margin-top: 0;" href="javascript:window.open('${root}/chat/main.do','채팅','width=1205px, height=745px, toolbar=no, menubar=no, left=100px, top=160px')">
	          	<i class="bi bi-chat-text bi-sub fs-4" style="color: #223055;"></i>
          	</a>
          </li>
          
          

          <li class="nav-item dropdown me-3">
            <a
              class="nav-link active"
              href="#"
              data-bs-toggle="dropdown"
              data-bs-display="static"
              aria-expanded="false"
            >
              <i class="bi bi-bell bi-sub fs-4"></i>
              <span id="alarmCount" class="badge bg-danger" style="position: absolute; top: 9px; right: -1px; font-size: 10px;"></span>             
            </a>
            
                     
<ul class="dropdown-menu dropdown-menu-end notification-dropdown" aria-labelledby="dropdownMenuButton" style="left: 13%;">
  <li class="dropdown-header">
    <h6>Notifications</h6>
  </li>
  
  <!-- notification-list -->
  <div class="notification-container">
  <ul id="notification-list" style="padding: 0;">
    <!-- 알림이 동적으로 추가되는 부분 -->
  </ul>
</div>

                 
           </li> 
         </ul> 
        </div>
        
        

        <div class="dropdown">
          <a href="#" type="button" data-bs-toggle="dropdown" aria-expanded="false">
            <div class="user-menu d-flex">
              <div class="user-name text-end me-2" style="padding-top: 5px; padding-right: 8px">
                <h6 class="mb-0 text-gray-600">${loginMember.empName}</h6>
                <p class="mb-0 text-sm text-gray-600">${loginMember.deptName} ${loginMember.posName}</p>
              </div>
              <div class="user-img d-flex align-items-center">
                <div class="avatar">
                  <c:choose>
                   <c:when test="${not empty infoDto.emp_profile_pic}">
                       <img id="headerPreview" style="border-radius: 50%; width: 45px; height: 45px; object-fit: cover" src="${infoDto.emp_profile_pic}" alt="이미지" />
                   </c:when>
                   <c:otherwise>
                     <img id="headerPreview" style="border-radius: 50%; width: 45px; height: 45px; object-fit: cover" src="${root}/resources/img/member-imgs/user.png" alt="profile" />
                   </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </a>
          <ul class="dropdown-menu dropdown-menu-lg-end" aria-labelledby="dropdownMenuButton" style="min-width: 10.5rem;" data-ps-popper="static" >
            <li>
              <h6 class="dropdown-header" style="margin-left: -15px">${loginDto.emp_name }님 환영합니다!</h6>
            </li>
            <li>
              <a class="dropdown-item" href="${root}/mypage.do" ><img src="${root}/resources/img/mypage.png" style="margin-bottom: 5px; margin-right: 10px;">마이페이지</a>
            </li>
            <li>
              <a class="dropdown-item" href="#"><img src="${root}/resources/img/document.png" style="margin-bottom: 5px; margin-right: 10px;">내 결재문서</a>
            </li>
            <c:if test="${loginMember.opLevel eq 2}">
               <li>
                 <a class="dropdown-item" href="${root}/foradmin/member/1"><i class="icon-mid bi bi-wallet me-2"></i> 관리자 메뉴</a>
               </li>
            </c:if>
            <li>
              <hr class="dropdown-divider" />
            </li>
            <li>
              <a class="dropdown-item" href="${root}/"><img src="${root}/resources/img/logout.png" style="margin-bottom: 5px; margin-right: 10px;">로그아웃</a>
            </li>
          </ul>
        </div>
      </div>
  </nav>
</header>

<script type="text/javascript">
$(document).ready(function() {
    //페이지가 로드되면 알림 데이터를 가져오는 함수 호출
     fetchNotifications();
     fetchUnreadAlarmCount();
    
    //주기적으로 알림 목록을 새로 고침 
    setInterval(fetchNotifications, 30000); //30초


    function fetchNotifications() {
    	$.ajax({
            url: '${root}/alarmList.do',
            type: 'GET',
            dataType: 'json',
            success: function(alarms) {
           	
            	 console.log("제발떠라: ",alarms);
            	 console.log(alarms);
            	           	 
                //알림 목록을 업데이트하는 함수 호출
                updateNotificationList(alarms);
            },
            error: function() {
                console.log("알림 데이터를 가져오는 중 오류가 발생했습니다.");
            }
        });
    }
    
    
    
    function updateNotificationList(alarms) {
        var notificationList = $('#notification-list');
        notificationList.empty(); // 기존 알림 목록 비우기
        
        if (alarms.length === 0) {
            notificationList.append('<li class="dropdown-item"><p style="font-weight:Semi Bold; font:sans-serif;"> -- 읽지 않은 알림이 없습니다 --</p></li>');
        } else {
            $.each(alarms, function(index, alarm) {
            	console.log(alarm);
            	var notificationItem;
            	var iconColor;
            	
            	
            	   switch (alarm.alarm_type) {
                   case 'C':
                       icon = '<i class="bi bi-chat-left-dots"></i>'; 
                       iconColor='gray';
                       break;
                   case 'A':
                       icon = '<i class="bi bi-check-circle"></i>'; 
                       iconColor='#15358f';
                       break;
                   case 'R':
                       icon = '<i class="bi bi-x-circle"></i>'; 
                       iconColor='#c22813';
                       break;
                   default:
                       icon = '<i class="bi bi-info-circle"></i>'; 
                       iconColor='black';
                       break;
               }
            	
            	if(alarm.alarm_type == 'C'){
            		notificationItem = 
            			//'<li class="dropdown-item notification-item" onclick="location.href=\'http://localhost:8080/Sync/board/detailBoard.do?bd_seq=' + alarm.bd_seq + '\'"' + 
            		 '<li class="dropdown-item notification-item" onclick="goBoard(\'' + alarm.bd_seq + '\', \'' + alarm.alarm_id + '\')">' + 
                        '<a class="d-flex align-items-center" href="#">' +
                        '<div class="notification-icon me-2" style="color: ' + iconColor + ';">' + icon + '</div>' +
                            '<div class="notification-text ms-4">' +
                                '<p class="notification-title font-bold">' + alarm.content + '</p>' +
                                '<p class="notification-subtitle font-thin text-sm">' + alarm.timeAgo + '</p>' +
                            '</div>' +
                        '</a>' +
                    '</li>';
            	}else if(alarm.alarm_type == 'A'||alarm.alarm_type == 'R'){
            		notificationItem =
            			//'<li class="dropdown-item notification-item" onclick="location.href=\'http://localhost:8080/Sync/approval/progress.do\'">' + 
            			 '<li class="dropdown-item notification-item" onclick="goApproval(\'' + alarm.alarm_id + '\')">' + 
                        '<a class="d-flex align-items-center" href="#">' +
                        '<div class="notification-icon me-2" style="color: ' + iconColor + ';">' + icon + '</div>' +
                            '<div class="notification-text ms-4">' +
                                '<p class="notification-title font-bold">' + alarm.content + '</p>' +
                                '<p class="notification-subtitle font-thin text-sm">' + alarm.timeAgo + '</p>' +
                            '</div>' +
                        '</a>' +
                    '</li>';
            	}
            	
            	

                notificationList.append(notificationItem);
            });
            
         // 알림 클릭 이벤트 처리
//             $('.notification-item').on('click', function() {
//                 var alarmId = $(this).data('alarm_id');
//                 console.log(alarmId);
//                 //var bd_seq = $(this).data('bd_seq');      
//                 //var approvalId = $(this).data('approval_id');
                
//                isRead(alarmId);
//             });
         
         
        }
    }

    
    
    
});
function goBoard(bd_seq, alarm_id) { 
	isRead(alarm_id);
	window.location.href = 'http://localhost:8080/Sync/board/detailBoard.do?bd_seq='+bd_seq;    
}

function goApproval(alarm_id){	
	isRead(alarm_id);
	window.location.href = 'http://localhost:8080/Sync/approval/progress.do';	
	
}



function isRead(alarm_id) {
	console.log(alarm_id);
    $.ajax({
        url: '${root}/alarmRead.do',
        type: 'POST',
        data: {alarm_id: alarm_id},
        success: function(data) {
        	console.log(data);
            console.log("알림이 읽음으로 처리되었습니다.");
           
            fetchNotifications(); //새로 고침
        },
        error: function(xhr, status, error) {
            console.log("알림을 읽음으로 처리하는 중 오류가 발생했습니다.", error);
        }
    });
}
    
    
    ///////        채팅알림입니다      !!!@!?//////
    
    
 // 자식 창에서 메시지를 받는 이벤트 리스너 등록
    $(window).on("message", function(event) {
        const origin = event.originalEvent.origin;
        const message = event.originalEvent.data;

        // 디버그용 로그 출력
        console.log(`부모 창에서 수신된 메시지: ${message}`);

        // 같은 도메인에서 온 메시지만 처리
        if (origin === window.location.origin) {
            showNotification(message);
        }
    });

    // 알림을 화면에 표시하는 함수 (오른쪽 하단)
    function showNotification(message) {
        const notification = $('<div></div>')
            .text(message)
            .css({
                'position': 'fixed',
                'bottom': '20px',
                'right': '20px',
                'background-color': '#00BFA5',
                'color': '#fff',
                'padding': '10px',
                'border-radius': '5px',
                'box-shadow': '0 2px 10px rgba(0, 0, 0, 0.2)',
                'z-index': '1000',
                'display': 'none'
            });

        // 알림을 화면에 추가하고 표시
        $('body').append(notification);
        notification.fadeIn(400);

        // 5초 후에 알림 자동 제거
        setTimeout(function() {
            notification.fadeOut(400, function() {
                $(this).remove();
            });
        }, 5000);
    }
    
    // 읽지 않은 알림 수를 가져오는 함수
    function fetchUnreadAlarmCount() {
        $.ajax({
            url: '${root}/alarmCnt.do',
            type: 'GET',
            success: function(count) {
                console.log("읽지 않은 알림 수: ", count);
                $('#alarmCount').text(count > 0 ? count : 0); // 알림 수 업데이트
            },
            error: function() {
                console.log("읽지 않은 알림 수를 가져오는 중 오류가 발생했습니다.");
            }
        });
    }


</script>
