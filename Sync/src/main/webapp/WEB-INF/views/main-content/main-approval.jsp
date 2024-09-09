<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<style>
/* CSS 스타일 */
.approval-dashboard {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    padding: 15px;
    box-sizing: border-box;
}

.approval-card {
    flex: 1 1 calc(25% - 15px); /* 4개 카드가 한 줄에 들어오도록 */
    min-width: 250px;
    background: linear-gradient(135deg, #ffffff, #f0f0f0);
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    overflow: hidden;
    padding: 15px;
    box-sizing: border-box;
    transition: transform 0.3s, box-shadow 0.3s;
}

.approval-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
    cursor: pointer;
}

.approval-card-header {
    display: flex;
    justify-content: space-between; /* 제목과 오른쪽 콘텐츠를 양쪽 끝으로 정렬 */
    align-items: center;
    border-bottom: 2px solid #e0e0e0;
    padding-bottom: 10px;
    margin-bottom: 10px;
}

.approval-card-header h5 {
    margin: 0;
    font-size: 18px;
    color: #333333;
    font-weight: bold;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 4px; /* 이미지와 badge 간의 간격 */
}

.status-badge {
    display: inline-block;
    padding: 4px 10px;
    font-size: 11px;
    color: #ffffff;
    border-radius: 20px;
    font-weight: bold;
}

.status-badge.pending {
    background-color: #ff9800; /* 대기중 상태 색상 */
}

.status-badge.approved {
    background-color: #4caf50; /* 승인 상태 색상 */
}

.status-badge.rejected {
    background-color: #f44336; /* 거부 상태 색상 */
}

.approval-card-body {
    display: flex;
    justify-content: space-between; /* 요소들을 세로로 나열 */
   	align-items: center; /* 요소 사이의 간격 */
}

.approval-card-body p {
    margin: 0;
    color: #555555;
    font-size: 14px;
    line-height: 1.5;
    display: inline;
}

.no-docs-container {
         position: relative;
         width: 100%;
         height: 100%;
         display: flex;
         justify-content: center;
         align-items: center;
         margin-top: 45px;
     }

     .no-docs-message {
         padding: 30px 40px;
         background: #ffffff;
         border: 1px solid #dcdcdc;
         border-radius: 12px;
         box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
         text-align: center;
         max-width: 80%;
         width: 400px;
         animation: fadeInUp 1s ease-out;
         position: relative;
     }

     .no-docs-message::before {
         content: "!";
         position: absolute;
         top: -30px;
         left: 50%;
         transform: translateX(-50%);
         font-size: 60px;
         color: #f44336;
         font-weight: bold;
         animation: bounce 1s infinite;
     }

     .no-docs-message h2 {
         margin: 0;
         font-size: 22px;
         color: #333333;
         font-weight: 600;
     }

     .no-docs-message p {
         margin-top: 10px;
         font-size: 16px;
         color: #666666;
     }

     @keyframes fadeInUp {
         0% {
             opacity: 0;
             transform: translateY(30px);
         }
         100% {
             opacity: 1;
             transform: translateY(0);
         }
     }

     @keyframes bounce {
         0%, 100% {
             transform: translateY(0);
         }
         50% {
             transform: translateY(-20px);
         }
     }
</style>
<!-- HTML 구조 -->
<div class="approval-dashboard">
	
	<c:if test="${fn:length(approval) < 1}">
		 <div class="no-docs-container">
	        <div class="no-docs-message">
	            <h2>기안 문서가 없습니다</h2>
	            <p>현재 표시할 내용이 없습니다.</p>
	        </div>
	    </div>
	</c:if>
	
	<c:forEach var="list" items="${approval}" begin="0" end="5">
		<div class="approval-card" onclick="getApprovalDetail('${list.approval_id}', '${loginDto.emp_id}','${list.document_type}','${list.temp_save_flag}')">
        <div class="approval-card-header">
            <h5>${list.document_type}</h5>
            	<div class="header-right">
            	<c:forEach var="li" items="${list.lineList}">
					<c:if test="${li.step >= 1}">
						<c:choose>
							<c:when test="${li.step eq 1 && li.status eq 0}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/pending.png">
							</c:when>
							<c:when test="${li.step eq 1 && li.status eq 1}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/check.png">
							</c:when>
							<c:when test="${li.step eq 1 && li.status eq 2}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/minus.png">
							</c:when>
							<c:when test="${li.step eq 2 && li.status eq 0}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/pending.png">
							</c:when>
							<c:when test="${li.step eq 2 && li.status eq 1}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/check.png">
							</c:when>
							<c:when test="${li.step eq 2 && li.status eq 2}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/minus.png">
							</c:when>
							<c:when test="${li.step eq 3 && li.status eq 0}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/pending.png">
							</c:when>
							<c:when test="${li.step eq 3 && li.status eq 1}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/check.png">
							</c:when>
							<c:when test="${li.step eq 3 && li.status eq 2}">
								<img alt="" style="width: 18px; height: 18px;" src="${root}/resources/img/approval_img/minus.png">
							</c:when>
						</c:choose>
						</c:if>
					</c:forEach>
            
            
			<c:choose>
				<c:when test="${list.approval_status eq 0}">
					<span class="status-badge pending">결재진행중</span>
				</c:when>
				<c:when test="${list.approval_status eq 1}">
					<span class="status-badge approved">결재완료</span>
				</c:when>
				<c:otherwise>
					<span class="status-badge rejected">결재반려</span>
				</c:otherwise>
			</c:choose>      
			</div>      
        </div>
        <div class="approval-card-body">
        	<p>${list.approval_title}</p>
            <p>${list.request_date}</p>
        </div>
    </div>
	</c:forEach>
</div>
<script type="text/javascript">
		function getApprovalDetail(approvalId, empId, documentType, flag){
			const encodedDocumentType = encodeURIComponent(documentType);
			location.href='http://localhost:8080/Sync/approval/getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+empId+'&temp_save_flag='+flag;
		}
		
		
</script>
