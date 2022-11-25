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
        		<span class="d-inline-block"><c:if test="${!empty(authUser)}"><span class="emphasize-blue">${authUser.userName}</span>님&nbsp;</c:if>오늘도 점심은 부장님요기요</span>
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
        	<c:if test="${!empty(authUser)}">
             <div class="text-start d-flex basket-aside-title" id="basket-title-group">
             	<span class="d-inline-block">나의 그룹</span>
             </div>
             
             <div class="d-flex" id="basket-groups">
             	<!--  회원이 속한 그룹이 올 자리  -->
             	<c:if test="${!empty(basketGroup)}">
					<c:forEach var="myGroup" items="${basketGroup}">
						<c:if test="${myGroup.groupNo == curr_basket_group}">
							<div class="basket-group basket-selected-group basket-normal-group" data-groupNo="${myGroup.groupNo}">
								<span>${myGroup.groupName}</span>
								<i class="fas fa-user-circle"></i>
							</div>	
						</c:if>
						
						<c:if test="${myGroup.groupNo != curr_basket_group}">
							<div class="basket-group basket-normal-group" data-groupNo="${myGroup.groupNo}">
								<span>${myGroup.groupName}</span>
								<i class="fas fa-user-circle"></i>
							</div>	
						</c:if>
					</c:forEach>
             	</c:if>

             	<c:if test="${empty(basketGroup) or fn:length(basketGroup) < 4}">
						<div class="basket-group basket-group-add"><span>그룹추가</span><i class="fas fa-user-plus"></i></div>	
				</c:if>
             </div>
            </c:if>
            
            <div class="text-start d-flex basket-aside-title" id="basket-title-lunch-candidates">
            	<span class="d-inline-block">오늘의 점심 후보</span>
            </div>
            
            <div class="table-responsive" id="basket-table">
                <table class="table" id="basket-table-table">
	                <tr>
	                    <td id="basket-table-button-area" colspan="2">
	                    	<i class="fas fa-filter" id="basket-filter-btn" title="메뉴 필터"></i>
	                    	<button class="btn btn-primary d-inline-block" id="basket-another-stores-btn" type="button">다른 가게 추천 받기</button>
	                    </td>
	                </tr>
	                <!--  장바구니 아이템이 올 자리 -->
	                <c:if test="${!empty(basket)}">
		                <c:forEach var="basketItems" items="${basket}">
		                	<c:if test="${basketItems.key == curr_basket_group}">
		                		<c:set var="basketCnt" value="0" />
		                		<c:set var="stores" value="${basketItems.value}" />
		                		
		                		<c:forEach var="store" items="${stores}">
		                			<c:if test="${store.stored}">
		                				<c:set var="basketCnt" value="${basketCnt + 1}" />
		                				
				                		<tr class="basket-table-row" data-storeNo="${store.storeNo}">
				                			<td class="d-xxl-flex justify-content-xxl-start basket-table-cell">
				                				<div class="basket-table-store-info">
				                					<span class="text-start basket-table-store-name">${store.storeName}</span>
				                					<span class="text-start basket-table-store-detail">${store.menu2ndCateName}&nbsp;/&nbsp;${store.distance}m</span>
				                				</div>
				                			</td>
				                			<td class="basket-table-del-cell"><i class="fas fa-minus-circle d-xxl-flex basket-del-btn"></i></td>
				                		</tr>
				                		
			                		</c:if>
			                	</c:forEach>
			                	
			                	<c:if test="${basketCnt == 0}">
			                		<tr id="no-basket-items">
                                		<td id="basket-no-items" colspan="2">점심 후보를 추가해주세요</td>
                            		</tr>
			                	</c:if>
			                </c:if>
		                </c:forEach>
	                </c:if>
                </table>
            </div>
            

            <div id="basket-button-area">
            	<c:if test="${!empty(authUser)}">
            		<button class="btn btn-primary" id="basket-vote-btn" type="button">투표하기</button>
            	</c:if>
            	<a href="${pageContext.request.contextPath}/random" style="text-decoration:none;">
            		<button class="btn btn-primary" id="basket-random-btn" type="button">랜덤선택</button>
           		</a>
            </div>
        </div>
    </div>
</nav>

<div class="modal fade row-cols-md-6 md" role="dialog" tabindex="-1" id="modal-recFilter">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header text-primary modal-header-custom">
            	<span>제외하고 싶은 음식은 체크를 해제해주세요&nbsp;<i class="fas fa-check"></i></span>
            	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body text-center text-dark" style="font-size: 14px;">
                <div class="text-start" id="modal-recFilter-btn-area">
                	<button class="btn btn-primary" id="modal-recFilter-addAll" type="button">전체선택</button>
                	<button class="btn btn-primary" id="modal-recFilter-delAll" type="button">전체해제</button>
                </div>
            
                <div class="row">
                    <div class="col" style="border-right: 1px solid voar(--bs-gray-200);">
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-1"><label class="form-check-label" for="formCheck-1">뷔페</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-2"><label class="form-check-label" for="formCheck-2">아시아음식</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-3"><label class="form-check-label" for="formCheck-3">양식</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-4"><label class="form-check-label" for="formCheck-4">일식</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-5"><label class="form-check-label" for="formCheck-5">한식</label></div>
                    </div>
                    <div class="col" style="border-right: 1px solid voar(--bs-gray-200);">
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-6"><label class="form-check-label" for="formCheck-6">패스트푸드</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-7"><label class="form-check-label" for="formCheck-7">패밀리레스토랑</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-8"><label class="form-check-label" for="formCheck-8">치킨</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-9"><label class="form-check-label" for="formCheck-9">분식</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-10"><label class="form-check-label" for="formCheck-10">중식</label></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center modal-footer-custom">
            	<button id="modal-filter-submit" class="btn btn-primary" type="button">저장</button>
            	<button id="modal-filter-dismiss" class="btn btn-light" type="button" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<c:set var="URI" value="${pageContext.request.requestURI}" />
<c:if test="${URI == '/lunchwb/WEB-INF/views/main/index.jsp'}">
	<c:import url="/WEB-INF/views/includes/storeInfo.jsp" />
</c:if>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e74b599be710b798192fd5221284718a&libraries=services"></script>

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

// 내가 속한 그룹 리스트(List<GroupVo> : groupNo, groupName 들어있음)
let basket_group = [] 
//현재 선택 그룹(groupNo)
let curr_basket_group = 0 

//제외된 메뉴 카테고리(List<Integer>: menu_1st_cate_no 들어있음)
let filter_excluded = "${filter_excluded}" 

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
		
		// 메뉴 제외 필터 확인
		await callFilter() 
		
		// 사용자 그룹 정보 + 장바구니 확인
		await callUser() 
		
		if (indexJSP) {
			// 지도 로딩
			await callMap()
		}
})


/////////////////// gps //////////////////////////////////////////////////////////////////////////////////

// 세션에 GPS 저장되어있으면 float로 불러오고, 없으면 찾아서 세션에 저장하는 함수 
async function callGPS() {
	sleep(300)
	
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
	    	var gpsX = position.coords.longitude // 경도 저장
	    	var gpsY = position.coords.latitude // 위도 저장
	    	gpsVo.gpsX = parseFloat(gpsX)
	    	gpsVo.gpsY = parseFloat(gpsY)
		})
		.catch((error) => { // 현재 위치 confirm 거절한 경우
			alert("GPS 사용을 허용해주세요")
		})
	
	// 카카오 API로 주소 알아내기
    await getAddr(gpsVo.gpsY, gpsVo.gpsX)
}


// 위도경도 > 지번주소 변환하는 카카오 api(파라미터 : 위도, 경도)
async function getAddr(lat, lng) {
	let geocoder = new kakao.maps.services.Geocoder()
	
	let addressSearch = (lat, lng) => {
		return new Promise((resolve, reject) => {
			geocoder.coord2Address(lng, lat, (result, status) => {
				if (status === kakao.maps.services.Status.OK) {
					gpsVo.address = result[0].address.address_name // 주소 획득
										
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
			if (!result) {
				console.log("gps 저장 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


///////////////// 장바구니 필터 /////////////////////////////////////////////////////////////////////////////////

// 세션에 필터가 없으면 생성해주고, 있으면 불러와서 파싱하는 함수
async function callFilter() {
	if (filter_excluded == "") { // 세션에 필터가 없다면 만들어서 저장
		await makeFilterSession()
					
	} else { // 세션에 필터가 있다면 list로 변환
		var temp1 = "${filter_excluded}"
		var temp2 = temp1.substring(1, temp1.length-1)
		filter_excluded = temp2.split(",")	
		
		for (var i = 0; i < filter_excluded.length; i++) {
			filter_excluded[i] = parseInt(filter_excluded[i])
		}
	}
}


// 세션에 새로 만든 빈 필터 저장하는 함수
async function makeFilterSession() {
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/makeFilterSession",		
		type : "post",
		contentType : "application/json",
		async : false,
		dataType : "json",
		success : function(result){
			if (result) {
				filter_excluded = []
			} else {
				console.log("필터 세션 생성 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


// 장바구니 필터 클릭 하면 작동 > 모달 체크박스 세션값과 동일하게 셋팅
$("#basket-filter-btn").on("click", function(){
	for (var i = 1; i <= 10; i++) {
		var curr = "#formCheck-" + String(i)
		
		if (filter_excluded.includes(i)) {
			$(curr).prop("checked", false)
		} else {
			$(curr).prop("checked", true)
		}
	}
	$("#modal-recFilter").modal("show")
})


// 필터 전체 선택 클릭 시
$("#modal-recFilter-addAll").on("click", function() {
	for (var i = 1; i <= 10; i++) {
		var curr = "#formCheck-" + String(i)
		$(curr).prop("checked", true)
	}
})


// 필터 전체 제외 클릭 시
$("#modal-recFilter-delAll").on("click", function() {
	for (var i = 1; i <= 10; i++) {
		var curr = "#formCheck-" + String(i)
		$(curr).prop("checked", false)
	}
})


// 장바구니 필터 적용 클릭 > 변경된 사항 세션 저장
$("#modal-filter-submit").on("click", function() {
	let temp_filter = filter_excluded
	filter_excluded = []
			
	for (var i = 1; i <= 10; i++) {
		var curr = "#formCheck-" + String(i)
		
		if (!$(curr).is(":checked")) {
			filter_excluded.push(i)
		}
	}
		
	if (filter_excluded.length == 10) { // 추천에 포함할 카테고리를 하나도 선택 안했으면
		alert("적어도 하나의 카테고리를 선택해야 합니다")
		filter_excluded = temp_filter
			
		return false
	}		
	
	// 변경된 필터 세션에 저장
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/saveFilterSession",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(filter_excluded),
		async : false,
		dataType : "json",
		success : function(result){
			if (!result) {
				console.log("필터 세션 저장 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
	
	$("#modal-recFilter").modal("hide")
})


/////////////// 사용자 //////////////////////////////////////////////////////////////////////////////

// 페이지 로딩 초기 그룹 확인 + 장바구니 확인
async function callUser() {	
	if (userNo == "") {		
		if ("${curr_basket_group}" == ""){ // 세션에 curr_basket_group = 0 저장
			await setSessionBasketGroup()
		}
		
		if (basket == "") {				
			await makeGuestBasket() // 장바구니 생성
			
		} else {
			await loadBasket() // 장바구니 불러오기
			
		}
		
	} else {		
		// curr_basket_group 세션 값이 있다면
		if ("${curr_basket_group}" != "" && "${curr_basket_group}" != "0") {
			curr_basket_group = parseInt("${curr_basket_group}") // 세션에 저장된 curr_basket_group 가져오기
		} 
		
		// 그룹 생성 + 삭제시 curr_bakset_group 바뀌면 true되는 변수
		let groupChanged = false 
		
		// 내가 속한 그룹 정보 가져오기
		groupChanged = await getBasketGroups()
								
		if (basket == "") { // 세션에 저장된 값이 없고 지금 처음 불러오는 경우
			$("[data-groupNo=" + String(curr_basket_group) + "]").addClass("basket-selected-group")
			
			// 장바구니 생성
			await makeGroupBasket() 
		
		} else { // 이미 세션에 저장된 basketGroup이 있는 경우
			// 장바구니 불러오기
			await loadBasket() 
			
			// 그룹 삭제 or 추가때문에 curr_basket_group이 변경되야하는 경우 장바구니 변경
			if (groupChanged && curr_basket_group != 0) {				
				for (var i = 0; i < basket[curr_basket_group].length; i++) {
					if (basket[curr_basket_group][i].stored) {
						addToBasket(basket[curr_basket_group][i])
					}
				}
			}
		}
	}
}
	

////////////////////// 그룹 ////////////////////////////////////////////////////////////////////////////////////

// 장바구니 그룹 목록 불러오기
async function getBasketGroups() {
	var change = true // curr_basket_group 수정 여부 확인
	
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/getBasketGroup",		
		type : "post",
		async : false,
		contentType : "application/json",
		data : JSON.stringify(userNo),
		dataType : "json",
		success : async function(basketGroup){				
			// 나 편하려고 basketGroup 세션에서 가져와서 파싱, 저장
			for (var i = 0; i < basketGroup.length; i++) {
				basket_group.push(basketGroup[i])
				
				// curr_basket_group에 아직도 속해있다면 변경사항 없음 확인
				if (basketGroup[i].groupNo == curr_basket_group) {
					change = false
				}
			}
			
			if (basket_group.length == 0) { // 속한 그룹이 하나도 없으면 curr_basket_group 임시로 0번
				curr_basket_group = 0
				
			} else if (change) { // curr_basket_group 없어졌으면 제일 앞에 있는 그룹을 curr_basket_group으로 변경
				curr_basket_group = basketGroup[0].groupNo	
				$("[data-groupNo=" + String(curr_basket_group) + "]").addClass("basket-selected-group")
			}
			
			// 세션에 저장된 curr_basket_group이랑 실제랑 다르면 세션에 다시 저장
			if ("${curr_basket_group}" != String(curr_basket_group)) {
				await setSessionBasketGroup()
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
		
	return change
}


// 다른 그룹 클릭할 때 css 변경 + 장바구니 다시 로딩
$("#basket-groups").on("click", ".basket-normal-group", async function(){	
	// 클릭한 그룹이 현재 curr_basket_group과 다른 경우에만
	if (String(curr_basket_group) != $(this).attr("data-groupNo")) { 	
		var url = document.location.href
		url = url.substr(url.indexOf("/lunchwb/")+9)

		if (!indexJSP && url.indexOf("vote") != -1) {  // 투표나 랜덤 작업 중일 때 confirm으로 경고
			var voteGroupChange = confirm("그룹을 변경하면 진행상황이 초기화됩니다. 변경하시겠습니까?")
			
			if(!voteGroupChange) {
				return false
			}
		}
		
		// css 변경
		$("[data-groupNo=" + String(curr_basket_group) + "]").removeClass("basket-selected-group")
		$(this).addClass("basket-selected-group")
		
		// 핀 제거
		if (indexJSP) {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null)
				overlays[i].setMap(null)
			}
			
			markers = []
			overlays = []
		}
		
		// curr_basket_group 변경
		curr_basket_group = parseInt($(this).attr("data-groupNo"))
		
		// 세션에 바뀐 curr_basket_group 저장
		await setSessionBasketGroup()
		
		// 장바구니 교체 작업
		await changeGroupBasket()
		
		// 투표나 랜덤 페이지에서
		if (!indexJSP) {
			// 장바구니 아이템이 2개 미만이면 메인으로 이동해버림
			if (countBasketItems(curr_basket_group) < 2) {
				location.replace("${pageContext.request.contextPath}/")
			
			// 장바구니가 충분히 차있으면 해당 그룹 + 장바구니에 대한 투표/랜덤 페이지로 이동 ****** 랜덤은 경우 더 생각해봐야 할 듯 ************
			} else {						
				location.replace("${pageContext.request.contextPath}/" + url)
			}
		}
	}
})	


// 세션에 현재 선택한 curr_basket_group 저장하는 함수
async function setSessionBasketGroup() {
	var data_group = {"curr_basket_group": curr_basket_group}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/setSessionBasketGroup",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data_group),
		dataType : "json",
		async : false,
		success : function(result){				
			if (!result) {
				console.log("현재 그룹 세션 저장 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})	
}


// 그룹추가 버튼 클릭 > 해당 페이지로 이동
$("#basket-groups").on("click", ".basket-group-add", function(){
	location.replace("${pageContext.request.contextPath}/group/add")
})
	

/////// 장바구니 ///////////////////////////////////////////////////////////////////////////////////////

// 비회원 장바구니 새로 생성하기
async function makeGuestBasket() {
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/guestMakeBasket",		
		type : "post",
		contentType : "application/json",
		async : false,
		dataType : "json",
		success : function(result){	
			basket = result // 전역변수에 장바구니 저장
			
			// 추천목록에 담긴 항목 표시하기
			if (result[0].length != 0) {							
				for (var i = 0; i < 3; i++) {
					addToBasket(basket[0][i])
				}
				
			} else { // 장바구니에 담을 수 있는 가게가 없다면 사용자에게 알려주기
				alert("현재 위치에서 추천 가능한 가게가 없습니다.")
				
				noStore()
				basketNoItem()					
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


// 회원 장바구니 새로 생성하기
async function makeGroupBasket() {
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/groupMakeBasket",		
		type : "post",
		contentType : "application/json",
		async : false,
		data : JSON.stringify(basket_group),
		dataType : "json",
		success : function(result){	
			basket = result // 전역변수에 저장
			
			// 현재 선택 그룹 추천목록에 항목 표시
			if (result[curr_basket_group].length != 0) {							
				for (var i = 0; i < 3; i++) {
					addToBasket(basket[curr_basket_group][i])
					
				}
				
			} else { // 추천 가능한 가게가 없으면 알려줌
				alert("현재 위치에서 추천 가능한 가게가 없습니다.")
				
				noStore()
				basketNoItem()					
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


// 세션에 존재하는 장바구니 불러오기
async function loadBasket() {
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/loadBasket",		
		type : "post",
		async : false,
		success : function(result){				
			basket = result			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})	
}


// 점심후보 항목 추가할 때 HTML 그려주는 함수
function addToBasket(store) {
	$("#basket-table-table").append(
		  "<tr class='basket-table-row' data-storeNo='" + store.storeNo + "'>"
           + 	"<td class='d-xxl-flex justify-content-xxl-start basket-table-cell'>"                    
           + 		"<div class='basket-table-store-info'><span class='text-start basket-table-store-name'>" + store.storeName + "</span><span class='text-start basket-table-store-detail'>" + store.menu2ndCateName + " / " + store.distance + "m</span></div>"                        
           + 	"</td>"                    
           + 	"<td class='basket-table-del-cell'><i class='fas fa-minus-circle d-xxl-flex basket-del-btn'></i></td>"                    
           + "</tr>"
	)
}


// 다른 가게 추천받기 버튼 클릭 > 가능하면 추가 가게 받아오기
$("#basket-another-stores-btn").on("click", async function(){
	if (!indexJSP) { // 투표나 랜덤에서 클릭했다면
		var realRecommend = confirm("메인으로 이동하시겠습니까? 현재 진행상황은 저장되지 않습니다.")
		
		if (!realRecommend) {
			
			return false
		}
	}
	
	// 장바구니 항목이 이미 15개인 경우
	if (basket[curr_basket_group].length >= 15) {
		alert("가게 추천은 15개까지만 가능합니다")
		
		return
	}
	
	// 장바구니에 추가할 항목 가져오기
	await addMoreStore()
		
	if (!indexJSP) { // 투표나 랜덤에 있었다면 메인으로 돌아가서 보여줌
		location.replace("${pageContext.request.contextPath}/")
	}
})


// 장바구니에 추가할 가게 백엔드에서 받아오는 함수
async function addMoreStore() {	
	var temp = basket[curr_basket_group].length // 가게 추가 전 장바구니 담긴 전체 항목 개수
	
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/addMoreStore",		
		type : "post",
		async : false,
		success : function(result){				
			basket = result // 장바구니 업데이트
			
			if (basket[curr_basket_group].length > temp) { 				
				if (indexJSP) {
					for (var i = temp; i < basket[curr_basket_group].length; i++) {
						updateMapPin(i, false)
					}
				}
				
			} else {
				alert("현재 위치, 필터를 적용할 때 추천 가능한 가게가 없습니다.")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
	
}


// 점심후보에서 삭제 버튼 클릭 시 > 점심후보에서 삭제하고 핀 변경 
$("#basket-table").on("click", ".basket-del-btn", async function(){
	var url = document.location.href
	url = url.substr(url.indexOf("/lunchwb/")+9)
	
	if (!indexJSP) { // 투표, 랜덤에서 접근했다면 경고
		if (url.indexOf("vote") != -1) {
			var deleteReal = confirm("페이지를 이동해서 점심 후보를 수정하시겠습니까? 지금까지의 진행상황은 저장되지 않습니다.")
			
		} else {
			var deleteReal = confirm("페이지를 이동해서 점심 후보를 수정하시겠습니까?")
		}
	
		if (!deleteReal) {
			
			return false
			
		} else {
			location.replace("${pageContext.request.contextPath}/")
		}
	}
	
	//점심후보에서 삭제할 storeNo
	var deleteStoreNo = parseInt($(this).closest(".basket-table-row").attr("data-storeNo"))
	
	// 삭제 진행
	await deleteBasketItem(deleteStoreNo)
	
})


// 점심후보에서 항목 삭제하는 함수 *********************************************** 모달 같은 데서 사용하셔요
async function deleteBasketItem(storeNo) {
	
	// 장바구니에서 해당 가게 stored = false로 변경
	await deleteSessionBasketGroup(storeNo)
	
	// 현재 가게 선택
	var idx
	for (var i = 0; i < basket[curr_basket_group].length; i++) {
		if (basket[curr_basket_group][i].storeNo == storeNo) {
			idx = i
			break
		}
	}
	
	// 핀 삭제하기
	updateMapPin(idx, false)
}


// 점심후보에서 삭제한 뒤 세션에 반영
async function deleteSessionBasketGroup(deleteStoreNo) {
	var delete_obj = {"storeNo": deleteStoreNo}

	$.ajax({
		url : "${pageContext.request.contextPath}/basket/deleteFromBasket",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(delete_obj),
		dataType : "json",
		async : false,
		success : function(result){				
			basket = result // 장바구니 업데이트
			
			// 점심후보에서 빼버림
			$("[data-storeNo=" + deleteStoreNo + "]").remove()
			
			// 만약 점심후보에 담긴 항목이 하나도 없어지면 표시하기
			if (countBasketItems(curr_basket_group) == 0) {
				basketNoItem()
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
		
	})	
}


// 점심후보에 가게 하나도 없을 때 html 그려주는 함수
function basketNoItem() {
	$("#basket-table-table").append(
		"<tr id='no-basket-items'><td id='basket-no-items' colspan='2'>점심 후보를 추가해주세요</td></tr>"
	)
}
	

// 점심후보에 항목 추가하기 ********************************************* 모달 같은데서 사용하세요
function addItemToBasket(storeNo) {
	if (countBasketItems(curr_basket_group) >= 3) { // 이미 점심 후보 3개 이상이면
		alert("점심 후보는 최대 3개까지 추가 가능합니다.")
		return false
	}
	
	var idx = basket[curr_basket_group].length
	
	for (var i = 0; i < basket[curr_basket_group].length; i++) {
		var curr = basket[curr_basket_group][i]
		
		if (curr.storeNo == storeNo) {
			idx = i
			break
		}
	}
	
	var temp = basket[curr_basket_group].length
	var add_obj = {"storeNo": storeNo}

	$.ajax({
		url : "${pageContext.request.contextPath}/basket/addToBasket",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(add_obj),
		dataType : "json",
		async : false,
		success : function(result){				
			basket = result // 장바구니 업데이트
			$("#no-basket-items").remove()			
			addToBasket(basket[curr_basket_group][idx])	
			
			// 핀 변경 or 생성하기
			updateMapPin(idx, true)
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})		
}


// 다른 그룹 선택 시 장바구니 교체하는 함수
async function changeGroupBasket() {
	$(".basket-table-row").remove()
	
	var cnt = 0
	for (var i = 0; i < basket[curr_basket_group].length; i++) {
		if (basket[curr_basket_group][i].stored) {
			cnt += 1
			addToBasket(basket[curr_basket_group][i])
			
			if (indexJSP) {
				updateMapPin(i, true)
			}
		} else {
			if (indexJSP) {
				updateMapPin(i, false)
			}
		}
	}
	
	$("#no-basket-items").remove()
	if (cnt == 0) {
		basketNoItem()
	}
}


// 점심 후보에 담겨있는 가게 개수 세는 함수(어차피 점심 후보는 curr_basket_group이라 파라미터 없어도 되는데 이미 늦은 듯)
function countBasketItems(groupNo) {
	var cnt = 0
	
	for (var i = 0; i < basket[groupNo].length; i++) {
		if (basket[groupNo][i].stored) {
			cnt += 1
		}
	}
	return cnt
}
	

////// 투표하기 / 랜덤선택 ////////////////////////////////////////////////////////////////////////////

// 투표하기 클릭 > 새 투표 만들기 페이지로 이동
$("#basket-vote-btn").on("click", function(){
	var url = document.location.href
	url = url.substr(url.indexOf("/lunchwb/")+9)
	
	if (!indexJSP && url.indexOf("vote") != -1) { // 이미 메인이 아니라면 물어보기
		var voteReal = confirm("페이지를 이동하시겠습니까? 지금까지의 진행상황은 저장되지 않습니다.")
		
		if (!voteReal) {
			
			return false
		}
	}
	
	// 그룹이 없으면 돌아가셈
	if (curr_basket_group == 0) {
		var noGroup = confirm("투표를 진행하려면 그룹이 필요합니다. 그룹 생성 페이지로 이동하시겠습니까?")
		
		if (noGroup) {
			location.replace("${pageContext.request.contextPath}/group/add")
		} 
		
		return false
	}
	
	// 점심 후보가 2개 미만이면 돌려보냄
	if (countBasketItems(curr_basket_group) < 2) {
		alert("오늘의 점심 후보가 2개 이상일 때 투표를 진행할 수 있습니다.")
		
		return
	}
	
	// 페이지 newVote.jsp로 이동
	location.replace("${pageContext.request.contextPath}/vote")
})


// 랜덤 선택 클릭 > 화이팅
$("#basket-random-btn").on("click", function(){
	if (!indexJSP) {
		var voteReal = confirm("페이지를 이동하시겠습니까? 지금까지의 진행상황은 저장되지 않습니다.")
		if (!voteReal) {
			return false
		}
	}
	if (countBasketItems(curr_basket_group) < 2) {
		alert("오늘의 점심 후보가 2개 이상일 때 이용할 수 있습니다.")
		return
	}
})	


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