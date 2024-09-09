<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<style>
body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        
        .document-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .document-card {
            flex: 1;
            border-radius: 8px;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            min-height: 300px;
        }
        .document-card:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .document-card h3 {
            margin: 0;
            font-size: 1.4em;
            color: #333;
        }
        .document-card .card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .document-card .icon {
            font-size: 2.5em;
            color: #007bff;
        }
        .document-card .details {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .document-card .details p {
            margin: 0;
            color: #666;
            font-size: 0.9em;
        }
        .document-card .details .document-list {
            display: flex;
            flex-direction: column;
        }
        
        .document-item {
            background-color: #f9f9f9; /* 기본 배경색 */
            border: 1px solid #dee2e6; /* 테두리 색상 */
            border-radius: 8px; /* 둥글게 */
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .document-item:nth-child(even) {
            background-color: #f1f1f1; /* 홀수와 짝수 항목 배경색 다르게 */
        }
        .document-item:hover {
            transform: translateY(-5px); /* 호버 시 약간의 상승 효과 */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15); /* 그림자 강화 */
            cursor: pointer;
        }
        .document-card .details .document-item {
            background-color: #f9f9f9;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9em;
            color: #666;
        }
        .document-card .details .document-item .item-field {
            flex: 1;
            margin-right: 10px;
            text-align: center;
            font-weight: bold;
            font-size: 14px;
        }
        .document-card .details .badge-container {
            display: flex;
            align-items: center;
        }
        .document-card .details .badge {
            color: #fff;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 1em;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .badge.pending {
		    background-color: #ff9800; /* 대기중 상태 색상 */
		}
		
		.badge.approved {
		    background-color: #4caf50; /* 승인 상태 색상 */
		}
		
		.badge.rejected {
		    background-color: #f44336; /* 거부 상태 색상 */
		}
		
		.badge.temp {
		    background-color: #6c757d; /* 임시저장 상태 색상 */
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
         margin-bottom: 35px;
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
</head>
<body>
    <div class="dashboard">
        <div class="document-row">
            <div class="document-card">
                <div class="card-header" style="padding: 5px;">
                    <div class="icon">📄</div>
                    <h3>최근 기안 문서</h3>
                    <a href="./progress.do" style="margin-left: auto; margin-right: 20px;"><img style="width: 20px; height: 20px; " src="${root}/resources/img/approval_img/enter.png"></a>
                </div>
                <div class="details">
                	<c:choose>
                		<c:when test="${fn:length(draft) < 1}">
                			<div class="no-docs-container">
						        <div class="no-docs-message">
						            <h2>기안 문서가 없습니다</h2>
						            <p>현재 표시할 내용이 없습니다.</p>
						        </div>
						    </div>
                		</c:when>
                		<c:otherwise>
                				<div class="document-list">
                			<c:forEach var="dr" items="${draft}" begin="0" end="4">
			                        <div class="document-item" onclick="getDraftApprovalDetail('${dr.approval_id}', '${loginDto.emp_id}','${dr.document_type}','${dr.temp_save_flag}')">
			                            <span class="item-field" style="font-weight: bold;">${dr.document_type}</span>
			                            <span class="item-field">${dr.approval_title}</span>
			                            <span class="item-field">${dr.requester_name}</span>
			                            <span class="item-field">${dr.request_date}</span>
			                            <c:choose>
			                            	<c:when test="${dr.approval_status eq 0}">
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge pending">결재진행</span>
					                            </span>
			                            	</c:when>
			                            	<c:when test="${dr.approval_status eq 1}">
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge approved">결재완료</span>
					                            </span>
			                            	</c:when>
			                            	<c:otherwise>
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge rejected">결재반려</span>
					                            </span>
			                            	</c:otherwise>
			                            </c:choose>
			                        </div>
                			</c:forEach>
			                    </div>
                		</c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
        <!-- 동일한 형식으로 다른 카드들도 추가합니다 -->
        <div class="document-row">
            <div class="document-card">
                <div class="card-header" style="padding: 5px;">
                    <div class="icon">📥</div>
                    <h3>최근 수신 문서</h3>
                    <a href="./receive.do" style="margin-left: auto; margin-right: 20px;"><img style="width: 20px; height: 20px; " src="${root}/resources/img/approval_img/enter.png"></a>
                </div>
                <div class="details">
                    <c:choose>
                		<c:when test="${fn:length(receive) < 1}">
                			<div class="no-docs-container">
						        <div class="no-docs-message">
						            <h2>수신 문서가 없습니다</h2>
						            <p>현재 표시할 내용이 없습니다.</p>
						        </div>
						    </div>
                		</c:when>
                		<c:otherwise>
                			<div class="document-list">
                				<c:forEach var="rc" items="${receive}" begin="0" end="4">
			                        <div class="document-item" onclick="getReceivedApprovalDetail('${rc.approval_id}', '${rc.requester_id}','${rc.document_type}','${rc.temp_save_flag}')">
			                            <span class="item-field" style="font-weight: bold;">${rc.document_type}</span>
			                            <span class="item-field">${rc.approval_title}</span>
			                            <span class="item-field">${rc.requester_name}</span>
			                            <span class="item-field">${rc.request_date}</span>
			                            <c:choose>
			                            	<c:when test="${rc.approval_status eq 0}">
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge pending">결재진행</span>
					                            </span>
			                            	</c:when>
			                            	<c:when test="${rc.approval_status eq 1}">
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge approved">결재완료</span>
					                            </span>
			                            	</c:when>
			                            	<c:otherwise>
			                            		<span class="item-field" style="text-align: center;">
					                            	<span class="badge rejected">결재반려</span>
					                            </span>
			                            	</c:otherwise>
			                            </c:choose>
			                        </div>
                				</c:forEach>
			                </div>
                		</c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
        <div class="document-row">
            <div class="document-card">
                <div class="card-header" style="padding: 5px;">
                    <div class="icon">💾</div>
                    <h3>임시 저장 문서</h3>
                    <a href="./tempsave.do" style="margin-left: auto; margin-right: 20px;"><img style="width: 20px; height: 20px; " src="${root}/resources/img/approval_img/enter.png"></a>
                </div>
                <div class="details">
                    <c:choose>
                		<c:when test="${fn:length(temp) < 1}">
                			<div class="no-docs-container">
						        <div class="no-docs-message">
						            <h2>임시 저장 문서가 없습니다</h2>
						            <p>현재 표시할 내용이 없습니다.</p>
						        </div>
						    </div>
                		</c:when>
                		<c:otherwise>
                				<div class="document-list">
                			<c:forEach var="tm" items="${temp}" begin="0" end="4">
			                        <div class="document-item" onclick="getTempApprovalDetail('${tm.approval_id}', '${tm.requester_id}','${tm.document_type}','${tm.temp_save_flag }')">
			                            <span class="item-field" style="font-weight: bold;">${tm.document_type}</span>
			                            <span class="item-field">${tm.approval_title}</span>
			                            <span class="item-field">${tm.requester_name}</span>
			                            <span class="item-field">${tm.request_date}</span>
	                            		<span class="item-field" style="text-align: center;">
			                            	<span class="badge temp">임시저장</span>
			                            </span>
			                        </div>
                			</c:forEach>
			                    </div>
                		</c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	<!-- 기안문서 상세조회 -->
	function getDraftApprovalDetail(approvalId, empId, documentType, flag){
	const encodedDocumentType = encodeURIComponent(documentType);
		location.href='http://localhost:8080/Sync/approval/getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+empId+'&temp_save_flag='+flag;
	}
	
	<!-- 수신문서 상세조회-->
	function getReceivedApprovalDetail(approvalId, empId, documentType, flag) {
		//		const url = location.href;
		//		console.log(url);
		
			const encodedDocumentType = encodeURIComponent(documentType);
			
			console.log(approvalId);
			console.log(documentType);
			console.log(empId);
			location.href='http://localhost:8080/Sync/approval/getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+empId+'&temp_save_flag='+flag;
		}
	
	
	<!-- 임시저장문서 상세조회 -->
	function getTempApprovalDetail(approvalId, empId, documentType, flag) {
		//		const url = location.href;
		//		console.log(url);
		
			const encodedDocumentType = encodeURIComponent(documentType);
			
			console.log(approvalId);
			console.log(documentType);
			console.log(empId);
			location.href='http://localhost:8080/Sync/approval/getApprovalDetail.do?approval_id='+approvalId+'&document_type='+encodedDocumentType+'&requester_id='+empId+'&temp_save_flag='+flag;
		}
</script>
</html>