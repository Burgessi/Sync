<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회의실 생성</title>
<style type="text/css">
.table {
	width: 100%;
	border-collapse: collapse;
}

.table th, .table td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: left;
}

.tb {
	width: 200px;
	text-align: center !important;
	background-color: #CCF6E4 !important;
}

.table th {
	color: #fff;
	font-weight: bold;
}

.table tr:hover {
	background-color: #eaeaea;
}

#bt {
	width: 100px;
	text-align: center;
}

.btn-container {
	text-align: center;
	margin-top: 20px;
}

.btn-container input {
	margin: 0 10px;
	width: 100px;
}

.card-header {
	text-align: right;
}

.ck-editor__editable {
	width: 100% !important;
	height: 500px !important;
}

/* 기본 입력 스타일 */
.input-hide {
	border-radius: 0px;
	border: none;
	width: 100%;
}

/* 클릭 후 숨기기 */
.input-hide:focus {
	border: 1px solid transparent;
	outline: none;
}
textarea {
	width: 100%; /* 테이블 셀 너비에 맞게 설정 */
	height: 150px; /* 높이 설정 필요에 따라 조절 */
	box-sizing: border-box; /* 패딩을 포함한 총 너비 설정 */
}
</style>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
        <h3>회의실 관리</h3>
				<div class="container">
					 <div class="card">
						<div class="card-header">			
						</div>
						<div class="card-body">
							<form action="${root}/fcl/insertFcl.do" method="post" enctype="multipart/form-data">
							    <table class="table">
							        <tr>
							            <td class="tb"><strong>회&nbsp;의&nbsp;실&nbsp;이&nbsp;름</strong></td>
							            <td>
							                <input type="text" class="input-hide" name="fcl_name">
							            </td>
							        </tr>
							        <tr>
							            <td class="tb"><strong>회&nbsp;의&nbsp;실&nbsp;이&nbsp;미&nbsp;지</strong></td>
							            <td>
							                <input type="file" class="input-hide" name="fcl_pic">
							            </td>
							        </tr>
							        <tr>
							            <td class="tb"><strong>설&nbsp;&nbsp;&nbsp;&nbsp;명</strong></td>
							            <td>
							                <textarea name="fcl_content"></textarea>
							            </td>
							        </tr>                
							    </table>
							    <div class="btn-container">
							        <input type="submit" class="btn btn-info" value="등록">
							        <input type="button" class="btn btn-secondary" value="뒤로가기" onclick="javascript:history.back(-1)">
							    </div>
							</form>
						</div>
					</div>
				</div>			
		</div>
	</div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>