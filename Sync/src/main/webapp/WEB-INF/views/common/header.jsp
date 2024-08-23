<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css" />

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
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-lg-0">
          <li class="nav-item dropdown me-3">
          	<a class="nav-link" style="margin-right: -12px;" href="">
	          	<i>
	          		<img alt="채팅" src="${root}/resources/img/chat.png" class="ch">
	          	</i>
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
              <li class="dropdown-item notification-item">
                <a class="d-flex align-items-center" href="#">
                  <div class="notification-icon bg-primary">
                    <i class="bi bi-cart-check"></i>
                  </div>
                  <div class="notification-text ms-4">
                    <p class="notification-title font-bold">Successfully check out</p>
                    <p class="notification-subtitle font-thin text-sm">Order ID #256</p>
                  </div>
                </a>
              </li>
              <li class="dropdown-item notification-item">
                <a class="d-flex align-items-center" href="#">
                  <div class="notification-icon bg-success">
                    <i class="bi bi-file-earmark-check"></i>
                  </div>
                  <div class="notification-text ms-4">
                    <p class="notification-title font-bold">Work submitted</p>
                    <p class="notification-subtitle font-thin text-sm">Algebra work</p>
                  </div>
                </a>
              </li>
              <li>
                <p class="text-center py-2 mb-0">
                  <a href="#">See all notification</a>
                </p>
              </li>
            </ul>
          </li>
        </ul>
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
                   <c:when test="${not empty loginMember.empProfile}">
                       <img style="border-radius: 30%; width: 45px; height: 45px; object-fit: cover" src="${root}/resources/upload/profile/${loginMember.empProfile}" alt="이미지" />
                   </c:when>
                   <c:otherwise>
		               <img src="${root}/resources/img/member-imgs/user.png" alt="profile" />
                   </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </a>
          <ul class="dropdown-menu dropdown-menu-lg-end" aria-labelledby="dropdownMenuButton" style="min-width: 10.5rem;" data-ps-popper="static" >
            <li>
              <h6 class="dropdown-header" style="margin-left: -15px">홍길동님 환영합니다!</h6> <!-- 여기에 홍길동 지우고 사원이름 넣으세요 -->
            </li>
            <li>
              <a class="dropdown-item" href="${root}/mypage" ><img src="${root}/resources/img/mypage.png" style="margin-bottom: 5px;"><i class="icon-mid bi bi-person me-2"></i>마이페이지</a>
            </li>
            <li>
              <a class="dropdown-item" href="#"><img src="${root}/resources/img/document.png" style="margin-bottom: 5px;"><i class="icon-mid bi bi-gear me-2"></i>내 결재문서</a>
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
              <a class="dropdown-item" href="${root}/logout"><img src="${root}/resources/img/logout.png" style="margin-bottom: 5px;"><i class="icon-mid bi bi-box-arrow-left me-2"></i> 로그아웃</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
</header>

