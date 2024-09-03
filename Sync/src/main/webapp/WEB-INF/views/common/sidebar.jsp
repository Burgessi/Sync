<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="root" value="${pageContext.request.contextPath}" />


<!-- datepicker -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>

<!-- Sweet -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.min.css" rel="stylesheet">

<!-- commons -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css">

<link rel="stylesheet" href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${root}/resources/css/sidebar.css">

<!-- sign -->
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>

<!-- jstree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>


<style>
    @import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap");
</style>

<div id="sidebar" class="active">
    <div class="sidebar-wrapper active">
         <div class="sidebar-header">
            <div class="d-flex justify-content-between">
                <div class="logo">
                    <a href="common/main.jsp"><h3>SYNC</h3>
                </div>         
            </div>
            
	            <div class="profile d-flex p-1">
	                <div class="avatar avatar-xl" style="border-radius: 10%">
	               <c:choose>
	                <c:when test="${not empty infoDto.emp_profile_pic}">
	                    <img id="sidebarPreview" style="border-radius: 50%; width: 65px; height: 65px; object-fit: cover" src="${infoDto.emp_profile_pic}" alt="이미지" />
	                </c:when>
	                <c:otherwise>
	              		<img id="sidebarPreview" style="border-radius: 50%; width: 65px; height: 65px; object-fit: cover" src="${root}/resources/img/member-imgs/user.png" alt="profile" />
	                </c:otherwise>
	               </c:choose>
	             </div>
	             <div class="d-flex" style="flex-direction: column; padding-left: 10px; padding-top: 8px">
		            <a href="${root}/mypage">
		              <span class="user-name" style="color:#7D6CFF">${loginMember.empName}</span>
		            </a>
	              <p class="mb-0 text-sm text-gray-600" style="padding-left: 1px;">${loginMember.deptName} ${loginMember.posName}</p>
	             </div>          
	            </div>
        </div>
        <div class="sidebar-menu">
            <ul class="menu mt-1" style="padding-left: 25px">
            
            <!-- 인사 관리 -->
            	    <li class="sidebar-item has-sub">
                    <a href="#" class='sidebar-link'>
                        <i class="bi bi-card-checklist"></i>
                        <span>인사관리</span>
                    </a>
                    <ul class="submenu" id="calendar">
                        <li class="submenu-item" id="calendar">
                            <a href="${root}/employeeSelectAll.do">사원 관리</a>	
                            <a href="#">본부/팀 관리</a>						              
                      	</li>                   
                    </ul>
                </li>

                

                <li class="sidebar-item has-sub">
                    <a href="#" class='sidebar-link'>
                        <i class="bi bi-archive"></i>
                        <span>전자결재</span>
                    </a>
                    <ul class="submenu" id="approv-part">
                        <li class="submenu-item" id="approv-main">
                            <a href="${root}/approval/main.do">결재메인</a>
                        </li>
                        <li class="submenu-item" id="approv-main">
                            <a href="${root}/approval/progress.do">기안문서함</a>
                        </li>
                        <li class="submenu-item" id="approv-main">
                            <a href="${root}/approval/tempsave.do">임시저장함</a>
                        </li>
                        <li class="submenu-item" id="approv-main">
                            <a href="${root}/approval/receive.do">수신문서함</a>
                        </li>
                    </ul>
                </li>
                
                <!-- 일정관리 -->
                <li class="sidebar-item has-sub">
                    <a href="#" class='sidebar-link'>
                        <i class="bi bi-card-checklist"></i>
                        <span>일정관리</span>
                    </a>
                    <ul class="submenu" id="calendar">
                        <li class="submenu-item" id="calendar">
                            <a href="${root}/plan/calendar.do">사내 일정</a>
							              <a href="${root}/plan/calendar">일정</a>
                      </li>                   
                    </ul>
                </li>                   
                <!-- 게시판 -->
               <li class="sidebar-item has-sub">
                    <a href="#" class='sidebar-link'>
                        <i class="bi bi-pencil-square"></i>
                        <span>게시판</span>
                    </a>
                    <ul class="submenu" id="doc-part">
                        <li class="submenu-item" id="doc-list">
                            <a href="${root}/notice/noticeBoard.do">공지게시판</a>
                        </li>
                        <li class="submenu-item" id="doc-list">
                            <a href="${root}/board/userBoard.do">자유게시판</a>
                        </li>
                    </ul>
                </li>               
                <!-- 시설예약  -->
                <li class="sidebar-item">
                    <a href="${root}/noBoard/noticeBoard.do" class='sidebar-link'>
                        <i class="bi bi-card-checklist"></i>
                        <span>시설예약</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>