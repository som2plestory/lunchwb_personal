<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>부장님요기요</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Bold-BS4-Responsive-Pricing-Table-Snippet.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-jw.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/voteMobile.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>

</head>

<body>

<header>
    <div class="text-center">
    	<img src="${pageContext.request.contextPath}/assets/img/bujang-logo.png">
    </div>
</header>

<div id="countdown-area" class="text-center">
    <div id="countdown-teamname" class="d-flex justify-content-center align-items-center align-content-center">
    	<span id="groupName" class="d-inline-block only-bold">${voteInfo.groupName}</span>
    	<span id="toopyo" class="d-inline-block">&nbsp;점심 투표</span>
    </div>
    
    <div>
        <div class="d-xxl-flex justify-content-center align-items-center align-content-center justify-content-xxl-center align-items-xxl-center">
        	<span class="countdown-title text-center d-xxl-flex countdown-label">종료 시각</span>
        	<span class="countdown-time text-center countdown-time">
        		<fmt:formatDate value="${voteInfo.voteEndTime}" pattern="HH"/>시&nbsp;
	            <fmt:formatDate value="${voteInfo.voteEndTime}" pattern="mm"/>분
        	</span>
        </div>
        <div class="d-xxl-flex justify-content-center align-items-center align-content-center justify-content-xxl-center align-items-xxl-center">
        	<span class="countdown-title text-center d-xxl-flex countdown-label">남은 시간</span>
        	<span id="countodwn-time" class="countdown-time text-center countdown-time">00:00:00</span>
        </div>
    </div>
</div>

<div>
    <div class="vote-title text-center">
    	<span class="no-drag">1. 이름을 선택해주세요</span>
    </div>
    
    <div id="vote-name-area" class="text-center">
	    <c:forEach items="${voteMember}" var="member">
	    	<c:if test="${member.voteVoted != -1}">
		    	<button class="btn btn-primary text-center vote-select-name-btn <c:if test="${member.voteVoted > 0}">vote-voted-name</c:if>" 
		    		    <c:if test="${member.voteVoted > 0}">disabled="disabled"</c:if> 
		    		    data-vote-member-no="${member.voteMemberNo}" data-vote-voted="${member.voteVoted}" data-user-no="${member.userNo}" 
		    			type="button">${member.userName}</button>
	    	</c:if>
		</c:forEach>
	</div>
		
</div>

<div>
    <div class="vote-title text-center">
    	<span class="no-drag">2. 가고 싶은 가게를 선택해주세요</span>
    </div>
    
    <div class="table-responsive">
        <table class="table">
        	<c:set var="voteIdx" value="-1" />
	        <c:forEach items="${voteBasket}" var="store">
	        	<c:set var="voteIdx" value="${voteIdx+1}" />
	        	
	        	<tr class="table-row">
	                <td class="storeRadio text-center">
	                	<input name="voteStore" id="rdo-${voteIdx}" type="radio" data-vote-idx="${voteIdx}" data-storeNo="${store.storeNo}">
	                </td>
	                
	                <td class="storeInfo">
	                    <div class="flex-nowrap">
	                    	<label for="rdo-${voteIdx}">
	                    		<span class="storeName d-block">${store.storeName}</span>
	                    	</label>
	                    	<span class="d-block">${store.menu2ndCateName}&nbsp;/&nbsp;${store.distance}m</span>
	                    </div>
	                </td>
	            </tr>
	        </c:forEach>             
        </table>       
    </div>
    
    <div id="vote-btn" class="text-center">
    	<button  id="vote-vote-btn" class="btn btn-primary" type="button">투표하기</button>
    </div>
    
</div>


<script type="text/javascript">

let voteEndTime = "${voteInfo.voteEndTime}"

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
	
	// 타이머 호출
	countDownTimer(voteEndTime)
})


/////////////// 사람 이름 클릭 ////////////////////////////////////////////////////////////

$(".vote-select-name-btn").on("click", function(){
	if ($(this).attr("disabled")) {
		alert("이미 투표한 회원은 선택할 수 없습니다.")
		
		return false
	}
	
	$("button").removeClass("vote-selected-name")
	$(this).addClass("vote-selected-name")
	
	selected["voteMemberNo"] = parseInt($(this).attr("data-vote-member-no"))
	selected["userName"] = $(this).text()
	selected["userNo"] = parseInt($(this).attr("data-user-no"))
	
})

/////////////////// 가게 클릭시 /////////////////////////////////////////////////////////////

$("input:radio[name=voteStore]").on("click", function(){
	// 비회원인데 이름 선택을 안했다면
	if (!("voteMemberNo" in selected)) {
		alert("투표에 참가할 이름을 먼저 선택해주세요")
		
		return false
	} 
	
	selected["voteIdx"] = parseInt($(this).attr("data-vote-idx"))
	selected["voteVoted"] = parseInt($(this).attr("data-storeNo"))
	
})

/////////////////// 투표하기 클릭 //////////////////////////////////////////////////////////

$("#vote-vote-btn").on("click", function(){
	// 투표 가능한 시각인지 확인
	if (new Date() >= voteEndTime) { // 종료시각 이후면 alert 후 메인으로 이동
		alert("이미 종료된 투표입니다")
		window.open('','_self').close()
		
		return false
	}
	
	// 비회원인데 이름 선택을 안했다면
	if (!("voteMemberNo" in selected)) {
		alert("투표에 참가할 이름을 선택해주세요")
		
		return false
	} 
	
	// 가게 선택 안했다면
	if (!("voteIdx" in selected)) {
		alert("투표할 가게를 선택해주세요")
		
		return false
	}

	// form으로 묶어서 controller에 전송	
	postVoteData("${pageContext.request.contextPath}/vote/submitVote", selected)
})


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
	
	
	alert("투표 완료 되었습니다.")
	window.close()
	
	form.submit()
}


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
			
			alert("투표가 종료되었습니다.")
			window.close()
			
			return
		}

		var hours = "" + Math.floor((distDt % day) / hour) 
		var minutes = "" + Math.floor((distDt % hour) / minute) 
		var seconds = "" + Math.floor((distDt % minute) / second) 
		
		// 포맷 맞춰서 표시하기
		$("#countodwn-time").text(hours.padStart(2, "0") + ":" + minutes.padStart(2, "0") + ":" + seconds.padStart(2, "0"))
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




// 세로모드 고정
$("body").on("orientationchange", function (event){
	var orientation = window.orientation
	var new_orientation
	
	if (orientation != 0) {
		new_orientation = 360 - orientation
	}
			
	$('body').css({
		"-webkit-transform": "rotate(" + new_orientation + "deg)"     
	})
})

</script>

</body>
</html>