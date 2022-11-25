<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title></title>
</head>


<body>
<nav id="basket-aside" class="navbar navbar-light bg-white text-center d-xxl-flex align-items-start justify-content-xxl-center sidebar accordion p-0">
    <div class="container-fluid d-flex flex-column p-0">
        <div id="bujang-logo-wrap">
        	<a href="${pageContext.request.contextPath}/"><img data-bss-hover-animate="pulse" id="bujang-logo-blue" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png"></a>
        </div>
        
        <div id="comment-box">
        	<span id="eat-what" class="d-inline-block">오늘 점심 뭐 먹지?</span>
        	<span id="prefer-data" class="d-inline-block">
        	<!--  
        		<span class="d-inline-block emphasize-blue">${authUser.userName}</span>
        		<span class="d-inline-block">님은 패스트푸드를 좋아하시니까!</span>
        	-->
        		<span class="d-inline-block">오늘도 점심은 부장님요기요</span>
        	</span>
        </div>
        
        <c:if test="${empty(authUser)}">
         <div id="basket-aside-login-area">
         	<span class="d-inline-block" id="login-jebal">로그인을 하면 취향에 맞는 식당을 추천해드려요</span>
         	<a href="${pageContext.request.contextPath}/login"><span class="d-inline-block" id="basket-login-btn">로그인하기</span></a>
         
             <div id="basket-login-controll">
             	<a href="${pageContext.request.contextPath}/join"><span class="d-inline-block" id="basket-join-link">회원가입</span></a>
             	<a href="${pageContext.request.contextPath}/findPW"><span class="d-inline-block" id="basket-findpw-link">비밀번호 찾기</span></a>
             </div>
         </div>
        </c:if>
        
        <div id="basket-aside-content" class="full-box">
             <div class="text-start d-flex basket-aside-title" id="basket-title-group">
             	<span class="d-inline-block">룰렛 그룹</span>
             </div>
             
             <div class="d-flex" id="basket-groups">
             	<!--  회원이 속한 그룹이 올 자리  -->
				<div class="basket-group basket-selected-group basket-normal-group">
					<span>${groupName}</span>
					<i class="fas fa-user-circle"></i>
				</div>	

             </div>
            
            <div class="text-start d-flex basket-aside-title" id="basket-title-lunch-candidates">
            	<span class="d-inline-block">오늘의 점심 후보</span>
            </div>
            
            <div class="table-responsive" id="basket-table">
                <table class="table" id="basket-table-table">
	                <!--  장바구니 아이템이 올 자리 -->
	                <c:forEach var="basket" items="${basketInfo}">
                		<tr class="basket-table-row" data-storeNo="${basket.storeNo}">
                			<td class="d-xxl-flex justify-content-xxl-start basket-table-cell">
                				<div class="basket-table-store-info">
                					<span class="text-start basket-table-store-name">${basket.storeName}</span>
                					<span class="text-start basket-table-store-detail">${basket.menu2ndCateName}&nbsp;/&nbsp;${basket.distance}m</span>
                				</div>
                			</td>
                		</tr>
	                </c:forEach>
                </table>
            </div>
        </div>
    </div>
</nav>

<c:import url="/WEB-INF/views/main/random/randomStoreInfo.jsp" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e74b599be710b798192fd5221284718a&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script type="text/javascript">
	
////////////////////////////////////// 대략 위치 ///////////////////////////////////////////////

// 페이지로드: 212
// gps: 232
// 장바구니 카테고리 필터: 350
// 로딩 초기 사용자 그룹 + 장바구니 정보 불러오기: 476 
// 그룹 관련: 546
// 장바구니 관련: 675
// 투표하기 + 랜덤선택 버튼: 984
// 기타: 1085


/////////////////////////// 전역변수 //////////////////////////////////////////////////////////

// index와 연결된 장바구니인지(모달 팝업 관련 필요)
let indexJSP = false

//userNo
const userNo = "${authUser.userNo}" 
// 장바구니(Map<Integer, List<StoreVo>: key - storeNo / value - StoreVo(이거저거 많이 들어있음))
let basket = "${basket}" 

// 현재 위치	
let gpsVo = { 
		gpsX : "${curr_location.gpsX}", // 경도
		gpsY : "${curr_location.gpsY}", // 위도
		address : "${curr_location.address}" // 주소(일단 지번으로)
	}
		

/////////////////////// 페이지 로드 시 ////////////////////////////////////////////////////////////

$(document).ready(
	async function(){
		// 현재 위치 확인
		await callGPS() 
		
		if (indexJSP) {
			// 지도 로딩
		}
})


/////////////////// gps //////////////////////////////////////////////////////////////////////////////////

// 세션에 GPS 저장되어있으면 float로 불러오고, 없으면 찾아서 세션에 저장하는 함수 
async function callGPS() {
	sleep(300)
	console.log(gpsVo.gpsX)
	console.log(gpsVo.gpsY)
	
	// 세션에 저장된 gps 정보가 없다면
	if (gpsVo.gpsX == "" || gpsVo.gpsX == 0.0) {
		// geolocation으로 현재 좌표 알아내기
		await curr_location()
					
		// 세션에 현재 gps 저장
		await setGPS(gpsVo)
		
	} else {
		gpsVo.gpsX = parseFloat(gpsVo.gpsX)
		gpsVo.gpsY = parseFloat(gpsVo.gpsY)
	}
	
	console.log(gpsVo)
	console.log("callGPS() 종료")
} 


// geolocation 이용해서 현재 위치 불러오고, 지번주소까지 알아내는 함수
async function curr_location() {
	document.cookie="safeCookie1=foo; SameSite=Lax";
	document.cookie="safeCookie2=foo";
	document.cookie="crossCookie=bar; SameSite=None; Secure";
	
	var options = {enableHighAccuracy: true} // geoocation 위치 정확도
	
	let getPosition = async function(options) {
		return new Promise(function (resolve, reject) {
			navigator.geolocation.getCurrentPosition(resolve, reject, options)
		})
	}
	
	await getPosition()
		.then((position) => {
			console.log("geolocation")
	    	var gpsX = position.coords.longitude // 경도 저장
	    	var gpsY = position.coords.latitude // 위도 저장
	    	gpsVo.gpsX = parseFloat(gpsX)
	    	gpsVo.gpsY = parseFloat(gpsY)
		})
		.catch((error) => { // 현재 위치 confirm 거절한 경우
			alert("GPS 사용을 허용해주세요")
		})
			
	console.log(gpsVo.gpsX)
	console.log(gpsVo.gpsY)
	
	// 카카오 API로 주소 알아내기
    await getAddr(gpsVo.gpsY, gpsVo.gpsX)
			
	console.log("curr_location() 종료")
}


// 위도경도 > 지번주소 변환하는 카카오 api(파라미터 : 위도, 경도)
async function getAddr(lat, lng) {
	console.log("getAddr() 시작")
	let geocoder = new kakao.maps.services.Geocoder()
	
	let addressSearch = (lat, lng) => {
		return new Promise((resolve, reject) => {
			geocoder.coord2Address(lng, lat, (result, status) => {
				if (status === kakao.maps.services.Status.OK) {
					gpsVo.address = result[0].address.address_name // 주소 획득
					console.log(gpsVo.address)
										
					if (!$('#modal-location-change').is(':visible')) { // 위치 변경 모달 열려있다면
						$("#curr-location-address").text(result[0].address.address_name)
						
					} else {
						$("#modal-curr-location").text(result[0].address.address_name)
						
					}
					resolve(result[0].address.address_name)
					
				} else {
					reject('geocoder error')
				}
			})
		})
	}	
	
	await addressSearch(lat, lng)
}


// 세션에 gps 값 저장하기
async function setGPS(gpsVo) {		
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/setGPS",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(gpsVo),
		dataType : "json",
		async : false,
		success : function(result){
			if (result) {
				console.log("gps 저장")
			} else {
				console.log("gps 저장 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
	console.log("setGPS() 종료")
}





//////////////////////////// 기타 //////////////////////////////////////////////////////////////////////

// sleep
async function sleep(ms) {
	let start = Date.now(), now = start
    while (now - start < ms) {
        now = Date.now()
    }
}
	
</script>

</body>

</html>