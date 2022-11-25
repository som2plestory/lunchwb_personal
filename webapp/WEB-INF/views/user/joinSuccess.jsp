<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> 회원가입 </title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
</head>

<body>
    <c:import url="/WEB-INF/views/includes/userHeader.jsp"></c:import>
    <div class="container">
        <div class="justify-content-center">
            <div class="col-md-9 col-lg-12 col-xl-10" style="width: 1200px;">
                <div class="card shadow-lg o-hidden border-0 my-5">
                    <div class="card-body p-0" style="width: 1176px;">
                            <div class="col-lg-6 col-xxl-12" style="width: 1200px;">
                                <div class="p-5" style="width: 1176px;">
                                    <div class="text-center">
                                        <h4 class="text-dark mb-4 h1" style="font-weight: bold; width: 1080px;">환영합니다!</h4>
                                    </div>
                                    <p style="text-align: center; width: 1080px;"><br>부장님 요기요 회원가입을 축하합니다.<br>${authUser.userName}님의 점심 선택의 부담을 덜어드릴 수 있도록 최선을 다하겠습니다.<br><br>그룹을 생성하시면 <br>각 그룹의 취향에 맞는 식당을 추천해드리고 있습니다.<br><br>또한&nbsp;<br>${authUser.userName}님의 막중한 책임감을 덜어드릴 수 있는<br>투표, 랜덤 선택 등 다양한 기능들을 제공하고 있습니다.<br><br>감사합니다.<br><br></p>
                                    <a href = "${pageContext.request.contextPath}/group/add" style="text-decoration:none; width: 270px;">
                                    	<button class="btn btn-primary d-block btn-user w-25 btn-radius" id="btn-joinsuccess" type="submit" tyle="width: 270px;">그룹 만들기</button>
                                    </a>
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