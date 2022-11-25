<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customModal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/storeInfo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">

</head>

<body>

<nav id="vote-aside" class="navbar navbar-light bg-white text-center d-xxl-flex align-items-start justify-content-xxl-center sidebar accordion p-0">
	<div class="container-fluid d-flex flex-column p-0">
		<div id="bujang-logo-wrap">
        	<a href="${pageContext.request.contextPath}/"><img data-bss-hover-animate="pulse" id="bujang-logo-blue" src="${pageContext.request.contextPath}/assets/img/bujang-logo%20blue.png"></a>
        </div>
        
        <div id="vote-countdown-box">
	        <div id="countdown-voting-group" class="justify-content-center align-items-center align-content-center">
	        	<span class="d-inline-block only-bold">${voteInfo.groupName}</span>
	        	<span class="d-inline-block">&nbsp;점심 투표</span>
	        </div>
	        
	        <div id="vote-countdown-times">
	            <div class="d-xxl-flex justify-content-center align-items-center  align-content-center justify-content-xxl-center align-items-xxl-center" id="vote-countdown-end-time">
	            	<span class="countdown-label">종료 시각</span>
	            	<span id="countdown-end-time" class="countdown-time">
	            		<fmt:formatDate value="${voteInfo.voteEndTime}" pattern="HH"/>시 
	            		<fmt:formatDate value="${voteInfo.voteEndTime}" pattern="mm"/>분
	            	</span>
	            </div>
	            <div class="d-xxl-flex justify-content-center align-items-center align-content-center justify-content-xxl-center align-items-xxl-center" id="vote-countdown-remain-time">
	            	<span class="countdown-label">남은 시간</span>
	            	<span id="countdown-time" class="countdown-time">00:00:00</span>
	            </div>
	        </div>
	    </div>
	    
	    <div id="vote-select-name-area">
	    	<c:if test="${userState == 1}">
	        	<div id="label-select-name"><span>이름을 선택해주세요</span></div>
	        </c:if>
	        
	        <c:if test="${userState == 2 or userState == 3}">
	        	<div id="label-select-name"><span>투표 참여자 목록입니다</span></div>
	        </c:if>
	        
	        <c:if test="${userState == 99}">
	        	<div id="label-select-name"><span>수정 전 투표 참여자 목록입니다<br>이미 투표 완료한 회원은 수정할 수 없습니다.</span></div>
	        </c:if>
	        
	        <div id="vote-select-names" class="d-flex d-xxl-flex flex-wrap justify-content-xxl-start">
	        	<!--  투표 인원 영역  -->       	
	        	<c:forEach items="${voteMember}" var="member">
	        		<c:if test="${member.voteVoted != -1}">
	        			<button class="btn btn-primary text-center vote-select-name-btn 
	        			               <c:if test="${authUser.userNo == member.userNo and member.voteVoted == 0}">vote-selected-name</c:if>
	        			               <c:if test="${userState == 1 and empty(authUser) and member.voteVoted == 0 and member.userGrade != 1}">can-click-name</c:if>
	        			               <c:if test="${member.voteVoted != 0}">vote-voted-name</c:if>" 
	        			        type="button" 
	        			        <c:if test="${member.voteVoted > 0 or (empty(authUser) and member.userGrade == 1) or (!empty(authUser) and authUser.userNo != member.userNo)}">disabled="disabled"</c:if> 
	        			        data-vote-member-no="${member.voteMemberNo}" data-vote-voted="${member.voteVoted}" data-user-no="${member.userNo}">${member.userName}</button>
	        		</c:if>
	        	</c:forEach>
	        </div>
	    </div>
	    
	    <div style="width: 100%;" class="justify-content-center align-items-center">
	        <div class="text-start d-flex basket-aside-title"><span class="d-inline-block">오늘의 점심 후보</span></div>
	        
	        <div class="table-responsive" id="basket-table">
	            <table class="table" id="basket-table-table">
	            	<!--  투표 가게 목록 올 곳 -->
	            	<c:if test="${!empty(authUser)}">
            			<c:forEach var="mem" items="${voteMember}">
            				<c:if test="${mem.userNo == authUser.userNo}">
            					<c:set var="myStore" value="${mem.voteVoted}" />
            				</c:if>
            			</c:forEach>
           			</c:if>
                        			
	            	<c:set var="voteIdx" value="-1" />
	            	<c:forEach items="${voteBasket}" var="store">
	            		<c:set var="voteIdx" value="${voteIdx+1}" />		
	            			<tr class="vote-table-row basket-table-row" data-vote-idx="${voteIdx}" data-storeNo="${store.storeNo}" data-storeX="${store.storeX}" data-storeY="${store.storeY}">
                        		<td class="d-xxl-flex justify-content-xxl-start basket-table-cell">
                            		<div class="basket-table-store-info">
                            			<span class="text-start basket-table-store-name">${store.storeName}</span>
                            			<span class="text-start basket-table-store-detail">${store.menu2ndCateName}&nbsp;/&nbsp;${store.distance}m</span>
                            		</div>
                        		</td>
                        		<td class="basket-vote-btn-cell">
                        			<c:if test="${userState == 1}">
                        				<button class="btn btn-primary vote-vote-btn align-items-center" type="button">투표하기</button>
                        			</c:if>
                        			
                        			<c:if test="${userState >= 2 and store.storeNo == myStore}">
                        				<button class="btn btn-primary vote-waiting-voted-btn align-items-center" type="button" disabled="disabled">투표완료</button>
                        			</c:if>
                        			
                        			<c:if test="${userState == 2 and store.storeNo != myStore}">
                        				<button class="btn btn-danger vote-wating-change-vote-btn align-items-center" type="button">투표변경</button>
                        			</c:if>
                        		</td>
                    		</tr>
	            	</c:forEach>

	            </table>
	        </div>
	      
	      	<c:if test="${authUser.userNo == voteInfo.voteMadeUser}">
		        <div id="vote-leader-btn-area" class="d-xxl-flex justify-content-center align-items-center">
		        	<c:if test="${userState < 3}">
		        		<button id="vote-leader-modify-btn" class="btn btn-primary d-flex d-xxl-flex justify-content-center align-items-center align-content-center" type="button">투표 수정하기</button>
		        	</c:if>
		        	<button id="vote-leader-cancel-btn" class="btn btn-danger d-flex d-xxl-flex justify-content-center align-items-center align-content-center" type="button">투표 취소하기</button>
		        </div>
	        </c:if>
	        
	        <c:if test="${!empty(authUser) and authUser.userNo != voteInfo.voteMadeUser and voteState < 3}">
		        <div id="vote-member-btn-area" class="justify-content-center align-items-center">
		        	<button id="vote-member-escape-btn" class="btn btn-danger d-flex d-xxl-flex justify-content-center align-items-center align-content-center justify-content-xxl-center align-items-xxl-start" type="button">다른 사람들이랑 먹을래요</button>
		        </div>
	        </c:if>
	    </div>
	</div>
</nav>

<c:if test="${userState >= 1 && userState <= 3}">
	<c:import url="/WEB-INF/views/includes/storeInfo.jsp" />
</c:if>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">


/////////////////////// 전역 변수 //////////////////////////////

let curr_basket_group = parseInt("${voteInfo.groupNo}")
let voteEndTime = "${voteInfo.voteEndTime}"
let clientIp
let userState = "${userState}"

// 투표할 때 넘길 데이터
let selected = {
	voteNo : parseInt("${voteInfo.voteNo}"),
	voteIdx : -1,
	voteVoted : 0
}


//////////////////// 페이지 로드시 ///////////////////////////////////////////////////////////////////////

$(document).ready(async function(){
	// 투표 종료 시각 date type으로 변환하기
	voteEndTime = changeTimeFormat(voteEndTime)
	
	// 투표 종료 안했다면 타이머 호출
	if ("${userState}" != 3) {
		countDownTimer(voteEndTime)
	}

	// 로그인 안했으면 클라이언트 ip 가져오기
	if ("${authUser}" == "") { 
		await getIpClient()
			
	} else { 
		if (userState == "1") { // 로그인 안했고 투표 안한 회원 - 투표할 때 보낼 정보 추가
			selected["userNo"] = $(".vote-selected-name").attr("data-user-no")
			selected["voteMemberNo"] = $(".vote-selected-name").attr("data-vote-member-no")	
		}
	}
})
	

////////// ip check 관련 ////////////////////////////////////////////////////////////////////

// 클라이언트 ip 불러오기
async function getIpClient() {
  try {
    const response = await axios.get('https://api.ipify.org?format=json')
    
    clientIp = response["data"]["ip"]
    selected["voteIp"] = clientIp
    
  } catch (error) {
    console.error(error);
  }
}


// guest 투표 참여했는 지 확인


////////////////////// 게스트가 자기 이름 클릭했을 때 //////////////////////////////////////////

$(".can-click-name").on("click", function(){
	$("button").removeClass("vote-selected-name")
	$(this).addClass("vote-selected-name")
	
	selected["voteMemberNo"] = parseInt($(this).attr("data-vote-member-no"))
	selected["userName"] = $(this).text()
})


/////////////////// 투표하기 클릭 //////////////////////////////////////////////////////////

$(".vote-vote-btn").on("click", function(){
	// 투표 가능한 시각인지 확인
	if (new Date() >= voteEndTime) { // 종료시각 이후면 alert 후 메인으로 이동
		alert("이미 종료된 투표입니다")
		location.replace("${pageContext.request.contextPath}/")
		
		return false
	}
	
	// 비회원인데 이름 선택을 안했다면
	if (!("voteMemberNo" in selected)) {
		alert("투표에 참가할 이름을 먼저 선택해주세요")
		
		return false
	} 
	
	// 몇번째 가게 선택했는지 정보 받아오기
	var voteRow = $(this).closest(".vote-table-row")
	selected["voteIdx"] = parseInt(voteRow.attr("data-vote-idx"))
	selected["voteVoted"] = parseInt(voteRow.attr("data-storeNo"))

	// form으로 묶어서 controller에 전송	
	postVoteData("${pageContext.request.contextPath}/vote/submitVote", selected)
})


/////////////// 투표 수정하기 //////////////////////////////////////////////////

$("#vote-leader-modify-btn").on("click", function(){
	var modifyCheck = confirm("투표를 수정하시겠습니까?")
	
	if (modifyCheck) {		
		postVoteData("${pageContext.request.contextPath}/vote/modifyVoteReady")
	}
})


/////////////// 투표 삭제하기 ///////////////////////////////////////////////////

$("#vote-leader-cancel-btn").on("click", function(){
	var deleteCheck = confirm("투표를 삭제하시겠습니까?")
	
	if (deleteCheck) {		
		postVoteData("${pageContext.request.contextPath}/vote/resetVote", {"voteNo" : parseInt("${voteInfo.voteNo}")})
	}
})


/////////////// 투표 탈주하기 ////////////////////////////////////////////////////

$("#vote-member-escape-btn").on("click", function(){
	var reallyEscape = confirm("${voteInfo.groupName}" + "과 점심을 따로 드시겠습니까?")
		
	if (reallyEscape) {
		var myVote = parseInt($("[data-user-no=" + "${authUser.userNo}" + "]").attr("data-vote-voted"))		
		var myIdx = 0
		if (myVote != 0) {
			for (var i = 0; i < 3; i++) {
				if (parseInt($("[data-vote-idx=" + i + "]").attr("data-storeNo")) == myVote) {
					myIdx = i
					break
				}
			}
		}
		
		var modifyData = {
			"userNo" : parseInt("${authUser.userNo}"), 
			"voteMemberNo" : parseInt($("[data-user-no=" + "${authUser.userNo}" + "]").attr("data-vote-member-no")),
			"voteNo" : parseInt("${voteInfo.voteNo}"), 
			"voteVoted" : myVote, 
			"voteResults" : "${voteInfo.voteResults}", 
			"voteIdx" : myIdx 		
		}
		
		postVoteData("${pageContext.request.contextPath}/vote/escapeVote", modifyData)
		
	} else {
		
		return false
	}
})


///////////////////// 투표한 가게 변경하기 /////////////////////////////////////////////

$(".vote-wating-change-vote-btn").on("click", function(){
	var storeName = $(this).closest(".vote-table-row").find(".basket-table-store-name").text()
	var lastWord = storeName.charCodeAt(storeName.length - 1)
	
	if ((lastWord-44032)%28 == 0) {
		storeName = storeName + "]로"
	} else {
		storeName = storeName + "]으로"
	}
	
	var changeVoteOK = confirm("[" + storeName + " 투표를 변경하시겠습니까?")
	
	if (!changeVoteOK) {
		
		return false
	}
	
	var newIdx = parseInt($(this).closest(".vote-table-row").attr("data-vote-idx"))
	
	var myVote = parseInt($("[data-user-no=" + "${authUser.userNo}" + "]").attr("data-vote-voted"))		
	var myIdx = 0
	if (myVote != 0) {
		for (var i = 0; i < 3; i++) {
			if (parseInt($("[data-vote-idx=" + i + "]").attr("data-storeNo")) == myVote) {
				myIdx = i
				break
			}
		}
	}
	
	var modifyVoteStore = {
			"userNo" : parseInt("${authUser.userNo}"), 
			"voteMemberNo" : parseInt($("[data-user-no=" + "${authUser.userNo}" + "]").attr("data-vote-member-no")),
			"voteNo" : parseInt("${voteInfo.voteNo}"), 
			"voteVoted" : parseInt($(this).closest(".vote-table-row").attr("data-storeNo")), 
			"voteResults" : "${voteInfo.voteResults}", 
			"voteIdx" : newIdx,
			"voteVotedIdx" : myIdx
	}
	
	postVoteData("${pageContext.request.contextPath}/vote/changeVotedStore", modifyVoteStore)
})


////////// 카운트다운 타이머 관련 /////////////////////////////////////////////////

// 카운트 다운 만들기
const countDownTimer = function(voteEndTime) {
	var second = 1000;
	var minute = second * 60
	var hour = minute * 60
	var day = hour * 24
	var timer
	
	function showRemaining() {
		var now = new Date();
		var distDt = voteEndTime - now

		if (distDt < 0) {
			clearInterval(timer);
			$("#countdown-time").text("00:00:00")
			
			if (parseInt("${userState}") != 99 && parseInt("${voteInfo.voteState}") < 3) {
				alert("투표가 종료되었습니다.")
				
				postVoteData("${pageContext.request.contextPath}/vote/finishVote", {"voteNo" : parseInt("${voteInfo.voteNo}")})				
			}
			return
		}

		var hours = "" + Math.floor((distDt % day) / hour) 
		var minutes = "" + Math.floor((distDt % hour) / minute) 
		var seconds = "" + Math.floor((distDt % minute) / second) 
		
		// 포맷 맞춰서 표시하기
		$("#countdown-time").text(hours.padStart(2, "0") + ":" + minutes.padStart(2, "0") + ":" + seconds.padStart(2, "0"))
	}
	
	// 1초마다 타이머 계산해서 표시
	timer = setInterval(showRemaining, 1000)
}


// 자바 시간 자바스크립트로 변환
function changeTimeFormat(time) {
	var timeSplit = time.split(" ")
	var newTime = new Date(timeSplit[1] + " " + timeSplit[2] + ", " + timeSplit[5] + " " + timeSplit[3])
	
	return newTime
}


///////////////// form 전송하는 함수 ////////////////////////////////////////////////////////////////

function postVoteData(path, params, method) {
	method = method || "post"
	
	var form = document.createElement("form")
	document.charset = "utf-8"
	
	form.setAttribute("method", method)
	form.setAttribute("action", path)
	
	for (var key in params) {
		var hiddenField = document.createElement("input")
		
		hiddenField.setAttribute("type", "hidden")
		hiddenField.setAttribute("name", key)
		hiddenField.setAttribute("value", params[key])
		
		form.appendChild(hiddenField)
	}

	document.body.appendChild(form)
	form.submit()
}


//////////// 지도 만드는 함수 /////////////////////////////////////////////////////////////////////

async function callMap() {
	// 지도가 표시될 구역
	var mapDiv = document.getElementById('kakaoMap')
	
	// 위치 불러오기
	var gpsX = parseFloat("${voteInfo.currX}")
	var gpsY = parseFloat("${voteInfo.currY}")
	
	// 지도의 기본 설정
	var mapOption = {
		center: new kakao.maps.LatLng(gpsY, gpsX),
		level: 3,
		draggable: false,
	}
	
	// 지도 표시하기, 축소 최대 레벨 설정
	map = new kakao.maps.Map(mapDiv, mapOption)
	
	// 현재 위치 마커 표시하기
	var currMarker = new kakao.maps.Marker({
		position: new kakao.maps.LatLng(gpsY, gpsX),
		image: new kakao.maps.MarkerImage(
			"${pageContext.request.contextPath}/assets/img/markers/currMarker.png",
			new kakao.maps.Size(40, 40)
		)
	})
	
	currMarker.setMap(map)
	
	// 장바구니 항목들 지도에 마커로 표시하기
	for (var i = 0; i <= ${voteIdx}; i++) {
		var currTr = $("[data-vote-idx=" + i + "]")
		
		var storeName = currTr.find(".basket-table-store-name").text().split(" ")[0]
		var storeNo = parseInt(currTr.attr("data-storeNo"))
		var storeX = parseFloat(currTr.attr("data-storeX"))
		var storeY = parseFloat(currTr.attr("data-storeY"))
		
		var img = new kakao.maps.MarkerImage(
			      	"${pageContext.request.contextPath}/assets/img/markers/selectedPin.png",
			      	new kakao.maps.Size(40, 40),
			      	{offset: new kakao.maps.Point(20, 45)}
			      )

						
		// 마커 생성
		var marker = new kakao.maps.Marker({
			map: map,
			position: new kakao.maps.LatLng(storeY, storeX),
			image: img,
			clickable: true
		})
											
		// 마커 태그 생성
		var content =   '<div class="customoverlay" data-storeNo="' + storeNo + '">' 
	        		  + 	'<span class="store_name">' + storeName + '</span>'
	        		  + '</div>'
	        
	    var customOverlay = new kakao.maps.CustomOverlay({
	  	    map: map,
	  	    position: new kakao.maps.LatLng(storeY, storeX),
	  	    content: content,
	  	    yAnchor: 1
	  	})

	}
}


</script>

</body>

</html>