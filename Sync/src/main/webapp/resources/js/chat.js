

function createChat(event){
	
	
	event.preventDefault();
	console.log("채팅방생성 ajax");
	
	let input = $("#chat-input").val();
	
	if(input == ""){
		alert("채팅방 제목을 입력해주세요.");
		return ;
	}	

	var formData = new FormData(document.getElementById('createChatRoomForm'));

	//채팅방 생성 db입력 요청
	$.ajax({
		
		url:"./createChatRoom.do",
		type:"post",
		data: formData,
		processData: false, // 데이터 처리 비활성화
        contentType: false,
		success:function(response){
			console.log(response);
			
				console.log("생성된 chatroomId : " + response);
//				document.getElementById('mySidebar1').classList.remove('open');
//    			document.getElementById('mySidebar2').classList.remove('open');
    			
    			//생성메세지 바로 db입력.
    			sendMessage("enter", response, "채팅방이 생성되었습니다.");
    			
    			
    			setTimeout(function() {
				    window.location.reload();
				}, 400); 
    			
	
		}
	});
	
	
}






var ws = null;
var chatroomId = null;
var empName = null;
//append 이후 scroll 하단으로 위치




function newChat(element, empId, empNameParam, chatroomIdParam){

	let isChatroomInitialized  = false;
	
	chatroomId = chatroomIdParam;
	empName = empNameParam;
	
	console.log(chatroomId);
	//전체 리스트 css제거
	$('.inbox_chat .chat_list').removeClass('active_chat');
	
	//선택된 list만 active
    $(element).addClass('active_chat');
	
	
	$.ajax({
		url:"./socketOpen.do?empId="+empId+"&empName="+empName+"&chatroomId="+chatroomIdParam,
		type:"get",
		success:function(response){
			console.log(response);
			console.log("메뉴 좀 열어즈ㅓ");
			
			
			//상단 메뉴 버튼들 show
			$("#dropdownButton1").show();
			$("#dropdownButton2").show();
			
			//변경시 초기화할 부분
			$(".msgDiv").html("");
			$("#numberOfParticipants").text("");
			$("#dropdownMenu1").html("");
			
			
			
			//참여자정보 업데이트하기.
			let sender = response[0].chat_sender;
			let participants = response[0].participants;
			
			console.log("sender"+sender);
			console.log("participants"+participants);
			
			//채팅방 만든경우 sender가 null
			if(sender == null || sender == ""){
				console.log("null임");
				//참여자 명단
				for(let i=0; i<response.length; i++){
					$("#dropdownMenu1").append(
					$("<div id='drop-Part'>").append(
						$("<img id='dropImg'>").attr('src', 'https://ptetutorials.com/images/user-profile.png'),
						$("<span id='drop-Part-Name'>").text(response[i].participants[0].participant_name),
						$("<span id='drop-Part-Team'>").text(response[i].participants[0].participant_team_name),
						$("<input type='hidden' class='drop-Part-Id'>").val(response[i].participants[0].participant_id)
					)
					
				);
				//참여자 수
				$("#numberOfParticipants").text(response.length);
				}
				
			} else{
				console.log("null 이 아님");
				//참여자 수
				$("#numberOfParticipants").text(participants.length);
				
				//참여자 명단
				console.log("명단:" + participants);
				
				for(let i=0; i<participants.length; i++){
					$("#dropdownMenu1").append(
						$("<div id='drop-Part'>").append(
							$("<img id='dropImg'>").attr('src', 'https://ptetutorials.com/images/user-profile.png'),
							$("<span id='drop-Part-Name'>").text(participants[i].participant_name),
							$("<span id='drop-Part-Team'>").text(participants[i].participant_team_name),
							$("<input type='hidden' class='drop-Part-Id'>").val(response[i].participants[0].participant_id)
						)
						
					);
					
				}
			}
			
			
			
			
			
			//채팅내역 append
			for(let i=0; i<response.length; i++){
				
				//보낸 사람이랑 같다면
				if(response[i].chat_sender == empId && response[i].chat_sender != null && response[i].chat_sender != ""){
					
					
					$(".msgDiv").append(
						    $('<div class="outgoing_msg">').append(
						        $('<div class="sent_msg">').append(
						            $('<p>').text(response[i].content),
						            $('<span class="time_date">').text(response[i].sent_at)
						        )
						    )
						);
					
					
					//퇴장 메세지 append
				} else if(response[i].chat_sender == "exit" && response[i].chat_sender != "" && response[i].chat_sender != null){
					$(".msgDiv").append($("<div class='exitChat'>").html(response[i].content));
					
					//입장 메세지 append
				} else if(response[i].chat_sender == "enter" && response[i].chat_sender != "" && response[i].chat_sender != null){
					
					$(".msgDiv").append($("<div class='enterChat'>").html(response[i].content));
					
					//다른 사람이 보낸 메세지
				} else if(response[i].chat_sender != empId && response[i].chat_sender != "" && response[i].chat_sender != null){
					
					
					$(".msgDiv").append(
						    $('<div class="incoming_msg">').append(
						        $('<div class="incoming_msg_img">').append(
						            $('<img>').attr('src', 'https://ptetutorials.com/images/user-profile.png').attr('alt', 'sunil')
						        ),
						        $('<div class="received_msg">').append(
						            $('<div class="received_withd_msg">').append(
						                $('<span class=chat_sender_name>').text(response[i].chat_sender_name),
						                $('<p>').text(response[i].content),
						                $('<span class="time_date">').text(response[i].sent_at)
						            )
						        )
						    )
						);
					
					
				}
				let chatContainer = $('.msg_history');
           		chatContainer.scrollTop(chatContainer[0].scrollHeight);
				
			}
			
			
			
			
			
			//메세지전송부분
			var today = new Date();
				
				if (ws) {
               		ws.close(); // 기존 웹소켓 연결을 닫기
           		}
				
			
				wsUrl = "ws://localhost:8080/Sync/chatGr.do";
				console.log(wsUrl);
				
				
				//채팅 입력 포커스
				$("#chatInput").focus();
				
				//웹소켓 객체 생성
				ws = new WebSocket(wsUrl);
				console.log("생성된 webSocket 주소", ws);
				
				
				//채팅방 입장
				ws.onopen=function(){
					console.log("웹소켓 오픈");
					//서버 handleText로
					let msg = $(".msgDiv").html();
					
					//이전 메세지 내역이 없다면? -> 채팅방이 생성됨
					if (msg === "" && !isChatroomInitialized) {
				        ws.send("#&chatroom_" + chatroomId);
				        isChatroomInitialized = true; // 채팅방 생성 요청을 보냈으므로 상태 업데이트
				    }
					
				}
				
				
				
				//메세지이벤트
				ws.onmessage=function(event){
					
					var msg = event.data;
					console.log(event, msg);
					
					if(msg.startsWith("#enter_")){	// 입장메시지
						
						console.log("입장 메세지 : " + msg);
						let text = msg.substring(msg.indexOf('_') + 1);
						
						
						$(".msgDiv").append($("<div class='enterChat'>").html(text));
						
						//최근 메시지 append
						$('.list_chatroom_id').each(function() {
							    if ($(this).val() == chatroomId) {
									if(text.length>15){
										text = text.substring(0,16) + " ...... ";
										$(this).prev('.latest_message_content').text(text);
									} else {
										$(this).prev('.latest_message_content').text(text);
									}
							        
							    }
						});		
						
					} else if(msg.startsWith("[나]")){	// 내 메세지 처리 
						
						
						let text = msg.substring(msg.indexOf(']') + 1);
						$(".msgDiv").append(
						    $('<div class="outgoing_msg">').append(
						        $('<div class="sent_msg">').append(
						            $('<p>').text(text),
						            $('<span class="time_date">').text(today.toLocaleTimeString())
						        )
						    )
						);
						
						$('.list_chatroom_id').each(function() {
							    if ($(this).val() == chatroomId) {
									if(text.length>15){
										text = text.substring(0,16) + " ...... ";
										$(this).prev('.latest_message_content').text(text);
									} else {
										$(this).prev('.latest_message_content').text(text);
									}
							        
							    }
						});
						
						
						
						//퇴장 메세지
					} else if(msg.startsWith("#exit_")) {
						console.log("퇴장 메세지 : " + msg);
						let text = msg.substring(msg.indexOf('_') + 1);
						
						
						$(".msgDiv").append($("<div class='exitChat'>").html(text));
						
						$('.list_chatroom_id').each(function() {
							    if ($(this).val() == chatroomId) {
									if(text.length>15){
										text = text.substring(0,16) + " ...... ";
										$(this).prev('.latest_message_content').text(text);
									} else {
										$(this).prev('.latest_message_content').text(text);
									}
							        
							    }
						});
						
						
					//다른 사람 메세지
					} else {
						
						let part = msg.split(":");
						let otherName = part[0];
						let otherMsg = part[1];
						
						$(".msgDiv").append(
								    $('<div class="incoming_msg">').append(
								        $('<div class="incoming_msg_img">').append(
								            $('<img>').attr('src', 'https://ptetutorials.com/images/user-profile.png').attr('alt', 'sunil')
								        ),
								        $('<div class="received_msg">').append(
								            $('<div class="received_withd_msg">').append(
												$('<span class=chat_sender_name>').text(otherName),
								                $('<p>').text(otherMsg),
								                $('<span class="time_date">').text(today.toLocaleTimeString())
								            )
								        )
								    )
						);
						
						
						//최근 메시지 append
						$('.list_chatroom_id').each(function() {
							    if ($(this).val() == chatroomId) {
									if(text.length>15){
										otherMsg = otherMsg.substring(0,16) + " ...... ";
										$(this).prev('.latest_message_content').text(otherMsg);
									} else {
										$(this).prev('.latest_message_content').text(otherMsg);
									}
							        
							    }
						});	
									
					}
					
					let chatContainer = $('.msg_history');
           			chatContainer.scrollTop(chatContainer[0].scrollHeight);
					
				}
						
						
					}
					
	});
		
		
		
}



//메세지 db입력
	function sendMessage(sender, chatroom, content){
		
		
		var formData = new FormData();
		//form에 데이터 추가
		formData.append("chat_sender", sender);
		formData.append("chatroom_id", chatroom);
		formData.append("content", content);
//		console.log(empId);
//		console.log(chatroomId);
//		console.log(content);
		
		
		$.ajax({
				url:"./sendMessage.do",
				type:"post",
				data:formData,
				processData: false, // 데이터 처리 비활성화
       			contentType: false,
       			success:function(response){
					console.log(response);
					let chatContainer = $('.msg_history');
           			chatContainer.scrollTop(chatContainer[0].scrollHeight);
				}
				
			});
		
	}
	


//목록삭제
$(document).on("click", ".removeParticipant", function(){
				$(this).closest("#chatRecipient").remove();
})


//채팅방 나가기
function exitChatRoom(){
	var empId = $("#empId").val();
	
	console.log(ws);
	if(ws == "" || ws == undefined){
		alert("나갈 채팅방이 없습니다.");
		return;
	}
	
	
	Swal.fire({
		  title: "채팅방을 나가시겠습니까?",
		  showDenyButton: true,
		  confirmButtonText: "취소",
		  denyButtonText: `나가기`	 
		}).then((result) => {
		  /* Read more about isConfirmed, isDenied below */
		  if (result.isDenied) {
		    //나가기 버튼을 눌렀을때
		    
		    	$.ajax({
					url:"./exitChatRoom.do?chatroom_id="+chatroomId+"&emp_id="+empId,
					type:"get",
					success:function(response){
						
						console.log(response);
						
						if(response == "true"){
						
						
						//퇴장메세지 DB입력하기
						sendMessage("exit", chatroomId, empName+"님이 채팅방을 나갔습니다.");
						
						//나갈때 메세지 전송
						ws.send("#exit_"+empName);
						
						ws.close();
						
						setTimeout(function() {
						    window.location.reload();
						}, 400);
						
						
						
						
						}
						
					}
			
				})
		  } 
		  
		  
		});

	
	
}


//채팅 드롭다운 초대 클릭 시 사원 선택 메뉴 open
function inviteToChatRoom(){
	
	$('#employeeList').jstree(true).deselect_all();
	
	
	//sidebar2-invite로 위치변경
	$("#mySidebar2").addClass('sidebar2-invite');
	$('#dropdownMenu2').hide();
	$("#mySidebar2").addClass('open');
	
	//title 변경
	$(".sidebar-title").text("");
	$(".sidebar-title").text("대화상대 초대");
	
	
	//초대버튼 활성화
	$(".add-recipient-btn").hide();
	$(".invite-btn").show();
	
	console.log("초대");
	
}


	

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
		
		// 체크박스 선택 값 담기 -> 체크 변할때마다
		// 결재선이 선택될때마다 변경 이벤트
		 $('#employeeList').on("changed.jstree", function () {
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
			    	            '<img id="RecipientProfile" src="http://localhost:8080/Sync/resources/img/구름이.png">' +
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
    							'<img src="http://localhost:8080/Sync/resources/img/approval_img/minus.png">'+
    						'</button>'+
    						'</div>'+
			    	        
			    	    '</div>';
			        
			        // 생성된 HTML을 chatRecipientList에 추가
			        $("#chatRecipientList").append(newChatRecipient);
			        $('#employeeList').jstree(true).deselect_all();
			        
			        
			    });
			
			
			
			
		});
	
	
		//초대버튼 이벤트
		$(".invite-btn").on("click", function(){
			
			console.log('초대 클릭');
			
			$(".drop-Part-Id").each(function(){
				console.log($(this).val());
			});
			
			
			
			
		})
		
	
	
	
	
	//메시지 보내기 버튼 이벤트
	$(".msg_send_btn").bind("click",function(){
		
		
		if($("#chatInput").val() == ""){
			alert("내용을 입력해주세요.");
		} else{
			//handler에 보낼 내용  '닉네임: 내용' 의 형태 
			
			let content = $("#chatInput").val();
			let sender = $("#empId").val();
			
			//퇴장메세지 db저장실행
			sendMessage(sender, chatroomId, content);
			
			//메세지 보내기
			ws.send(sender + ":" + content);
			
			
			
			$("#chatInput").val("");
			$("#chatInput").focus();
		}
		
		
	});
	
	
	// 첫 번째 사이드바 열기
	$('#openSidebar1').on('click', function() {
	    $('#mySidebar1').addClass('open');
	});
	
	// 첫 번째 사이드바 닫기
	$('#closeSidebar1').on('click', function() {
	    $('#mySidebar1').removeClass('open');
	    $('#mySidebar2').removeClass('open');
	});
	
	// 두 번째 사이드바 열기
	$('#openSidebar2').on('click', function() {
		
		$('#employeeList').jstree(true).deselect_all();
		
		//sidebar2-invite로 위치변경
		$("#mySidebar2").removeClass('sidebar2-invite');
		
		//title 변경
		$(".sidebar-title").text("");
		$(".sidebar-title").text("대화상대 추가");
		
		
		//초대버튼 활성화
		$(".invite-btn").hide();
		$(".add-recipient-btn").show();
		
	    $('#mySidebar2').addClass('open');
	    
	    
	    
	});
	
	// 두 번째 사이드바 닫기
	$('#closeSidebar2').on('click', function() {
	    $('#mySidebar2').removeClass('open');
	});
	
		
	
	// 버튼 클릭 시 드롭다운 메뉴 표시/숨기기
    $('#dropdownButton1').on('click', function(event) {
        event.stopPropagation(); // 클릭 이벤트가 부모로 전파되지 않도록 함
        $('#dropdownMenu1').toggle(); // 드롭다운 메뉴를 토글함
    });

    
    // 드롭다운 메뉴 안을 클릭해도 메뉴가 사라지지 않도록 함
    $('#dropdownMenu1').on('click', function(event) {
        event.stopPropagation(); // 클릭 이벤트가 부모로 전파되지 않도록 함
    });
    
	// 버튼 클릭 시 드롭다운 메뉴 표시/숨기기
    $('#dropdownButton2').on('click', function(event) {
        event.stopPropagation(); // 클릭 이벤트가 부모로 전파되지 않도록 함
        $('#dropdownMenu2').toggle(); // 드롭다운 메뉴를 토글함
    });

    
    // 드롭다운 메뉴 안을 클릭해도 메뉴가 사라지지 않도록 함
    $('#dropdownMenu2').on('click', function(event) {
        event.stopPropagation(); // 클릭 이벤트가 부모로 전파되지 않도록 함
    });
	
	// 화면의 다른 곳을 클릭했을 때 드롭다운 메뉴 숨기기
    $(document).on('click', function() {
        $('#dropdownMenu1').hide(); // 드롭다운 메뉴를 숨김
        $('#dropdownMenu2').hide(); // 드롭다운 메뉴를 숨김
       
    });

	
	
});





