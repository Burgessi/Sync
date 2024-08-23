<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css">

<link rel="stylesheet" href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${root}/resources/css/sidebar.css">

<style>
    @import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap");

</style>

<div id="sidebar" class="active">
    <div class="sidebar-wrapper active">
         <div class="sidebar-header">
            <div class="d-flex justify-content-between">
                <div class="logo">
                    <h3>SYNC</h3>
                </div>         
            </div>
            
	            <div class="profile d-flex p-1">
	                <div class="avatar avatar-xl" style="border-radius: 10%">
	               <c:choose>
	                <c:when test="${not empty loginMember.empProfile}">
	                    <img style="border-radius: 30%; width: 65px; height: 65px; object-fit: cover" src="${root}/resources/upload/profile/${loginMember.empProfile}" alt="이미지" />
	                </c:when>
	                <c:otherwise>
	              		<img style="width: 60px; height: 60px;" src="${root}/resources/img/member-imgs/user.png" alt="profile" />
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

                
                
<!--                 <li class="sidebar-item" id="address"> -->
<%--                     <a href="${root}/address/1" class='sidebar-link'> --%>
<!--                         <i class="bi bi-person-square"></i> -->
<!--                         <span>주소록</span> -->
<!--                     </a> -->
<!--                 </li> -->

<!--                 <li class="sidebar-item has-sub"> -->
<!--                     <a href="#" class='sidebar-link'> -->
<!--                         <i class="bi bi-calendar-check"></i> -->
<!--                         <span>근태관리</span> -->
<!--                     </a> -->
<!--                     <ul class="submenu" id="att-part"> -->
<!--                         <li class="submenu-item " id="att-day"> -->
<%--                             <a href="${root}/att/day">일일근태 등록</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item " id="att-month"> -->
<%--                             <a href="${root}/att/month">월 근태 현황</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item " id="att-off"> -->
<%--                             <a href="${root}/off/manage">휴가관리</a> --%>
<!--                         </li> -->
<%--                         <c:if test="${loginMember.posNo lt 3}"> --%>
<!--                         	<li class="submenu-item " id="att-offCon"> -->
<%-- 	                            <a href="${root}/off/confirm">휴가 신청 확인</a> --%>
<!-- 	                        </li> -->
<%--                         </c:if> --%>
<!--                     </ul> -->
<!--                 </li> -->
                
<!--                 <li class="sidebar-item has-sub"> -->
<!--                     <a href="#" class='sidebar-link'> -->
<!--                         <i class="bi bi-wallet"></i> -->
<!--                         <span>급여관리</span> -->
<!--                     </a> -->
<!--                     <ul class="submenu" id="salary-part"> -->
<!--                         <li class="submenu-item" id="salary-pay"> -->
<%--                             <a href="${root}/salary/payslip">급여명세서</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item " id="salary-main"> -->
<%--                             <a href="${root}/salary/main">급여관리자</a> --%>
<!--                         </li> -->
                      
<!--                     </ul> -->
<!--                 </li> -->

<!-- 				<li class="sidebar-item has-sub"> -->
<!--                     <a href="#" class='sidebar-link'> -->
<!--                         <i class="bi bi-folder"></i> -->
<!--                         <span>문서관리</span> -->
<!--                     </a> -->
<!--                     <ul class="submenu" id="doc-part"> -->
<!--                         <li class="submenu-item" id="doc-list"> -->
<%--                             <a href="${root}/docmanage/list/1">일반문서</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item "id="doc-write"> -->
<%--                             <a href="${root}/appmanage/list/1">결재문서</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item"  id="doc-manage"> -->
<%--                             <a href="${root}/docmanage/manage/1">문서관리</a> --%>
<!--                         </li> -->
<!--                     </ul> -->
<!--                 </li> -->
                
<!--                 <li class="sidebar-item has-sub"> -->
<!--                     <a href="#" class='sidebar-link'> -->
<!--                         <i class="bi bi-archive"></i> -->
<!--                         <span>결재관리</span> -->
<!--                     </a> -->
<!--                     <ul class="submenu" id="approv-part"> -->
<!--                         <li class="submenu-item" id="approv-main"> -->
<%--                             <a href="${root}/approv/main">결재메인</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item" id="approv-write"> -->
<%--                             <a href="${root}/approv/create">문서작성</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item" id="approv-noelecwrte"> -->
<%--                             <a href="${root}/approv/create/noelec">비전자문서작성</a> --%>
<!--                         </li> -->
<!--                     </ul> -->
<!--                 </li> -->
                
<!--                 <li class="sidebar-item has-sub"> -->
<!--                     <a href="#" class='sidebar-link'> -->
<!--                         <i class="bi bi-card-text"></i> -->
<!--                         <span>문서양식</span> -->
<!--                     </a> -->
<!--                     <ul class="submenu" id="form-part"> -->
<!--                         <li class="submenu-item" id="form-main"> -->
<%--                             <a href="${root}/approv/form/main/1">양식메인</a> --%>
<!--                         </li> -->
<!--                         <li class="submenu-item" id="form-create"> -->
<%--                             <a href="${root}/approv/form/create">양식생성</a> --%>
<!--                         </li> -->
<!--                     </ul> -->
<!--                 </li> -->

                <!-- 일정관리 -->
                 <li class="sidebar-item has-sub">
                    <a href="#" class='sidebar-link'>
                        <i class="bi bi-card-checklist"></i>
                        <span>일정관리</span>
                    </a>
                    <ul class="submenu" id="calendar">
                        <li class="submenu-item" id="calendar">
                            <a href="${root}/plan/calendar.do">사내 일정</a>
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
                            <a href="${root}/board/userBoard.do">자유게시판</a>
                        </li>
                        <li class="submenu-item" id="doc-list">
                            <a href="${root}/notice/noticeBoard.do">공지게시판</a>
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