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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.min.css" rel="stylesheet">
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
	font: 0.8em sans-serif;
	margin-top: 5px;
	margin-bottom: 5px;
}


#RecipientProfile{
	border-radius: 10px;
	width: 30px;
	height: 30px;
}

/* 사이드바 스타일 */
.sidebar {
    height: 100%;
    width: 400px; /* 사이드바 너비 */
    position: fixed;
    top: 0;
    background-color: #B0B7C0;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: 0.3s; /* 부드러운 애니메이션 효과 */
    z-index: 1050; /* 다른 요소보다 위에 위치 */
}

/* 첫 번째 사이드바 위치 */
.sidebar1 {
    left: -400px; /* 화면 밖으로 숨김 */
}

/* 두 번째 사이드바 스타일 */
.sidebar2 {
    left: 400px; /* 첫 번째 사이드바 너비만큼 오른쪽으로 이동 */
    width: 300px; /* 두 번째 사이드바 너비 */
    background-color: #D0D7E0; /* 두 번째 사이드바 배경색 */
    display: none; /* 기본적으로 숨김 */
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
    margin-top: 20px;
    margin-bottom: 20px;
    font-weight: bold;
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
    background: linear-gradient(135deg, #6c5b7b, #c06c84); /* 부드러운 그라데이션 배경 */
    border: none;
    color: white;
    padding: 15px 30px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 50px; /* 라운드 처리된 모서리 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */
    transition: all 0.3s ease; /* 애니메이션 */
    cursor: pointer;
    outline: none;
}

/* 호버 효과 */
.chat-btn:hover {
    background: linear-gradient(135deg, #c06c84, #6c5b7b); /* 그라데이션 반전 */
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2); /* 그림자 강화 */
    transform: translateY(-3px); /* 살짝 위로 이동 */
}

/* 버튼 클릭 시 효과 */
.chat-btn:active {
    transform: translateY(0); /* 클릭 시 원래 위치로 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15); /* 그림자 원상 복귀 */
}

.add-recipient-btn {
    background: linear-gradient(135deg, #ff7e5f, #feb47b); /* 부드러운 그라데이션 배경 */
    border: none;
    color: white;
    padding: 12px 24px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 30px; /* 라운드 처리된 모서리 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    transition: all 0.3s ease; /* 애니메이션 */
    cursor: pointer;
    outline: none;
    text-transform: uppercase; /* 대문자 변환 */
    letter-spacing: 1px; /* 문자 간격 */
}

/* 호버 효과 */
.add-recipient-btn:hover {
    background: linear-gradient(135deg, #feb47b, #ff7e5f); /* 그라데이션 반전 */
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); /* 그림자 강화 */
    transform: translateY(-3px); /* 살짝 위로 이동 */
}

/* 버튼 클릭 시 효과 */
.add-recipient-btn:active {
    transform: translateY(0); /* 클릭 시 원래 위치로 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 원상 복귀 */
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
				                  <p>${list.latest_message_content}</p>
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
		            <div style="border-bottom: 1px solid #e0e0e0; display: flex; align-items: center;"><img src="${root}/resources/img/userplus.png" style="width: 22px; height: 22px; margin-left: 10px;"><a href="#" style="font: 0.9em sans-serif; font-weight: bold;">초대</a></div>
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
 <!-- 첫 번째 사이드바 -->
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
            <h5 class="sidebar-title">대화상대 추가	</h5>
            <div id="employeeList" style="width: 90%; height: 400px; overflow: auto; margin: 5px auto;"></div>
            <div style="width: 200px; margin: 5px auto; text-align: center;">
            	<button class="add-recipient-btn">대화상대 추가</button>
            </div>
        </div>
    </div>

<!-- 채팅방 생성 -->
<!-- <div class="modal fade" tabindex="-1" role="dialog" id="chatRoomModal"> -->
<!-- 			 <div class="modal-dialog modal-dialog-centered" role="document"> -->
<!-- 				 <div class="modal-content rounded-4 shadow"> -->
<!-- 						<div class="modal-header p-5 pb-4 border-bottom-0"> -->
<!-- 							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 						</div> -->
<!-- 						<div class="modal-body p-5 pt-0"> -->
<!-- 							<input type="text" class="form-control chat-input" placeholder="채팅방 이름을 입력해주세요.">		 -->
<!-- 						</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- </div> -->




<!-- <!-- 채팅방 생성시 사원목록 --> 
<!-- <div class="modal fade" tabindex="-1" role="dialog" id="chatEmployeeModal"> -->
<!--     <div class="modal-dialog modal-dialog-centered modal-sm" role="document"> -->
<!--         <div class="modal-content rounded-4 shadow"> -->
<!--             <div class="modal-header p-5 pb-4 border-bottom-0"> -->
<!--                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--             </div> -->
<!--             <div class="modal-body p-5 pt-0"> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->




<!-- <!-- 채팅방 생성시 사원목록 -->
<!-- <div class="modal fade" tabindex="-1" role="dialog" id="chatEmployeeModal"> -->
<!-- 			 <div class="modal-dialog modal-dialog-centered" role="document"> -->
<!-- 				 <div class="modal-content rounded-4 shadow"> -->
<!-- 						<div class="modal-header p-5 pb-4 border-bottom-0"> -->
<!-- 							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 						</div> -->
<!-- 						<div class="modal-body p-5 pt-0"> -->
							
<!-- 							<div class="row"> -->
<!-- 								<div class="col-md-6" style="font-weight: bold; font: 0.7em sans-serif; height: 500px; overflow:auto;"> -->
<!-- 									<h4 class="fw-bold mb-0 fs-4">사원목록</h4> -->
<!-- 									목록출력 부분 -->
<!-- 									<div id="employeeList"> -->
									
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-md-6" style="text-align: center; font-weight: bold;"> -->
<!-- 								<h4 class="fw-bold mb-0 fs-4">받는사람 목록</h4> -->
<!-- 									</div> -->
<!-- 							</div> -->
							
													
<!-- 						</div> -->
						
<!-- 				</div> -->
<!-- 			</div> -->
<!-- </div> -->




</body>
<script type="text/javascript">

	


	$(document).ready(function(){
		//조직도 jsTree
		
		// 서버에 데이터 요청
		$.ajax({
		   	type : "POST",
		   	url : 'http://localhost:8080/Sync/approval/approvalJstree.do',
		   	success: function(data){
		   		var url = location.href;
			        menu_json = data;
			        CreateJSTrees(data);
		    }
		});
		
		// 서버에서 가져온 데이터로 JSTree 만듦
		function CreateJSTrees(data){
//				console.log('22');
//				console.log(menu_json);
			console.log(data);
			
			$('#employeeList').jstree({
				  'core' : {
				    'data' : menu_json,
				    
				    "check_callback" : true
				
				  },
				  'checkbox' : {
				        'three_state': false
				    },
				  "search": {
				        "show_only_matches": true,
				        "show_only_matches_children": true
				   },
				   "themes" : {
			            "responsive": true
			        },
				  "plugins" : ["search", "checkbox"],
				 
			});
			
			
			
		}
		
		
		// 검색 상자
		var to = false;
		$('#treeSearchInput').keyup(function () {
		    if(to) { clearTimeout(to); }
		    to = setTimeout(function () {
		        var v = $('#treeSearchInput').val();
		        $('#employeeList').jstree(true).search(v);
		    }, 250);
		});
		
		
		
		// 서버에 값 보낼때 필요하기 때문에 전역변수로
		var selectedNodes = "";
		var nodeIds = [];
		
		// 체크박스 선택 값 담기 -> 체크 변할때마다
		// 결재선이 선택될때마다 변경 이벤트
		 $('#employeeList').on("changed.jstree", function (e, data) {
//	 		 console.log($('#tree').jstree("get_selected", true));
//	 		 console.log($('#tree').jstree("get_checked", true));
			 
			 //현재 선택된 모든 노드
	         selectedNodes = $('#employeeList').jstree("get_selected", true);
			 console.log(selectedNodes);
			 
		 });
		
		 
		 $('.add-recipient-btn').on('click', function() {
			    
			 // 선택된 jstree 노드
// 			    console.log(selectedNodes);
// 			    console.log(selectedNodes[0].original.text);
			    
			    
		        var duplicateChk = "N";
			    
			    //목록에 추가 되어있는 empid 배열로 담기
			    var empIds = $("input[name=emp_id]").map(function() {
			        return $(this).val();
			    }).get();
			    console.log(empIds);
		        
			    selectedNodes.forEach(function(node) {
			    	if(empIds.includes(node.id)){
			    		duplicateChk = "Y";
			    	}
			    });
			    
			    
			    if(duplicateChk == "Y"){
		    		alert("목록에 존재합니다.");
		    		 $('#employeeList').jstree(true).deselect_all();
		    		return;
		    	}
			    
			    
			    
// 			    // 선택된 노드 반복해서 append하기
			    selectedNodes.forEach(function(node) {
			    	
			    	
			    	var newChatRecipient = 
			    	    '<div id="chatRecipient">' +
			    	        '<div id="chatRecipientProfile">' +
			    	            '<img id="RecipientProfile" src="${root}/resources/img/구름이.png">' +
			    	        '</div>' +
			    	        '<div id="chatRecipientName">' +
			    	            '<h5>' + node.original.text + '</h5>' +
			    	            '<input type="hidden" name="emp_id" value="'+ node.id +'">' + 
			    	        '</div>' +
			    	        '<div id="chatRecipientRank">' +
			    	            '<h5>' + node.original.rank + '</h5>' +
			    	        '</div>' +
			    	        '<span style="margin: 0; margin-left: 8px;">-</span>' +
			    	        '<div id="chatRecipientTeam">' +
			    	            '<h5>' + node.original.team + '</h5>' +
			    	        '</div>' +
			    	        
			    	        '<div>' +
    						'<button type="button" class="removeParticipant" style="border: none; background: none;">'+
    							'<img src="${root}/resources/img/approval_img/minus.png">'+
    						'</button>'+
    						'</div>'+
			    	        
			    	    '</div>';
			        
			        // 생성된 HTML을 chatRecipientList에 추가
			        $("#chatRecipientList").append(newChatRecipient);
			        $('#employeeList').jstree(true).deselect_all();
			        
			        
			    });
			
			
			
			
		});
		
		
		
	})
	
// 첫 번째 사이드바 열기
document.getElementById('openSidebar1').addEventListener('click', function() {
    document.getElementById('mySidebar1').classList.add('open');
});

// 첫 번째 사이드바 닫기
document.getElementById('closeSidebar1').addEventListener('click', function() {
    document.getElementById('mySidebar1').classList.remove('open');
    document.getElementById('mySidebar2').classList.remove('open');
});

// 두 번째 사이드바 열기
document.getElementById('openSidebar2').addEventListener('click', function() {
    document.getElementById('mySidebar2').classList.add('open');
});

// 두 번째 사이드바 닫기
document.getElementById('closeSidebar2').addEventListener('click', function() {
    document.getElementById('mySidebar2').classList.remove('open');
});
	
</script>
</html>