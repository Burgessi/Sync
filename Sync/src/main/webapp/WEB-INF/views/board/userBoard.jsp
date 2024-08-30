<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="${root}/resources/js/common/checkbox.js"></script>
<style type="text/css">
.table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed; /* Add this */
}

.table th, .table td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

.table tbody tr {
	border-bottom: 1px solid #e0e0e0;
}

.table thead {
	background-color: #f8f9fa;
}

.table thead th {
	background-color: #dee2fb;
	color: black;
	font-size: 14px;
}

.table tbody tr:hover {
	background-color: #f1f1f1;
}

.table input[type="checkbox"] {
	cursor: pointer;
}

.table .author, .table .title {
	text-align: left;
}

.table .post-id {
	width: 8%;
	max-width: 80px;
}

.table th, .table td {
	text-align: center;
}

.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination a {
	text-decoration: none;
	color: #007bff;
	padding: 8px 16px;
	margin: 0 4px;
	border: 1px solid #ddd;
	border-radius: 4px;
	display: inline-block; /* 링크들을 가로로 나열 */
}

.pagination a.active {
	background-color: #007bff;
	color: white;
}

.pagination a:hover {
	background-color: #e9ecef;
}

.btn-container {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.search-container {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.search-container select, .search-container input[type="text"],
	.search-container button {
	margin-left: 10px;
}

.search-container select {
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.search-container input[type="text"] {
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 200px;
}

.search-container button {
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-bottom: 12px;
}

.search-container button:hover {
	background-color: #0056b3;
}
</style>
<title>자유게시판</title>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>
			<h3>자유게시판</h3>


			<div class="container">
				<div class="card">


					<div class="card-body">
						<div id="list" style="overflow: auto;" class="container mt-3">
							<form action="./deleteBoard.do" method="post" onsubmit="return checkSub(event)">
									<div class="btn-container">
										<input type="button" class="btn btn-primary" value="글작성" onclick="location.href='./insertBoard.do'">
										<c:if test="${infoDto.authority == 'A'}">
										<input type="submit" class="btn btn-danger" value="삭제">
										</c:if>
									</div>
								<div id="boardSearch">
									<table class="table table-hover">
										<thead>
											<tr>
												<c:if test="${infoDto.authority == 'A'}">
													<th style="width: 1%">
														<input type="checkbox"id="chkAll" onclick="allCheck(this.checked)">
													</th>
												</c:if>
												<th style="width: 10%">게시물번호</th>
												<th style="width: 15%">작성자</th>
												<th style="width: 60%">제목</th>
												<th>작성일자</th>
											</tr>
										</thead>
										<c:forEach items="${blist}" var="bo" varStatus="vs">
											<tbody>
												<tr>
													<c:if test="${infoDto.authority == 'A'}">
														<td>
															<input type="checkbox" name="chk" value="${bo.bd_seq}">
														</td>
													</c:if>
													<td>${bo.bd_seq}</td>
													<td>${bo.employee_name}</td>
													<td>
														<a href="${root}/board/detailBoard.do?bd_seq=${bo.bd_seq}">${bo.bd_title}</a></td>
													<td>
														<fmt:parseDate var="cDate" value="${bo.bd_date}" pattern="yyyy-MM-dd"></fmt:parseDate>
														<fmt:formatDate value="${cDate}" />
													</td>
												</tr>
											</tbody>
										</c:forEach>
									</table>
								</div>
							</form>
						</div>
						<!-- 검색 -->
						<div class="search-container">
							<form name="search-form">
								<select name="type" id="type">
									<option value="title" selected>제목</option>
									<option value="author">작성자</option>
								</select> <input type="text" name="keyword" placeholder="검색어를 입력해주세요"
									value="${keyword}">
								<button type="button" class="btn btn-info" onclick="searchBoard(event)">
									<img alt="" src="${root}/resources/img/search.png">
								</button>
							</form>
						</div>
						<!-- 페이지 -->
						<div id="boardPage">
							<ul class="pagination justify-content-center">
								<c:if test="${paging.startPage > 1}">
									<a
										href="${root}/board/userBoard.do?page=${paging.startPage - 1}&countRow=${paging.countRow}&countPage=${paging.countPage}">&lt;&lt;</a>
								</c:if>

								<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
									var="i">
									<c:choose>
										<c:when test="${i == paging.page}">
											<a href="#" class="active">${i}</a>
										</c:when>
										<c:otherwise>
											<a
												href="${root}/board/userBoard.do?page=${i}&countRow=${paging.countRow}&countPage=${paging.countPage}">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<c:if test="${paging.endPage < paging.totalPage}">
									<a
										href="${root}/board/userBoard.do?page=${paging.endPage + 1}&countRow=${paging.countRow}&countPage=${paging.countPage}">&gt;&gt;</a>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
<script type="text/javascript">
//글삭제
function checkSub(event){
	event.preventDefault();
	
	var cnt = checkCount();
	 if(cnt > 0){
	        Swal.fire({
	            title: "선택한 공지를 삭제하겠습니까?",
	            icon: "warning",
	            showDenyButton: true,
	            confirmButtonText: "삭제",
	            denyButtonText: "취소"
	        }).then((result) => {
	            if(result.isConfirmed){
	                Swal.fire("삭제되었습니다!", "", "success").then(() => {
	                    document.querySelector('form').submit();
	                });
	            } else if(result.isDenied){
	                Swal.fire("취소되었습니다", "", "info");
	            }
	        });
	    } else {
	        Swal.fire("선택된 공지글이 없습니다");
	    }
	}
	
//검색
function searchBoard(event){
	event.preventDefault();
	
	var opt = document.getElementById("type").value;
	var keyword = document.getElementsByName("keyword")[0].value;
	
	$.ajax({
		url: "${root}/board/searchBoard.do",
		type: "POST",
		data: {"opt" : opt, "keyword" : keyword},
		dataType: "json",
		success:function(data){
			if(data && data.length > 0){
				var boardView = "<table class='table table-hover'><thead><tr><th>게시물번호</th><th>제목</th><th>작성자</th></tr></thead><tbody>";
				
				$.each(data, function (index, value){
					
					boardView += "<tr>";
					boardView += "<td>" + value.bd_seq + "</td>";
					boardView += "<td><a href='${root}/board/detailBoard.do?bd_seq=" + value.bd_seq + "'>" + value.bd_title + "</a></td>";
					boardView += "<td>" + escapeHtml(value.employee_name) + "</td>";
					boardView += "</tr>";
				});
				
				boardView += "</tbody></table>";
				$('#boardSearch').html(boardView);
				$('#boardPage').html("");
			}else{
				$('#boardSearch').html('<p>검색 결과가 없습니다. <p>');
			}
		},
		error:function(e){
			toastr.error('잘못된 요청입니다.');
		}
	});
	
}
function escapeHtml(text) {
    return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}
	
</script>
</html>