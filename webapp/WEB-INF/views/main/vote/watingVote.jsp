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
    
    <div id="content-wrapper" class="d-flex flex-column">
    	<c:import url="/WEB-INF/views/includes/header.jsp" />
         
        <div class="container justify-content-center align-items-center" id="waiting-container">
        
        	<div class="d-flex d-xxl-flex justify-content-center" id="wating-btn-area">
            	<button class="btn btn-danger d-inline-flex d-xxl-flex justify-content-center align-items-center" id="vote-kakao-btn" type="button">
            		<i class="fas fa-comment"></i>
            		<span>공유하기</span>
            	</button>
            	
            	<span class="d-inline-flex flex-shrink-0 justify-content-center flex-nowrap align-items-xxl-center" id="vote-url-copy-box">
            		<i class="fas fa-link d-inline-flex d-xxl-flex flex-shrink-0 justify-content-start align-items-center justify-content-xl-start align-items-xl-center justify-content-xxl-start align-items-xxl-center"></i>
            		<input id="vote-url-input" class="d-inline-flex d-xxl-flex flex-shrink-0 align-items-xxl-center" type="text" value="http://localhost:8088/lunchwb/${voteInfo.voteNo}">
            		<button id="vote-url-copy-btn" class="btn btn-primary d-inline-flex d-xxl-flex flex-shrink-0 justify-content-center align-items-center align-content-center align-items-xl-center justify-content-xxl-center align-items-xxl-center" type="button">복사</button>
            	</span>
            </div>
        
            <div id="waiting-vote-area" class="d-flex d-xxl-flex justify-content-center align-items-center align-content-center flex-nowrap justify-content-xxl-center align-items-xxl-center card-body">
                <div>
                    <div id="align-f" class="d-inline-flex d-xxl-flex justify-content-center align-content-center align-items-center justify-content-xxl-center align-items-xxl-center">
                    	<span class="d-xxl-flex">아직 투표가 진행중입니다. (${currVote.votedCnt}명 /&nbsp;${currVote.totCnt}명)</span>
                    </div>
                    
                    <div class="d-xxl-flex flex-wrap justify-content-xxl-center">
                        <div class="progress">
                            <div class="progress-bar bg-warning progress-bar-striped progress-bar-animated" aria-valuenow="${currVote.votedCnt}" aria-valuemin="0" aria-valuemax="${currVote.totCnt}" style="width: ${currVote.votedCnt/currVote.totCnt*100}%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
</div>


<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">

//복사 클릭 시 클립보드에 url 복사
$("#vote-url-copy-btn").on("click", function(){
	var content = $("#vote-url-input").val();

    navigator.clipboard.writeText(content)
        .then(() => {
        alert("클립보드에 복사되었습니다.")
    })
        .catch(err => {
        console.log("클립보드 복사 실패");
    })
})


/////////////// 카카오 공유하기 api ////////////////////////////////////////////////////

var voteURL = ${voteInfo.voteNo};
var basketItem = ["${voteBasket[0].storeName}", "${voteBasket[1].storeName}", "${voteBasket[2].storeName}"] ;
// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('f78c3d22061aa91b824c89a07b348da9');

function kakaoShare() {	
	var descr;
	if(basketItem[2] == '' || basketItem[2] == null){
		descr = basketItem[0] + ", " + basketItem[1];
	}else{
		descr = basketItem[0] + ", " + basketItem[1] + ", " + basketItem[2];
	}
	Kakao.Link.sendDefault({
		objectType: 'feed',
		content: {
			title: '부장님 투표해주세요',
			//title: '부장님 여기어때?',
			imageUrl: 'http://localhost:8088/lunchwb/' + voteURL,
			description: descr,
			link: {
			  mobileWebUrl: 'http://localhost:8088/lunchwb/' + voteURL,
			  webUrl: 'http://localhost:8088/lunchwb/' + voteURL
			}
		},
		buttons: [
			{
				title: '웹으로 보기',
				link: {
					mobileWebUrl: 'http://localhost:8088/lunchwb/' + voteURL,
					webUrl: 'http://localhost:8088/lunchwb/' + voteURL
				}
			}
		],
	    // 카카오톡 미설치 시 카카오톡 설치 경로이동
	    installTalk: true
	})
}


</script>

</body>

</html>