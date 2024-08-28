<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.pro.sync.employee.vo.EmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>SYNC_login</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
      crossorigin="anonymous"
    ></script>

    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css" />

    <link rel="stylesheet" href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="resources/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="${root}/resources/css/common/app.css" />

	
    <link rel="stylesheet" href="${root}/resources/css/member/login-style.css" />
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
      body {
        background-color: #fff;
      }
    </style>
    
    <script src="${root}/resources/js/login/login.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
  </head>
  
<!-- 로그인 실패 시, 경고창 -->
<!-- 로그인은 성공인데 재직상태가 A라면 비밀번호 변경 모달-->
<% 
	Boolean loginFailed = (Boolean) request.getAttribute("loginFailed");

	// 로그인 실패 시
	if (loginFailed != null && loginFailed) { 
%>
    <script type="text/javascript">
        alert("아이디와 비밀번호를 확인해주세요.");
    </script>

<% 
	}


%>

  <body>
    <%@ include file="/WEB-INF/views/common/toastify.jsp" %>

    <div class="container">
      <div class="form-container">
        <div class="signin">
          <form action="./login.do" class="signin-form" autocomplete=off method="post">
            <h1 class="title">SYNC</h1>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input name="emp_id" type="text" autocomplete="on" placeholder="아이디" required />
            </div>
            <div class="input-field">
              <i class="fa-solid fa-shield-halved"></i>
              <input name="emp_password" type="password" placeholder="비밀번호"  autocomplete="on" required />
            </div>
            <div class="login-info">
              <div class="save-id form-check form-switch">
<!--               	아이디 저장 여부 체크-구현 예정 -->
                <input name="saveId" id="saveCheck" class="form-check-input" type="checkbox" role="switch" />
                <label for="saveCheck" class="form-check-label">아이디 저장</label>
              </div>
              <div class="find-idpwd">
<!--               	비밀번호 재설정 페이지로 이동-연결 예정 -->
                <button type="button" class="btn btn-sm">비밀번호 재설정</button>
              </div>
            </div>
            <input type="submit" value="로그인" class="login-btn solid" style="width: 320px;"/>
          </form>
          
        </div>
      </div>
      <div class="panel-container">
        <div class="panel">
          <img src="${root}/resources/img/구름이.png" class="image" alt="" />
        </div>
      </div>
    </div>
    
    
  </body>
   
  </body>
</html>
