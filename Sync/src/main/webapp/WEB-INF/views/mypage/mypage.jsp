<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<head>
<title>SYNC_Mypage</title>
<style>
.section {
	display: flex;
	flex-direction: row;
}

/* 사이드바 조정 */
.mypage-sidebar {
	flex-shrink: 0; /* 사이드바가 줄어들지 않도록 설정 */
	width: 275px; /* 사이드바의 고정된 너비 설정 */
}

/* 카드 조정 */
.card {
	flex-grow: 1; /* 카드가 남은 공간을 차지하도록 설정 */
	min-width: 300px;
	
}

.emp-info.pic {
    display: flex;               /* Flexbox 사용 */
    justify-content: center;    /* 가로 중앙 정렬 */
    align-items: center;        /* 세로 중앙 정렬 */

}



	

</style>
</head>
<body>
	<div id="app">
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div id="main">
			<%@ include file="/WEB-INF/views/common/header.jsp"%>

			<div class="page-heading">
				<div class="page-title">
					<div class="row">
						<div class="col-12 col-md-6 order-md-1 order-last mt-2 mb-4">
							<h3>마이페이지</h3>
						</div>
					</div>
				</div>
				<div class="page-content" >
					<section class="section">
						<%@ include file="/WEB-INF/views/mypage/mypage-sidebar.jsp"%>
						<div class="card " data-bs-spy="scroll" data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
							
							<!-- 개인정보 조회 영역 -->
					        <section id="simple-list-item-1">
					            <%@ include file="/WEB-INF/views/mypage/mypage-info.jsp"%>
					        </section>
					
					        <!-- 개인정보 수정 영역 -->
					        <section id="simple-list-item-2">
					            <%@ include file="/WEB-INF/views/mypage/mypage-info-modify.jsp"%>
					        </section>
					
					        <!-- 계좌 정보 영역 -->
					        <section id="simple-list-item-3">
					            <%@ include file="/WEB-INF/views/mypage/mypage-account.jsp"%>
					        </section>
					
					        <!-- 비밀번호 수정 영역 -->
					        <section id="simple-list-item-4">
					            <%@ include file="/WEB-INF/views/mypage/mypage-pw.jsp"%>
					        </section>
					
					        <!-- 연차 조회 영역 -->
					        <section id="simple-list-item-5">
					            <%@ include file="/WEB-INF/views/mypage/mypage-off.jsp"%>
					        </section>
							
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var scrollSpy = new bootstrap.ScrollSpy(document.body, {
                target: '#mypage-sidebar',
                offset: 0
            });
        });
    </script>
</body>
</html>


