<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/storeInfo.css">

<!-- 가게 정보 보기 -->
<div id="modal-store" class="modal visible no-drag modal-stores" role="dialog" tabindex="-1" style="min-width: 800px;">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content" style="width: 798px;">
            <div class="modal-header">
            	<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="fs-4 fw-bold text-dark modal-store-title">
                	<span class="d-inline-block modalStoreName"></span>
               		<span class="fs-6 text-secondary d-inline-block store-cate modalStoreCate"></span>
                    <div id="storeHours1" class="dropdown d-inline-block">
                    	<button class="btn btn-sm dropdown-toggle fs-6 fw-bold text-start text-secondary" aria-expanded="false" data-bs-toggle="dropdown" type="button">영업시간</button>
                        <div id="drop1" class="dropdown-menu">
                        	<div class="modalStoreOpening" style="z-index: 9000;"></div>
                        	<div class="modalStoreBreak" style="z-index: 9000;"></div>
                        </div>
                    </div>
                </div>
                <div class="store-info">
                    <div class="d-inline-block store-info-left">
                        <div>
                        	<span class="modalStoreAddress"></span>
                        	<span class="fw-bold text-primary modalStoreDistance"></span>
                        </div>
                        <div>
                        	<span class="fw-bold text-primary modalStoreVisitCnt"></span>
                        	<span> / 40대 그룹 선호 가게 "여기 해야함"</span>
                        </div>
                    </div>
                    <div class="text-end d-inline-block store-info-right">
                        <div>
                        	<span>별점</span>
                        	<span class="fw-bold text-primary modalStoreScore"></span>
                        </div>
                        <div>
                        	<span class="fw-bold text-warning modalStoreStar"></span>
                        </div>
                    </div>
                </div>
                <div>
                    <div id="store-about">
                        <div class="d-inline-block store-imgs">
                            <div class="d-inline-block img-area height-full width-full">
                            	<span class="d-inline-block"></span>
                            </div>
                            <div class="text-center img-paging-icon">
                            	<i id="imgIcon-1" class="fas fa-circle visually-hidden"></i>
                            	<i id="imgIcon-2" class="far fa-circle visually-hidden"></i>
                            	<i id="imgIcon-3" class="far fa-circle visually-hidden"></i>
                            </div>
                        </div>
                        <div class="d-inline-block review-area" style="height: 256px;">
	                        	<!-- 최근 리뷰 영역 -->
                        </div>
                    </div>
                    <div id="all-menu" class="text-start">
                    	<span id="all-menu-sentence" class="fw-bold text-info d-inline-block" style="color: rgb(54, 185, 204);"></span>
                    	<button id="modal-see-menu" class="btn" type="button" data-bs-target="#modal-all-menu" data-bs-toggle="modal">
                    		메뉴 보러가기 <i class="icon ion-android-arrow-dropright-circle"></i>
                    	</button>
                    </div>
                    <div class="other-stores">
                        <div class="text-primary other-store-state">
                        	<span class="d-inline-block"></span>
                        </div>
                        <div class="text-start d-lg-flex justify-content-lg-center other-stores-area">
		                </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer-custom">
                <p class="modalStoreWithMe text-center"></p>
                <div class="store-button-area"></div>
            </div>
        </div>
    </div>
</div>



<!-- 모든 리뷰 보기 -->
<div id="modal-reviews" class="modal visible no-drag modal-stores" role="dialog" tabindex="-1" style="min-width: 798px;">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content" style="width: 798px;">
            <div class="modal-header">
            	<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="fs-4 fw-bold text-dark modal-store-title">
                	<span class="d-inline-block modalStoreName"></span>
                	<span class="fs-6 text-secondary d-inline-block store-cate modalStoreCate"></span>
                    <div class="dropdown d-inline-block">
                    	<button class="btn btn-sm dropdown-toggle fs-6 fw-bold text-start text-secondary" aria-expanded="false" data-bs-toggle="dropdown" type="button">영업시간</button>
                        <div class="dropdown-menu">
                        	<div class="modalStoreOpening"></div>
                        	<div class="modalStoreBreak"></div>
                        </div>
                    </div>
                </div>
                <div class="store-info">
                    <div class="d-inline-block store-info-left">
                        <div>
                        	<span class="modalStoreAddress"></span>
                       		<span class="fw-bold text-primary modalStoreDistance"></span>
                       	</div>
                        <div>
                        	<span class="fw-bold text-primary modalStoreVisitCnt"></span>
                        	<span> / 40대 그룹 선호 가게 "여기 해야함"</span>
                        </div>
                    </div>
                    <div class="text-end d-inline-block store-info-right">
                        <div>
                        	<span>별점</span>
                        	<span class="fw-bold text-primary modalStoreScore"></span>
                        </div>
                        <div>
                        	<span class="fw-bold text-warning modalStoreStar"></span>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block review-area">
                    <div>
                    	<button class="btn back-store-info" type="button" data-bs-target="#modal-store" data-bs-toggle="modal">
                    		<i class="icon ion-android-arrow-dropleft-circle"></i>
                    		 이전으로 돌아가기
                    	</button>
                    </div>
                    <div id="store-all-review">
                    </div>
                </div>
            </div>
            <div class="modal-footer-custom">
                <p class="modalStoreWithMe text-center"></p>
                <div class="store-button-area">
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 최근 메뉴창 -->
<div id="modal-all-menu" class="modal visible no-drag modal-stores" role="dialog" tabindex="-1" style="min-width: 798px;">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content" style="width: 798px;">
            <div class="modal-header">
            	<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="fs-4 fw-bold text-dark modal-store-title">
                	<span class="d-inline-block modalStoreName"></span>
               		<span class="fs-6 text-secondary d-inline-block store-cate modalStoreCate"></span>
                    <div class="dropdown d-inline-block">
                    	<button class="btn btn-sm dropdown-toggle fs-6 fw-bold text-start text-secondary" aria-expanded="false" data-bs-toggle="dropdown" type="button">영업시간</button>
                        <div class="dropdown-menu">
                        	<div class="modalStoreOpening"></div>
                        	<div class="modalStoreBreak"></div>
                        </div>
                    </div>
                </div>
                <div class="store-info">
                    <div class="d-inline-block store-info-left">
                        <div>
                        	<span class="modalStoreAddress"></span>
                        	<span class="fw-bold text-primary modalStoreDistance"></span>
                        </div>
                        <div>
	                        <span class="fw-bold text-primary modalStoreVisitCnt"></span>
	                        <span> / 40대 그룹 선호 가게 "여기 해야함"</span>
                        </div>
                    </div>
                    <div class="text-end d-inline-block store-info-right">
                        <div>
                        	<span>별점</span>
                        	<span class="fw-bold text-primary modalStoreScore"></span>
                        </div>
                        <div>
                        	<span class="fw-bold text-warning modalStoreStar"></span>
                        </div>
                    </div>
                </div>
                <div id="latest-menu-area">
                    <div class="text-start">
                    	<button class="btn back-store-info" type="button" data-bs-target="#modal-store" data-bs-toggle="modal">
                    		<i class="icon ion-android-arrow-dropleft-circle"></i> 이전으로 돌아가기
                    	</button>
                    </div>
                    <div id="store-latest-menu" class="text-center">
                    </div>
                </div>
                <div class="other-stores">
                    <div class="text-primary other-store-state">
                    	<span class="d-inline-block"></span>
                    </div>
                    <div class="text-start d-lg-flex justify-content-lg-center other-stores-area"></div>
                </div>
            </div>
            <div class="modal-footer-custom">
                <p class="modalStoreWithMe text-center"></p>
                <div class="store-button-area"></div>
            </div>
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





<script type="text/javascript">

/* 메인-가게바구니에서 조회할 때 */
$("#basket-table").on("click", ".basket-table-store-name", function(){
      var storeNo = $(this).closest(".basket-table-row").attr("data-storeNo")
      var groupNo = ${groupNo}
      
      storeInfoOpen(storeNo, groupNo, 2)
		      
})

/* 실험용 */
$("#test-storeInfo").on("click", function(){
	var storeNo = $(this).data("storeno")
	var groupNo = curr_basket_group
	
	storeInfoOpen(storeNo, groupNo, 1)
})


/* 가게 고정 */
/* 리뷰 메인 가게정보에서 조회할 때 */
$("#visited-store-name").on("click", function(){
	var storeNo = $(this).data("storeno")
	var groupNo = "${visitedMap.visitedVo.groupNo}"
	
	storeInfoOpen(storeNo, groupNo, 0)
})


/* 블랙리스트(alrady)가게 조회 */
$("#black-body").on("click", ".black-store-name", function(){
	var storeNo = $(this).attr("data-storeno")
	var groupNo = "${map.groupNo}"
	
	storeInfoOpen(storeNo, groupNo, 3)
})


/* 블랙리스트에서 가게 조회(블랙에 없는 add할) */
$("#black-add-body").on("click", ".store-search-name", function(){
	var storeNo = $(this).attr("data-storeno")
	var groupNo = "${map.groupNo}"
	
	storeInfoOpen(storeNo, groupNo, 4)
})


/* 캘린더 기록 가게 조회 */
$("#calendar-area").on("click", ".show-menu", function(){
	var storeNo = $(this).attr("data-storeno")
	
	//임시 : 그룹 순서로 그룹 번호 알아오기 > 탈퇴그룹 불가라서 당시 방문일로 가져오기로함
	//그룹 넘버를 data로 저장 > 그 번호 가져오고
	var userNo = "${authUser.userNo}"
	var visitedDate = $(this).attr("data-visit")
	
	var visitedVo = {
		userNo: userNo,
		visitedDate: visitedDate
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/visited/group/byDate",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(visitedVo),
		dataType : "json",
		
		success : function(groupNo){
			
			if(groupNo != 0 && groupNo != ""){
				
				storeInfoOpen(storeNo, groupNo, 5)
				
			}else{
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
	
})


//페이지 구분 두고 나중에 마지막까지 안쓰면 다 지워버리겠어
/* 모달에서 > 다시 다른 가게 정보 조회(버튼) */
$("#modal-store").on("click", ".other-store-btn", function(){
	//모달에서 다른 모달로 넘어가기 : 페이지 상관없이 불러올 변수는 동일
	var storeNo = $(this).attr("data-no")
	var groupNo = $(this).attr("data-groupno")
	var sortNo = $(this).attr("data-sortno")
	
	storeInfoOpen(storeNo, groupNo, Number(sortNo))
})

$("#modal-all-menu").on("click", ".other-store-btn", function(){
	//모달에서 다른 모달로 넘어가기 : 페이지 상관없이 불러올 변수는 동일
	var storeNo = $(this).attr("data-no")
	var groupNo = $(this).attr("data-groupno")
	var sortNo = $(this).attr("data-sortno")
	
	
	storeInfoOpen(storeNo, groupNo, Number(sortNo))
})
 
 
/* 가게정보 모달 오픈 */
function storeInfoOpen(storeNo, groupNo, k){
	storeBasicInfo(storeNo)
	
	//추천 때만 나와의 거리를 보여줌
	if(k==1){
		modalStoreDistance(storeNo)
	}
	
	drawOtherStores(storeNo, groupNo, k)
	
	//k:footer 버튼 용
	//k=2 > 버튼 없음
	//k=5 > 버튼 안띄움
	if(k != 2 && k != 5){
		modalSortOfStore(storeNo, k)
	}
	
	$("#modal-store").modal("show")
}


/* 가게 기본정보 */
function storeBasicInfo(storeNo){
	
	$.ajax({
		url : "${pageContext.request.contextPath}/store/info",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(storeNo),
		dataType : "json",
		
		success : function(storeMap){
			
			$(".modalStoreName").text(storeMap.storeVo.storeName)
			$(".modalStoreCate").text("|   " + storeMap.storeVo.menu2ndCateName + "   |")
			$(".modalStoreAddress").text(storeMap.storeVo.storeRoadAddress)
			$(".modalStoreVisitCnt").text("여기갈래요 "+ storeMap.storeVo.visitCnt +"회")
			$(".modalStoreScore").text("(" + storeMap.storeVo.ratingBujang + "/5)")
			
			modalStoreStar(storeMap.storeVo.ratingBujang, 0)
			
			$(".modalStoreOpening").html('<a class="dropdown-item disabled link-secondary bg-warning">영업시간 :</a>')
			$(".modalStoreBreak").html('<a class="dropdown-item disabled link-secondary bg-warning">브레이크타임 :</a>')
			modalStoreTime(storeMap.storeVo.openingHours, 1)
			modalStoreTime(storeMap.storeVo.breaktime, 2)
			
			//가게 이미지
			if(storeMap.imgList.length == 0){
				$(".img-area span").html('<img src="${pageContext.request.contextPath}/assets/img/no-review-img.png"/>')
				
			}else{
				for(var i=0; i<storeMap.imgList.length; i++){
					if(i==0){
						$(".img-area span").html('<img id="proImg-1" data-imgno="1" data-end="'+storeMap.imgList.length+'" src="${pageContext.request.contextPath}/upload/'+storeMap.imgList[0]+'">')	
						document.getElementById("imgIcon-1").className = "fas fa-circle"
					
					}else if(i==1){
						$(".img-area span").append('<img id="proImg-2" class="visually-hidden" data-imgno="2" data-end="'+storeMap.imgList.length+'" src="${pageContext.request.contextPath}/upload/'+storeMap.imgList[1]+'">')	
						//document.getElementById("imgIcon-2").className = "far fa-circle"

					}else{
						$(".img-area span").append('<img id="proImg-3" class="visually-hidden" data-imgno="3" data-end="'+storeMap.imgList.length+'" src="${pageContext.request.contextPath}/upload/'+storeMap.imgList[2]+'">')	
						//document.getElementById("imgIcon-3").className = "far fa-circle"
					}
				}
			}
			
			//가게 정보창
			$("#modal-store .review-area").text("")
			if(storeMap.reviewList.length != 0){
				for(var i=0; i<2; i++){
					modalStoreReivew(storeMap.reviewList[i], 1)
					
				}
				modalStoreMoreReivews()
				
			}else{
				$(".review-area").html('<div class = "store-reviews text-center" style="height: 192px; margin-bottom: 64px;">'
										+'	<span class="d-block">'
										+'		</br></br>작성된 리뷰가 존재하지 않습니다</br></br>'
										+'	<span>'
										+'</div>')
			}
			
			$("#all-menu-sentence").html("#" + storeMap.storeVo.storeName + "에서 최근 한달 선택된 메뉴 &gt;&gt;")
			
			$(".other-store-state span").text(storeMap.storeVo.menu2ndCateName + " 카테고리 다른 가게")
			$(".other-stores-area").html("")
			
			//푸터
			if(storeMap.visitedVo == null){
				$(".modalStoreWithMe").text("방문기록이 없어요")
			}else{
				$(".modalStoreWithMe").text("나의 방문 횟수: " + storeMap.visitedVo.visitCount + "회(최근 방문일 " + storeMap.visitedVo.visitedDate + ", " + storeMap.visitedVo.groupName + ")")
			}
			
			//전체 리뷰창
			$("#modal-reviews #store-all-review").text("")
			if(storeMap.reviewList.length != 0){
				for(var i=0; i<storeMap.reviewList.length; i++){
					modalStoreReivew(storeMap.reviewList[i], 2)
				}
			}
			
			modalStoreSentence()
			for(var i=0; i<storeMap.menuList.length; i++){
				modalStoreAllMenu(storeMap.menuList[i])
			}
			
			if(storeMap.menuList.length == 0){
				$("#modal-all-menu #store-latest-menu").append("<span></br></br>최근 한달간 선택된 메뉴가 없습니다</span>")
			}
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	 
	})
}


/* 조회하는 유저와의 가게 거리 - only 추천 장바구니 */
function modalStoreDistance(storeNo) {
	$.ajax({
		url : "${pageContext.request.contextPath}/store/distance",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(storeNo),
		dataType : "json",
		
		success : function(distance){
			
			if(distance>0){
				$(".modalStoreDistance").text(" ("+distance+"m)")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
 
	})
}


/* 별 그리기 */
/* k:별그릴위치 종류 0:이 가게, 1 2 3: 다른가게 */
function modalStoreStar(starScore, k){
	
	var str = ''
	for(var i=0; i<5; i++){
		if(starScore >= (i+0.75)){
			str += '				<i class="fas fa-star"></i>'
		}else if(starScore >= (i+0.25) && starScore < (i+0.75) ){
			str += '				<i class="fas fa-star-half-alt"></i>'
		}else{
			str += '				<i class="far fa-star"></i>'
		}
	}
	
	switch(k){
		case 0: 
			$(".modalStoreStar").html(str)
			break
		
		case 1:
			$(".other-store-"+1+" span").append(str)
			break
		
		case 2:
			$(".other-store-"+2+" span").append(str)
			break
		
		case 3:
			$(".other-store-"+3+" span").append(str)
			break
			
		default:
			break
	}
	
}


/* 영업시간+브레이크타임 드랍다운 리스트 */
function modalStoreTime(storeTime, opt){
	var str = ''
	
	if(storeTime[0] == "정보없음"){
		str += '<a class="dropdown-item disabled link-secondary">정보없음</a>'
	}else{
		str += '<a class="dropdown-item disabled link-secondary">월 : ' + storeTime[0] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">화 : ' + storeTime[1] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">수 : ' + storeTime[2] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">목 : ' + storeTime[3] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">금 : ' + storeTime[4] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">토 : ' + storeTime[5] + '</a>'
		str += '<a class="dropdown-item disabled link-secondary">일 : ' + storeTime[6] + '</a>'
	}
	
	if(opt == 1){
		$(".modalStoreOpening").append(str)
	}else if(opt == 2){
		$(".modalStoreBreak").append(str)
	}else{
	}
}


/* 가게 이미지 클릭 > 다음 이미지로 전환 */
/* 
$("#store-about").on("click", "img", function(){
	var imgNo = $(this).attr("data-imgno")
	var endNo = $(this).attr("data-end")
	
	document.getElementById("proImg-"+imgNo).className = "visually-hidden"
	document.getElementById("imgIcon-"+imgNo).className = "far fa-circle"
	
	//마지막 이미지면 첫번째꺼로 
	if(imgNo == endNo){
		document.getElementById("proImg-1").className = ""
		document.getElementById("imgIcon-1").className = "fas fa-circle"
	
	}else{
		document.getElementById("proImg-"+(imgNo+1)).className = ""
		document.getElementById("imgIcon-"+(imgNo+1)).className = "fas fa-circle"
	}
	
})
 */

/* 가게 리뷰 */
function modalStoreReivew(storeReview, k){
	var str = ''
	str += '<div class="store-reviews">'
	str += '	<div class="d-inline-block store-review-left">'
	str += '		<span class="fw-bolder d-block">'
	str += '			' + storeReview.userName + ' (' + storeReview.avgAge + ' / ' + storeReview.withCount + '인 / ' + storeReview.menuName + ')'
	str += '		</span>'
	str += '		<span class="d-block">' + storeReview.reviewContent + '</span>'
	str += '	</div>'
	str += '	<div class="text-end d-inline-block store-review-right">'
	str += '		<span class="d-inline-block">'
	
	for(var i=0; i<5; i++){
		if(storeReview.userScore > i){
			str += '			<i class="fas fa-star"></i>'
		}else{
			str += '			<i class="far fa-star"></i>'
		}
	}
	
	str += '		</span>'
	str += '		<div class="d-inline-block">'
	str += '			<a class="btn float-none review-report" aria-expanded="false" data-bs-toggle="dropdown" role="button">신고하기'
	str += '				<svg class="bi bi-megaphone-fill text-danger modal-review-report-icon" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">'
	str += '					<path d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-11zm-1 .724c-2.067.95-4.539 1.481-7 1.656v6.237a25.222 25.222 0 0 1 1.088.085c2.053.204 4.038.668 5.912 1.56V3.224zm-8 7.841V4.934c-.68.027-1.399.043-2.008.053A2.02 2.02 0 0 0 0 7v2c0 1.106.896 1.996 1.994 2.009a68.14 68.14 0 0 1 .496.008 64 64 0 0 1 1.51.048zm1.39 1.081c.285.021.569.047.85.078l.253 1.69a1 1 0 0 1-.983 1.187h-.548a1 1 0 0 1-.916-.599l-1.314-2.48a65.81 65.81 0 0 1 1.692.064c.327.017.65.037.966.06z"></path>'
	str += '				</svg>'
	str += '			</a>'
	str += '			<div class="dropdown-menu dropdown-menu-end text-start">'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="1">광고/홍보글</a>'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="2">욕설/비방</a>'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="3">잘못된메뉴</a>'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="4">관련없는내용</a>'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="5">개인정보유출</a>'
	str += '				<a class="dropdown-item" href="#" data-reviewno="'+storeReview.reviewNo+'" data-reporttype="6">음란/선정성</a>'
	str += '			</div>'
	str += '		</div>'
	
	str += '		<div><span>' + storeReview.visitedDate + ' (' + storeReview.visitedCount + '번째 방문) </span></div>'
	str += '	</div>'
	str += '</div>'
	
	if(k == 1){
		$("#modal-store .review-area").append(str)
	}else if(k == 2){
		$("#modal-reviews #store-all-review").append(str)
	}
}


/* 리뷰더보기 버튼 */
function modalStoreMoreReivews(){
	
	var str = ''
	str += '<div id="more-reviews" class="text-end">'
	str += '	<button id="modal-review-more" class="btn btn-sm" type="button" data-bs-target="#modal-reviews" data-bs-toggle="modal">'
	str += '		리뷰더보기<i class="icon ion-android-arrow-dropright-circle"></i>'
	str += '	</button>'
	str += '</div>'
	
	$("#modal-store .review-area").append(str)
}


/* 리뷰 신고 */
$("#store-about").on("click", ".dropdown-item", function(){
	var reviewNo = $(this).data("reviewno")
	var reportCateNo = $(this).data("reporttype")
	
	if(confirm("리뷰를 신고하시겠습니까?") == false){
		return false
	}
	
	var reportVo = {
			reviewNo: reviewNo,
			reportCateNo: reportCateNo
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/store/review/report",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(reportVo),
		dataType : "json",
		
		success : function(result){
			if(result == "success"){
				alert("신고해주신 리뷰는 관리자 검토 후 조치가 진행됩니다")
			}else if(result == "fail"){
				alert("다시 시도해주세요")
			}else{
				alert("로그인 후 시도해주세요")
			}
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
 
	})
})


/* 최근 메뉴 */
function modalStoreSentence(){
	
	var str = ''
	str += '<p class="fs-6 fw-bold text-start text-info">'
	str += '	<strong>'
	str += '		<span style="color: rgb(54, 185, 204);">'
	str += '			#최근 한달 동안 다른 사람들이 리뷰를 남긴 메뉴/ 선택 횟수 &gt;&gt;'
	str += '		</span>'
	str += '	</strong><br />'
	str += '</p>'
	
	$("#modal-all-menu #store-latest-menu").html(str)
}


/* 최근 메뉴 리스트 */
function modalStoreAllMenu(menuVo){
	var str = '<span class="latest-menu">' + menuVo.menuName + '(<span>' + menuVo.menuCount + '</span>회)</span>'
	$("#modal-all-menu #store-latest-menu").append(str)
}


/* 같은 카테 다른 가게 버튼 그리기 */
function drawOtherStores(storeNo, groupNo, sortNo){
	var storeVo = {
		storeNo : storeNo,
		groupNo : groupNo
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/store/sameCate",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(storeVo),
		dataType : "json",
		
		success : function(otherStores){

			if(otherStores != null && otherStores != ""){
				for(var i=0; i<otherStores.length; i++){
					var str = ''
					str += '<span class="d-inline-block">'
					str += '	<button class="btn other-store-btn other-store-'+(i+1)+'" type="button" data-no="'+otherStores[i].storeNo+'" data-groupno="'+groupNo+'" data-sortno="'+sortNo+'">'
					
					if(otherStores[i].storeName.length > 10){
						var name = (otherStores[i].storeName).split(' ')
						
						var sum
						for(var l=1; l<name.length; l++){
							sum += name[l].length
						}
						
						//두번째 배열부터의 합이 길면 > 첫줄 : 첫번째 + 두번째 / 두번째줄 : 나머지  
						if(sum.length>10){
							
							str += name[0] + name[1] + '<br>'
							for(var j=2; j<name.length; j++){
								str += name[j]
							}

						//두번째 배열부터의 합이 짧으면 > 두번째 줄에 두번째 배열부터
						}else{
							
							str += name[0] + '<br>'
							for(var j=1; j<name.length; j++){
								str += name[j]
							}
						}

					}else{
						
						str += otherStores[i].storeName
					}

					str += '		<span class="fw-bold text-warning d-block">'
					str += '		</span>'
					str += '	</button>'
					str += '</span>'
					
					$(".other-stores-area").append(str)
					
					modalStoreStar(otherStores[i].ratingBujang, i+1)
				}
				
			}else{
				$(".other-stores-area").append('<span class="d-block">'
												+'	</br></br>현재 위치가 설정되지 않았거나 근처에 같은 카테고리의 다른 가게가 없습니다</br></br>'
												+'</span>')
				
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error)
		}
	})
	
}




//k=0 > 리뷰메인 : 내가 다녀온 장소 방문취소 (다녀온 곳 아니면 버튼 x) / 블랙리스트 추가(이미 블랙 > 블랙리스트 제외)   
//k=1 > 장바구니 : 여기갈래요 / 장바구니에 있으면 점심후보추가 or 없으면 점심후보제외
//k=2 > 장바구니 추천 제외 index 페이지 typeof indexJSP === 'undefined' 버튼 없음
//k=3 > 블랙리스트 : 블랙리스트 제외 blacklistJSP
//k=4 > 블랙리스트 : 블랙리스트 추가 blacklistJSP
//k=5 > STAT(방문취소 불가) 블랙리스트만? 3&4 통합? 취소
/* 가게 정보 모달  다른 가게 + footer 버튼 */
function modalSortOfStore(storeNo, k){
	//버튼 영역 초기화
	$(".store-button-area").html("")
	
	switch(k){
		case 0:
		// k=1 : 리뷰메인(모달에서 넘어가는거 아니고)
			//조회하는 가게 = 다녀온 가게
			if(storeNo == "${visitedMap.visitedVo.storeNo}" && "${visitedMap.reviewVo}" == ""){
				$(".store-button-area").append('<a href="${pageContext.request.contextPath}/visited/cancel/${visitedMap.visitedVo.visitedNo}">'
												+'	<button class="btn btn-primary modal-btn-visited-cancel" type="button">방문취소</button>'
												+'</a>')
			}
			//다녀온 가게가 아니면 블랙추가버튼이겠죠.. :  
			if("${authUser.userNo}" == "${visitedMap.groupLeader}"){
				//다녀온 가게 블추 했는지?
				if(storeNo == "${visitedMap.visitedVo.storeNo}"){
					var blackVo = {
						storeNo: storeNo,
						groupNo: "${visitedMap.visitedVo.groupNo}"
					}
				
					isBlack(blackVo, 1)
				//안 갔다 온 가게는 블랙 아닌것만 볼수있어요;;
				}else{
					addModalBlackBtn(storeNo, "N")
				}
			}
			break
		
		case 1:
		// k=1 : 장바구니/지도

			// 그룹? 비로그인 또는 그룹이 없으면 여기갈래요 불가 > 
			if(curr_basket_group != 0 && curr_basket_group != null){
				$(".store-button-area").append('<button class="btn btn-primary btn-decision-this" type="button" data-storeno="'+storeNo+'" data-bs-dismiss="modal">여기갈래요</button>')
			}
			
			// 바구니? ${basket.curr_basket_group}: 선택된 가게 리스트
			//장바구니 안에 가게가 있으면 있는 가게인지 검사 해줘야해
			if(basket[curr_basket_group] != null && basket[curr_basket_group] != "" && basket[curr_basket_group] != []){
				for(var i=0; i<basket[curr_basket_group].length; i++){
					//장바구니에 있는 가게만 검사했어
					if(basket[curr_basket_group][i].storeNo == storeNo){
						
						//장바구니에 있는 가게
						if(basket[curr_basket_group][i].stored){
							$(".store-button-area").append('<button class="btn btn-light btn-delete-store-basket" type="button" data-storeNo="'+storeNo+'" data-bs-dismiss="modal">점심후보제외</button>')
						}else{
							$(".store-button-area").append('<button class="btn btn-light btn-add-store-basket" type="button" data-storeNo="'+storeNo+'" data-bs-dismiss="modal">점심후보추가</button>')
						}
						
						break
						
					//마지막까지 검사했어 없었어(모달에서 다른 가게 정보 접근)
					}else if(i == basket[curr_basket_group].length - 1){
						$(".store-button-area").append('<button class="btn btn-light btn-add-store-basket" type="button" data-storeNo="'+storeNo+'" data-bs-dismiss="modal">점심후보추가</button>')
					}
				}
			}else{
				$(".store-button-area").append('<button class="btn btn-light btn-add-store-basket" type="button" data-storeNo="'+storeNo+'" data-bs-dismiss="modal">점심후보추가</button>')
			}

			break
			
		//case 2: 
		//k=2 : typeof indexJSP === 'undefined'
			
		case 3:
		// 블랙리스트 테이블에서 조회(이미 있음 > 제거)
			// 그룹장만 가능
			if("${authUser.userNo}" == "${map.groupLeader}"){
				$(".store-button-area").append('<button class="btn btn-light btn-del-black" type="button" data-storeNo="'+storeNo+'">블랙제외</button>')
			}
			break
		
		case 4:
		// 블랙리스트에서 블랙할 가게 검색(없음 > 추가)
			//그룹장만 가능(애초에 접근자체가 그룹장만 되는데)
			if("${authUser.userNo}" == "${map.groupLeader}"){
				
				$(".store-button-area").append('<button class="btn btn-light btn-add-black" type="button" data-storeNo="'+storeNo+'">블랙추가</button>')
			}
			
		//case 5:
		// 캘린더에서 조회
			
		default :
			break
	}
}


//장바구니 점심 후보 추가
$("#modal-store").on("click", ".btn-add-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	addItemToBasket(Number(storeNo))
})
$("#modal-reviews").on("click", ".btn-add-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	addItemToBasket(Number(storeNo))
})
$("#modal-all-menu").on("click", ".btn-add-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	addItemToBasket(Number(storeNo))
})


//장바구니 점심 후보 삭제
$("#modal-store").on("click", ".btn-delete-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	deleteSessionBasketGroup(Number(storeNo))
})
$("#modal-reviews").on("click", ".btn-delete-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	deleteSessionBasketGroup(Number(storeNo))
})
$("#modal-all-menu").on("click", ".btn-delete-store-basket", function(){
	var storeNo = $(this).attr("data-storeNo") 
	deleteSessionBasketGroup(Number(storeNo))
})


//블랙추가 공통
//bAddNo = 0 : visitedMain
//bAddNo = 1 : blacklist.Jsp 분리 X
//bAddNo = 2 : 나중에 추가될지도 모를 STAT용으로 놔둠 
function blackAdd(blackVo, bAddNo){
	$.ajax({
		url : "${pageContext.request.contextPath}/group/black/add",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(blackVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){
				
				alert("블랙리스트 추가 완료")
				
				//공통
				//modal(showInfo.jsp)
				$(".modal-btn-add-black").remove()
				addModalBlackBtn(blackVo.storeNo, "Y")
				
				switch(bAddNo){
					case 0: 
						//visitedAside(visitedMain)
						drawBlackBtn("Y")
						break
				}
				
			}else{
				alert("블랙리스트 추가 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	})
}


//블랙제거 공통
//bAddNo = 0 : visitedMain.Jsp
//bAddNo = 1 : blacklist.Jsp
function blackDel(blackVo, bDelNo){
	$.ajax({
		url : "${pageContext.request.contextPath}/group/black/delete",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(blackVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){
				
				alert("블랙리스트 삭제 완료")
				
				//공통
				//modal(showInfo.jsp)
				$(".modal-btn-del-black").remove()
				addModalBlackBtn(blackVo.storeNo, "N")
				
				switch(bDelNo){
					case 0: 
						//visitedAside(visitedMain)
						drawBlackBtn("N")
						break
						
					case 1:
						//blacklist
						delBlackTable(blackVo.storeNo)
						break
				}
				
			}else{
				alert("블랙리스트 삭제 실패")
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
 
	})
}



//여기갈래요 버튼 클릭(장바구니화면 모달)
$("#modal-store").on("click", ".btn-decision-this", function(){
	
	if (typeof indexJSP == 'undefined' || indexJSP) {
		var storeNo = $(this).attr("data-storeNo")

        if(confirm("정말로 방문을 선택하시겠습니까?") == true){
			modalSelectMembers(storeNo, curr_basket_group)
		}
	}
})

$("#modal-reviews").on("click", ".btn-decision-this", function(){
	
	if (typeof indexJSP == 'undefined' || indexJSP) {
		var storeNo = $(this).attr("data-storeNo")

        if(confirm("정말로 방문을 선택하시겠습니까?") == true){
			modalSelectMembers(storeNo, curr_basket_group)
		}
	}
})

$("#modal-all-menu").on("click", ".btn-decision-this", function(){
	
	if (typeof indexJSP == 'undefined' || indexJSP) {
		var storeNo = $(this).attr("data-storeNo")

        if(confirm("정말로 방문을 선택하시겠습니까?") == true){
			modalSelectMembers(storeNo, curr_basket_group)
		}
	}
})


function modalSelectMembers(storeNo, groupNo){
	$("#modal-select-member-area").html("")
	
	$.ajax({
		url : "${pageContext.request.contextPath}/visited/members/goWith",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupNo),
		dataType : "json",
		
		success : function(memberList){
			
			var str = ''
			str += '<form id="members-with-me" action="${pageContext.request.contextPath}/visited/decision/'+storeNo+'/'+groupNo+'" method="post">'
			str += '	<div class="row">'
			
			if(memberList.length == 0){
				str += '			<p>선택할 수 있는 멤버가 없습니다</p>'
			}

			str += '		<div class="col" style="border-right: 1px solid; border-right-color: #EAEAEA;">'
			
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

 
/* 여기갈래요 > 그룹멤버선택모달창 멤버 전체선택 */
$("#member-all-selection").on("click", function(){
	$("#modal-select-member-area [name='memberList']").attr("checked",true)
})


/* 여기갈래요 > 그룹멤버선택모달창 멤버 전체해제 */
$("#member-all-selection-del").on("click", function(){
	$("#modal-select-member-area [name='memberList']").attr("checked",false)
})


/* 그룹 블랙리스트 가게인지 확인하기 */
function isBlack(blackVo, bno){
	$.ajax({
		url : "${pageContext.request.contextPath}/group/isBlack",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(blackVo),
		dataType : "json",
		
		success : function(result){
			
			switch(bno){
				case 0:
					//방문메인ASIDE
					drawBlackBtn(result)
				case 1:
					//방문메인 가게모달창
					addModalBlackBtn(blackVo.storeNo, result)
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
		
	})
}


//모달 블랙 추가/삭제 버튼 그리기
function addModalBlackBtn(storeNo, result){
	//블랙맞음
	if(result == "Y"){
		$(".store-button-area").append('<button class="btn btn-light modal-btn-del-black" type="button" data-storeno="' + storeNo + '">블랙삭제</button>')
	//블랙아냐
	}else{
		$(".store-button-area").append('<button class="btn btn-light modal-btn-add-black" type="button" data-storeno="' + storeNo + '">블랙추가</button>')
	}
}


</script>
