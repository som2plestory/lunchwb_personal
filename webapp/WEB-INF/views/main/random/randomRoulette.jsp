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
<c:import url="/WEB-INF/views/includes/aside/basketAside.jsp" />


<div class="d-flex flex-column" id="content-wrapper" style="position: relative;">
    <div class="container" id="container" style="max-width: 1920px;height: auto;margin: 0;padding: 0;">
        <div id="header-1">
            <c:import url="/WEB-INF/views/includes/header.jsp" />
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

<div id="modal-select-member-go" class="modal visible no-drag" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-sm modal-dialog-top" role="document">
		<div class="modal-content">
			<div class="modal-header text-primary modal-header-custom">
				<span>함께할 멤버 선택</span>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body text-center text-dark" style="font-size: 14px;">
				<p>
					표시되지 않은 멤버는<br> 이미 다른 그룹과 함께한 멤버입니다
				</p>
				<div id="member-selection-button">
					<button id="member-all-selection" class="btn btn-light">전체 선택</button>
					<button id="member-all-selection-del" class="btn btn-light">전체 해제</button>
				</div>
				<div id="modal-select-member-area"></div>
			</div>
		</div>
	</div>

</div>

</body>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">

// 장바구니 비우기
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


let countbas;
let theWheel;
// 룰렛
// Create new wheel object specifying the parameters at creation time.

setTimeout(() => {
	countbas = countBasketItems(curr_basket_group);
      
      if(countbas == 3){
    	  theWheel = new Winwheel({
              
              'numSegments'  : countbas,     // Specify number of segments.
              'outerRadius'  : 305,   // Set outer radius so wheel fits inside the background.
              'textFontSize' : 18,    // Set font size as desired.
              'segments'     :        // Define segments including colour and text.
              [ 
                    {'fillStyle' : '#36b9cc', 'text' : basket[curr_basket_group][0].storeName, 'storeNo' : basket[curr_basket_group][0].storeNo},
                    {'fillStyle' : '#f6c23e', 'text' : basket[curr_basket_group][1].storeName, 'storeNo' : basket[curr_basket_group][1].storeNo},
                    {'fillStyle' : '#1cc88a', 'text' : basket[curr_basket_group][2].storeName, 'storeNo' : basket[curr_basket_group][2].storeNo}
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
                    {'fillStyle' : '#36b9cc', 'text' : basket[curr_basket_group][0].storeName, 'storeNo' : basket[curr_basket_group][0].storeNo},
                    {'fillStyle' : '#f6c23e', 'text' : basket[curr_basket_group][1].storeName, 'storeNo' : basket[curr_basket_group][1].storeNo}
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


// Vars used by the code in this page to do power controls.
let wheelSpinning = false;
let stopAt;
function startSpin()
{
    if (wheelSpinning == false) {
    	 // This formula always makes the wheel stop somewhere inside prize 3 at least
        // 1 degree away from the start and end edges of the segment.
        stopAt = (1 + Math.floor((Math.random() * 360)))
 
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
    
    // May as well start the spin from here.
}

let creatorNo = "${authUser.userNo}";

function alertPrize(indicatedSegment){
    // Do basic alert of the segment text. You would probably want to do something more interesting with this information.
    if(confirm("오늘 방문할 가게는 [" + indicatedSegment.text +"] 입니다. \n방문하시겠습니까?" ) == false){
    	wheelSpinning = false
    	
    	document.getElementById('spin_button').src       = "${pageContext.request.contextPath}/assets/img/rouletteOn.png";
        document.getElementById('spin_button').className = "";
        
        theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
        theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
        theWheel.draw();                // Call draw to render changes to the wheel.
        
    	return false
    }
      
   // 장바구니 데이터 정리
  	var curr_basket = []
  	for (var i = 0; i < basket[curr_basket_group].length; i++) {
  		if (basket[curr_basket_group][i].stored) {
  			curr_basket.push(basket[curr_basket_group][i])
  		}
  	}
  	currBasket = JSON.stringify(curr_basket)
  	
    let randomData = {
    		stopAt : stopAt,
    		currBasket : currBasket,
    		currBasketGroup : curr_basket_group,
    		creatorNo : creatorNo
	}
      
      
  	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/random/makeRandomResult",
		contentType : "application/json",
		async : false,
		data : JSON.stringify(randomData),
		dataType : 'json',
		
		success : function(randomNo) {
			if (randomNo == 0) {
				alert("랜덤 결과 생성 실패")
			}
		},
		error: function(xhr, status, error){
			console.log("오류 발생" + error)
		}
	})
  	
      if(modalSelectRandomMembers(indicatedSegment.storeNo, curr_basket_group) == false){
		return false
        
    }
}
    
function modalSelectRandomMembers(storeNo, groupNo){
	$("#modal-select-member-area").html("")
	
	$.ajax({
		url : "${pageContext.request.contextPath}/visited/members/goWith",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupNo),
		dataType : "json",
		
		success : function(memberList){
			console.log(memberList)
			
			var str = ''
			str += '<form id="members-with-me" action="${pageContext.request.contextPath}/random/decision/'+storeNo+'/'+groupNo+'" method="post">'
			str += '	<div class="row">'
			
			if(memberList.length == 0){
				str += '			<p>선택할 수 있는 멤버가 없습니다</p>'
			}

			str += '		<div class="col" style="border-right: 1px solid; border-right-color: #EAEAEA;z">'
			
			for(var i=0; i<parseInt((memberList.length+1)/2); i++){
				var n= String(i)
				str += '			<div class="form-check">'
				str += '				<input id="formCheck-'+n+'1" class="form-check-input" type="checkbox" name="memberList" value="'+memberList[i].userNo+'">'
				str += '				<label class="form-check-label" for="formCheck-'+n+'1" data-no="'+i+'">  '+memberList[i].userName+'  </label>'
				str += '			</div>'
			}
			str += '		</div>'
			
			str += '		<div class="col">'
			for(var i=parseInt((memberList.length+1)/2); i<memberList.length; i++){
				var n= String(i)
				str += '			<div class="form-check">'
				str += '				<input id="formCheck-'+n+'1" class="form-check-input" type="checkbox" name="memberList" value="'+memberList[i].userNo+'">'
				str += '				<label class="form-check-label" for="formCheck-'+n+'1" data-no="'+i+'">  '+memberList[i].userName+'  </label>'
				str += '			</div>'
			}
			str += '		</div>'
			
			str += '	</div>'
			str += '	<div class="modal-footer-custom" style="margin-top: 20px; padding-top: 15px;">'
			str += '		<span><button id="modal-select-member-ok" class="btn btn-primary" type="submit" style="width: 100px;">확인</button></span>'
			str += '		<span><button id="modal-select-member-cancel" class="btn btn-light" type="button" data-bs-dismiss="modal" style="width: 100px;">취소</button></span>'
			str += '	</div>'
			str += '</form>'
			
			$("#modal-select-member-area").append(str)
			$("#modal-select-member-go").modal("show")
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
 
	})
	
	
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
         console.log("클립보드 복사 실패")
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
 //console.log(Kakao.isInitialized());

 /* function kakaoShare() {
 	var voteURL = $("#vote-url-input").val();
 	var basketItem = [JSON.parse(currBasket)[0].storeName, JSON.parse(currBasket)[1].storeName, JSON.parse(currBasket)[2].storeName];
 	var desc;
 	
 	if(basketItem[2] == '' || basketItem[2] == null){
 		desc = basketItem[0] + ", " + basketItem[1];
 	}else{
 		desc = basketItem[0] + ", " + basketItem[1] + ", " + basketItem[2];
 	} 
 	
 	Kakao.Link.sendDefault({
 		objectType: 'feed',
 		content: {
 			title: '부장님 투표해주세요',
 			//title: '부장님 여기어때?',
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
 } */
 
</script>

</html>