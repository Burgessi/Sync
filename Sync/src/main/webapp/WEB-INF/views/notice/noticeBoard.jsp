<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
		<h3>공지사항</h3>
							
				<div class="container">
					 <div class="card">
						<div class="card-header">
							
						</div>
						<div class="card-body">
								
							${lists}
								
						</div>
					</div>		
				</div>					
			
		
		</div>
	 
	</div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>