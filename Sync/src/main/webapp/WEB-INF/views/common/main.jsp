
<%@page import="com.pro.sync.employee.vo.EmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<html>
  <head>
    <title>SYNC</title>
    <style>
      .input-size {
        max-width: 350px;
      }

      .img-edit-plus {
        top: -10px;
      }

      .info-flex {
        display: flex;
        flex-direction: column;
      }

      .info-span {
        padding-bottom: 25px;
      }

      .user-edit {
        margin-left: 20px;
      }

      #profile {
        position: absolute;
      }

      #profile-img {
        margin-left: 5px;
        bottom: 5px;
      }

      #profile-edit {
        position: relative;
        top: 22px;
        right: 25px;
        width: 30px;
        height: 30px;
        background-color: #ffffff;
        border: 1px solid #eeeeee;
        border-radius: 50%;
        padding-top: 5px;
        padding-left: 5px;
      }

      #profile-edit:hover {
        border: 1px solid #d3d3d3;
      }
    </style>
  </head>
  

  <body>
    <div id="app">
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

      <div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="page-heading">
          <div class="page-title">
            <div class="row">
              <div class="col-12 col-md-6 order-md-1 order-last mt-2 mb-4">
                <h3>메인</h3>
              </div>
            </div>
          </div>
          <div class="page-content">
            <section class="section d-flex">
              <div class="card" style="width: 30%; min-width: 260px; height:500px; padding: 5px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역1 - 출퇴근</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
              <div class="card" style="width: 90%; min-width: 500px; padding: 5px; margin-left:10px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역2 - 캘린더</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
            </section>
            <section class="section d-flex">
              <div class="card" style="width: 50%; min-width: 500px; height:500px; padding: 5px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역3 - 소속아티스트 음원 순위 현황(추이)</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
              <div class="card" style="width: 55%; min-width: 500px; padding: 5px; margin-left:10px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역4 - 실시간 음원차트</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
            </section>
            <section class="section d-flex">
              <div class="card" style="width: 50%; min-width: 500px; height:500px;padding: 5px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역5 - 공지사항</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
              <div class="card" style="width: 55%; min-width: 500px; padding: 5px; margin-left:10px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역6 - 연예뉴스</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>
            </section>
            <section class="section d-flex">
              <div class="card" style="width: 100%; min-width: 500px; padding: 5px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>메인 컨텐츠 영역7 - 주가</h4>
                </div>
                <div class="card-body">
<!--                   컨텐츠 내용 -->
                </div>
              </div>

            </section>
          </div>
        </div>
      </div>
    </div>
    

    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>


  
</html>
