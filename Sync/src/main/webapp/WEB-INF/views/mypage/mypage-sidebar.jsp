<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <div class="" style="width: 260px; margin-right: 30px">
       
       <div class="card mb-4">
         <div class="card-header mt-1 py-3">
           <h4 class="mb-0">내 정보 관리</h4>
         </div>
         <div class="card-content">
           <div class="recent-message d-flex px-4 py-2">
             <div class="name ms-2">
                <a href="${root}/mypage">
               		<h6 class="mb-1">내 정보 조회</h6>
                </a>
             </div>
           </div>
           <div class="recent-message d-flex px-4 py-2">
             <div class="name ms-2">
             	<a href="${root}/mypage/account">
               		<h6 class="mb-1">급여계좌 설정</h6>
             	</a>
             </div>
           </div>
           <div class="recent-message d-flex px-4 py-2">
             <div class="name ms-2">
             	<a data-bs-toggle="modal" data-bs-target="#modalPwdEdit">
               		<h6 class="mb-1">비밀번호 변경</h6>
               	</a>
             </div>
           </div>
           <div class="recent-message d-flex px-4 py-2">
             <div class="name ms-2">
             	<a data-bs-toggle="modal" data-bs-target="#modalPwdEdit">
               		<h6 class="mb-1">연차 조회</h6>
               	</a>
             </div>
           </div>
           <div class="recent-message d-flex px-4 py-2">
             <div class="name ms-2">
             	<a data-bs-toggle="modal" data-bs-target="#modalPwdEdit">
               		<h6 class="mb-3">재직증명서 출력</h6>
               	</a>
             </div>
           </div>
         </div>
       </div>
       </div>
       
      