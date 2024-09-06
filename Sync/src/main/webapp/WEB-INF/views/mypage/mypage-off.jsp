<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>

</style>

<div>
	<!-- 연차 영역 -->
	<div class="card-header mt-1 py-3">
		<h4 class="mb-0">연차 조회</h4>
	</div>
	<div class="card-body" style="max-width: 900px">
		<div class="emp-off" style="width: 100%;">
			<table class="table">
				<thead>
					<tr>
						<td>총 연차</td>
						<td>사용 연차</td>
						<td>잔여 연차</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${infoDto.total_off }</td>
						<td>${infoDto.used_off }</td>
						<td>${infoDto.total_off - infoDto.used_off }</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="emp-off-history" style="width: 100%; margin-top: 50px;">
			<h5>연차 사용 내역</h5>
			<table id="myTable" class="hover stripe" style="width: 80%;">
			    <thead>
								<tr>
									<td>No.</td>
									<td>연차사용일자</td>
									<td>내용</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${offVo}" varStatus="vs">
									<tr>
										<td>${fn:length(offVo) - vs.index}</td>
										<td>${vo.off_date}</td>
										<td>${vo.off_reason }</td>
			
									</tr>
								</c:forEach>
							</tbody>
			</table>
		</div>
	</div>
</div>

<script>
$(document).ready( function () {
	new DataTable('#myTable', {
	    pageLength: 5,
	    "dom":"tp",
        "language": {
            "paginate": {
                "previous": "<",  // Previous 버튼 텍스트 변경
                "next": ">"       // Next 버튼 텍스트 변경 (필요 시)
            }
        }
	});
} );
</script>