


let isFocused = true;

// 자식 창에 포커스가 있을 때
window.onfocus = function() {
    isFocused = true;
    console.log('채팅창에 포커스가 있습니다.');
};

// 자식 창에 포커스가 없을 때
window.onblur = function() {
    isFocused = false;
    console.log('채팅창에 포커스가 없습니다.');
};

// 메시지가 도착했을 때 부모 창으로 알림 전송
function sendMessageToParent(message) {
    // 자식 창에 포커스가 없을 때만 부모 창으로 알림 전송
    if (window.opener && !isFocused) {
        window.opener.postMessage(message, window.location.origin);
        console.log(`부모 창으로 알림 전송: ${message}`);
    }
}



function createChat(event){
	
	
	event.preventDefault();
	console.log("채팅방생성 ajax");
	
	let input = $("#chat-input").val();
	
	if(input == ""){
		toastr.info("채팅방 이름을 입력해주세요.");
		return ;
	}	

	let cnt = 0;
	$("input[name=emp_id]").each(function(){
		cnt ++;
	});
	
	if(cnt<=1){
		toastr.error("채팅 상대를 선택해 주세요.");
		return;	
	}


	

	let formData = new FormData(document.getElementById('createChatRoomForm'));

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
var today = new Date();
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
							$("<input type='hidden' class='drop-Part-Id'>").val(participants[i].participant_id)
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
					
					//초대 메세지 append
				} else if(response[i].chat_sender == "invite" && response[i].chat_sender != "" && response[i].chat_sender != null){
				
					$(".msgDiv").append($("<div class='inviteChat'>").html(response[i].content));
				
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
						
						
						
					// 초대 메세지	
					} else if (msg.startsWith("#invite_")){
						console.log("초대메세지 : " + msg);
						let text = msg.substring(msg.indexOf('_') + 1);
						
						
						//초대메세지는 사람 있을때 실행됨 -> 메세지 받고 insert가능
						sendMessage("invite", chatroomId, text);
						
						$(".msgDiv").append($("<div class='inviteChat'>").html(text));
						
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
						// 메시지가 도착했을 때 호출
						sendMessageToParent("새로운 채팅 메시지가 도착했습니다.");
						
						
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
						// 메시지가 도착했을 때 호출
						sendMessageToParent("새로운 채팅 메시지가 도착했습니다.");
						
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
									if(otherMsg.length>15){
										otherMsg = otherMsg.substring(0,16) + " ...... ";
										$(this).prev('.latest_message_content').text(otherMsg);
									} else {
										$(this).prev('.latest_message_content').text(otherMsg);
									}
							        
							    }
									
							    
						});	
							
						// 메시지가 도착했을 때 호출
						sendMessageToParent("새로운 채팅 메시지가 도착했습니다.");	
									
					}
					
					let chatContainer = $('.msg_history');
           			chatContainer.scrollTop(chatContainer[0].scrollHeight);
					
				}
						
						
					}
					
	});
		
		
		
}



//메세지 db입력
	function sendMessage(sender, chatroom, content){
		
		
		let formData = new FormData();
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
	$(".sidebar2-title").text("");
	$(".sidebar2-title").text("대화상대 초대");
	
	
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
			    
			    
		        let duplicateChk = "N";
			    
			    //목록에 추가 되어있는 empid 배열로 담기
			    var empIds = $("input[name=emp_id]").map(function() {
			        return $(this).val();
			    }).get();
			    console.log(empIds);
		        
		        
		        //목록 중복확인
			    selectedNodes.forEach(function(node) {
			    	if(empIds.includes(node.id)){
			    		duplicateChk = "Y";
			    	}
			    });
			    
			    
			    if(duplicateChk == "Y"){
		    		toastr.warning("이미 목록에 존재하는 사원입니다.");
		    		 $('#employeeList').jstree(true).deselect_all();
		    		return;
		    	}
			    
			    
			    
// 			    // 선택된 노드 반복해서 append하기
			    selectedNodes.forEach(function(node) {
			    	
			    	let name = node.original.text;
			    	
			    	
			    	var newChatRecipient = 
			    	    '<div id="chatRecipient">' +
			    	        '<div id="chatRecipientProfile">' +
			    	            '<img id="RecipientProfile" src="http://localhost:8080/Sync/resources/img/구름이.png">' +
			    	        '</div>' +
			    	        '<div id="chatRecipientName">' +
			    	            '<h5>' + name.substring(0, name.indexOf(" (")) + '</h5>' +
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
			
			let ids = [];
			
			console.log('초대 클릭');
			
			// 현재 참여자 ID 가져오기. 
			$(".drop-Part-Id").each(function(){
				console.log($(this).val());
				ids.push($(this).val());
			});
			
			
			let str = "";
			//선택한 node name 저장하기
			selectedNodes.forEach(function(node) {
				 str += node.text + ", ";
			});
			inviteName = str.slice(0,-2);
			
			console.log("inviteName : "+ inviteName + "님을 초대했습니다.");
			
			console.log(ids);
			
			//참여자 중복 확인
			let duplicateChk = "N";
			let selectIds = [];
			
			selectedNodes.forEach(function(node) {
				selectIds.push(node.id);
		    	if(ids.includes(node.id)){
		    		duplicateChk = "Y";
		    	}
			});
			
//			console.log(selectIds);
//			console.log(selectedNodes);
			
			//중복시 리턴
			if(duplicateChk == "Y"){
				toastr.warning('채팅방에 이미 존재하는 사원입니다.');
				$('#employeeList').jstree(true).deselect_all();
				return;
			}
			
			
			//선택node가 하나도 없을때 리턴
			if(selectedNodes.length <= 0){
				toastr.warning("선택한 사원이 없습니다.");
				return;
			}
			
			let formData = new FormData();
			formData.append("chatroomId", chatroomId);
			
			for(let i=0; i<selectIds.length; i++){
				formData.append("empIds", selectIds[i]);
			}
			
			console.log("전달 form data: " + formData);
			
			
			
			Swal.fire({
				  text: "선택한 사원을 초대하시겠습니까?",
				  icon: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#3085d6",
				  cancelButtonColor: "#d33",
				}).then((result) => {
				  if (result.isConfirmed) {
				   
				   			$.ajax({
					
								url:"./inviteToChatRoom.do",
								type:"post",
								data:formData,
								processData: false, // 데이터 처리 비활성화
						       	contentType: false,
								success:function(response){
									
									console.log(response);
									
									//핸들러로 메세지 전송
									ws.send("#invite_" + inviteName + "님을 초대했습니다.");
									
									
									
									
									let participants = response[0].participants;
									
									
									//숫자 명단 clear 후 재입력
									$("#numberOfParticipants").text("");
									$("#dropdownMenu1").html("");
									
									$("#numberOfParticipants").text(participants.length);
							
									//참여자 명단
									console.log("명단:" + participants);
									
									for(let i=0; i<participants.length; i++){
										$("#dropdownMenu1").append(
											$("<div id='drop-Part'>").append(
												$("<img id='dropImg'>").attr('src', 'https://ptetutorials.com/images/user-profile.png'),
												$("<span id='drop-Part-Name'>").text(participants[i].participant_name),
												$("<span id='drop-Part-Team'>").text(participants[i].participant_team_name),
												$("<input type='hidden' class='drop-Part-Id'>").val(participants[i].participant_id)
											)
											
										);
										
									}
									
									
									//tree 선택 초기화
									$('#employeeList').jstree(true).deselect_all();
									
									//사이드바 닫기
									 $('#mySidebar2').removeClass('open');
									
								}
								
								
								
							})
				   
				   
				  }
				});
			
			
			
		})
		
	
	
	
	
	//메시지 보내기 버튼 이벤트
	$(".msg_send_btn").bind("click",function(){
		
		
		if($("#chatInput").val() == ""){
			toastr.info("내용을 입력해주세요.");
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
		$(".sidebar2-title").text("");
		$(".sidebar2-title").text("대화상대 추가");
		
		
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
    
    
    
   		   $('.chat_date').each(function() {
                var $chatDateElement = $(this);
                var chatDateText = $chatDateElement.text().trim(); // 텍스트에서 공백 제거

                // 메시지 날짜와 시간 분리
                var parts = chatDateText.split(' ');
                var messageDate = parts[0];
                var messageTime = parts[1];

                // 날짜 객체 생성
                var messageDateObj = new Date(messageDate + 'T00:00:00'); // 메시지 날짜를 기준으로 Date 객체 생성
                var todayDateObj = new Date(); // 현재 날짜
                todayDateObj.setHours(0, 0, 0, 0); // 오늘 날짜의 00:00:00으로 설정

                // 날짜 비교 및 표시
                if (messageDateObj.getTime() === todayDateObj.getTime()) {
                    // 오늘 날짜와 같다면 시간만 표시
                    $chatDateElement.text(messageTime);
                } else {
                    // 오늘 날짜가 아니라면 전체 날짜 표시
                    $chatDateElement.text(messageDate);
                }
            });

	
	
	//사진첨부
	$('#attachButton').on('click', function() {
	    $('#fileInput').click();
	  });
	
	// 파일 입력창에서 파일 선택 시 이미지 미리보기
	  $('#fileInput').on('change', function(event) {
	    const file = event.target.files[0]; // 선택한 파일 가져오기
	
	    if (file && file.type.startsWith('image/')) { // 이미지 파일인지 확인
	      const reader = new FileReader();
	
	      // 파일 읽기가 완료되면 실행
	      reader.onload = function(e) {
	        // 미리보기 이미지 표시
	        $(".msgDiv").append(
						    $('<div class="outgoing_msg">').append(
						        $('<div class="sent_msg">').append(
									$('<span> style="color=black;"').text("미리보기"),
						           $('<img src="' + e.target.result + '" alt="Image Preview" style="max-width: 350px; max-height: 350px;">'),
						            $('<span class="time_date">').text(today.toLocaleTimeString())
						        )
						    )
						);
	      };
			
			
	      // 파일을 읽음 (데이터 URL 형식으로)
	      reader.readAsDataURL(file);
	    } else {
	      // 이미지 파일이 아닌 경우 처리
	      toastr.error("이미지 파일을 선택해주세요.");
	    }
	  });
	
	
});





