<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>

<nav id="user-aside"
	class="navbar navbar-dark bg-primary align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
	<div class="container-fluid d-flex flex-column p-0">
		<a href="${pageContext.request.contextPath}/">
			<img data-bss-hover-animate="pulse" id="bujang-logo" width="159" height="38"
				src="${pageContext.request.contextPath}/assets/img/bujang-logo.png">
		</a>
		<ul class="navbar-nav" id="asdie-ul">
			<li class="nav-item">
				<a class="nav-link nav-title no-drag">나의정보</a>
			</li>
			<li class="nav-item">
				<a id="nav-user" class="nav-link nav-menu" href="${pageContext.request.contextPath}/user/checkUser">회원정보수정</a>
			</li>
			<li class="nav-item">
				<hr class="nav-line">
			</li>

			<li class="nav-item">
				<a class="nav-link nav-title no-drag">나의그룹</a>
			</li>
			<li class="nav-item">
				<a id="nav-group" class="nav-link nav-menu" href="${pageContext.request.contextPath}/group/list">그룹목록</a>
			</li>
			<li class="nav-item">
				<a id="nav-black" class="nav-link nav-menu" href="${pageContext.request.contextPath}/group/blacklist">블랙리스트</a>
			</li>

			<li class="nav-item">
				<hr class="nav-line">
			</li>
			<li class="nav-item">
				<a class="nav-link nav-title no-drag">방문내역</a>
			</li>
			<li class="nav-item">
				<a id="nav-cal" class="nav-link nav-menu" href="${pageContext.request.contextPath}/stat/statCalendar">캘린더</a>
			</li>
			<li class="nav-item">
				<a id="nav-review" class="nav-link nav-menu" href="${pageContext.request.contextPath}/stat/reviewList">리뷰내역</a>
			</li>
			<li class="nav-item">
				<a id="nav-chart"class="nav-link nav-menu" href="${pageContext.request.contextPath}/stat/statChart">방문통계</a>
			</li>
			<li class="nav-item">
				<hr class="nav-line">
			</li>
			<li class="nav-item">
				<a class="nav-link nav-title no-drag">고객센터</a>
			</li>
			<li class="nav-item">
				<a id="nav-faq" class="nav-link nav-menu" href="${pageContext.request.contextPath}/customer/faq">FAQ</a>
			</li>
			<li class="nav-item">
				<a id="nav-inq" class="nav-link nav-menu" href="${pageContext.request.contextPath}/customer/writeInquiry">문의하기</a>
			</li>
			<li class="nav-item">
				<a id="nav-report" class="nav-link nav-menu" href="${pageContext.request.contextPath}/customer/reviewReport/${authUser.userNo}">문의내역</a>
			</li>
		</ul>
	</div>
</nav>

<script type="text/javascript">

$(document).ready(function(){
	indexActive()
})


function indexActive(){
	console.log("active 체크")
	document.getElementsByClassName("nav-menu").className = "nav-link nav-menu"
	
	var url =  window.location.pathname
	console.log("url: " + url)
	
	switch(url){
		case "/lunchwb/user/checkUser" :
			document.getElementById("nav-user").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/group/blacklist" :
			document.getElementById("nav-black").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/group/list" :
			document.getElementById("nav-group").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/stat/statCalendar" :
			document.getElementById("nav-cal").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/stat/reviewList" :
			document.getElementById("nav-review").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/stat/statChart" :
			document.getElementById("nav-chart").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/customer/faq" :	
			document.getElementById("nav-faq").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/customer/writeInquiry" :
			document.getElementById("nav-inq").className = "nav-link nav-menu nav-active"
			break
			
		case "/lunchwb/customer/reviewReport/":
			document.getElementById("nav-report").className = "nav-link nav-menu nav-active"
			break
			
	}
}


</script>
