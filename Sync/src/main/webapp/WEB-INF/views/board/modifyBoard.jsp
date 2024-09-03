<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.ckeditor.com/ckeditor5/12.4.0/classic/ckeditor.js"></script>
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
.delete-button {
    background-color: transparent;
    color: black;
    border: none;
    font-size: 14px;
}

.delete-button:hover {
    background-color: darkred;
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
					
					</div>
					<div class="card-body">
					<form action="${root}/board/modifyBoard.do" method="post" enctype="multipart/form-data">
						<table class="table">
							<tr>
								<td class="tb"><strong>이&nbsp;&nbsp;&nbsp;&nbsp;름</strong></td>
								<td>${bo.employee_name}</td>
							</tr>
							<tr>
								<td class="tb"><strong>제&nbsp;&nbsp;&nbsp;&nbsp;목</strong></td>
								<td>
									<input type="text" class="input-hide" name="bd_title" style="border-radius: 0px; border: none;" value="${bo.bd_title}">
								</td>
							</tr>
							<tr>
								<td class="tb"><strong>첨&nbsp;부&nbsp;파&nbsp;일</strong></td>
								<td>
							        <c:choose>
							            <c:when test="${not empty bo.fileVo}">
							                <c:forEach var="file" items="${bo.fileVo}">
							                	<div class="file-item" id="file-${file.file_seq}">
								                    <a href="${root}/board/downloadFile.do?file_sname=${file.file_sname}" target="_blank">
								                        ${file.file_oname} (${file.file_size} bytes)
								                    </a>
							                    	<button type="button" class="delete-button" data-file-seq="${file.file_seq}">x</button><br>
												</div>
							                </c:forEach>
							            </c:when>
							            <c:otherwise>
							                첨부파일이 없습니다.
							            </c:otherwise>
							      </c:choose>
						          <input type="file" class="input-hide" name="filename"  multiple="multiple">
						      </td>
							</tr>
							<tr>
								<td class="tb"><strong>내&nbsp;&nbsp;&nbsp;&nbsp;용</strong></td>
								<td>
                                   <textarea id="editor" name="bd_content" >${bo.bd_content}</textarea>
                               </td>
							</tr>
							<tr>
								<td class="tb"><strong>작&nbsp;성&nbsp;일</strong></td>
								<td>${bo.bd_date}</td>
							</tr>
						</table>
						<div class="btn-container">
							<input type="hidden" name="bd_seq" value="${bo.bd_seq}">
							<input type="hidden" name="emp_id" value="${bo.emp_id}">
	                        <input type="submit" class="btn btn-info"  value="등록">
	                        <input type="button" class="btn btn-secondary" value="뒤로가기" onclick="javascript:history.back(-1)">
                        </div>
                        </form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
<script>
let myEditor;

ClassicEditor
  .create(document.querySelector('#editor'), {
    ckfinder: {
       uploadUrl : '{자기가 만든 컨트롤러 url}'
    },
    // 에디터의 기본 크기를 설정
    editorConfig: {}
    })
    .then(editor => {
        myEditor = editor;
        console.log('Editor was initialized');
    })
    .catch(error => {
        console.error(error);
    });

//파일 삭제
$(document).ready(function(){
	$('.delete-button').on('click',function(){
		
		var file_seq = $(this).data('file-seq');
		var fileDiv = $(this).closest('.file-item');
		
		console.log(file_seq);
		
		$.ajax({
			url:"./deleteFile.do",
			type:"POST",
			data:{file_seq: file_seq},
			success:function(data){
				if(data === 1){
					fileDiv.remove();
					toastr.success('파일이 삭제됐습니다.');
				} else{
					toastr.error('파일 삭제를 실패했습니다.');
				}
			},
			error:function(e){
				toastr.error('알 수 없는 오류입니다.');
			}
		});
	});	
});

    
 
</script>
</html>