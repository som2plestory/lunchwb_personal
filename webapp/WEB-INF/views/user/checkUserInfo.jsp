<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>유저 확인</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/group.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
</head>

<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/includes/aside/userAside.jsp"></c:import>
        <div class="d-flex flex-column" id="content-wrapper">
            <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
            <div class="container" id="container" style="max-width: 1920px;height: auto;">
                <div>
                    <section class="position-relative py-4 py-xl-5">
                        <div class="container">
                            <div class="row mb-0">
                                <div class="col-md-8 col-xl-6 text-center mx-auto">
                                    <h2 style="font-weight: bold;">회원 정보 수정</h2>
                                </div>
                            </div>
                            <div class="row d-flex justify-content-center">
                                <div class="col-md-6 col-xl-4">
                                    <div class="p-5">
                                        <div class="text-center"></div>
                                        <form method="post" action="${pageContext.request.contextPath}/user/userInfo/" class="user">
                                        	<span id="infoEmail" class="input-group-text ">${authUser.userEmail}</span>
                                            <div class="mb-3">
                                            	<input class="form-control form-control-user btn-radius" type="password" id="inputLoginPassword" placeholder="비밀번호를 입력해주세요." name="userPassword">
                                           	</div>
                                            <button class="btn btn-primary d-block btn-user w-100 btn-radius" id="btn-submit" type="submit">확인</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <!-- footer -->
    		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
<script type="text/javascript">

</script>

</html>