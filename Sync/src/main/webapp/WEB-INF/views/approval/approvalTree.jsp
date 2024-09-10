<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>기안 작성 결재선</title>
</head>
<body>
	<form id="approvalLineForm" action="./approvalLine.do" method="post">
	<div class="container">
		
		<div class="row">
			<div class="col-md-4" style="border: 1px solid;">
				<div class="card">
					<div class="card-header"><h4>조직도</h4></div>
					<div class="card-body form-control" style="height: 400px;padding: 10px; border: 1px solid; overflow: auto;">
						<!-- jsTree 조직도 -->
							<div id="approvalLine">
							</div>
					</div>
					<input type="text" id="treeSearchInput" class="form-control" placeholder="검색어를 입력하세요" style="font-size: 0.8em">
<!-- 					<div class="card-header"><h4>자주쓰는 결재선</h4></div> -->
<!-- 					<div class="card-body form-control" style="height: 250px;padding: 10px; border: 1px solid; overflow: auto;"> -->
<!-- 						자주쓰는 결재선 -->
<!-- 						hi -->
<!-- 					</div> -->
				</div>
			</div>
			
			<div class="col-md-2" style="text-align: center; font-weight: bold;">
				<div class="card" style="margin-top: 60px;">
					<div class="card-body">
						<input type="button" class="rightArrow" id="addLine">
						<p style="font-size: 0.8em;">결재자</p>
						<input type="button" class="leftArrow" id="removeLine">
						<p style="font-size: 0.8em;">취소</p>
					</div>
				</div>
				<div class="card" style="margin-top: 60px;">
					<div class="card-body">
						<input type="button" class="rightArrow" id="addReferrer">
						<p style="font-size: 0.8em;">참조자</p>
						<input type="button" class="leftArrow" id="removeReferrer">
						<p style="font-size: 0.8em;">취소</p>
					</div>
				</div>
			</div>
			
				<div class="col-md-6" style="border: 1px solid;">
					<div class="card" style="margin-top: 15px; height: 250px;">
						<div class="card-header" style="padding: 10px"><h4>결재자</h4></div>
						<div class="card-body" style="padding: 10px">
							<table id="approvalTable" class="table table-bordered approval-line-table">
								<thead>
									<tr>
										<td style="width: 44px;">순서</td>
										<td style="width: 60px;">이름</td>
										<td style="width: 48px;">직책</td>
										<td colspan="2">부서</td>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						
					</div>
					<div class="card" style="margin-top: 40px;">
						<div class="card-header" style="padding: 10px"><h4>참조자</h4></div>
						<div class="card-body" style="padding: 10px">
							<table id="referrerTable" class="table table-bordered approval-line-table">
								<thead>
									<tr>
										<td style="width: 65px;">이름</td>
										<td style="width: 60px;">직책</td>
										<td colspan="2">부서</td>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						
					</div>
					
				</div>
		</div>
		
		
		
	</div>
	</form>
</body>
</html>