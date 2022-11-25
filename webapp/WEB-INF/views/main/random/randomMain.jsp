<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0">

<title>부장님요기요</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Bold-BS4-Responsive-Pricing-Table-Snippet.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-jw.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basket-aside.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customModal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/storeInfo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/roulette.css" type="text/css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/Winwheel.js"></script>
</head>


<body>
<div id="wrapper">
    <c:import url="/WEB-INF/views/includes/aside/basketAside.jsp" />
    <div class="d-flex flex-column" id="content-wrapper" >
        <c:import url="/WEB-INF/views/includes/header.jsp" />
        <div style="height: 400px;text-align: center;background: var(--bs-white);width: 700px;margin: auto;border-radius: 50px;box-shadow: 2px 4px 15px var(--bs-blue);">
            <div style="text-align: center;padding-top: 90px;">
                <div class="col-xxl-11" style="height: 100px;width: 700px;margin-bottom: 60px;"><img src="${pageContext.request.contextPath}/assets/img/random-box.png" style="width: 100px;margin-right: 10px;"><span style="font-size: 24px;">랜덤 방식을 선택해주세요!</span>
                    <div></div>
                </div>
                <div class="col" style="width: 700px;">
                    <div class="row" style="width: 700px;margin: 0px;">
                        <div class="col" style="padding: 0px;">
                        	<button class="btn btn-primary" id="random-btn" type="button" style="width: 172px;height: 60px;">부장님 요기요의 선택</button>
                       	</div>
                       	<c:if test="${!empty(basketGroup)}">
                       		<div class="col" style="padding: 0px;">
                       			<a href="${pageContext.request.contextPath}/random/roulette" style="text-decoration:none;">
                        			<button class="btn btn-primary" type="button" style="width: 172px;height: 60px;">룰렛 돌리기</button>
                       			</a>
                   			</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
</div>
</body>

<c:import url="/WEB-INF/views/includes/storeInfo.jsp" />
<script type="text/javascript">

//랜덤 선택 클릭 > 화이팅
$("#random-btn").on("click", function(){
	if (countBasketItems(curr_basket_group) < 2) {
		alert("오늘의 점심 후보가 2개 이상일 때 이용할 수 있습니다.")
		return
	}
	
	var randomStore = Math.floor(Math.random()*(countBasketItems(curr_basket_group)))
	var randomStoreNo = basket[curr_basket_group][randomStore].storeNo
	var randomStoreName = basket[curr_basket_group][randomStore].storeName
	
	var checkGroup
	
	// curr_basket_group의 값이 0일 경우 그룹이 하나도 없을 것.
	// 그룹이 하나도 없다면 로그인/비로그인 유저 모두 그룹 명 체크를 할 필요가 없음.
	if(basket_group.length > 0){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/random/getGroupName",		
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(curr_basket_group),
			dataType : "json",
			async : false,
			success : function(result){				
				
				checkGroup = confirm("현재 선택하신 그룹이 [" + result + "] 맞습니까?");
				
				if(!checkGroup) {
					return false
				}
				
				alert("오늘 방문할 가게는 [" + randomStoreName + "] 입니다.")
				
				if(modalSelectMembers(randomStoreNo, curr_basket_group) == false){
					return false
				}
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		})
		
	}else{
		alert("오늘 방문할 가게는 [" + randomStoreName + "] 입니다.")
		alert("시간 있으시면 가입하시죠?")
	}
	
})	

</script>
</html>