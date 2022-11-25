<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

		<ul class="menu">
		
			<c:choose>
				<c:when test="${authUser != null }">
					<!-- 로그인 후 메뉴 -->
					<li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
					<li><a href="${pageContext.request.contextPath}/user/checkUser">회원정보수정</a></li>
					<input type="text" value = "${authUser.userEmail }">
				</c:when>
				
				<c:otherwise>
					<!-- 로그인 전 메뉴 -->
					<li><a href="${pageContext.request.contextPath}/login">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/join">회원가입</a></li>
				</c:otherwise>
			</c:choose>
 		</ul>