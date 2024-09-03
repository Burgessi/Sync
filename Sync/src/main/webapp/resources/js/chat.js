



function newChat(empId, empName){
	
	let grId = "S";
	
	$.ajax({
		url:"./socketOpen.do?empId="+empId+"&grId="+grId+"&empName="+empName,
		type:"get",
		success:function(response){
			console.log(response);
			
			var today = new Date();
	
	
				wsUrl = "ws://localhost:8080/Sync/chatGr.do";
				console.log(wsUrl);
				var empName = $("#empName").text();
				
				//채팅 입력 포커스
				$("#chatInput").focus();
				
				//웹소켓 객체 생성
				ws = new WebSocket(wsUrl);
				console.log("생성된 webSocket 주소", ws);
				
				//채팅방 입장
				ws.onopen=function(){
					console.log("웹소켓 오픈");
					//서버 handleText로
					ws.send("#&name_"+empName);
				}
				
				//메세지이벤트
				ws.onmessage=function(event){
					var msg = event.data;
					console.log(event, msg);
					
					if(msg.startsWith("<font style")){	// 입장메시지 퇴장 메세지
						$(".msgDiv").append($("<div class='enterChat'>").html(msg));
						
					} else if(msg.startsWith("[나]")){	// 내 메세지 처리 
					
						var text = msg.substring(msg.indexOf(']') + 1);
						$(".msgDiv").append(
						    $('<div class="outgoing_msg">').append(
						        $('<div class="sent_msg">').append(
						            $('<p>').text(text),
						            $('<span class="time_date">').text(today.toLocaleTimeString())
						        )
						    )
						);
						
						
						
					} else {
						
						$(".msgDiv").append(
								    $('<div class="incoming_msg">').append(
								        $('<div class="incoming_msg_img">').append(
								            $('<img>').attr('src', 'https://ptetutorials.com/images/user-profile.png').attr('alt', 'sunil')
								        ),
								        $('<div class="received_msg">').append(
								            $('<div class="received_withd_msg">').append(
								                $('<p>').text(msg),
								                $('<span class="time_date">').text(today.toLocaleTimeString())
								            )
								        )
								    )
								);
						
									
					}
//						$(".incoming_msg").scrollTop($(".incoming_msg")[0].scrollHeight);
				}
						
						
					}
					
	});
		
		
		
}
	
	
	
	
	

$(document).ready(function(){
	
	var empId = $("#empId").val();
	var empName = $("#empName").text();
	
	//메시지 보내기 버튼 이벤트
	$(".msg_send_btn").bind("click",function(){
		
		
		if($("#chatInput").val() == ""){
			alert("내용을 입력해주세요.");
		} else{
			//handler에 보낼 내용  '닉네임: 내용' 의 형태 
			ws.send(empId + ":" + $("#chatInput").val());
			$("#chatInput").val("");
			$("#chatInput").focus();
		}
	});
		
	
});




