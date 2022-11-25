<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">


<c:set var="URL" value="${pageContext.request.requestURL}" />
<c:if test="${fn:contains(URL, 'group') or fn:contains(URL, 'stat') or fn:contains(URL, 'customer') or fn:contains(URL, 'user')}">
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
</c:if>

<nav id="header" class="navbar navbar-light navbar-expand-xl bg-white shadow d-xxl-flex justify-content-xxl-end mb-4 topbar static-top">
    <div class="container">
        <div></div>
        <div id="msgStack"></div>
        
       	<c:choose>
       		<c:when test="${!empty authUser}">
       			<ul class="navbar-nav d-xxl-flex align-items-xxl-center">
		        	<!-- 알림 -->
					<c:import url="/WEB-INF/views/includes/alertCenter.jsp"></c:import>
							            
		            <!-- 로그아웃 -->
		            <li class="nav-item d-inline-flex">
		            	<a href="${pageContext.request.contextPath}/logout" style="padding: 15px 0px">
		            		<button id="logout-btn" class="btn btn-primary" type="button" style="2px 0px 0px 0px">로그아웃</button>
		            	</a>
		            </li>
		            
		            <!-- 유저 메뉴 -->
		            <li id="menu-dropdown" class="nav-item dropdown show d-xxl-flex">
		            	<a class="nav-link" aria-expanded="false" data-bs-toggle="dropdown" data-bs-auto-close="outside">
		            		<i class="fas fa-bars"></i>
		            	</a>
		                <div class="dropdown-menu dropdown-menu-end" data-bs-popper="none">
		                	<a class="dropdown-item" href="${pageContext.request.contextPath}/user/checkUser">나의정보</a>
		                	<a class="dropdown-item" href="${pageContext.request.contextPath}/group/list">나의그룹</a>
		                	<a class="dropdown-item" href="${pageContext.request.contextPath}/stat/statCalendar">방문내역</a>
		                	<a class="dropdown-item" href="${pageContext.request.contextPath}/customer/faq">고객센터</a>
		                </div>
		            </li>
	            </ul>
           	</c:when>
           	
           	<c:otherwise>
           		<!-- 로그인 -->		            
            	<a href="${pageContext.request.contextPath}/login" style="padding: 15px 0px">
            		<button id="logout-btn" class="btn btn-primary" type="button" style="2px 0px 0px 0px">로그인</button>
            	</a>		            
           	</c:otherwise>
    	</c:choose>      
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>
</script>