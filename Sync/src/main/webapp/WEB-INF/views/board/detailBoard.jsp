<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>자유게시글 상세보기</title>
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
	text-align: right;
}

.btn-container input {
	margin: 0 10px;
	width: 100px;
}

.card-header {
	text-align: right;
}

.content-cell {
	height: 200px;
	max-height: 600px;
	vertical-align: top !important;
}

.comment-container {
	margin-top: 20px;
}

.comment-form {
	margin-bottom: 20px;
}

.comment-form textarea {
	width: 100%;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 8px;
	font-size: 14px;
	resize: vertical;
}

.comment-form .btn {
	margin-top: 10px;
}

.comment-item {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 10px;
	margin-bottom: 10px;
	background-color: #f9f9f9;
}

.comment-author {
	font-weight: bold;
	margin-bottom: 5px;
}

.comment-date {
	color: #888;
	font-size: 12px;
}

.comment-content {
	margin-top: 5px;
}

.rank-image {
	width: 17px; /* 원하는 이미지 크기로 조절 */
	height: 17px; /* 원하는 이미지 크기로 조절 */
	vertical-align: middle;
	margin-bottom: 5px;
}
#combtn{
	background-color: transparent;
	border: none;
	font-size: 10px;
	text-decoration: none;
}
#combtn:hover {
    text-decoration: underline; /* 마우스를 올렸을 때 밑줄 추가 */
    text-decoration-color: blue; /* 밑줄 색상 설정 (파란색) */
}
.loadMore{
	text-decoration: underline; /* 마우스를 올렸을 때 밑줄 추가 */
    text-decoration-color: blue; /* 밑줄 색상 설정 (파란색) */
    font-size: 13px;
    border: none;
    background-color: transparent;
}
.commentValue{
	width: 100%
}
.comment-action{
	display: flex;
    align-items: center;
    margin-bottom: 10px; /* 버튼과 폼 사이의 간격 조절 */
}
#btnsize{
	font-size: 12px;
	margin-bottom: 15px;
}
</style>
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
					<div class="card-header">
						<form>
							<input type="hidden" name="bd_seq" value="${detail.bd_seq}">
							<div class="btn-container">
								<c:if test="${loginDto.getEmp_name() eq detail.employee_name}">
									<input type="button" class="btn btn-info" value="수정" onclick="modify(event)">
									<input type="button" class="btn btn-danger" value="삭제" onclick="deleteOne()">
								</c:if>
								<input type="button" class="btn btn-secondary" value="뒤로가기"
									onclick="location.href='${root}/board/userBoard.do'">
							</div>
						</form>
					</div>
					<div class="card-body">
						<table class="table">
							<tr>
								<td class="tb"><strong>이&nbsp;&nbsp;&nbsp;&nbsp;름</strong></td>
								<td>${detail.employee_name}</td>
							</tr>
							<tr>
								<td class="tb"><strong>제&nbsp;&nbsp;&nbsp;&nbsp;목</strong></td>
								<td id="boardTitle">${detail.bd_title}</td>
							</tr>
							<tr>
								<td class="tb"><strong>첨&nbsp;부&nbsp;파&nbsp;일</strong></td>
								<td>
									<c:choose>
							            <c:when test="${not empty detail.fileVo}">
							                <c:forEach var="file" items="${detail.fileVo}">
							                    <a href="${root}/board/downloadFile.do?file_seq=${file.file_seq}" target="_blank">
							                        ${file.file_oname} (${file.file_size} bytes)
							                    </a><br>
							                </c:forEach>
							            </c:when>
							            <c:otherwise>
							                첨부파일이 없습니다.
							            </c:otherwise>
							        </c:choose>
								</td>
							</tr>
							<tr>
								<td class="tb"><strong>내&nbsp;&nbsp;&nbsp;&nbsp;용</strong></td>
								<td class="content-cell">${detail.bd_content}</td>
							</tr>
							<tr>
								<td class="tb"><strong>작&nbsp;성&nbsp;일</strong></td>
								<td>${detail.bd_date}</td>
							</tr>
						</table>
							<div class="comment-container">
								<h6>
									댓글 <input type="button" value="댓글 입력"  id= "btnsize" class="btn btn-primary" onclick="showhideForm(event)"> 
								</h6>
								<div id="hideform" class="hideform" style ="display: none;">
								<form class="comment-form" action="${root}/board/insertComment.do" method="post">
									<textarea name="bd_content" rows="5" placeholder="${infoDto.emp_name}님 댓글을 입력하세요..."></textarea>
									<br>
									<div style="text-align: right;">
										<input type="submit" value="댓글 추가" class="btn btn-primary" style="font-size: 12px;" id="submitComment">
										<input type="hidden" name="bd_post" value="${detail.bd_post}">
										<input type="hidden" name="emp_id" value="${loginDto.emp_id}">
										<input type="hidden" name="bd_seq" value="${detail.bd_seq}">
										<input type="hidden" name="bd_title" value="${detail.bd_title}">
									</div>
								</form>
							</div>
							<div id="comments">
									<c:forEach var="co" items="${clist}">
										<div class="comment-item">
											<div class="comment-author">
												<span>${co.employee_name}</span>
												<c:choose>
													<c:when test="${co.employee_name ne detail.employee_name}">
														<c:choose>
															<c:when test="${co.employee_rank eq 'RANK001'}">
																<img src="${root}/resources/img/comment/rank1.png"
																	class="rank-image" alt="Rank 1">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK002'}">
																<img src="${root}/resources/img/comment/rank2.png"
																	class="rank-image" alt="Rank 2">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK003'}">
																<img src="${root}/resources/img/comment/rank3.png"
																	class="rank-image" alt="Rank 3">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK004'}">
																<img src="${root}/resources/img/comment/rank4.png"
																	class="rank-image" alt="Rank 4">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK005'}">
																<img src="${root}/resources/img/comment/rank5.png"
																	class="rank-image" alt="Rank 5">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK006'}">
																<img src="${root}/resources/img/comment/rank6.png"
																	class="rank-image" alt="Rank 6">
															</c:when>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${co.employee_rank eq 'RANK001'}">
																<img src="${root}/resources/img/comment/rank1.png"
																	class="rank-image" alt="Rank 1">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK002'}">
																<img src="${root}/resources/img/comment/rank2.png"
																	class="rank-image" alt="Rank 2">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK003'}">
																<img src="${root}/resources/img/comment/rank3.png"
																	class="rank-image" alt="Rank 3">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK004'}">
																<img src="${root}/resources/img/comment/rank4.png"
																	class="rank-image" alt="Rank 4">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK005'}">
																<img src="${root}/resources/img/comment/rank5.png"
																	class="rank-image" alt="Rank 5">
															</c:when>
															<c:when test="${co.employee_rank eq 'RANK006'}">
																<img src="${root}/resources/img/comment/rank6.png"
																	class="rank-image" alt="Rank 6">
															</c:when>
														</c:choose>
														<img src="${root}/resources/img/comment/author.png"
															class="rank-image">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="comment-content">${co.bd_content}</div>
											<div class="comment-date">${co.bd_date}</div>
											<form action="${root}/board/deleteComment.do" method="post" >
												<input type="hidden" name="bd_seq" value="${detail.bd_seq}">
												<input type="hidden" name="co_post" value="${co.bd_post}">
												<input type="hidden" name="co_comment" value="${co.bd_comment}">
												<c:if test="${co.employee_name eq loginDto.emp_name}">
													<input type="button" value="수정" id="combtn" onclick="showEditForm('${co.bd_comment}', '${co.bd_content}')"> 
													<input type="submit" value="삭제" id="combtn">
												</c:if>
											</form>
											 <div class="edit-form" id="edit-form-${co.bd_comment}" style="display: none;">
										        <form action="${root}/board/modifyComment.do" method="post">
										            <input type="hidden" name="bd_seq" value="${detail.bd_seq}">
										            <input type="hidden" name="co_post" value="${co.bd_post}">
										            <input type ="hidden" name ="co_comment" value ="${co.bd_comment}">
										            <textarea class="commentValue" name="co_content" rows="5">${co.bd_content}</textarea>
										            <br>
										            <input type="submit" value="저장" class="btn btn-primary">
										            <input type="button" value="취소" class="btn btn-secondary" onclick="hideEditForm('${co.bd_comment}')">
										        </form>
										    </div>
										</div>
									</c:forEach>
									<div class="btn-container">
									    <button class ="loadMore" id="loadMore" onclick="loadMoreComments()">더보기</button>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
<script type="text/javascript">
function showEditForm(comment, content){
	
	var editForm = document.getElementById('edit-form-' + comment);
	
	if(editForm){
		var textarea = editForm.querySelector('textarea[name="co_content"]');
		
		if(textarea){
			textarea.value = content;
			
			editForm.style.display = 'block';
		}else{
			toastr.error('content 오류');
		}
	} else{
		toastr.error('textarea 오류');
	}
	
}

function hideEditForm(comment){
	document.getElementById('edit-form-' + comment).style.display = 'none';
}

function showhideForm(event){
	event.preventDefault();
	
	var show = document.getElementById('hideform');
	
	if(show.style.display === 'none' || show.style.display === ''){
		show.style.display = "block";
	} else{
		show.style.display = 'none';
	}
}

//수정
function modify(event){
	event.preventDefault();
	
	var frm = document.forms[0];
	var seq = document.querySelector("input[name=bd_seq]").value;
	
	
	frm.action="${root}/board/modifyBoard.do?bd_seq="+seq;
	frm.method="get";
	frm.submit();
}

//삭제
function deleteOne(){
	console.log(${detail.bd_seq})
	
	var seq = ${detail.bd_seq};
	location.href="${root}/board/deleteBoard.do?chk="+seq;
}




</script>
</html>