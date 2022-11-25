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
                            <div class="col-lg-6 col-xxl-12" style="width:600px height:720px">
                                <div class="p-5" style="width:480px height:720px">
                                    <div class="text-center">
                                        <h4 class="text-dark mb-4 fix-480" style="font-weight:bold">회원가입</h4>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/join" class="user" id="joinForm" style="width:480px height:720px">
                                        <div class="mb-3 fix-480" id="email">
                                        	<strong class="join-text">아이디</strong>
                                        	<input class="form-control form-control-user" type="email" id="inputJoinEmail" aria-describedby="emailHelp" placeholder="이메일을 입력해주세요." name="userEmail">
                                        	<button class="btn btn-primary" id="check-email" type="button">중복 확인</button>
                                        	<span class="check-text" id="msgErrorEmail"><br>이메일 형식으로 입력해주세요.</span>
                                        	<span class="check-text" id="msgOverlapEmail"><br></span>
                                        	
                                       	</div>
                                        <div class="mb-3 fix-480 password" >
                                        	<strong class="join-text">비밀번호</strong>
                                        	<input class="form-control form-control-user input-box" type="password" id="inputJoinPassword" placeholder="비밀번호를 입력해주세요." name="userPassword">
                                        	<span class="check-text" id="msgErrorPassword">8자리 이상의 비밀번호를 작성해주세요.</span>
                                       	</div>
                                        <div class="mb-3 fix-480 password">
                                        	<strong class="join-text">비밀번호 확인</strong>
                                        	<input class="form-control form-control-user input-box" type="password" id="checkJoinPassword" placeholder="비밀번호를 한 번 더 입력해주세요." name="checkPassword">
                                        	<span class="check-text" id="msgErrorCheckPassword">비밀번호를 입력해주세요.</span>
                                       	</div>
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
                                        	<button class="btn btn-primary d-block btn-user w-100 fix-480" id="btn-join" type="submit">가입하기</button>
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

var idChk;

var engCheck = /[a-z]/;
var numCheck = /[0-9]/;
var specialCheckEmail = /[`~!#$%^&*|\\\'\";:\/?]/gi;
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?.]/gi;

$("#check-email").on("click", function(){
	
	var id = $('[name = "userEmail"]').val();
	
	if($("#msgErrorEmail").text() != "") {
		if($("#msgOverlapEmail").hasClass("check-text") === false) {
			$("#msgOverlapEmail").addClass("check-text");
			$("#msgOverlapEmail").removeClass("collect-text");
		}
		$("#msgOverlapEmail").html("<br>사용할 수 없는 이메일입니다.");
	}else{
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
					$("#msgOverlapEmail").html("<br>사용할 수 있는 이메일 입니다.");
					idChk = id;
				}else {
					if($("#msgOverlapEmail").hasClass("check-text") === false) {
						$("#msgOverlapEmail").addClass("check-text");
						$("#msgOverlapEmail").removeClass("collect-text");
					}
					$("#msgOverlapEmail").html("<br>이미 사용중인 이메일 입니다.");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		}); 
	}
 	
});
	
	
$("#email").change(function(){
	var id = $('#joinForm [name = userEmail]').val();
	if(id=="" || id == null){
		$("#msgOverlapEmail").html("");
		$("#msgErrorEmail").html("<br>이메일 형식으로 입력해주세요.");
	}else if (id.search(/\s/) != -1) {
		$("#msgOverlapEmail").html("");
		$("#msgErrorEmail").html("<br>이메일은 빈 칸을 포함 할 수 없습니다.");
	}else if (specialCheckEmail.test(id)) {
    	$("#msgOverlapEmail").html("");
 		$("#msgErrorEmail").html("<br>@와 .을 제외한 특수문자를 포함 할 수 없습니다.");
	}else{
 		$("#msgErrorEmail").text("");
	}
})

$(".password").change(function(){
	var password = $('#joinForm [name = userPassword]').val();
	var checkPassword = $('#joinForm [name = checkPassword]').val();
	
	if(password =="" || password == null){
		if($("#msgErrorPassword").hasClass("check-text") === false) {
			$("#msgErrorPassword").addClass("check-text");
			$("#msgErrorPassword").removeClass("collect-text");
		}
		$("#msgErrorPassword").text("8자리 이상의 비밀번호를 작성해주세요.");
	}else if(password.length >= 8){
		if($("#msgErrorPassword").hasClass("collect-text") === false) {
			$("#msgErrorPassword").addClass("collect-text");
			$("#msgErrorPassword").removeClass("check-text");
		} 
		$("#msgErrorPassword").text("사용 가능한 비밀번호 입니다.");
	}
	
	if(password == null){
		if($("#msgErrorCheckPassword").hasClass("check-text") === false) {
			$("#msgErrorCheckPassword").addClass("check-text");
			$("#msgErrorCheckPassword").removeClass("collect-text");
		}
		$("#msgErrorCheckPassword").text("비밀번호를 입력해주세요.");
	}else if(password != checkPassword){
		if($("#msgErrorCheckPassword").hasClass("check-text") === false) {
			$("#msgErrorCheckPassword").addClass("check-text");
			$("#msgErrorCheckPassword").removeClass("collect-text");
		}
		$("#msgErrorCheckPassword").text("비밀번호가 일치하지 않습니다.");
	}else if(password == checkPassword && password != null && password.length >= 8){
		if($("#msgErrorCheckPassword").hasClass("collect-text") === false) {
			$("#msgErrorCheckPassword").addClass("collect-text");
			$("#msgErrorCheckPassword").removeClass("check-text");
		} 
		
		$("#msgErrorCheckPassword").text("비밀번호가 일치합니다.");
	}
})

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
	var sex = $('#joinForm [name = userSex]').val();
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
	
	var id = $('#joinForm [name = userEmail]').val();
	var password = $('#joinForm [name = userPassword]').val();
	var checkPassword = $('#joinForm [name = checkPassword]').val();
	var name = $('#joinForm [name = userName]').val();
	var birth = $('#joinForm [name = userBirthYear]').val();
	var sex = $('#joinForm [name = userSex]').val();
	var Check = $('#formCheck-1').is(":checked");
		
	if(id=="" || id == null){
		alert("이메일을 확인해주세요.");
		/* $("#msgErrorEmail").text("아이디를 입력해주세요."); */
		return false;
	}else if (id.search(/\s/) != -1) {
        alert("이메일은 빈 칸을 포함 할 수 없습니다.");
        return false;
     }else if (specialCheckEmail.test(id)) {
		alert("@와 .을 제외한 특수문자를 포함 할 수 없습니다.");
 		return false;
     }
	
	
	if(idChk != id){
		alert("이메일 중복 확인을 다시 해주세요.");
		/* $("#msgCheckOverlap").text("id 중복 확인을 다시 해주세요"); */
		return false;
	}
	
	if(password =="" || password == null){
		alert("비밀번호를 확인해주세요.");
		return false;	
	}else if (password.length < 8){
		alert("8자리 이상의 비밀번호를 작성해주세요.");
		return false;	
	}
	
	if(password != checkPassword){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
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