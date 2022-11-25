<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>


<li id="user-alert" class="nav-item dropdown d-xxl-flex no-arrow">
	<a class="dropdown-toggle nav-link nav-link" aria-expanded="false" data-bs-toggle="dropdown" data-bs-auto-close="outside">
		<span class="badge bg-danger badge-counter"></span>
		<i class="fas fa-bell fa-fw"></i>
	</a>
    <div id="user-alert-list" class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in" data-bs-popper="none">
        <h6 class="dropdown-header">alerts center</h6>
        <ul id="draw-noti-area">
        </ul>
    </div>
</li>

<script type="text/javascript">

//마지막으로 띄운 알림 번호
let lastNoti = 0
//확인하지 않은 알림 개수
let countNoti = 0

$(document).ready(function(){
	notiCount()
})

/* 
let click = document.querySelector("body")
click.addEventListener("click", function(){
	notiCount()
})
 */
/* 알림 개수 표시 */
function notiCount(){
	var userNo = "${authUser.userNo}"
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notice/count",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(userNo),
		dataType : "json",
		
		success : function(notiCnt){
			countNoti = notiCnt
			
			if(notiCnt > 3){
				$("#user-alert .badge-counter").text("3+")
			
			}else if(notiCnt == 0){
				$("#user-alert .badge-counter").text("")
				noAlert()
			}else{
				$("#user-alert .badge-counter").text(notiCnt)
			}	
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	 
	})
}


//알림 개수 뱃지
function drawNotiBadge(notiCnt){
	countNoti = countNoti + notiCnt
	$("#noti-0").remove()
	
	if(countNoti > 3){
		$("#user-alert .badge-counter").text("3+")
	
	}else if(countNoti == 0){
		$("#user-alert .badge-counter").text("")
		noAlert()
		
	}else{
		$("#user-alert .badge-counter").text(countNoti)
		
	}
	
}


function noAlert(){
	
	var str = ''
		str = '<li id="noti-0" class="dropdown-item d-flex align-items-center">'
		str += '	<div class="text-center">'
		str += '		알림이 없습니다'
		str += '	</div>'
		str += '</li>'
		
	$("#draw-noti-area").append(str)
}


//알림 확인하기
$("#user-alert").on("click", function(){
	
	var notiVo = {
		userNo : "${authUser.userNo}",
		notiNo : lastNoti
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notice/recent/list",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(notiVo),
		dataType : "json",
		
		success : function(notiList){
			
			if(notiList.length > 0){
				$("#noti-0").remove()
				for(var i=0; i<notiList.length; i++){
					renderNoti(notiList[i])
				}
			}
			
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	 
	})
	
})


//알림리스트 그리기
function renderNoti(notiVo){
	lastNoti = notiVo.notiNo

	var str = ''
	str += '<li id="noti-'+notiVo.notiNo+'" class="dropdown-item d-flex align-items-center">'
	
	switch(notiVo.notiType){
		//그룹원 초대
		case 1: 
			str += '	<div class="bg-secondary icon-circle"></div>'
			str += '	<div  class="alert-p-area-2">'
			str += '		<p class="alert-choice">'+notiVo.groupName+'에 초대되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-ok btn-alert-invite-ok" type="button" data-type="1" data-notino="'+notiVo.notiNo+'" data-groupno="'+notiVo.groupNo+'"'
			str += '			data-groupname="'+notiVo.groupName+'" data-leader="'+notiVo.sendUser+'">수락</button>'
			str += '		<button class="btn btn-primary btn-alert-opposite btn-alert-invite-reject" type="button" data-type="1" data-notino="'+notiVo.notiNo+'" data-groupno="'+notiVo.groupNo+'"'
			str += '			data-leader="'+notiVo.sendUser+'">거절</button>'
			str += '	</div>'
			break

		//초대 수락 
		case 2:
			str += '	<div class="bg-warning icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.sendEmail+'님이 '+notiVo.groupName+'의 초대를 수락하였습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-type="2" data-notino="'+notiVo.notiNo+'" data-groupno="'+notiVo.groupNo+'">확인</button>'
			str += '	</div>'
			break
		
		//초대 거절 
		case 3:
			str += '	<div class="bg-warning icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.sendEmail+'님이 '+notiVo.groupName+'의 초대를 거절하였습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
		
		//그룹원 탈퇴
		case 4:
			str += '	<div class="bg-success icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.sendName+'님이 '+notiVo.groupName+'을 탈퇴하였습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
			
		//그룹원 강퇴
		case 5:
			str += '	<div class="bg-danger icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.groupName+'에서 퇴장되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-type="5" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
		
		//그룹장 위임
		case 6:
			str += '	<div class="bg-primary icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.groupName+'의 그룹장이 되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-type="6" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
		
		//그룹명 변경
		case 7:
			str += '	<div class="bg-primary icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.alertCmt+'</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-type="7" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
		
		//신고된 리뷰 삭제
		case 8:
			str += '	<div class="bg-dark icon-circle"></div>'
			str += '	<div class="alert-p-area-1">'
			str += '		<p class="alert-basic">'+notiVo.reviewDate+'에 남겨주신 리뷰가 '+notiVo.reportCateName+'의 사유로 삭제조치되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-check" type="button" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
			
		//문의 답변 알림
		case 9:
			str += '	<div class="bg-info icon-circle"></div>'
			str += '	<div class="alert-p-area-2">'
			str += '		<p class="alert-choice">문의('+notiVo.inquiryTitle+')에 대한 답변이 등록되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<a href="${pageContext.request.contextPath}/customer/readInquiryForm/'+notiVo.inquiryNo+'"'
			str += '			<button class="btn btn-primary btn-alert-ok btn-alert-reply" type="button" data-notino="'+notiVo.notiNo+'">보기</button>'
			str += '		</a>'
			str += '		<button class="btn btn-primary btn-alert-opposite btn-alert-reply" type="button" data-notino="'+notiVo.notiNo+'">확인</button>'
			str += '	</div>'
			break
			
		//부장님 초대
		case 10:
			str += '	<div class="bg-secondary icon-circle"></div>'
			str += '	<div class="alert-p-area-2">'
			str += '		<p class="alert-choice">'+notiVo.groupName+'에 부장님으로 초대되었습니다.</p>'
			str += '	</div>'
			str += '	<div class="btn-group" role="group">'
			str += '		<button class="btn btn-primary btn-alert-ok btn-alert-invite-ok" type="button" data-type="10" data-notino="'+notiVo.notiNo+'" data-groupno="'+notiVo.groupNo+'"'
			str += '			data-groupname="'+notiVo.groupName+'" data-leader="'+notiVo.sendUser+'">수락</button>'
			str += '		<button class="btn btn-primary btn-alert-opposite btn-alert-invite-reject" type="button" data-type="10" data-notino="'+notiVo.notiNo+'" data-groupno="'+notiVo.groupNo+'"'
			str += '			data-leader="'+notiVo.sendUser+'">거절</button>'
			str += '	</div>'
			break
	}
	
	str += '</li>'
	
	$("#draw-noti-area").append(str)
}


/* 초대-수락 버튼을 눌렀을 때 */
$("#draw-noti-area").on("click", ".btn-alert-invite-ok", function(){
	//console.log("초대 수락 버튼 누름")
	var userNo = "${authUser.userNo}"
	
	var notiType = $(this).attr("data-type")
	var notiNo = $(this).attr("data-notino")  //삭제용+부장님 구분용(db/view)
	var groupLeader = $(this).attr("data-leader")
	var groupNo = $(this).attr("data-groupno")
	var groupName = $(this).attr("data-groupname")
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/count",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(userNo),
		dataType : "json",
		
		success : function(groupCount){
			
			if(groupCount > 3){
				alert("수락 불가: 그룹은 4개까지 보유가능합니다.")
			
			}else{
				var notiVo = {
					notiType : notiType,
					notiNo : notiNo,  //삭제용+부장님 구분용(db/view)
					userNo : groupLeader,	//확인알림 받을 사람
					groupNo : groupNo,
					groupName : groupName,
					sendUser : "${authUser.userNo}", //내가 초대 받았다고
					groupOrder : groupCount+1 //그룹 추가 > 순서조정
				}
				
				alertInviteOk(notiVo)
			}
			
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	})
})


/* 초대 수락 */
function alertInviteOk(notiVo){
	var notiNo = notiVo.notiNo
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notice/group/invite/ok",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(notiVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){
				var notiNo = notiVo.notiNo
				$("#noti-"+notiNo).remove()
				
				drawNotiBadge(-1)
				alertUpdate(notiVo)
				
				//추천메인 > 리로드 
				if(window.location.pathname == "/lunchwb/" && typeof indexJSP != 'undefined' && indexJSP == true){
					location.replace("${pageContext.request.contextPath}/")
					
				//그 그룹을 보고 있을리는 없고 다른 그룹 보고있다면 그룹 aside에 채워주기
				}else if(window.location.pathname == "/lunchwb/group/list"){
					var str = ''
					str += '<li id="grouplist-'+notiVo.groupNo+'" class="nav-item">'
					str += '	<a class="nav-link group-nav-menu" href="${pageContext.request.contextPath}/group/list?no='+notiVo.groupNo+'">'+notiVo.groupName+'<br /></a>'
					str += '</li>'
					
					$("#group-aside-ul").append(str)
				
				//블랙리스트 화면일 때
				}else if(window.location.pathname == "/lunchwb/group/blacklist"){
					var str = ''
						str += '<li id="grouplist-'+notiVo.groupNo+'" class="nav-item">'
						str += '	<a class="nav-link group-nav-menu" href="${pageContext.request.contextPath}/group/blacklist?no='+notiVo.groupNo+'">'+notiVo.groupName+'<br /></a>'
						str += '</li>'
						
						$("#group-aside-ul").append(str)
				}
				
				
			}else{
				//console.log("초대 수락 처리 실패")
			
			}
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	})
}



/* 초대-거절 버튼을 눌렀을 때 */
$("#draw-noti-area").on("click", ".btn-alert-invite-reject", function(){
	//console.log("초대 거절 버튼 누름")
	
	var notiVo = {
		notiType : $(this).attr("data-type"),
		notiNo : $(this).attr("data-notino"), 
		userNo : $(this).attr("data-leader"),
		groupNo : $(this).attr("data-groupno"),
		sendUser : "${authUser.userNo}"
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notice/group/invite/reject",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(notiVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){
				var notiNo = notiVo.notiNo
				$("#noti-"+notiNo).remove()

				drawNotiBadge(-1)
				alertUpdate(notiVo)
				
			}else{
				//console.log("초대 거절 처리 실패")
			
			}
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	})
	
})


/* 문의 답변 알림 버튼 눌렀을 때 */
$("#draw-noti-area").on("click", ".btn-alert-reply", function(){
	notiNo = $(this).attr("data-notino")
	alertCheck(notiNo)
})


/* 알림 - 단순 확인 버튼 눌렀을 때 */
$("#draw-noti-area").on("click", ".btn-alert-check", function(){
	var notiNo = $(this).attr("data-notino")
	var notiType = $(this).attr("data-type")
	var groupNo = $(this).attr("data-groupno")
	
	alertCheck(notiNo, groupNo, notiType)
})


/* 알림 확인 처리 */
function alertCheck(notiNo, groupNo, notiType){
	
	var notiVo = {
		notiNo : notiNo,
		notiType : notiType
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notice/check",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(notiVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){

				$("#noti-"+notiNo).remove()
				drawNotiBadge(-1)
				
				//그룹 이름이 바뀌었거나 강퇴당했을 때(초대를 받는건 1-10 따로 처리) 이름이 바뀌는건 뺌
				if(notiType == 5){
					if(window.location.pathname == "/lunchwb/" && typeof indexJSP != 'undefined' && indexJSP == true){
						location.replace("${pageContext.request.contextPath}/")
					
					//5 내가 그룹장이 아니고 리스트를 보는데 그룹에서 강퇴당했다는 알림을 확인하면 첫번째 그룹으로 보내줘
					}else if(window.location.pathname == "/lunchwb/group/list" || window.location.pathname == "/lunchwb/group/blacklist"){
						location.replace("/lunchwb/group/list")
					}
					
				}else if(window.location.pathname == "/lunchwb/group/list"){
					//2 내가 그룹장이고 그룹페이지를 보고있는데 초대 수락알림이 왔으면 그 사람 포함한 목록을 그려)
					//6 그룹원이었는데 그룹장이 됐다는 알림을 확인했어)
					//7 어디에 있던 그룹 이름이 바꼈어
					if(groupNo == "${map.groupNo}" && (notiType == 2 || notiType == 6)){
							location.replace("${pageContext.request.contextPath}/group/list?no=${map.groupNo}")
							
					}else if(notiType == 7){
						location.replace("${pageContext.request.contextPath}/group/list?no=${map.groupNo}")

					}
				}
				
			}else{
				//console.log("알림 확인 처리 실패")
			
			}
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error)
		}
	})
}


let sock = null

$(document).ready(function(){
	if ("${authUser.userName}" != "") {
		connectWs()
	}
})

function connectWs(){
	
	sock = new SockJS(getContextPath()+'/alarm')
	
	sock.onopen = function() {
	 		//console.log('socket: open')
	 
	 }
	
	sock.onmessage = function(e) {
	  //console.log('message', e.data)
	  //alert("확인하지 않은 알림이 있습니다.")
	  
		  $('.toast').remove()
		  let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>"
		  toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>"+e.data+"</strong>"
		  $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
		  $(".toast").toast({"animation": true, "autohide": true})
		  $('.toast').toast('show')
		  
		  drawNotiBadge(1)
	
		  setTimeout(() => $(".toast").toast("hide"), 4000)
	  
	  
		sock.close()
	 }
	
	sock.onclose = function() {
	    //console.log('close')
	 }

}


function getContextPath() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) )
} 


function alertUpdate(notiVo){
	var receiver = notiVo.userNo
	var notiType = notiVo.notiType 
	
	if(sock){
		var Msg = receiver+","+notiType
		sock.send(Msg)
	}
}


</script>



</body>
</html>