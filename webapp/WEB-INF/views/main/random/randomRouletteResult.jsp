<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/vote.css">

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
<script src="http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
</head>


<body>

<div id="wrapper">
<c:import url="/WEB-INF/views/includes/aside/rouletteAside.jsp" />


<div class="d-flex flex-column" id="content-wrapper" style="position: relative;">
    <div class="container" id="container" style="max-width: 1920px;height: auto;margin: 0;padding: 0;">
        <div id="header-1">
            <c:import url="/WEB-INF/views/includes/header.jsp" />
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
            		<input id="vote-url-input" class="d-inline-flex d-xxl-flex flex-shrink-0 align-items-xxl-center" type="text" value="http://localhost:8088/lunchwb/random/${randomNo}">
            		<button id="vote-url-copy-btn" class="btn btn-primary d-inline-flex d-xxl-flex flex-shrink-0 justify-content-center align-items-center align-content-center align-items-xl-center justify-content-xxl-center align-items-xxl-center" type="button">복사</button>
            	</span>
            </div>
            
        
       <div style="margin-top: 100px;" align="center">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <div class="power_controls">
                            <img id="spin_button" src="${pageContext.request.contextPath}/assets/img/rouletteOn.png" alt="Spin" onClick="startSpin();" />
                        </div>
                    </td>
                    <td width="620" height="500" class="the_wheel" align="center" valign="center">
                        <canvas id="canvas" width="620" height="800">
                            <p style="{color: white}" align="center">Sorry, your browser doesn't support canvas. Please try another.</p>
                        </canvas>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

</body>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">



let countbas;
let theWheel;
let storeInfo = ${storeInfo};



// 룰렛
// Create new wheel object specifying the parameters at creation time.

setTimeout(() => {
	countbas = storeInfo.length;
      
      if(countbas == 3){
    	  theWheel = new Winwheel({
              
              'numSegments'  : countbas,     // Specify number of segments.
              'outerRadius'  : 305,   // Set outer radius so wheel fits inside the background.
              'textFontSize' : 18,    // Set font size as desired.
              'segments'     :        // Define segments including colour and text.
              [ 
                    {'fillStyle' : '#36b9cc', 'text' : storeInfo[0].storeName, 'storeNo' : storeInfo[0].storeNo},
                    {'fillStyle' : '#f6c23e', 'text' : storeInfo[1].storeName, 'storeNo' : storeInfo[1].storeNo},
                    {'fillStyle' : '#1cc88a', 'text' : storeInfo[2].storeName, 'storeNo' : storeInfo[2].storeNo}
              ],
              'animation' :           // Specify the animation to use.
              {
                  'type'     : 'spinToStop',
                  'duration' : 1,     // Duration in seconds.
                  'spins'    : 10,     // Number of complete spins.
                  'callbackFinished' : alertPrize
              },
              'pins' :    // Specify pin parameters.
              {
                  'number'      : 18,
                  'outerRadius' : 5,
                  'margin'      : 10,
                  'fillStyle'   : '#7734c3',
                  'strokeStyle' : '#ffffff'
              }
           });
      }else if (countbas == 2){
    	  theWheel = new Winwheel({
              
              'numSegments'  : countbas,     // Specify number of segments.
              'outerRadius'  : 305,   // Set outer radius so wheel fits inside the background.
              'textFontSize' : 18,    // Set font size as desired.
              'segments'     :        // Define segments including colour and text.
              [ 
                    {'fillStyle' : '#36b9cc', 'text' : storeInfo[0].storeName, 'storeNo' : storeInfo[0].storeNo},
                    {'fillStyle' : '#f6c23e', 'text' : storeInfo[1].storeName, 'storeNo' : storeInfo[1].storeNo}
              ],
              'animation' :           // Specify the animation to use.
              {
                  'type'     : 'spinToStop',
                  'duration' : 1,     // Duration in seconds.
                  'spins'    : 10,     // Number of complete spins.
                  'callbackFinished' : alertPrize
              },
              'pins' :    // Specify pin parameters.
              {
                  'number'      : 18,
                  'outerRadius' : 5,
                  'margin'      : 10,
                  'fillStyle'   : '#7734c3',
                  'strokeStyle' : '#ffffff'
              }
           });
      }
}, 400);

setTimeout(() => {
	startSpin();
}, 900);

// Vars used by the code in this page to do power controls.
let wheelSpinning = false;
let stopAt = "${stopAtValue}"
function startSpin()
{
    if (wheelSpinning == false) {
        // Important thing is to set the stopAngle of the animation before stating the spin.
        theWheel.animation.stopAngle = stopAt;

        // Disable the spin button so can't click again while wheel is spinning.
        document.getElementById('spin_button').src       = "${pageContext.request.contextPath}/assets/img/rouletteOff.png";
        document.getElementById('spin_button').className = "";

        // Begin the spin animation by calling startAnimation on the wheel object.
        theWheel.startAnimation();

        // Set to true so that power can't be changed and spin button re-enabled during
        // the current animation. The user will have to reset before spinning again.
        wheelSpinning = true;
    }
}
    
    // May as well start the spin from here.

function alertPrize(indicatedSegment){
    // Do basic alert of the segment text. You would probably want to do something more interesting with this information.
    
    alert("오늘 방문할 가게는 [" + indicatedSegment.text +"] 입니다." )
    
    wheelSpinning = false
    	
   	document.getElementById('spin_button').src       = "${pageContext.request.contextPath}/assets/img/rouletteOn.png";
    document.getElementById('spin_button').className = "";
    
    theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
    theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
    theWheel.draw();                // Call draw to render changes to the wheel.

}
    

//////////////////////투표 생성 모달 //////////////////////////////////////////////

 // 복사 버튼 클릭 시 클립보드에 url 복사
 $("#vote-url-copy-btn").on("click", async function(){
 	await saveClipBoard()
 	//location.replace("${pageContext.request.contextPath}/")
 })
 	
 	
 // 클립보드 저장 api 사용하는 function
 async function saveClipBoard() {
 	var content = $("#vote-url-input").val()

     navigator.clipboard.writeText(content)
         .then(() => {
         alert("클립보드에 복사되었습니다.")
     })
         .catch(err => {
     })
 }


 // 투표 생성 모달 닫힘 > 메인페이지로 이동
 $("#vote-link-modal").on("hide.bs.modal", function(){
 	location.replace("${pageContext.request.contextPath}/")
 })


 //////////// 카카오 공유하기 api /////////////////////////////////////////////////////////////////////////

 // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
 Kakao.init('f78c3d22061aa91b824c89a07b348da9');

 // SDK 초기화 여부를 판단합니다.

function kakaoShare() {
 	var voteURL = $("#vote-url-input").val();
 	var basketItem = [storeInfo[0].storeName, storeInfo[1].storeName, storeInfo[2].storeName];
 	var desc;
 	
 	if(basketItem[2] == '' || basketItem[2] == null){
 		desc = basketItem[0] + ", " + basketItem[1];
 	}else{
 		desc = basketItem[0] + ", " + basketItem[1] + ", " + basketItem[2];
 	} 
 	
 	Kakao.Link.sendDefault({
 		objectType: 'feed',
 		content: {
 			title: '오늘 점심 결과가 궁금하지 않으세요?.',
 			imageUrl: voteURL,
 			description: desc,
 			link: {
 			  mobileWebUrl: voteURL,
 			  webUrl: voteURL
 			}
 		},
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
 
</script>

</html>