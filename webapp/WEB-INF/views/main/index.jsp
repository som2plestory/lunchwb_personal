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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>


</head>


<body>

<div id="wrapper">
<c:import url="/WEB-INF/views/includes/aside/basketAside.jsp" />


<div class="d-flex flex-column" id="content-wrapper">
	<c:import url="/WEB-INF/views/includes/header.jsp" />
    
    <div class="container" id="container">
        <div class="align-items-center" id="map-util">
        	<div class="flex-nowrap" id="curr-location">
	        	<span class="emphasize-blue" style="margin-right: 5px;">&nbsp;현위치:</span>
	        	<span id="curr-location-address">${curr_location.address}</span>
	        	<button class="btn btn-primary" id="location-change-btn" type="button">위치재설정</button>
        	</div>
        	
        	<button id="reset-center" title="현재 위치로 이동" class="btn btn-primary d-flex d-xl-flex align-items-center align-items-xl-center" type="button">
        		<i class="fas fa-crosshairs"></i>
        	</button>
        	
        	<button id="reset-recommend" title="다시 추천받기" class="btn btn-primary d-flex d-xl-flex align-items-center align-items-xl-center" type="button">
        		<i class="fas fa-undo"></i>
        	</button>
        </div>
        
        <c:if test="${!empty(curr_location)}">
        	<c:forEach var="basketItems" items="${basket}">
            	<c:if test="${basketItems.key == curr_basket_group}">
            		<c:set var="stores" value="${basketItems.value}" />
            		<c:if test="${fn:length(stores)==0}">
            			<div class='d-flex justify-content-center align-items-center' id='no-store'>
                    		<div>
                    			<span class='d-block justify-content-center' id='no-store-alert-1'>주변에 추천 가능한 가게가 없어요</span>
                    			<span class='d-flex justify-content-center' id='no-store-alert-2'>현재 위치나 필터를 확인해주세요</span>
                    		</div>
                		</div>
            		</c:if>		
             	</c:if>
             </c:forEach>
        </c:if>
        
        <div id="kakaoMap" style="width: 100%; height: 100%; position: absolute;"></div>
        
        &nbsp;
    </div>
    &nbsp;
</div>

<a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- 위치 재설정 모달 -->
<div id="modal-location-change" class="modal fade" role="dialog" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom-color: rgb(255,255,255);">
                    <h4 class="modal-title">현재 위치 설정</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <div>
                	<span>출발 위치를 선택해주세요.</span>
                	<span id="kindComment">(지도에서 현 위치 마커를 클릭하면 직접 위치를 변경할 수 있습니다.)</span>
                	
                    <div id="modal-curr-location-box">
                    	<span class="emphasize-blue">현재 설정 위치:&nbsp;</span>
                    	<span id="modal-curr-location">${curr_location.address}</span>
                    	<button class="btn btn-primary float-end" id="modal-curr-location-btn" type="button" title="현재 위치로 변경">현위치</button>
                    </div>
                    <div id="write-location-box">
                    	<span class="d-inline-block">직접 입력하기:</span>
                    	<input type="text" class="location-search-bar" readonly>
                    	<button class="btn btn-primary align-items-center location-search-bar" type="button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="modal-footer modal-footer-custom">
            	<button id="modal-gps-submit" class="btn btn-primary" type="button">저장</button>
            	<button class="btn btn-light" type="button" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e74b599be710b798192fd5221284718a"></script> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

// basketAside에서 사용(나는 index.jsp임)
indexJSP = true

//지도 전역변수로 놔두기
let map

// 마커 저장할 배열
let markers = []
let overlays = []


// 위치재설정 버튼 클릭 시 > 모달 텍스트 불러옴 + 모달 보여주게
$("#location-change-btn").on("click", function(){
	var curr_address = ""
	
	// 모달 내부에 표시될 현재 위치 불러오기
	if (gpsVo.address == "") {
		curr_address = "현재 위치를 설정해주세요"
		
	} else {
		curr_address = gpsVo.address
	}
	
	// 모달에 내용 표시하고 보여주기
	$("#modal-curr-location").text(curr_address)
	$("#modal-location-change").modal('show')
})


// gps에 저장할 위치를 현재 위치로 재설정
$("#modal-curr-location-btn").on("click", function(){
	curr_location()
})


// 직접 주소 검색하기
$(".location-search-bar").on("click", async function(){			
	await DaumPostcode()
})


// Daum 주소 api 불러오는 함수
   async function DaumPostcode() {
      new daum.Postcode({
          oncomplete: function(data) {
        	  // 검색해서 클릭한 주소로 모달에 표시되는 주소도 변경
        	  var daumAddress = data.jibunAddress
        	  
        	  if (daumAddress == "") {
        		  daumAddress = data.autoJibunAddress
        	  }
              $("#modal-curr-location").text(daumAddress)
          }
      }).open()
   }


// 주소 변경 모달에서 확인 클릭시 > 주소 변경, 위도 경도 불러오기, 세션에 저장
$("#modal-gps-submit").on("click", function(){
	// 주소가 변경되었다면
	if ($("#curr-location-address").text() != $("#modal-curr-location").text()) {
		var gpsChangeOK = confirm("현재 위치 변경 시 현재 저장한 점심 후보가 초기화됩니다. 정말로 변경하시겠습니까?")

		if (!gpsChangeOK) {
			return false
		}
		
		// 카카오 api 주소 > 위도경도 찾기
		var geocoder = new kakao.maps.services.Geocoder()
		   geocoder.addressSearch($("#modal-curr-location").text(), async function(result, status) {

		   if (status === kakao.maps.services.Status.OK) {
			    // 전역변수 gpsVo에 변경된 위도, 경도, 주소 저장
			    gpsVo.gpsX = result[0].x
			    gpsVo.gpsY = result[0].y
		        gpsVo.address = $("#modal-curr-location").text()
		        
		        // 세션에 gps저장
		        await setGPS(gpsVo)
			    await clearBasket()
			    
				// 모달 숨기고 페이지 다시 로드
			    $("#modal-location-change").modal("hide")
			    
			    alert("현재 위치가 변경되었습니다.")
			    location.replace("${pageContext.request.contextPath}/")
		   	  } 
		})
		
	} else {
		// 주소 변경 안했으면 얌전히 모달만 닫기
		$("#modal-location-change").modal("hide")
	}
})


// 장바구니 아예 비워버리는 함수
async function clearBasket() {
	$.ajax({
		url : "${pageContext.request.contextPath}/basket/clearBasket",		
		type : "post",
		async : false,
		success : function() {
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


// 주변에 가게가 하나도 없을 때 html 그려주는 함수
function noStore() {
	if (indexJSP) {
		$("#container").prepend(
			  "<div class='d-flex justify-content-center align-items-center' id='no-store'>"
            + 	"<div>"
            +   	"<span class='d-block justify-content-center' id='no-store-alert-1'>주변에 추천 가능한 가게가 없어요</span>"
            +       "<span class='d-flex justify-content-center' id='no-store-alert-2'>현재 위치나 필터를 확인해주세요</span>"
            +   "</div>"
            + "</div>"
		)
	}
}


//카카오지도 API 불러오기
async function callMap() {
	// 지도가 표시될 구역
	var mapDiv = document.getElementById('kakaoMap')
	
	// 지도의 기본 설정
	var mapOption = {
		center: new kakao.maps.LatLng(gpsVo.gpsY, gpsVo.gpsX),
		level: 3		
	}
	
	// 지도 표시하기, 축소 최대 레벨 설정
	map = new kakao.maps.Map(mapDiv, mapOption)
	map.setMaxLevel(4)
	
	
	// 현재 위치 마커 표시하기
	var currMarker = new kakao.maps.Marker({
		position: new kakao.maps.LatLng(gpsVo.gpsY, gpsVo.gpsX),
		image: new kakao.maps.MarkerImage(
			"${pageContext.request.contextPath}/assets/img/markers/currMarker.png",
			new kakao.maps.Size(40, 40)
		)
	})
	
	currMarker.setMap(map)
	
	// 현재 위치 마커 클릭 > 현재 위치 변경
	kakao.maps.event.addListener(currMarker, 'click', function() { 
		var changeCurrLoc = confirm("현재 위치를 변경하시겠습니까?")
		
		if (changeCurrLoc) {
			currMarker.setMap(null)

			var marker = new kakao.maps.Marker({
			    position: new kakao.maps.LatLng(gpsVo.gpsY, gpsVo.gpsX),
			    image: new kakao.maps.MarkerImage(
					   "${pageContext.request.contextPath}/assets/img/markers/selectedRed.png",
					   new kakao.maps.Size(40, 40),
					   {offset: new kakao.maps.Point(20, 40)}
					)
			})
			
			marker.setMap(map)
			marker.setDraggable(true)
			
			kakao.maps.event.addListener(marker, 'dragend', function() {
				var latlng =  marker.getPosition()
				var newX = latlng.getLng()
				var newY = latlng.getLat()
				var newAddress
				
				geocoder = new kakao.maps.services.Geocoder()
				
				geocoder.coord2Address(newX, newY, async function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
						newAddress = result[0].address.address_name // 주소 획득
											
						var changeAddr = confirm("[" + newAddress + "]로 기준 위치를 변경하시겠습니까? 추천된 가게 목록은 초기화됩니다.")
						
						if (changeAddr) {
							gpsVo.gpsX = newX
							gpsVo.gpsY = newY
							gpsVo.address = newAddress
							
							await setGPS(gpsVo)
						    await clearBasket()
						    
							// 페이지 다시 로드						    
						    alert("현재 위치가 변경되었습니다.")
						    location.replace("${pageContext.request.contextPath}/")
							
						} else {
							return false
						}
	
					}
				})		
			})
				
			kakao.maps.event.addListener(map, 'click', function() {
				var dontChange = confirm("현재 위치 변경을 취소하시겠습니까?")
				
				if (dontChange) {
					location.replace("${pageContext.request.contextPath}/")
					
				} else {
					return false
				}
			})
			
			$("#reset-center").on('click', function() {
				var dontChange = confirm("현재 위치 변경을 취소하시겠습니까?")
				
				if (dontChange) {
					location.replace("${pageContext.request.contextPath}/")
					
				} else {
					return false
				}
			})
			
		} else {
			return false
		}
	})
	
	// 장바구니 항목들 지도에 마커로 표시하기
	for (var i = 0; i < basket[curr_basket_group].length; i++) {
		updateMapPin(i, basket[curr_basket_group][i].stored)
	}
}


// customoverlay 클릭 시 - 모달 연결
$("#kakaoMap").on("click", ".customoverlay", function(){
	var storeNo = parseInt($(this).attr("data-storeNo"))
	var groupNo = curr_basket_group

	storeInfoOpen(storeNo, groupNo, 1)
})


// 가게 추가 버튼 클릭 시 > 장바구니에 항목 추가
$("#kakaoMap").on("click", ".fa-plus-square", function(e){
	var storeNo = parseInt($(this).closest(".customoverlay").attr("data-storeNo"))
	addItemToBasket(storeNo)

	// 부모 태그 function 작동 방지
	e.stopPropagation()
})


// 가게 제거 버튼 클릭 시 > 장바구니에 항목 삭제
$("#kakaoMap").on("click", ".fa-minus-square", function(e){
	var storeNo = parseInt($(this).closest(".customoverlay").attr("data-storeNo"))
	deleteBasketItem(storeNo)

	// 부모 태그 function 작동 방지
	e.stopPropagation()
})

	
	
// 중심 좌표로 이동하기
$("#reset-center").on("click", function(){
	map.setCenter(new kakao.maps.LatLng(gpsVo.gpsY, gpsVo.gpsX))
	map.setLevel(3)
})


// 가게 추천 초기화하기 클릭
$("#reset-recommend").on("click", async function(){
	if (basket[curr_basket_group].length == 0) {
		alert("추천된 가게가 적어도 1개 이상 있어야 사용 가능합니다.")
		return false
	}
	
	var resetConfirm = confirm("현재 추천된 가게 목록을 초기화하시겠습니까?")
	
	if (resetConfirm) {
		await clearBasket()
		location.replace("${pageContext.request.contextPath}/")
		
	} else {
		return
	}
})


//  


// 지도에 핀 제거 / 생성 함수
function updateMapPin(idx, selected) {
	if (markers.length > idx) {
		overlays[idx].setMap(null)
		markers[idx].setMap(null)
	}
	
	var curr_store = basket[curr_basket_group][idx]
	
	var img
	
	// 마커 색깔 구분
	if (selected) {
		img = new kakao.maps.MarkerImage(
		      	"${pageContext.request.contextPath}/assets/img/markers/selectedPin.png",
		      	new kakao.maps.Size(40, 40),
		      	{offset: new kakao.maps.Point(20, 45)}
		      )
	} else {
		img = new kakao.maps.MarkerImage(
		      	"${pageContext.request.contextPath}/assets/img/markers/unselectedPin.png",
		      	new kakao.maps.Size(40, 40),
		      	{offset: new kakao.maps.Point(20, 45)}
		      )
	}
					
	// 마커 생성
	var marker = new kakao.maps.Marker({
		map: map,
		position: new kakao.maps.LatLng(curr_store.storeY, curr_store.storeX),
		image: img,
		clickable: true
	})
								
	// 배열에 마커 저장
	markers[idx] = marker 
	
	// 마커 태그 생성
	var content 
	
	var storeName = curr_store.storeName
	storeName = storeName.split(" ")[0]
	
	if (selected) {
		content =   '<div class="customoverlay" data-storeNo="' + curr_store.storeNo + '" title="상세보기">' 
        		  + 	'<span class="store_name">' + storeName + '<i class="far fa-minus-square" title="점심 후보 제외"></i></span>'
        		  + '</div>'
        
	} else {
		content =   '<div class="customoverlay" data-storeNo="' + curr_store.storeNo + '" title="상세보기">' 
                  + 	'<span class="store_name">' + storeName + '<i class="far fa-plus-square" title="점심 후보 추가"></i></span>'
                  + '</div>'
	}

    var customOverlay = new kakao.maps.CustomOverlay({
  	    map: map,
  	    position: new kakao.maps.LatLng(curr_store.storeY, curr_store.storeX),
  	    content: content,
  	    yAnchor: 1
  	})

	// 배열에 오버레이 저장
	overlays[idx] = customOverlay
}



</script>

</body>

</html>