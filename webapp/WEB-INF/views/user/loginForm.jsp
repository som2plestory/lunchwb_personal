<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> 로그인 </title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
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
                        <div class="row">
                            <div class="col-lg-6 col-xxl-12">
                                <div class="p-5"  style="width: 500px;">
                                    <div class="text-center">
                                    	<img class="login_logo" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png">
                                   	</div>
                                    <div class="text-center">
                                        <h4 class="text-dark mb-4 h3 input-box fix-380">로그인</h4>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/login" class="user fix-380">
                                        <div class="mb-3 fix-380">
                                        	<input class="form-control form-control-user " type="email" id="InputLoginEmail" aria-describedby="emailHelp" placeholder="이메일을 입력해주세요." name="userEmail">
                                       	</div>
                                        <div class="mb-3 fix-380">
                                        	<input class="form-control form-control-user " type="password" id="inputLoginPassword" placeholder="비밀번호를 입력해주세요." name="userPassword">
                                        </div>
                                        <div class="mb-3 fix-380">
                                            <div class="custom-control custom-checkbox small">
                                                <div class="form-check"><input class="form-check-input custom-control-input" type="checkbox" id="autoLogin" name = "autoLogin"><label class="form-check-label custom-control-label input-box" for="autoLogin">로그인 상태 유지</label></div>
                                            </div>
                                            <c:if test="${param.result eq 'fail' }">
	                                    		<span class="check-text" id="msgErrorName">로그인에 실패했습니다. 이메일과 비밀번호를 확인해주세요.</span>
											</c:if>
                                        </div><button class="btn btn-primary d-block btn-user w-100 " id="btn-login" type="submit">로그인</button>
                                        <hr>
                                        <a class="btn btn-primary d-block btn-naver btn-user w-100 mb-2 fix-380" role="button" href="${naverUrl}">네이버 아이디로 로그인</a>
                                        <a class="btn btn-primary d-block btn-kakao btn-user w-100 mb-2 fix-380" role="button" 
                                        	href="https://kauth.kakao.com/oauth/authorize?client_id=76831635e5a5685d3617238b00847def&redirect_uri=http://localhost:8088/lunchwb/kakaoLoginCallback&response_type=code">카카오 아이디로 로그인</a>
                                        <a class="btn btn-primary d-block btn-google btn-user w-100 mb-2 fix-380" role="button" 
                                        	href = "https://accounts.google.com/o/oauth2/v2/auth?client_id=438267358505-j3dkkelfosq3bi7mo6th93ecq413ftpb.apps.googleusercontent.com&redirect_uri=http://localhost:8088/lunchwb/googleLoginCallback&response_type=code&scope=email%20profile%20openid&access_type=offline">구글 아이디로 로그인</a>
                                        <hr>
                                    </form>
                                    <div class="text-center">
                                    	<a class="small fix-380" href="${pageContext.request.contextPath}/findPW" style="text-decoration:none;">비밀번호 찾기</a>
                                   	</div>
                                    <div class="text-center">
                                    	<a class="small fix-380" href="${pageContext.request.contextPath}/join" style="text-decoration:none;">회원가입</a>
                                   	</div>
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

$("#check-email").on("click", function(){
	
	var id = $('[name = "userEmail"]').val();
	
	
 	$.ajax({
		url : "${pageContext.request.contextPath }/user/checkEmail",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(id),
		dataType : "json",
		success : function(result){
			
			if(result == "success"){
				if($("#msgOverlapEmail").hasClass("collect-text") === false) {
						$("#msgOverlapEmail").addClass("collect-text");
						$("#msgOverlapEmail").removeClass("check-text");
					} 
				$("#msgOverlapEmail").text("사용할 수 있는 이메일 입니다.");
				idChk = id;
			}else {
				if($("#msgOverlapEmail").hasClass("check-text") === false) {
					$("#msgOverlapEmail").addClass("check-text");
					$("#msgOverlapEmail").removeClass("collect-text");
				}
				$("#msgOverlapEmail").text("이미 사용중인 이메일 입니다.");
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	}); 
});

</script>

</html>

