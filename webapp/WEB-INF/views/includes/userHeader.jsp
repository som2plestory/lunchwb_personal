<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">

<nav class="navbar navbar-light navbar-expand bg-white shadow d-xxl-flex justify-content-xxl-end mb-4 topbar static-top no-side-bar-header">
    <div class="container join-login-page">
    	<a href="${pageContext.request.contextPath}/" class="no-drag"><span class="logo-span"><img id="bujang-logo-blue" class="no-drag" width="159" height="38" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png"/></span></a>
        <%-- <ul class="navbar-nav d-xxl-flex align-items-xxl-center">
       		 <c:if test="${empty(authUser)}">
           	 <li class="nav-item d-inline-flex">
            	<a href="${pageContext.request.contextPath}/login" style="padding: 15px 0px">
            		<button id="logout-btn" class="btn btn-primary" type="button" style="2px 0px 0px 0px">로그인</button>
            	</a>
           	</li>
       		</c:if>
			<c:if test="${!empty(authUser)}">
           	<li class="nav-item d-inline-flex">
           		<a href="${pageContext.request.contextPath}/logout" style="padding: 15px 0px">
	            		<button id="logout-btn" class="btn btn-primary" type="button" style="2px 0px 0px 0px">로그아웃</button>
            	</a>
          	 </li>
       		</c:if>
       </ul> --%>
    </div>
</nav>