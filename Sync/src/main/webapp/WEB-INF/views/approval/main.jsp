<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>전자결재 Home</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
		h4{
			display: inline;
		}
		.enter{
			float: right;
		}
		
		table{
			 text-align: center;
		}
        thead {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }
        .main-header{
        	margin: 15px;
        }
        
        .btngray{
        	background: #B0B7C0;
        	color: #fff;
		    border: none;
		    border-radius: 10px;
        }
        
</style>
</head>
<body>
	<div id="app">
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

      <div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
        
        	<main>
            
	            <div class="container">
			        
							
								<div class="main-header" style="margin: 20px;">
								
									<h4>자주 쓰는 양식</h4>
									<button onclick="javascript:location.href='${root}/approval/write.do'" class="btn btn-primary" style="float: right; margin: 0px;">기안서 작성</button>
								</div>
							
							
							
							
							
							<div class="row">
							
							
								<div class="col-md-3">
									<div class="card mb-3">
										
										<div class="card-body">
											<div style="text-align: center;">
												<img alt="" src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="${root}/approval/write.do?formNo=form001" class="card-link">휴가신청서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
										
										
										<div class="card-body">
											<div style="text-align: center;">
												<img src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="${root}/approval/write.do?formNo=form002" class="card-link">출장보고서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
									
										<div class="card-body">
											<div style="text-align: center;">
												<img  src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="${root}/approval/write.do?formNo=form003" class="card-link">지출결의서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
									
										<div class="card-body">
											<div style="text-align: center;">
												<img alt="" src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="${root}/approval/write.do?formNo=form004" class="card-link">협조문</a></h6>
										</div>
									
									</div>
								</div>
								
							
							</div>
		
		
		
		
							<!-- 결재 문서 내역 content -->
			        		<div>
								<jsp:include page="./main-content.jsp"></jsp:include>
							</div>
			        
			    </div>
			</main>
        
        
        
        
        
      </div>
    </div>   
        
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>   
</body>
</html>