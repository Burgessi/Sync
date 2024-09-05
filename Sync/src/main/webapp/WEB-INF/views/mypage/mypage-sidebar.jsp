<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.name{
	width: 100%;
	
}
.p-1{
	display: flex;
	align-items: center;
}

.name.ms-2 a {
    display: flex; /* Flexbox를 사용하여 자식 요소를 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    padding: 15px 20px; /* 상하좌우 패딩 조정 */
    text-decoration: none; /* 링크의 밑줄 제거 */
    color: inherit; /* 링크의 텍스트 색상 상속 */
    border-radius: 5px; /* 링크의 모서리 둥글게 설정 */
    position: relative; /* 요소의 상대적 위치 설정 */
}

.name.ms-2 a:hover {
    background-color: #f0f0f0; /* 호버 시 배경색 */
    color: #000; /* 호버 시 텍스트 색상 */
    cursor: pointer; /* 클릭 커서로 변경 */
    transition: background-color 0.3s ease; /* 부드러운 배경색 전환 */
}

.recent-message h6 {
    margin: 0; /* 필요에 따라 margin 조정 */
    position: relative; /* 상대적 위치 설정 */
    z-index: 0; /* 링크보다 낮은 z-index 설정 */
}
.recent-message {
    overflow: hidden;
}

.recent-message{
	margin: 15px 0px 30px;
	width: 100%;
	
}
</style>
    <div style="width: 260px; margin-right: 30px">
       
       <div id="simple-list-example" class="mypage-sidebar d-flex flex-column gap-2 simple-list-example-scrollspy card mb-4 list-group" style="position: fixed; height: 70%; border-radius: 10px;">
         <div class="card-header mt-1 py-3">
           <h4 class="mb-0" >내 정보 관리</h4>
         </div>
         <div class="card-content">
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
                <a class="p-1 rounded active" href="#simple-list-item-1">
               		<h6>내 정보 조회</h6>
                </a>
             </div>
           </div>
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
                <a class="p-1 rounded" href="#simple-list-item-2">
               		<h6>개인정보 수정</h6>
                </a>
             </div>
           </div>
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
             	<a class="p-1 rounded" href="#simple-list-item-3">
               		<h6>급여계좌 설정</h6>
             	</a>
             </div>
           </div>
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
             	<a class="p-1 rounded" href="#simple-list-item-4">
               		<h6>비밀번호 변경</h6>
               	</a>
             </div>
           </div>
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
             	<a class="p-1 rounded" href="#simple-list-item-5">
               		<h6>연차 조회</h6>
               	</a>
             </div>
           </div>
           <c:if test="${infoDto.emp_status != 'A'}">
           <div class="recent-message d-flex px-4">
             <div class="name ms-2">
             	<a  class="p-1 rounded" href="#simple-list-item-6">
               		<h6>재직증명서 출력</h6>
               	</a>
             </div>
           </div>
           </c:if>
         </div>
       </div>
       </div>
  