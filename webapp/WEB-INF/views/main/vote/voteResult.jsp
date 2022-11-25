<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>부장님요기요</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Bold-BS4-Responsive-Pricing-Table-Snippet.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-jw.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vote-aside.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vote.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>

</head>


<body>
<div id="wrapper">
    <c:import url="/WEB-INF/views/includes/aside/voteAside.jsp" />
    
    <div class="d-flex flex-column" id="vote-result-content-wrapper">
        <c:import url="/WEB-INF/views/includes/header.jsp" />
        
        <div class="container" id="container">
            <div id="contents-vote-result-title">
            	<span>투표 결과</span>
            	<c:set var="topStore" value="" />
            	<c:set var="topCnt" value="0" />
            	
            	<c:forEach var="store" items="${voteResults}">
            		<c:if test="${store.vote1st}">
            			<c:if test="${!empty(topStore)}">
            				<c:set var="topStore" value="${topStore}, ${store.storeName}" />
            			</c:if>
            			
            			<c:if test="${empty(topStore)}">
            				<c:set var="topStore" value="${store.storeName}" />
            			</c:if>
            			
            			<c:set var="topCnt" value="${topCnt+1}" />
            		</c:if>
            	</c:forEach>
            </div>
			
			<div class="d-flex d-xxl-flex justify-content-center" id="vote-result-link-btn-area">
            	<a href="javascript:kakaoShare()" style="text-decoration:none;">
	            	<button class="btn btn-danger d-inline-flex d-xxl-flex justify-content-center align-items-center" id="vote-kakao-btn" type="button">
	            		<i class="fas fa-comment"></i>
	            		<span>공유하기</span>
	            	</button>
            	</a>	
            	<span class="d-inline-flex flex-shrink-0 justify-content-center flex-nowrap align-items-xxl-center" id="vote-url-copy-box">
            		<i class="fas fa-link d-inline-flex d-xxl-flex flex-shrink-0 justify-content-start align-items-center justify-content-xl-start align-items-xl-center justify-content-xxl-start align-items-xxl-center"></i>
            		<input id="vote-url-input" class="d-inline-flex d-xxl-flex flex-shrink-0 align-items-xxl-center" type="text" value="http://localhost:8088/lunchwb/${voteInfo.voteNo}">
            		<button id="vote-url-copy-btn" class="btn btn-primary d-inline-flex d-xxl-flex flex-shrink-0 justify-content-center align-items-center align-content-center align-items-xl-center justify-content-xxl-center align-items-xxl-center" type="button">복사</button>
            	</span>
            </div>

            <div id="vote-result-area" class="d-flex d-xxl-flex justify-content-center align-items-center align-content-center flex-wrap justify-content-xxl-center align-items-xxl-center card-body">
                <div id="align-content-centert" class="justify-content-center align-items-center align-content-center">
                    <div id="vote-result-lunch-group" class="d-flex d-sm-flex d-xl-flex d-xxl-flex justify-content-center align-items-center justify-content-sm-center align-items-sm-center justify-content-xl-center align-items-xl-center justify-content-xxl-center">
                    	<span id="vote-lunch-group">${voteInfo.groupName}</span>
                    	<span id="today-lunch-neun">&nbsp;오늘 점심은</span>
                    </div>
                    
                    <div id="vote-result-lunch-menu" class="d-inline-flex d-sm-flex d-xl-flex d-xxl-flex justify-content-center align-items-center align-content-center justify-content-sm-center align-items-sm-center justify-content-xl-center align-items-xl-center justify-content-xxl-center align-items-xxl-center">
                    	<c:if test="${topCnt == 1}">
	                    	<span id="vote-lunch-store" class="d-xxl-flex justify-content-xxl-center align-items-xxl-center">${topStore}</span>
	                    	<span id="ipnida" class="d-xxl-flex justify-content-xxl-center align-items-xxl-center">&nbsp;요기요!</span>
                    	</c:if>
                    	
                    	<c:if test="${topCnt > 1}">
	                    	<span id="vote-lunch-store" class="d-xxl-flex justify-content-xxl-center align-items-xxl-center">${topStore}</span>
	                    	<span id="ipnida" class="d-xxl-flex justify-content-xxl-center align-items-xxl-center">&nbsp;중에 어디가 좋을까요?</span>
                    	</c:if>
                    </div>
                </div>
                
                <div id="vote-result-graph" class="d-inline-flex justify-content-center align-items-center align-content-center align-self-center flex-wrap">       
                	<c:set var="resultCnt" value="0" />
                	
                	<c:forEach var="result" items="${voteResults}">
                		<c:set var="resultCnt" value="${resultCnt+1}" />
                		
                		<div class="d-flex justify-content-center align-items-center justify-content-xl-center align-items-xl-center justify-content-xxl-center align-items-xxl-center vote-graph-div">
	                    	<span class="vote-graph-store" data-storeNo="${result.storeNo}" data-resultCnt="${resultCnt}">${result.storeName}</span>
	                        <div id="vote-progress-chart" class="progress">
	                            <div class="progress-bar bg-primary" aria-valuenow="${result.votes}" aria-valuemin="0" aria-valuemax="${currVote.totCnt}" style="width: ${result.votes/currVote.totCnt*100}%;"></div>
	                        </div>
	                        <span class="vote-graph-votes">${result.votes}표</span>
                    	</div>	
                	</c:forEach>
                </div>
                
                <c:if test="${authUser.userNo == voteInfo.voteMadeUser}">
                    <div id="vote-result-btn-area" class="d-flex d-xxl-flex justify-content-center align-items-center justify-content-xxl-center align-items-xxl-center">
	                    <div class="flex-nowrap" id="vote-result-btn-box">
	                    	<c:if test="${topCnt == 1}">
		                    	<button id="vote-result-letsgo-btn" class="vote-result-letsgo-btn btn btn-primary d-inline-flex d-xxl-flex justify-content-center align-items-center justify-content-xxl-center align-items-xxl-center" type="button">여기갈래요</button>
	                    	</c:if>
	                    	
	                    	<c:if test="${topCnt > 1}">
		                    	<button id="vote-result-random-btn" class="btn btn-primary d-inline-flex d-xxl-flex justify-content-center align-items-center justify-content-xxl-center align-items-xxl-center" type="button">랜덤선택</button>
	                    	</c:if>
	                    		                    	
	                    	<form id="resetVote" action="${pageContext.request.contextPath}/vote/resetVote" method="post">
	                    		<input type="hidden" name="voteNo" value="${voteInfo.voteNo}">
	                    		<button id="vote-result-again-btn" class="btn btn-danger d-inline-flex d-xxl-flex justify-content-center align-items-center justify-content-xxl-center align-items-xxl-center" type="button">다시 고를래요</button>
	                    	</form>
	                    </div>
	                </div>
                </c:if>
            </div>
        </div>
    </div>
    <a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
</div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

// 투표 결과 가게 이름 정렬
let maxwidth = 0
var content = $(".vote-graph-store")
content.each(function(){
	maxwidth = Math.max(maxwidth, $(this).width())
})
$(".vote-graph-store").css("width", maxwidth + "px")


//복사 클릭 시 클립보드에 url 복사
$("#vote-url-copy-btn").on("click", function(){
	var content = $("#vote-url-input").val()

    navigator.clipboard.writeText(content)
        .then(() => {
        alert("클립보드에 복사되었습니다.")
    })
        .catch(err => {
        console.log("클립보드 복사 실패")
    })
})


// 여기갈래요 클릭
$("html").on("click", ".vote-result-letsgo-btn", function(){
	var storeName
	var storeNo
	
	if (parseInt("${topCnt}") == 1) {
		storeName = "${topStore}"
		storeNo = parseInt($("[data-resultCnt=1]").attr("data-storeNo"))
	} else {
		storeName = $(this).closest("#modal-store").find(".modalStoreName").text()
		storeNo =  parseInt($(this).attr("data-storeNo"))
	}
	
	var confirmVisit = confirm("오늘 [" + storeName + "]에 방문하겠습니까?")
	
	if (!confirmVisit) {
		return false
	}
	
	var voteMember = []
	
	$("#vote-select-name-area").find(".vote-select-name-btn").each(function(index, item){
		var tempUserNo = parseInt($(item).attr("data-user-no"))
		var voteVoted = parseInt($(item).attr("data-vote-voted"))
		
		if (tempUserNo > 0 && voteVoted >= 0) {
			voteMember.push(tempUserNo)			
		}
	})
	
	var visitData = {
		groupNo : parseInt("${voteInfo.groupNo}"),
		voteNo : parseInt("${voteInfo.voteNo}"),
		storeNo : storeNo,
		voteMember : voteMember
	}	
	postVoteData("${pageContext.request.contextPath}/vote/visitConfirm", visitData)
})


// 다시 고를래요 클릭
$("#vote-result-again-btn").on("click", function(){
	var reallyAgain = confirm("투표를 초기화하시겠습니까? 지금까지의 진행정보를 모두 삭제합니다.")
	
	if (!reallyAgain) {
		return false
	} else {
		$("#resetVote").submit()
	}
})


///////////// 카카오 공유하기 api ////////////////////////////////////////////////////////////////////////////////

var todayStore = $("#vote-lunch-store").text();

var voteURL = ${voteInfo.voteNo};
// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('f78c3d22061aa91b824c89a07b348da9');

function kakaoShare() {
	var title
	
	if (${topCnt} > 1) {
   		title = '부장님 오늘 점심은 ' + todayStore + ' 중에 어디가 좋겠습니까?'
	} else {
		title = '부장님 오늘 점심은 ' + todayStore + ' 입니다.'
	}
	
	var content = {
		title: title,
	    imageUrl: 'http://localhost:8088/lunchwb/' + voteURL,
	    description: todayStore,
	    link: {
	        mobileWebUrl: 'http://localhost:8088/lunchwb/' + voteURL,
	        webUrl: 'http://localhost:8088/lunchwb/' + voteURL
	    }
	}
	
	Kakao.Link.sendDefault({
	    objectType: 'feed',
	    content: content,
	    buttons: [{
	        title: '웹으로 보기',
	    	link: {
	            mobileWebUrl: 'http://localhost:8088/lunchwb/' + voteURL,
	        	webUrl: 'http://localhost:8088/lunchwb/' + voteURL
	    	}
	    }],
	    // 카카오톡 미설치 시 카카오톡 설치 경로이동
	    installTalk: true
	})
}


// 랜덤 선택 긁어옴
$("#vote-result-random-btn").on("click", function(){
	var randomIdx = 1 + Math.floor(Math.random() * ${topCnt})
	var randomStoreNo = parseInt($("[data-resultCnt=" + randomIdx + "]").attr("data-storeNo"))
	var randomStoreName = $("[data-resultCnt=" + randomIdx + "]").text()
	
	var confirmRandom = confirm("오늘 방문할 가게는 [" + randomStoreName + "] 입니다. 방문하시겠습니까?")
	
	if (confirmRandom) {
		var voteMember = []
		
		$("#vote-select-name-area").find(".vote-select-name-btn").each(function(index, item){
			var tempUserNo = parseInt($(item).attr("data-user-no"))
			var voteVoted = parseInt($(item).attr("data-vote-voted"))
		
			if (tempUserNo > 0 && voteVoted >= 0) {
				voteMember.push(tempUserNo)			
			}
		})
		
		var visitData = {
			groupNo : parseInt("${voteInfo.groupNo}"),
			voteNo : parseInt("${voteInfo.voteNo}"),
			storeNo : randomStoreNo,
			voteMember : voteMember
		}
		
		postVoteData("${pageContext.request.contextPath}/vote/visitConfirm", visitData)	
		
	} else {
		return false
	}
})


////////////////// 투표 결과창 모달 연결 /////////////////////////////////////////////////////////

$(".vote-graph-store").on("click", function(){
	var storeNo = parseInt($(this).attr("data-storeNo"))
	
	var groupNo = parseInt("${voteInfo.groupNo}")
    
    $(".store-button-area").html("")
    
    if ("${authUser}" != "" && "${authUser.userNo}" == "${voteInfo.voteMadeUser}" && "${topStore}".indexOf($(this).text().split(" ")[0]) != -1) {
	    $(".store-button-area").append('<button class="btn btn-primary vote-result-letsgo-btn" type="button" data-storeNo="'+ storeNo +'" data-bs-dismiss="modal">여기갈래요</button>')
    }
	
    storeInfoOpen(storeNo, groupNo, 2)
})


$(".basket-table-store-name").on("click", function(){
	var storeNo = parseInt($(this).closest(".vote-table-row").attr("data-storeNo"))
	
	$(".store-button-area").html("")
	
    if ("${authUser}" != "" && "${authUser.userNo}" == "${voteInfo.voteMadeUser}" && "${topStore}".indexOf($(this).text().split(" ")[0]) != -1) {
	    $(".store-button-area").append('<button class="btn btn-primary vote-result-letsgo-btn" type="button" data-storeNo="'+ storeNo +'" data-bs-dismiss="modal">여기갈래요</button>')
    }	
})

</script>

</body>

</html>