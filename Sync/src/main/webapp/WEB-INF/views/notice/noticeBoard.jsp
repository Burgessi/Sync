<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
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
	background-color: #FDE6D8;
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
.search-container select,
.search-container input[type="text"],
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
    border-radius: 5px;
    width: 200px;
}
.search-container button {
    padding: 8px 16px;
   	border:1.5px solid #17a2b8; /* 기본 버튼 색상 */
    border-radius: 10px;
    cursor: pointer;
    margin-bottom: 12px;
    background-color: white;
    
}
.search-container button:hover {
    background-color: #0056b3;
}

.notice-tag {
	position: absolute; /* 절대 위치를 설정 */
	 left: 42%; /* 좌측 고정 */
    display: inline-block;
    padding: 4px 8px;
    background-color: #ff6d72; /* 중요 공지 배경색 */
    color: #fff; /* 중요 공지 텍스트 색 */
    border-radius: 3px;
    font-size: 12px;
    font-weight: bold;
    margin-left: 8px;
    vertical-align: middle; /* 텍스트와 함께 정렬되도록 */
    text-align: center;
}
/* 버튼 커스텀 */
	.btn-container {
        display: flex;
        gap: 10px; /* 버튼 사이의 간격 조정 */
        margin-top: 10px; /* 버튼 상단과의 간격 조정 */
    }
    .Bsuccess {
   		background-color: white;
   		border: 2px solid #28a745;
        color: #28a745; /* 현재 btn-success 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
    .Bwarning {
    	background-color: white;
    	border: 2px solid #ffc107;
        color: #ffc107; /* 현재 btn-warning 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
    .Bprimary {
    	background-color: white;
    	border: 2px solid #007bff;
        color: #007bff; /* 현재 btn-primary 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
    .Bdanger {
   		background-color: white;
   		border: 2px solid #dc3545;
        color: #dc3545; /* 현재 btn-danger 색상 */
        font-weight: bold; /* 폰트 두껍게 */
        border-radius: 12px; /* 버튼 테두리 둥글기 조정 */
    }
</style>
<title>공지게시판</title>
</head>
<body>
	<div id="app">
		<!-- 사이드바 include -> 메뉴 이동 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
		<!--헤더 include -> 상단 로그인정보 등 -->
		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>
			<h3>공지사항</h3>

			<div class="container">
				<div class="card">
				                        

					<div class="card-body">
						<div id="list" style="overflow: auto;" class="container mt-3">
							<form action="./deleteNotice.do"  method="post" onsubmit="return checkSubmit(event)">
								<c:if test="${infoDto.authority == 'A'}">
									<div class="btn-container">		
										<input type="button" class="Bprimary" value="상단등록" onclick="pin(event)">
										<input type="button" class="Bprimary" value="상단해제" onclick="cancel(event)">
										<input type="button" class="Bprimary" value="글작성" onclick="location.href='./insertNotice.do'">
										<input type="submit" class="Bdanger" value="삭제">
	                        		</div>
                        		</c:if>
                        		<div id="searchView">
									<table class="table table-hover">
										<thead>
											<tr>
												<c:if test="${infoDto.authority == 'A'}">
												<th style="width: 1%"><input type="checkbox" id="chkAll" onclick="allCheck(this.checked)"></th>
												</c:if>
												<th style="width: 10%">게시물번호</th>
												<th style="width: 15%">작성자</th>
												<th style="width: 60%">제목</th>
												<th>작성일자</th>
											</tr>
										</thead>
										<c:forEach items="${lists}" var="no" varStatus="vs">
										<tbody>
										<c:set var="bgColor" value="${no.notice_pinbtn eq 'Y' ? '#F2F2F2': '#FFFFFF'}" />
												<tr style="background-color: ${bgColor}">
													<c:if test="${infoDto.authority == 'A'}">
													<td><input type="checkbox" name="chk" value="${no.notice_seq}"></td>
													</c:if>
													<td>${no.notice_seq}</td>
													<td>${no.employee_name}</td>
													<td>
													  <c:if test="${no.notice_pinbtn eq 'Y'}">
														<span class="notice-tag">공지</span>
													  </c:if>
													  <a href="${root}/notice/detailNotice.do?notice_seq=${no.notice_seq}">${no.notice_title}</a>
													</td>
													<td>
														<fmt:parseDate var="cDate" value="${no.notice_regdate}" pattern="yyyy-MM-dd"></fmt:parseDate>
														<fmt:formatDate value="${cDate}"/>
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
                            <form name="search-form" >
                                <select name="type" id="type">
                                    <option value="title" selected>제목</option>
                                    <option value="author">작성자</option>
                                </select>
                                <input type="text" name="keyword" placeholder="검색어를 입력해주세요" value="${keyword}">
                                <button type="button" class="Binfo" onclick="searchNotice(event)">
                                    <img alt="" src="${root}/resources/img/search.png">
                                </button>
                            </form>
                        </div>
						<!-- 페이지 -->
						<div id="cat">
							<ul class="pagination justify-content-center">
							    <c:if test="${paging.startPage > 1}">
							        <a href="${root}/notice/noticeBoard.do?page=${paging.startPage - 1}&countRow=${paging.countRow}&countPage=${paging.countPage}">&lt;&lt;</a>
							    </c:if>
							    
							    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i">
							        <c:choose>
							            <c:when test="${i == paging.page}">
							                <a href="#" class="active">${i}</a>
							            </c:when>
							            <c:otherwise>
							                <a href="${root}/notice/noticeBoard.do?page=${i}&countRow=${paging.countRow}&countPage=${paging.countPage}">${i}</a>
							            </c:otherwise>
							        </c:choose>
							    </c:forEach>
							
							    <c:if test="${paging.endPage < paging.totalPage}">
							        <a href="${root}/notice/noticeBoard.do?page=${paging.endPage + 1}&countRow=${paging.countRow}&countPage=${paging.countPage}">&gt;&gt;</a>
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
//삭제
function checkSubmit(event){
    event.preventDefault();

    var cnt = checkCount(); // 이 함수가 정의되어 있는지 확인
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

// 검색
function searchNotice(event) {
    event.preventDefault(); // 폼 제출 방지

    var opt = document.getElementById("type").value; // 검색 유형
    var keyword = document.getElementsByName("keyword")[0].value; // 검색어
    var authority = "${infoDto.authority}";
    
    $.ajax({
        url: "${root}/notice/searchNotice.do",
        type: "POST",
        data: { "opt": opt, "keyword": keyword },
        dataType: "json",
        success: function (data) {
            if (data && data.length > 0) {
				var view = null;		
				if(authority == 'A'){
					view = "<table class='table table-hover'><thead><tr><th style='width: 1%'><input type='checkbox' id='chkAll' onclick='allCheck(this.checked)'></th><th>게시물번호</th><th>제목</th><th>작성자</th></tr></thead><tbody>";
				} else{
					view = "<table class='table table-hover'><thead><tr><th>게시물번호</th><th>제목</th><th>작성자</th></tr></thead><tbody>";
				}
                $.each(data, function (index, value) {
	                    view += "<tr>";
                	if(authority == 'A'){
	                    view += "<td><input type='checkbox' name='chk' value='" + value.notice_seq + "'></td>";
                	}
                    view += "<td>" + value.notice_seq + "</td>";
                    view += "<td><a href='${root}/notice/detailNotice.do?notice_seq=" + value.notice_seq + "'>" + value.notice_title + "</a></td>";
                    view += "<td>" + escapeHtml(value.employee_name) + "</td>";
                    view += "</tr>";
                    console.log("notice_seq:", value.notice_seq); // 확인용 로그
                    console.log("notice_title:", value.notice_title); // 확인용 로그
                	
                });
                view += "</tbody></table>";
                $('#searchView').html(view);
                $('#cat').html("");
            } else {
                $('#searchView').html('<p>검색 결과가 없습니다.</p>');
            }
        },
        error: function (e) {
            console.error('Error:', e);
            toastr.error('잘못된 요청입니다.');
        }
    });
}

// HTML 특수문자 이스케이프
function escapeHtml(text) {
    return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// 상단등록
function pin(event) {
    event.preventDefault();
    
    var checkedValues = [];
    document.querySelectorAll("input[name=chk]:checked").forEach(function(checkbox) {
        checkedValues.push(checkbox.value);
    });

    if (checkedValues.length === 0) {
        toastr.error('선택된 공지가 없습니다.');
        return;
    }
    if (checkedValues.length > 5) {
        toastr.error('최대 5개의 공지만 선택할 수 있습니다.');
        return;
    }
    
    $.ajax({
        url: "${root}/notice/noticePin.do",
        type: "POST",
        traditional: true,
        data: $.param({ chk: checkedValues }, true),
        success: function(pin) {
            if (pin === 'success') {
                toastr.success('공지사항을 고정하였습니다.');
                setTimeout(function() {
                    location.href = "${root}/notice/noticeBoard.do";
                }, 500); 
            } else if(pin === 'fail') {
                toastr.error("최대 5개 고정 가능합니다.");
                setTimeout(function() {
                    location.href = "${root}/notice/noticeBoard.do";
                }, 500); 
            }
        },
        error: function(e) {
            toastr.error('문제가 있습니다.');
        }
    });
}

// 상단해제
function cancel(event) {
    event.preventDefault();
    
    var checkedValues = [];
    document.querySelectorAll("input[name=chk]:checked").forEach(function(checkbox) {
        checkedValues.push(checkbox.value);
    });

    if (checkedValues.length === 0) {
        toastr.error('선택된 공지가 없습니다.');
        return;
    }
    
    $.ajax({
        url: "${root}/notice/noticePinCancel.do",
        type: "POST",
        traditional: true,
        data: $.param({ chk: checkedValues }, true),
        success: function(cancel) {
            if (cancel === 'success') {
                toastr.success('고정을 해제했습니다.');
                setTimeout(function() {
                    location.href = "${root}/notice/noticeBoard.do";
                }, 500);
            } else if(cancel === 'fail') {
                toastr.error('고정해제를 못했습니다.');
                setTimeout(function() {
                    location.href = "${root}/notice/noticeBoard.do";
                }, 500);
            }
        },
        error: function(e) {
            toastr.error('문제가 있습니다.');
        }
    });
}

</script>

</html>
