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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <!-- js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
</head>

<body>
    <nav class="navbar navbar-light navbar-expand bg-white shadow d-xxl-flex justify-content-xxl-end mb-4 topbar static-top no-side-bar-header">
	    <div class="container join-login-page">
	    	<a href="${pageContext.request.contextPath}/" class="no-drag"><span class="logo-span"><img id="bujang-logo-blue" class="no-drag" width="159" height="38" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png"/></span></a>
	       	<ul class="navbar-nav d-xxl-flex align-items-xxl-center">
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
	       </ul>
	    </div>
	</nav>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-12 col-xl-10" style="width: 600px;">
                <div class="card shadow-lg o-hidden border-0 my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-lg-6 col-xxl-12">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h4 class="text-dark mb-4" style="font-weight: bold;">회원가입</h4>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/joinSNS" class="user" id="joinForm">
                                    	<input class="form-control form-control-user input-box" type="hidden" id="inputJoinNickname" name="email" value="${userEmail}">
                                    	<input class="form-control form-control-user input-box" type="hidden" id="inputJoinNickname" name="id" value="${snsLogin }">
                                    	<input class="form-control form-control-user input-box" type="hidden" id="inputJoinNickname" name="access_token" value="${access_Token }">
                                        <div class="mb-3 fix-480 name">
                                        	<strong class="join-text">닉네임</strong>
                                        	<input class="form-control form-control-user input-box" type="text" id="inputJoinNickname" placeholder="사용하실 닉네임을 입력해주세요. (5자 이하)" name="userName">
                                        	<span class="check-text" id="msgErrorName">사용하실 닉네임을 입력해주세요. (5자 이하)</span>
                                       	</div>
                                        <div class="mb-3 fix-480">
                                        	<strong class="join-text">출생연도</strong>
                                        	<input id="inputBirthDate" type="number" name="userBirthYear" placeholder="출생연도를 적어주세요." min="1900" max="2030">
                                        	<br>
                                        	<span class="check-text" id="msgErrorBirth">출생연도를 입력해주세요.</span>
                                       	</div>
                                        <div class="mb-3 fix-480">
                                        	<strong class="join-text">성별</strong>
                                       		<select class="form-select" style="width: 150px;height: auto;" name="userSex">
                                                <option value="male" selected="selected">남자</option>
                                                <option value="female">여자</option>
                                           	</select>
                                           	<span class="check-text" id="msgSex"></span>
                                       	</div>
                                        <div class="mb-3 fix-480">
                                            <div class="custom-control custom-checkbox small">
                                                <div class="form-check">
                                                	<input class="form-check-input custom-control-input" type="checkbox" id="formCheck-1">
                                                	<label class="form-check-label custom-control-label" for="formCheck-1">이용약관을 확인하였습니다.</label>
                                                	<span class="check-text" id="msgCheckBox"></span>
                                                	<br>
                                                	<span class="check-text" id="msgErrorCheckBox">약관에 동의해주세요.</span>
                                               	</div>
                                            </div>
                                            <span class="check-text" id="msgCheckOverlap"></span>
                                        </div>
                                        <div class="mb-3 fix-480">
                                        	<button class="btn btn-primary d-block btn-user w-100" id="btn-join" type="submit">가입하기</button>
                                        </div>
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
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>
<script type="text/javascript">

var engCheck = /[a-z]/;
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?.]/gi;


$(".name").change(function(){
	var name = $('#joinForm [name = userName]').val();
	
	if(name == "" || name == null){
		if($("#msgErrorName").hasClass("check-text") === false) {
			$("#msgErrorName").addClass("check-text");
			$("#msgErrorName").removeClass("collect-text");
		}
		$("#msgErrorName").text("닉네임을 입력해주세요.");
	}else if(name.length > 5){
		if($("#msgErrorName").hasClass("check-text") === false) {
			$("#msgErrorName").addClass("check-text");
			$("#msgErrorName").removeClass("collect-text");
		}
		$("#msgErrorName").text("닉네임의 길이가 초과되었습니다.");
	}else if (name.search(/\s/) != -1) {
		if($("#msgErrorName").hasClass("check-text") === false) {
			$("#msgErrorName").addClass("check-text");
			$("#msgErrorName").removeClass("collect-text");
		}
		$("#msgErrorName").text("닉네임은 빈 칸을 포함 할 수 없습니다.");
    }else if (specialCheck.test(name)) {
    	if($("#msgErrorName").hasClass("check-text") === false) {
			$("#msgErrorName").addClass("check-text");
			$("#msgErrorName").removeClass("collect-text");
		}
		$("#msgErrorName").text("닉네임은 특수문자를 포함 할 수 없습니다.");
    }else if(name != null){
		if($("#msgErrorName").hasClass("collect-text") === false) {
			$("#msgErrorName").addClass("collect-text");
			$("#msgErrorName").removeClass("check-text");
		} 
		$("#msgErrorName").text("닉네임을 입력하셨습니다.");
	}
})

$("input").change(function(){
	var birth = $('#joinForm [name = userBirthYear]').val();
	var Check = $('#formCheck-1').is(":checked");
	
	if(birth == "" || birth == null){
		if($("#msgErrorBirth").hasClass("check-text") === false) {
			$("#msgErrorBirth").addClass("check-text");
			$("#msgErrorBirth").removeClass("collect-text");
		}
		$("#msgErrorBirth").text("출생연도를 입력해주세요.");
	}else if(birth < 1900 || birth > 2030){
		if($("#msgErrorBirth").hasClass("check-text") === false) {
			$("#msgErrorBirth").addClass("check-text");
			$("#msgErrorBirth").removeClass("collect-text");
		}
		$("#msgErrorBirth").text("출생연도를 정확히 입력해주세요.");
	}else if(birth != null){
		if($("#msgErrorBirth").hasClass("collect-text") === false) {
			$("#msgErrorBirth").addClass("collect-text");
			$("#msgErrorBirth").removeClass("check-text");
		} 
		$("#msgErrorBirth").text("출생연도를 입력하셨습니다.");
	}
	
	if(Check == false){
		if($("#msgErrorCheckBox").hasClass("check-text") === false) {
			$("#msgErrorCheckBox").addClass("check-text");
			$("#msgErrorCheckBox").removeClass("collect-text");
		}
		$("#msgErrorCheckBox").text("약관에 동의해주세요.");
	}else if(Check == true){
		if($("#msgErrorCheckBox").hasClass("collect-text") === false) {
			$("#msgErrorCheckBox").addClass("collect-text");
			$("#msgErrorCheckBox").removeClass("check-text");
		} 
		$("#msgErrorCheckBox").text("약관에 동의하셨습니다.");
	}
	return true;

})

$("#btn-join").on("click", function(){
	var name = $('#joinForm [name = userName]').val();
	var birth = $('#joinForm [name = userBirthYear]').val();
	var sex = $('#joinForm [name = userSex]').val();
	var Check = $('#formCheck-1').is(":checked");
	
	if(name == "" || name == null){
		alert("닉네임을 입력해주세요.");
		return false;
	}else if (name.length > 5){
		alert("5자 이하의 닉네임을 입력해주세요.")
		return false;
	}else if (name.search(/\s/) != -1) {
        alert("닉네임은 빈 칸을 포함 할 수 없습니다.");
        return false;
    }else if (specialCheck.test(name)) {
		alert("닉네임은 특수문자를 포함 할 수 없습니다.");
		return false;
    }
	
	if(birth == "" || birth == null){
		alert("생년월일을 입력해주세요.");
		return false;
	}
	
	if(sex == "" || sex == null){
		alert("성별을 입력해주세요.");
		return false;
	}
	
	if(Check == false){
		alert("약관에 동의해주세요");
		return false;
	}
	
	return true;
	
});

</script>

</html>

