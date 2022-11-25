<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>부장님요기요</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-jw.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/error.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Bold-BS4-Responsive-Pricing-Table-Snippet.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>

</head>


<body id="page-top">
<div id="bujang-logo-wrap">
	<a href="${pageContext.request.contextPath}/" class="no-drag">
		<img data-bss-hover-animate="pulse" id="bujang-logo-blue" class="no-drag" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png">
	</a>
</div>
<div id="wrapper" class="no-drag">
    <div class="d-flex flex-column" id="content-wrapper">
        <div id="content">
            <c:import url="/WEB-INF/views/includes/header.jsp" />
            <div class="container-fluid">
                <div class="text-center mt-5" id="error-main">
                    <div class="error mx-auto" data-text="500">
                        <p class="m-0">500</p>
                    </div>
                    <p class="text-dark mb-5 lead" style="font-family: 'Nanum Gothic', sans-serif;">Error</p>
                    <p class="text-black-50 mb-0" style="font-family: 'Nanum Gothic', sans-serif;">일시적으로 오류가 발생했습니다.</p><a href="${pageContext.request.contextPath}/">← 메인으로 돌아가기</a>
                </div>
            </div>
        </div>
        <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    </div>
</div>
    
</body>


</html>