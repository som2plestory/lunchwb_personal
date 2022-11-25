<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>회원정보 수정</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/group.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
    <!-- js -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
	
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
                            <div class="mb-0" style = "width: 1071px;">
                                <div class="col-md-8 col-xl-6 text-center mx-auto" style = "width: 535px;">
                                    <h2 style="font-weight: bold; width: 512px;">회원 정보 수정</h2>
                                </div>
                            </div>
                            <div class="d-flex justify-content-center" style = "width: 1071px;">
                                <div class="col-md-6 col-xl-4 col-xxl-5" style = "width: 448px;">
                                    <div class="p-5" style = "width: 423px;">
                                        <div class="text-center"></div>
                                        <form method="post" action="${pageContext.request.contextPath}/user/modifyUser" class="user" id="updateForm">
                                            <div class="mb-3 fix-330">
                                            	<strong class="join-text fix-330">아이디</strong>
                                            	<input id="infoEmail" class="form-control form-control-user input-box btn-radius fix-330" name = "userEmail" value="${userInfo.userEmail}"readonly>
                                           	</div>
                                            <div class="mb-3 fix-330 password">
                                            	<strong class="join-text fix-330">새 비밀번호</strong>
                                            	<input class="form-control form-control-user input-box btn-radius fix-330" type="password" id="inputPassword" placeholder="비밀번호를 입력해주세요." name="userPassword">
                                            	<span class="check-text fix-330" id="msgErrorPassword">8자리 이상의 비밀번호를 작성해주세요.</span>
                                           	</div>
                                            <div class="mb-3 fix-330 password">
                                            	<strong class="join-text fix-330">새 비밀번호 확인</strong>
                                            	<input class="form-control form-control-user input-box btn-radius fix-330" type="password" id="checkPassword" placeholder="비밀번호를 한 번 더 입력해주세요." name="checkPassword">
                                            	<span class="check-text fix-330" id="msgErrorCheckPassword">비밀번호를 입력해주세요.</span>
                                           	</div>
                                            <div class="mb-3 fix-330 name">
                                            	<strong class="join-text fix-330">닉네임</strong>
                                            	<input class="form-control form-control-user input-box fix-330" type="text" id="inputJoinNickname" placeholder="사용하실 닉네임을 입력해주세요. (5자 이하)" value="${userInfo.userName}" name="userName">
												<span class="collect-text fix-330" id="msgErrorName">닉네임을 입력하셨습니다.</span>
                                           	</div>
                                            <div class="mb-3">
                                            	<strong class="join-text fix-330">출생연도</strong>
                                            	<input id=inputBirthDate type="number" value="${userInfo.userBirthYear}" name="userBirthYear" placeholder="출생연도를 적어주세요." min="1900" max="2100">
                                            	<br>
                                            	<span class="collect-text fix-330" id="msgErrorBirth">출생연도를 입력하셨습니다.</span>
                                           	</div>
                                            <div class="mb-3"><strong class="join-text fix-330">성별</strong>
                                            	<select class="form-select gender-box" style="width: 150px;height: auto;" name="userSex">
                                            		<option value="male" <c:if test="${userInfo.userSex eq 'male' }">selected</c:if>>남자</option>
                                                   	<option value="female" <c:if test="${userInfo.userSex eq 'female' }">selected</c:if>>여자</option>
                                                </select>
                                            </div>
                                            <div class="mb-3 fix-330">
                                            	<button class="btn btn-primary d-block btn-user w-100 btn-radius" id="btn-submit" type="submit">수정하기</button>
                                           	</div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>

<script type="text/javascript">
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?.]/gi;

$(".password").change(function(){
	var password = $('#updateForm [name = userPassword]').val();
	var checkPassword = $('#updateForm [name = checkPassword]').val();
	
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
	var name = $('#updateForm [name = userName]').val();
	
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
	var birth = $('#updateForm [name = userBirthYear]').val();
	var sex = $('#updateForm [name = userSex]').val();
	
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
	return true;
})


$("#btn-submit").on("click", function(){
	
	var password = $('#updateForm [name = userPassword]').val();
	var checkPassword = $('#updateForm [name = checkPassword]').val();
	var name = $('#updateForm [name = userName]').val();
	var birth = $('#updateForm [name = userBirthYear]').val();
	var sex = $('#updateForm [name = userSex]').val();
	
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
		alert("출생연도를 입력해주세요.");
		return false;
	}
	
	if(sex == "" || sex == null){
		alert("성별을 입력해주세요.");
		return false;
	}
	//return true;
});

</script>



</html>

