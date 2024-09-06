<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.ckeditor.com/ckeditor5/12.4.0/classic/ckeditor.js"></script>
<title>글 수정</title>
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
</style>
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
                    <div class="card-header">
                        
                    </div>
                    <div class="card-body">
                        <form action="${root}/notice/modifyNotice.do" method="post">
                             <input type="hidden" name="notice_seq" value="${no.notice_seq}">
                             <table class="table">
                                <tr>
                                    <td class="tb"><strong>이&nbsp;&nbsp;름</strong></td>
                                    <td>${no.employee_name}</td>
                                </tr>
                                <tr>
                                    <td class="tb"><strong>제&nbsp;&nbsp;&nbsp;&nbsp;목</strong></td>
                                    <td>
                                        <input type="text" name="notice_title" style="border-radius: 0px; border: none; width: 100%;" value="${no.notice_title}">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tb"><strong>내&nbsp;&nbsp;&nbsp;&nbsp;용</strong></td>
                                    <td>
                                        <textarea id="editor" name="notice_content">${no.notice_content}</textarea>
                                    </td>
                                </tr>                
                             </table>
                             <div class="btn-container">
	                            <input type="submit" class="btn btn-info"  value="수정">
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
</script>
</html>
