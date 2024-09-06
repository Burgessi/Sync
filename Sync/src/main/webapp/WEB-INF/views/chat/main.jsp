<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>채팅</title>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- jstree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<!-- font -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet"/>
<!-- sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.min.css" rel="stylesheet">
<!-- bootstrap -->
<link rel="stylesheet" href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${root}/resources/css/chat/main.css">
<script type="text/javascript" src="${root}/resources/js/chat.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${root}/resources/js/common/main.js"></script>
<style>

.container{
	margin: 0 auto;
	margin-top: 30px;
}

.no-checkbox > .jstree-anchor > .jstree-checkbox {
    display: none !important; /* 체크박스를 완전히 숨김 */
}

.chat-input{
	width: 100%;
  padding: 10px;
  border-radius: 8px; /* 둥근 모서리 */
  border: 1px solid #b0bec5; /* 더 진한 회색 테두리 */
  font-size: 14px;
  background-color: #ffffff; /* 흰색 배경 */
 }


#RecipientProfile{
	border-radius: 10px;
	width: 30px;
	height: 30px;
}

/* 사이드바 스타일 */
.sidebar {
    width: 400px; /* 사이드바 너비 */
  	position: fixed; 
    top: 30px;
    border-radius: 20px; 
/* 	background-color: #B0B7C0; */
/*  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);    */
    transition: 0.3s;*     
    z-index: 1050; 
    
    background-color: #d0e3f0; /* 조금 더 진한 블루 회색 배경 */
 	border-right: 1px solid #b0bec5; /* 오른쪽에 진한 블루 회색 선 */
/*   padding: 20px; /* 패딩 */ */
/*   height: 100vh; /* 전체 높이 */ */
  	display: flex;
  	flex-direction: column; /* 세로로 정렬 */
  	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    
}




/* 첫 번째 사이드바 위치 */
.sidebar1 {
    left: -400px; /* 화면 밖으로 숨김 */
}

/* 두 번째 사이드바 스타일 */
.sidebar2 {
    left: 400px; /* 첫 번째 사이드바 너비만큼 오른쪽으로 이동 */
    width: 300px; /* 두 번째 사이드바 너비 */
    display: none; /* 기본적으로 숨김 */
    background-color: #f5f5f5; /* 밝은 회색 배경 */
  	border-left: 1px solid #e0e0e0; /* 왼쪽에 연한 회색 선 */
  	box-shadow: -2px 0 10px rgba(0, 0, 0, 0.2); /* 진한 그림자 */
}

.sidebar2-invite{
	left: 50%;
	cursor: move;
}




/* 사이드바를 열 때의 위치 */
.sidebar1.open {
    left: 0;
}

.sidebar2.open {
    display: block;
}

/* 사이드바 내용 스타일 */
.sidebar-content {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding: 20px;
}

/* 사이드바 닫기 버튼 */
.btn-close {
    font-size: 24px;
    background: none;
    border: none;
    color: #333;
    cursor: pointer;
    margin-left: auto;
}

/* 사이드바 제목 스타일 */
.sidebar-title {
/*     margin-top: 20px; */
/*     margin-bottom: 20px; */
/*     font-weight: bold; */
    
     font-size: 18px;
  color: #2c3e50; /* 더 진한 네이비 블루 텍스트 */
  margin-bottom: 20px; /* 제목 아래 여백 */
  font-weight: 700; /* 굵은 글씨 */
    
}

/* 사이드바 내용 스타일 */
.sidebar-body {
    flex: 1;
}

/* 숨겨진 영역 스타일 */
.hidden-section {
    display: none; /* 기본적으로 숨김 */
}

/* 숨겨진 영역이 보일 때의 스타일 */
.hidden-section.show {
    display: block;
}

#chatRecipient {
    display: flex; /* Flexbox 활성화 */
    align-items: center; /* 수직 중앙 정렬 */
    padding: 10px; /* 여백 */
    margin-bottom: 3px;
    background-color: #f8f9fa; /* 배경색 */
    border-radius: 11px; /* 모서리 둥글게 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 */
    height: 60px;
}

#chatRecipientProfile {
    margin-right: 10px; /* 프로필 이미지와 이름 사이의 여백 */
}

#RecipientProfile {
    width: 50px; /* 프로필 이미지의 너비 */
    height: 50px; /* 프로필 이미지의 높이 */
    border-radius: 50%; /* 원형 이미지 */
    object-fit: cover; /* 이미지 비율 유지 */
}

#chatRecipientTeam h5{
	margin: 0;
	font-size: 12px;
	font: sans-serif;
	margin-left:8px;
	width: 120px;
}

#chatRecipientRank h5{
	margin: 0;
	margin-left:8px;
	font-size: 12px;
	font: sans-serif;
}

#chatRecipientName h5 {
    margin: 0; /* 제목의 여백 제거 */
    font-size: 17px; /* 제목 글자 크기 */
    font-weight: bold; /* 제목 굵게 */
    font: sans-serif;
}



.chat-btn {
    background-color: #0288d1; /* 기본 진한 블루 배경 */
  color: #ffffff; /* 흰색 텍스트 */
  border: none;
  border-radius: 8px; /* 둥근 모서리 */
  padding: 12px 20px; /* 여백 추가 */
  font-size: 16px;
  font-weight: 500; /* 보통 굵기 */
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease; /* 부드러운 전환 효과 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 진한 그림자 */
  text-align: center; /* 텍스트 중앙 정렬 */
  display: inline-flex; /* 아이콘과 텍스트 정렬을 위한 플렉스 박스 */
  align-items: center; /* 수직 정렬 */
}

/* 호버 효과 */
.chat-btn:hover {
    background-color: #0277bd; /* 더 진한 블루 배경 */
  transform: translateY(-2px); /* 살짝 위로 이동 */
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); /* 더 깊은 그림자 */
}

/* 버튼 비활성화 상태 */
.sidebar .button:disabled {
  background-color: #b0bec5; /* 비활성화된 버튼 배경 */
  color: #ffffff; /* 흰색 텍스트 */
  cursor: not-allowed; /* 커서 모양 변경 */
  box-shadow: none; /* 그림자 제거 */
}



.add-recipient-btn, .invite-btn {
    background-color: #424242; /* 진한 회색 배경 */
  color: #ffffff; /* 흰색 텍스트 */
  border: none;
  border-radius: 8px; /* 둥근 모서리 */
  padding: 12px 20px; /* 여백 추가 */
  font-size: 16px;
  font-weight: 500; /* 보통 굵기 */
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease; /* 부드러운 전환 효과 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 부드러운 그림자 */
  text-align: center; /* 텍스트 중앙 정렬 */
  display: inline-flex; /* 아이콘과 텍스트 정렬을 위한 플렉스 박스 */
  align-items: center; /* 수직 정렬 */
}

.add-recipient-btn:hover {
  background-color: #333333; /* 더 진한 회색 배경 */
  transform: translateY(-2px); /* 살짝 위로 이동 */
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); /* 더 깊은 그림자 */
}

/* 두 번째 사이드바 버튼 비활성화 상태 */
.add-recipient-btn:disabled {
  background-color: #e0e0e0; /* 비활성화된 버튼 배경 */
  color: #ffffff; /* 흰색 텍스트 */
  cursor: not-allowed; /* 커서 모양 변경 */
  box-shadow: none; /* 그림자 제거 */
}

#dropdownButton2,#dropdownButton1 {
	display: none;
}


/* 드롭다운 메뉴 스타일 */
.dropdown-content a {
    color: black;
    padding: 8px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content div:hover {
    background-color: #ddd;
}

#dropImg{
	width: 32px; height: 32px; margin-left: 10px;
}

#drop-Part{
	border-bottom: 1px solid #e0e0e0; display: flex; 
	align-items: center; width: 100%; height: 70px;
}

#drop-Part-Name{
	font-weight: bold; font-size: 0.9em; margin-left: 7px;
}

#drop-Part-Team{
	font-size: 0.7em; margin-left: 8px;
}


.employeeTree{
	background-color: #ffffff; /* 흰색 배경 */
  border-radius: 8px; /* 둥근 모서리 */
  padding: 15px; /* 패딩 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
  border: 1px solid #e0e0e0; /* 연한 회색 테두리 */
  overflow-y: auto; /* 세로 스크롤 */
}


/* jstree 기본 스타일 */
.jstree {
  font-family: 'Arial', sans-serif; /* 폰트 설정 */
  font-size: 11px; /* 폰트 크기 */
  color: #333; /* 텍스트 색상 */
}

/* jstree 노드 스타일 */
.jstree-node {
  border-radius: 6px; /* 둥근 모서리 */
  margin-bottom: 6px; /* 항목 간 여백 */
  transition: background-color 0.3s ease, color 0.3s ease; /* 부드러운 전환 */
  align-items: center; /* 수직 정렬 */
}


/* jstree 활성화 노드 스타일 */
.jstree-node .jstree-clicked {
  color: #424242; /* 진한 회색 텍스트 */
  border-left: 5px solid #757575; /* 왼쪽에 더 진한 회색 선 */
  font-weight: 600; /* 굵은 글씨 */
  background-color: #b0bec5;
}


/* jstree 선택된 노드 강조 스타일 */
.jstree-clicked {
  background-color: #b0bec5; /* 아주 연한 파란색 배경 */
  color: #01579b; /* 더 진한 파란색 텍스트 */
}



/* 체크박스 컨테이너 */
.jstree-checkbox {
  position: relative; /* 위치 조정을 위한 상대 위치 설정 */
  margin-right: 20px; /* 체크박스와 노드 간격 조정 */
}

/* 체크박스 스타일 */
.jstree-checkbox input[type="checkbox"] {
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  appearance: none; /* 기본 체크박스 스타일 제거 */
  background-color: #ffffff; /* 체크박스 기본 배경색 */
  border: 2px solid #b0bec5; /* 체크박스 테두리 색상 */
  border-radius: 4px; /* 둥근 모서리 */
  cursor: pointer; /* 클릭 가능한 커서 */
}

/* 체크박스가 체크된 상태 스타일 */
.jstree-checkbox input[type="checkbox"]:checked {
  background-color: #1e88e5; /* 체크된 배경 색상 */
  border-color: #1e88e5; /* 체크된 테두리 색상 */
}

/* 체크박스 체크 아이콘 */
.jstree-checkbox input[type="checkbox"]:checked::before {
  content: ''; /* 아이콘 내용 초기화 */
  display: block;
  width: 10px;
  height: 10px;
  background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICA8cGF0aCBkPSJNMTAsMEwgMTAsMTYiIHN0cm9rZT0iI0ZGRiIgLz4KPC9zdmc+'); /* 체크 아이콘 */
  background-repeat: no-repeat;
  background-position: center;
  background-size: 10px 10px;
}

/* 체크박스에 마우스를 올렸을 때 스타일 */
.jstree-checkbox input[type="checkbox"]:hover {
  border-color: #1e88e5; /* 마우스 오버 시 테두리 색상 */
}

/* 체크박스 비활성화 상태 스타일 */
.jstree-checkbox input[type="checkbox"]:disabled {
  background-color: #e0e0e0; /* 비활성화 배경 색상 */
  border-color: #b0bec5; /* 비활성화 테두리 색상 */
  cursor: not-allowed; /* 클릭 불가능 커서 */
}



</style>
</head>
<body>
<%-- <%@ include file="/WEB-INF/views/common/sidebar.jsp" %> --%>
<div class="container">
<div class="messaging">
      <div class="inbox_msg">
        <div class="inbox_people">
          <div class="headind_srch">
             <div class="recent_heading">
              <h4>Chat</h4>
              <input type="hidden" id="empId" value="${infoDto.emp_id}">
            </div>
            <div class="srch_bar">
              <div class="stylish-input-group" style="right: 0;">
              	<button style="border: none; background: none;" id="openSidebar1"><img alt="" src="${root}/resources/img/newChat.png"></button>
         	</div>
            </div>
          </div>
          <div class="inbox_chat">
          	
			<!-- 채팅내역 set -->
			<c:set var="ln" value="${fn:length(chatList)}"/>
          	<c:choose>
          		<c:when test="${ln > 0}">
          				<c:forEach var="list" items="${chatList}">
		          			 <div class="chat_list" onclick="newChat(this,'${infoDto.emp_id}','${infoDto.emp_name}','${list.chatroom_id}')">
				              <div class="chat_people">
				                <div class="chat_img"> 
				                <img src="https://picsum.photos/250/250" alt="sunil"> 
<!-- 				                <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil">  -->
				                </div>
				                <div class="chat_ib">
				                  <h5>${list.chatroom_name}<span class="chat_date">${list.latest_message_sent_at}</span></h5>
				                  <c:set var="content" value="${list.latest_message_content}"/>
				                  <c:choose>
				                  	<c:when test="${fn:length(content) > 15}"> <!-- 15글자 이상 -->
				                  		<p class="latest_message_content">${fn:substring(content,0,15)} ......</p>
				                  	</c:when>
				                  	<c:otherwise>
				                  		<p class="latest_message_content">${content}</p>
				                  	</c:otherwise>
				                  </c:choose>
				                  
				                  <input type="hidden" class="list_chatroom_id" value="${list.chatroom_id}">
				                </div>
				              </div>
				            </div>
		          		</c:forEach>
          		</c:when>
          		<c:otherwise>
          		<div style="height: 500px; display: flex; justify-content: center; align-items: center;">
          			<h5>채팅 내역이 없습니다.</h5>
          		</div>
          		</c:otherwise>
          	</c:choose>
           
            
            
           </div>
        </div>
        
        
        <!-- 채팅 출력 부분 -->
        <div class="mesgs">
        	<div style="width: 100%; border-bottom: 0.5px solid #c4c4c4; position: relative; height: 35px;">
        		<button id="dropdownButton1" style="background: none; border: none; position: absolute;">
        			<img style="width: 19px; height: 19px; " src="${root}/resources/img/chatpeople.png">
        			<span id="numberOfParticipants" style="font-size: 12px;"></span>
        		</button>
        		
        		<!-- 채팅 참여 목록 -->
        		<div id="dropdownMenu1" class="dropdown-content" style="display: none; position: absolute; top: 35px; background-color: white; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; width: 230px; height: 300px; overflow: auto;">
		        </div>
        		
        		
        		<button id="dropdownButton2" type="button" style="background: none; border: none; position: absolute; right: 0;">
        			<img src="${root}/resources/img/more.png">
        		</button>
        		
        		 <div id="dropdownMenu2" class="dropdown-content" style="display: none; position: absolute; right: 0; top: 35px; background-color: white; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1;">
		            <div style="border-bottom: 1px solid #e0e0e0; display: flex; align-items: center;"><img src="${root}/resources/img/userplus.png" style="width: 22px; height: 22px; margin-left: 10px;"><a href="#" style="font: 0.9em sans-serif; font-weight: bold;" onclick="inviteToChatRoom()">초대</a></div>
		            <div style="border-bottom: 1px solid #e0e0e0; display: flex; align-items: center;"><img src="${root}/resources/img/exit.png" style="width: 19px; height: 19px; margin-left: 10px;"><a href="#" onclick="exitChatRoom()" style="font: 0.9em sans-serif; font-weight: bold;">나가기</a></div>
		        </div>
        	</div>
          <div class="msg_history">
          	<!-- 채팅내용 -->
          		<div class="msgDiv">
          		
          		
<!--           			<div class="outgoing_msg"> -->
<!--           				<div class="sent_msg"> -->
<!--           					<span>이름</span> -->
<!--           					<p>안녕하세요</p> -->
<!--           					<span class="time_date">222</span> -->
<!--           				</div> -->
<!--           			</div> -->
<!--           			<div class="incoming_msg"> -->
<!--           				<div class="incoming_msg_img"> -->
<!--           					<span>이름</span> -->
<!--           					<p>안녕하세요</p> -->
<!--           					<span class="time_date">222</span> -->
<!--           				</div> -->
<!--           			</div> -->
          			
          			
          		</div>
          		
          		
			<!--채팅 입력 -->
        </div>
        <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" id="chatInput" class="write_msg" placeholder="내용을 입력해주세요." onkeypress="if(event.keyCode == 13){ $('.msg_send_btn').click()}"/>
              <button class="msg_send_btn" type="button">
              	<i class="fa fa-paper-plane-o" aria-hidden="false"></i>
              </button>
            </div>
          </div>
      </div>
      
      
    </div>
    
   </div>
</div>
 <!-- 첫 번째 사이드바  채팅방 생성/추가된 사원목록 -->
 <form id="createChatRoomForm">
    <div id="mySidebar1" class="sidebar sidebar1">
        <div class="sidebar-content rounded-4 shadow">
            <button type="button" class="btn-close text-white" id="closeSidebar1">
                <img alt="" src="${root}/resources/img/approval_img/xIcon.png">
            </button>
            <h5 class="sidebar-title">채팅방 만들기</h5>
            <div class="sidebar-body">
            	<span style="padding: 8px; font: 0.8em sans-serif;">채팅방 이름</span>
                <input type="text" id="chat-input" autocomplete="off" name="chatroom_name" class="form-control chat-input" placeholder="채팅방 이름을 입력해주세요.">
                <div class="row">
                	<div class="col-md-9">
                		<h5 class="sidebar-title mt-4">참여자 목록</h5>
                	</div>	
                	<div class="col-md-3" style="text-align: right;">
                		<button type="button" style="border: none; background: none; width: 40px; height: 40px; margin-top: 18px;" id="openSidebar2">
	               		 <img alt="" src="${root}/resources/img/userplus.png">
	          	 	 	</button>
                	</div>
               </div> 		
                		
                	<div id="chatRecipientList" style="height: 320px; overflow: auto;">
                		
                			<div id="chatRecipient">
                					<div id="chatRecipientProfile">
                						<img id="RecipientProfile" src="${root}/resources/img/구름이.png">
                					</div>
                					<div id="chatRecipientName">
                						<h5>${infoDto.emp_name}</h5>
                						<input type="hidden" name="emp_id" value="${infoDto.emp_id}">
                					</div>
                					<div id="chatRecipientRank">
                						<h5>${infoDto.rank_name}</h5>
                					</div>
                					<span style="margin: 0; margin-left: 8px;">-</span>
                					<div id="chatRecipientTeam">
                						<h5>${infoDto.team_name}</h5>
                					</div>
                			</div>
                			
                		</div>
                		<div style="text-align: center; margin-top: 30px;">
                			<button class="chat-btn" onclick="createChat(event)">채팅방 생성</button>
                		</div>
                		
                </div>
              </div>
         </div>
</form>
    <!-- 두 번째 사이드바 -> 대화상대 선택 -->
    <div id="mySidebar2" class="sidebar sidebar2">
        <div class="sidebar-content rounded-4 shadow">
            <button type="button" class="btn-close text-white" id="closeSidebar2">
                <img alt="" src="${root}/resources/img/approval_img/xIcon.png">
            </button>
            <h5 class="sidebar-title"></h5>
            <div class="employeeTree">
            	<div id="employeeList" style="width: 90%; height: 400px; overflow: auto; margin: 5px auto;"></div>
            </div>
            <div style="width: 200px; margin: 5px auto; text-align: center;">
            	<button class="add-recipient-btn">추가</button>
            	<button class="invite-btn">초대</button>
            </div>
        </div>
    </div>


</body>
</html>