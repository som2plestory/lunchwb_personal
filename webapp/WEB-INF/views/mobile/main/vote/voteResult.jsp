<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<div id="header" class="text-center justify-content-center">
	<img src="${pageContext.request.contextPath}/assets/img/bujang-logo.png">
</div>

<c:set var="topStore" value="" />
<c:set var="topCnt" value="" />

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
            	
<div id="result-box" class="text-center">
    <div class="d-flex justify-content-center align-items-center">
    	<span id="result-1">${voteInfo.groupName}</span>
    	<span id="result-2">&nbsp;오늘 점심은</span>
    </div>
    
    <div class="justify-content-center align-items-center">
    	<c:if test="${topCnt == 1}">
	    	<span id="result-3">${topStore}</span>
	    	<span id="result-4">&nbsp;요기요!</span>
    	</c:if>
    	
    	<c:if test="${topCnt > 1}">
    		<span id="result-3">${topStore}</span>
	    	<span id="result-4">&nbsp;중에 어디가 좋을까요?</span>
    	</c:if>
    </div>
</div>

<div id="result-graph-box">
	<c:set var="resultCnt" value="0" />

	<c:forEach var="result" items="${voteResults}">
    	<c:set var="resultCnt" value="${resultCnt+1}" />
    	
	    <div class="graph-area justify-content-center align-items-center align-content-center">
	        <div class="graph-info">
	        	<span class="graph-1 vote-graph-store" data-storeNo="${result.storeNo}" data-resultCnt="${resultCnt}">${result.storeName}</span>
	        	<span class="graph-2">${result.votes}표</span>
	        </div>
	        <div class="graph-graph">
	            <div class="progress">
	                <div class="progress-bar progress-bar-animated" aria-valuenow="${result.votes}" aria-valuemin="0" aria-valuemax="${currVote.totCnt}" style="width: ${result.votes/currVote.totCnt*100}%;"></div>
	            </div>
	        </div>
	    </div>
    </c:forEach>
</div>

<div id="link-box" class="text-center">
    <div>
    	<span id="link-comment">투표 결과를 그룹원에게 공유해보아요</span>
    </div>
    
    <a href="javascript:kakaoShare()" style="text-decoration:none;">
	    <button class="btn btn-danger d-inline-flex d-xxl-flex justify-content-center align-items-center" id="vote-kakao-btn" type="button">
	    	<i class="fas fa-comment"></i>
	    	<span>공유하기</span>
	    </button>
    </a>
    
    <button id="copy-link-btn" class="btn btn-primary" type="button">링크 복사</button>
</div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

///////////// 카카오 공유하기 api ////////////////////////////////////////////////////////////////////////////////

var todayStore = $("#result-3").text();

var voteURL = 'http://localhost:8088${pageContext.request.contextPath}/' + ${voteInfo.voteNo};
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
	    imageUrl: voteURL,
	    description: todayStore,
	    link: {
	        mobileWebUrl: voteURL,
	        webUrl: voteURL
	    }
	}

	Kakao.Link.sendDefault({
	    objectType: 'feed',
	    content: content,
	    buttons: [{
	        title: '웹으로 보기',
	    	link: {
	            mobileWebUrl: voteURL,
	        	webUrl: voteURL
	    	}
	    }],
	    // 카카오톡 미설치 시 카카오톡 설치 경로이동
	    installTalk: true
	})
}

//복사 클릭 시 클립보드에 url 복사
$("#copy-link-btn").on("click", function(){
	var content = 'http://localhost:8088${pageContext.request.contextPath}/' + ${voteInfo.voteNo}
	
    navigator.clipboard.writeText(content)
        .then(() => {
        alert("클립보드에 복사되었습니다.")
    })
        .catch(err => {
        console.log("클립보드 복사 실패")
    })
})

</script>


</body>

</html>