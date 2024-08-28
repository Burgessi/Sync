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
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="#" class="card-link">휴가신청서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
										
										
										<div class="card-body">
											<div style="text-align: center;">
												<img src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="#" class="card-link">품의서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
									
										<div class="card-body">
											<div style="text-align: center;">
												<img  src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="#" class="card-link">출장보고서</a></h6>
										</div>
										
									</div>
								</div>
								
								<div class="col-md-3">
									<div class="card mb-3">
									
										<div class="card-body">
											<div style="text-align: center;">
												<img alt="" src="${root}/resources/img/approval_img/htmlicon.png">
											</div>
											<h6 style="text-align: center; margin-top: 10px;" class="card-subtitle mb-2 text-muted"><a href="#" class="card-link">협조문</a></h6>
										</div>
									
									</div>
								</div>
								
							
							</div>
		
			        	
			        	
				        	
				        	<div class="row">
							
								<div class="col-md-6">
									<div class="card mb-6">
			        					<div class="card-header">
			        						<h4>결재 상신</h4>
			        						<img class="enter" alt="" src="${root}/resources/img/approval_img/enter.png">
			        					</div>
			        					
			        					<div class="card-body">
				        					<div style="width: 500px; margin: auto;">
					        					<table class="table table-hover table-font100">
						                    		<thead>
						                    			<tr>
						                    				<td>번호</td>
						                    				<td>제목</td>
						                    				<td>작성자</td>
						                    				<td>등록일</td>
						                    				<td>결재상태</td>
						                    			</tr>
						                    		</thead>
						                    		<tbody>	
						                    			<tr>
						                    				<td>7</td>
						                    				<td>공지사항333</td>
						                    				<td>인사팀장</td>
						                    				<td>2024-08-08</td>
						                    				<td><span class="badge bg-warning">결재진행</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>6</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-warning">결재진행</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>5</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-warning">결재진행</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>4</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-danger">결재반려</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>3</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-danger">결재반려</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>2</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-primary">결재완료</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>1</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-primary">결재완료</span><td>
						                    			</tr>
						                    		</tbody>
						                    	</table>
				        					</div>
			        					</div>
			        					
			        				</div>
			        			</div>
			        			
			        			<div class="col-md-6">
									<div class="card mb-6">
										
										<div class="card-header">
			        						<h4>결재 완료</h4>
			        						<img class="enter" alt="" src="${root}/resources/img/approval_img/enter.png">
			        					</div>
										
									
										<div class="card-body">
				        					<div style="width: 500px; margin: auto;">
						        					<table class="table table-hover table-font100">
							                    		<thead>
							                    			<tr>
							                    				<td>번호</td>
							                    				<td>제목</td>
							                    				<td>작성자</td>
							                    				<td>등록일</td>
							                    				<td>결재상태</td>
							                    			</tr>
							                    		</thead>
							                    		<tbody>
							                    			<tr>
							                    				<td>7</td>
							                    				<td>공지사항333</td>
							                    				<td>인사팀장</td>
							                    				<td>2024-08-08</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>6</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>5</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>4</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>3</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>2</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>1</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    		</tbody>
							                    	</table>
				        						
				        						
				        						</div>
			        					</div>
			        				</div>
			        			</div>
			        			
			        			
			        		</div>
			        		
			        		<div class="row">
							
								<div class="col-md-6">
									<div class="card mb-6">
			        					<div class="card-header">
			        						<h4>결재 상신</h4>
			        						<img class="enter" alt="" src="${root}/resources/img/approval_img/enter.png">
			        					</div>
			        					
			        					<div class="card-body">
				        					<div style="width: 500px; margin: auto;">
					        					<table class="table table-hover table-font100">
						                    		<thead>
						                    			<tr>
						                    				<td>번호</td>
						                    				<td>제목</td>
						                    				<td>작성자</td>
						                    				<td>등록일</td>
						                    				<td>결재상태</td>
						                    			</tr>
						                    		</thead>
						                    		<tbody>	
						                    			<tr>
						                    				<td>7</td>
						                    				<td>공지사항333</td>
						                    				<td>인사팀장</td>
						                    				<td>2024-08-08</td>
						                    				<td><span class="badge bg-secondary">임시저장</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>6</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-warning">결재진행</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>5</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-secondary">임시저장</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>4</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-danger">결재반려</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>3</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-primary">결재완료</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>2</td>
						                    				<td>보세요 제발</td>
						                    				<td>마케팅팀장</td>
						                    				<td>2024-08-02</td>
						                    				<td><span class="badge bg-danger">결재반려</span><td>
						                    			</tr>
						                    			<tr>
						                    				<td>1</td>
						                    				<td>주목하세요 주목</td>
						                    				<td>하건호</td>
						                    				<td>2024-08-01</td>
						                    				<td><span class="badge bg-warning">진행중</span><td>
						                    			</tr>
						                    		</tbody>
						                    	</table>
				        					</div>
			        					</div>
			        					
			        				</div>
			        			</div>
			        			
			        			<div class="col-md-6">
									<div class="card mb-6">
										
										<div class="card-header">
			        						<h4>결재 완료</h4>
			        						<img class="enter" alt="" src="${root}/resources/img/approval_img/enter.png">
			        					</div>
										
									
										<div class="card-body">
				        					<div style="width: 500px; margin: auto;">
						        					<table class="table table-hover table-font100">
							                    		<thead>
							                    			<tr>
							                    				<td>번호</td>
							                    				<td>제목</td>
							                    				<td>작성자</td>
							                    				<td>등록일</td>
							                    				<td>결재상태</td>
							                    			</tr>
							                    		</thead>
							                    		<tbody>
							                    			<tr>
							                    				<td>7</td>
							                    				<td>공지사항333</td>
							                    				<td>인사팀장</td>
							                    				<td>2024-08-08</td>
							                    				<td><span class="badge bg-warning">결재진행</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>6</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-danger">결재반려</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>5</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-secondary">임시저장</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>4</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>3</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>2</td>
							                    				<td>보세요 제발</td>
							                    				<td>마케팅팀장</td>
							                    				<td>2024-08-02</td>
							                    				<td><span class="badge bg-primary">결재완료</span><td>
							                    			</tr>
							                    			<tr>
							                    				<td>1</td>
							                    				<td>주목하세요 주목</td>
							                    				<td>하건호</td>
							                    				<td>2024-08-01</td>
							                    				<td><span class="badge bg-warning">결재진행</span><td>
							                    			</tr>
							                    		</tbody>
							                    	</table>
				        						
				        						
				        						</div>
			        					</div>
			        				</div>
			        			</div>
			        			
			        			
			        		</div>
			        		
			        	
			        	
			        
			        
			    </div>
			
			</main>
        
        
        
        
        
      </div>
    </div>   
        
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>   
</body>
</html>