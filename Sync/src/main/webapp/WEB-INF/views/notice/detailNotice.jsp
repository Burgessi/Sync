<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 상세보기</title>
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
  .tb{
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
  #bt{
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
  .card-header{
    text-align: right;
  }
  .content-cell {
     height: 500px;
     max-height: 600px; 
     vertical-align: top !important;
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
                        <table class="table">
                            <tr>
                                <td class="tb"><strong>아&nbsp;이&nbsp;디</strong></td>
                                <td>${noti.employee_name}</td>
                            </tr>
                            <tr>
                                <td class="tb"><strong>제&nbsp;&nbsp;&nbsp;&nbsp;목</strong></td>
                                <td>${noti.notice_title}</td>
                            </tr>
                            <tr>
                                <td class="tb"><strong>내&nbsp;&nbsp;&nbsp;&nbsp;용</strong></td>
                                <td class="content-cell">${noti.notice_content}</td>
                            </tr>
                            <tr>
                                <td class="tb"><strong>작&nbsp;성&nbsp;일</strong></td>
                                <td>${noti.notice_regdate}</td>
                            </tr>							
                        </table>
                        <form>
                        	<input type="hidden" name="notice_seq" value="${noti.notice_seq}">
                       		 <div class="btn-container">
                       		 	<c:if test="${infoDto.team_code == 'HR' and infoDto.authority == 'A'}">
                        		<input type="button" class="btn btn-info"  value="수정" onclick="modify(event)">
                        		</c:if>
                        		<input type="button" class="btn btn-secondary"  value="뒤로가기" onclick="location.href='${root}/notice/noticeBoard.do'"> 
                        	</div>
                        </form>
                    </div>
                </div>				
            </div>	
        </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    
<script type="text/javascript">
function modify(event){
	event.preventDefault();
	
	var frm = document.forms[0];
	var seq = document.querySelector("input[name=notice_seq]").value;
	
	frm.action="${root}/notice/modifyNotice.do?notice_seq="+seq;
	frm.method="get";
	frm.submit();
}

</script>    
</body>
</html>
