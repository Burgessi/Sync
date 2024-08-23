<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${root}/resources/css/toastify.css" />

<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
  crossorigin="anonymous"
></script>

<style>
	@keyframes toast-animation {
        0% {
          top: 0px;
        }
        100% {
          top: 20px;
        }
      }
</style>
<div
    id="toastify"
    aria-live="assertive"
    aria-atomic="true"
    role="alert"
    class="toast toastify on toastify-center toastify-top"
    aria-live="polite"
    data-bs-autohide="false"
    style="
    background: linear-gradient(to right, #aca1ff, #9081ff);
    transform: translate(0px, 0px);
    top: 20px;
    border: none;
    animation: toast-animation 0.2s linear 0s;
  "
>
  <!-- session field-->
  <span id="toastContentSession">${toastMsg}</span>
  <!-- javascript field-->
  <span id="toastContentJS"></span>
  <button id="toastCloseBtn" type="button" data-bs-dismiss="toast" aria-label="Close" class="toast-close"> ✖</button>
</div>

<script>
	const toastContent = document.querySelector("#toastContentJS");
	const toastContentSession = document.querySelector("#toastContentSession");
	const toastLive = document.getElementById('toastify');
   	const toast = new bootstrap.Toast(toastLive);
	
	//js로 호출  //toastContent.innerText = "" 로 부여;
	$('#toastContentJS').on('DOMSubtreeModified', function(){
		toastContentSession.innerText = "";
   		toast.show();
	});
	
	//닫기
	$('#toastify').on('hidden.bs.toast', function(){
		toastContent.innerText = "";
		toast.hide();
	});
</script>

<c:set var="toastMsg" value="${sessionScope.toastMsg}"/>
<c:remove var="toastMsg" scope="session"/>

<c:if test="${not empty toastMsg}">
	<script>
	    toast.show();
	</script>
</c:if>

