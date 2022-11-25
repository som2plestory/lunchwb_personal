<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> 비밀번호 찾기 </title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
    <!-- js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
	
</head>

<body>
    <c:import url="/WEB-INF/views/includes/userHeader.jsp"></c:import>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-12 col-xl-10" style="width: 500px;">
                <div class="card shadow-lg o-hidden border-0 my-5">
                    <div class="card-body p-0">
                        <div class="row" style="width: 500px;">
                            <div class="col-lg-6 col-xxl-12" style="width: 500px;">
                                <div class="p-5" style="width: 500px;">
                                    <div class="text-center fix-380"><img class="login_logo" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png">
                                        <div class="text-center fix-380">
                                            <h4 class="text-dark mb-4 h4">비밀번호 찾기</h4>
                                        </div>
                                    </div>
                                    <div class="text-center fix-380"></div>
                                    <form method="post" action="${pageContext.request.contextPath}/findPW" class="user">
                                        <div class="mb-3 fix-380">
                                            <div>
                                            	<span class="check-text">입력하신 이메일로 임시 비밀번호를 발급합니다.</span>
                                           	</div>
                                           	<input class="form-control form-control-user fix-380" type="email" id="InputLoginEmail" aria-describedby="emailHelp" placeholder="이메일을 입력해주세요." name="userEmail">
                                        </div>
                                        <div class="mb-3 fix-380"></div>
                                        <div class="mb-3 fix-380">
                                        </div><button class="btn btn-primary d-block btn-user w-100 fix-380" id="btn-login" type="submit">임시 비밀번호 발급받기</button>
                                        <hr>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
<script type="text/javascript">

</script>
</html>