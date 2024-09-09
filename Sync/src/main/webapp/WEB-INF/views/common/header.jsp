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
        
        
          <li class="nav-item dropdown me-3">   
             <a class="nav-link" style="margin-right: -8px; margin-top: 3px;" href="javascript:window.open('${root}/chat/main.do','채팅','width=1205px, height=745px, toolbar=no, menubar=no, left=100px, top=160px')">
                <i class="bi bi-chat-left-dots bi-sub fs-4" style="color: #223055;"></i>
             </a>
          </li>
          
          
          
          
          <!-- 알림 -->
          <li class="nav-item dropdown me-3">	
          	<a class="nav-link" style="margin-right: -8px; margin-top: 3px;" href="javascript:window.open('${root}/chat/main.do','채팅','width=1205px, height=745px, toolbar=no, menubar=no, left=100px, top=160px')">
	          	<i class="bi bi-chat-left-dots bi-sub fs-4" style="color: #223055;"></i>
          	</a>
          </li>
          
          

          <li class="nav-item dropdown me-3">
            <a
              class="nav-link active dropdown-toggle text-gray-600"
              href="#"
              data-bs-toggle="dropdown"
              data-bs-display="static"
              aria-expanded="false"
            >
              <i class="bi bi-bell bi-sub fs-4"></i>
            </a>
            
                     
<ul class="dropdown-menu dropdown-menu-end notification-dropdown" aria-labelledby="dropdownMenuButton" style="left: 13%;">
  <li class="dropdown-header">
    <h6>Notifications</h6>
  </li>
  
  <!-- notification-list -->
  <ul id="notification-list">
    <!-- 알림이 동적으로 추가되는 부분 -->
<!--     <li class="dropdown-item notification-item"> -->
<!--       <a class="d-flex align-items-center" href="#"> -->
<!--         <div class="notification-icon bg-primary"> -->
<!--           <i class="bi bi-cart-check"></i>  -->
<!--         </div> -->
<!--         <div class="notification-text ms-4"> -->
<!--           <p class="notification-title font-bold">댓글이 달렸습니다</p> -->
<!--           <p class="notification-subtitle font-thin text-sm">1분 전</p> -->
<!--         </div> -->
<!--       </a> -->
<!--     </li> -->
<!--     <li class="dropdown-item notification-item"> -->
<!--       <a class="d-flex align-items-center" href="#"> -->
<!--         <div class="notification-icon bg-success"> -->
<!--           <i class="bi bi-file-earmark-check"></i>  -->
<!--         </div> -->
<!--         <div class="notification-text ms-4"> -->
<!--           <p class="notification-title font-bold">결재가 승인되었습니다</p> -->
<!--           <p class="notification-subtitle font-thin text-sm">2시간 전</p> -->
<!--         </div> -->
<!--       </a> -->
<!--     </li> -->
  </ul>  
</ul>

                 
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
    
    //주기적으로 알림 목록을 새로 고침 
    setInterval(fetchNotifications, 30000); //30초

    function fetchNotifications() {
        $.ajax({
            url: './alarmList.do',
            type: 'GET',
            dataType: 'json',
            success: function(alarms) {
           	
            	 console.log("제발떠라: ",alarms);
            	           	 
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
            notificationList.append('<li class="dropdown-item"><p>읽지 않은 알림이 없습니다.</p></li>');
        } else {
            $.each(alarms, function(index, alarm) {
                var notificationItem = `
                    <li class="dropdown-item notification-item">
                        <a class="d-flex align-items-center" href="#">
                            <div class="notification-text ms-4">
                                <p class="notification-title font-bold">${alarm.title}</p>
                                <p class="notification-subtitle font-thin text-sm">${alarm.timeAgo}</p>
                            </div>
                        </a>
                    </li>
                `;
                notificationList.append(notificationItem);
            });
            
         // 알림 클릭 이벤트 처리
            $('.notification-item').on('click', function() {
                var alarmId = $(this).data('alarm-id');
                isRead(alarmId);
            });
        }
    }

    function isRead(alarmId) {
        $.ajax({
            url: './alarmRead/${alarmId}',
            type: 'POST',
            success: function() {
                console.log("알림이 읽음으로 처리되었습니다.");
               
                fetchNotifications(); //새로 고침
            },
            error: function(xhr, status, error) {
                console.log("알림을 읽음으로 처리하는 중 오류가 발생했습니다.", error);
            }
        });
    }
    
    
});

    
    
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
    
// });
    
    
    
    
    
</script>