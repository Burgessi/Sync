<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${root}/resources/css/chat/main.css">
<script type="text/javascript" src="${root}/resources/js/chat.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${root}/resources/js/common/main.js"></script>
<style>
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
              <h4 id="empName">${infoDto.emp_name}</h4>
              <input type="hidden" id="empId" value="${infoDto.emp_id}">
            </div>
            <div class="srch_bar">
              <div class="stylish-input-group" style="right: 0;">
                <button data-bs-toggle="modal" data-bs-target="#chatEmployeeModal"> <img alt="" src="${root}/resources/img/newChat.png"> </button>
         	</div>
            </div>
          </div>
          <div class="inbox_chat">
            <div class="chat_list active_chat">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
            <div class="chat_list">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                  <p>Test, which is a new approach to have all solutions 
                    astrology under one roof.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        
        <!-- 채팅 출력 부분 -->
        <div class="mesgs">
          <div class="msg_history">
          
          	<!-- 채팅내용 -->
          		<div class="msgDiv">
          			
          		</div>
          		
          		
<!--           채팅 입력 -->
          <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" id="chatInput" class="write_msg" placeholder="Type a message" />
              <button class="msg_send_btn" type="button">
<!--               <i class="fa fa-paper-plane-o" aria-hidden="false"></i> -->
              </button>
            </div>
          </div>
          
        </div>
      </div>
      
      
    </div>
    
   </div>
</div>



<!-- 채팅방 생성시 사원목록 -->
<div class="modal fade" tabindex="-1" role="dialog" id="chatEmployeeModal">
			 <div class="modal-dialog modal-dialog-centered" role="document">
				 <div class="modal-content rounded-4 shadow">
						<div class="modal-header p-5 pb-4 border-bottom-0">
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body p-5 pt-0">
							
							<div class="row">
								<div class="col-md-6" style="text-align: center; font-weight: bold; font: 0.7em sans-serif; height: 500px; overflow:auto;">
									<h4 class="fw-bold mb-0 fs-4">사원목록</h4>
									<!-- 목록출력 부분 -->
									<div id="employeeList">
									
									</div>
								</div>
								<div class="col-md-6" style="text-align: center; font-weight: bold;">
								<h4 class="fw-bold mb-0 fs-4">받는사람 목록</h4>
									</div>
							</div>
							
													
						</div>
						
				</div>
			</div>
		</div>




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
			        CreateJSTrees();
		    }
		});
		
		// 서버에서 가져온 데이터로 JSTree 만듦
		function CreateJSTrees(){
//				console.log('22');
//				console.log(menu_json);
			
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
		        $('#approvalLine').jstree(true).search(v);
		    }, 250);
		});
		
		
		
		// 서버에 값 보낼때 필요하기 때문에 전역변수로
		var selectedNodes = "";
		
		
		// 체크박스 선택 값 담기 -> 체크 변할때마다
		// 결재선이 선택될때마다 변경 이벤트
		 $('#approvalLine').on("changed.jstree", function (e, data) {
//	 		 console.log($('#tree').jstree("get_selected", true));
//	 		 console.log($('#tree').jstree("get_checked", true));
			 
			 //현재 선택된 모든 노드
	         selectedNodes = $('#approvalLine').jstree("get_selected", true);
			 console.log(selectedNodes);
			 
			 let rowCount = $("#approvalTable>tbody>tr").length;
			 let addCount = 3-rowCount; //추가가능한 행의 수
			 
			 
			 //선택된 노드 개수 제한하기 최대 3개만 가능
			 if(selectedNodes.length > 3){
				 $('#approvalLine').jstree(true).deselect_node(data.node);
				 toastr.info("3명만 선택 가능합니다.");
				 //error , success 
			 }
			 
		 });
		
	})
</script>
</html>