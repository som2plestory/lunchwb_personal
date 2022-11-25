<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>부장님요기요: 나의그룹</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customModal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/group.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">
	
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
	
</head>

<body id="page-top">

<div id="wrapper">
	
	<c:import url="/WEB-INF/views/includes/aside/userAside.jsp"></c:import>
	
	<c:import url="/WEB-INF/views/includes/aside/groupAside.jsp"></c:import>
	
	<div id="content-wrapper" class="d-flex flex-column">
		
		<div id="content">
			
			<div id="header-1">
				<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
			</div>
			
               	<div class="container-fluid">
               	
					<h3 class="text-dark mb-4 group-content-title">
						
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -64 640 640" width="1em" height="1em" fill="currentColor" style="font-size: 30px;">
							<path d="M224 256c70.7 0 128-57.31 128-128S294.7 0 224 0C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3c-95.73 0-173.3 77.6-173.3 173.3C0 496.5 15.52 512 34.66 512H413.3C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304zM479.1 320h-73.85C451.2 357.7 480 414.1 480 477.3C480 490.1 476.2 501.9 470 512h138C625.7 512 640 497.6 640 479.1C640 391.6 568.4 320 479.1 320zM432 256C493.9 256 544 205.9 544 144S493.9 32 432 32c-25.11 0-48.04 8.555-66.72 22.51C376.8 76.63 384 101.4 384 128c0 35.52-11.93 68.14-31.59 94.71C372.7 243.2 400.8 256 432 256z"></path>
	                    </svg>
	                    ${map.groupName}
	                    <input type="hidden" id="thisGpNo" name="groupNo" value="${map.groupNo}">
	                    <c:if test="${authUser.userNo == map.leader}">
		                    <button class="btn btn-sm link-dark" type="button" data-bs-target="#modal-group-name-change" data-bs-toggle="modal">
		                    	<i class="fas fa-pencil-alt"></i>
		                    </button>
	                    </c:if>
	                    
	                    <span class="group-title-btn-area">
	                    	<c:if test="${authUser.userNo == map.leader && map.userCount > 1}">
		                    	<button id="pass-leader" class="btn btn-primary group-title-btn btn-leader-pass" type="button" data-bs-target="#modal-group-leader-pass" data-bs-toggle="modal">
		                    		그룹장 위임
		                    	</button>
	                    	</c:if>
                    		<c:if test='${authUser.userNo != map.leader || map.memberCount == 1}'> 
		                    	<button id="out-group" class="btn btn-primary group-title-btn btn-group-leave" type="button">
		                    		그룹 탈퇴
		                    	</button>
                    		</c:if>
	                    </span>
	                    
                    </h3>
                    
                   	<div id="groupmem-list" class="card shadow">
                   	
                       	<div class="card-header py-3">
                           <p class="text-primary m-0 fw-bold">그룹원 목록</p>
                       	</div>
                       
                       	<div class="card-body">
                         
                           	<div id="groupmem-list-table" class="table-responsive table mt-2" role="grid" aria-describedby="dataTable_info">
                             
                               	<table id="dataTable" class="table my-0">
                                	<colgroup>
                                		<col style="width: 10%;">
                                		<col style="width: 10%;">
                                		<col style="width: 15%;">
                                		<col style="width: 10%;">
                                		<col style="width: 15%;">
                                		<col style="width: 15%;">
                                		<col style="width: 10%;">
                                		<col style="width: 15%;">
                                	</colgroup>
                                   	<thead>
                                       	<tr>
											<th>부장님</th>
											<th>그룹장</th>
											<th>이름</th>
											<th>성별</th>
											<th>출생연도</th>
											<th>연령대</th>
											<th>회원</th>
											<th>
												<c:if test="${authUser.userNo == map.leader}">
													내보내기
												</c:if>
											</th>
                                       	</tr>
                                    </thead>
                                  
                                    <tbody id="memberListArea" class="text-dark">
										<c:forEach items="${map.memberList}" var="memberVo" varStatus="status">
											<tr id="member-${memberVo.userNo}" <c:if test="${memberVo.userNo == authUser.userNo}">class="fw-bold"</c:if>>
												<td class="group-bujang">
													<c:if test="${memberVo.bossCheck == 1}">
	                                           			<img src="${pageContext.request.contextPath}/assets/img/bujang.png" width="24px" />
	                                           		</c:if>
	                                           	</td>
												<td>
													<c:if test="${memberVo.userNo == map.leader}">
														<svg class="groupmem-user" xmlns="http://www.w3.org/2000/svg" viewBox="-32 0 512 512" width="1em" height="1em" fill="currentColor">
													        <path d="M438.6 105.4C451.1 117.9 451.1 138.1 438.6 150.6L182.6 406.6C170.1 419.1 149.9 419.1 137.4 406.6L9.372 278.6C-3.124 266.1-3.124 245.9 9.372 233.4C21.87 220.9 42.13 220.9 54.63 233.4L159.1 338.7L393.4 105.4C405.9 92.88 426.1 92.88 438.6 105.4H438.6z"></path>
													    </svg>
													</c:if>													
												</td>
												<td>${memberVo.userName}</td>
												<td>${memberVo.userSex}</td>
												<td>${memberVo.userBirthYear}</td>
												<td>${memberVo.userAge}</td>
												<td>
													<c:if test="${memberVo.groupOrder != 0}">
														<svg class="groupmem-user" xmlns="http://www.w3.org/2000/svg" viewBox="-32 0 512 512" width="1em" height="1em" fill="currentColor">
													        <path d="M438.6 105.4C451.1 117.9 451.1 138.1 438.6 150.6L182.6 406.6C170.1 419.1 149.9 419.1 137.4 406.6L9.372 278.6C-3.124 266.1-3.124 245.9 9.372 233.4C21.87 220.9 42.13 220.9 54.63 233.4L159.1 338.7L393.4 105.4C405.9 92.88 426.1 92.88 438.6 105.4H438.6z"></path>
													    </svg>
													</c:if>
												</td>
												<td>
													<c:if test="${authUser.userNo == map.leader}">
														<c:if test="${memberVo.userNo != authUser.userNo}">
															<svg class="text-danger groupmem-delete" data-no="${memberVo.userNo}" data-user="${memberVo.userName}"
																 data-order="${memberVo.groupOrder}"
																 xmlns="http://www.w3.org/2000/svg" viewBox="-96 0 512 512" width="1em" height="1em" fill="currentColor">
													        	<path d="M310.6 361.4c12.5 12.5 12.5 32.75 0 45.25C304.4 412.9 296.2 416 288 416s-16.38-3.125-22.62-9.375L160 301.3L54.63 406.6C48.38 412.9 40.19 416 32 416S15.63 412.9 9.375 406.6c-12.5-12.5-12.5-32.75 0-45.25l105.4-105.4L9.375 150.6c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L160 210.8l105.4-105.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-105.4 105.4L310.6 361.4z"></path>
													    	</svg>
													    </c:if>
													</c:if>
												</td>
											</tr>
										</c:forEach>
                                   	</tbody>
                               	</table>
                           	</div>
                           
                           	<div class="row">
                               	<div class="col-md-6 align-self-center">
                                   	<p class="dataTables_info" role="status" aria-live="polite">인원 : 
                                   		<span id="memberCount">${map.memberCount}</span>
                                   		<c:if test="${map.leader == authUser.userNo}">
                                   			(초대중인 인원: <span id="inviteCount">${map.inviteCount}</span>)
                                   		</c:if>
                                   	</p>
                               	</div>
                               	
                               	<!-- 추가랑 같이해야해서 대기 
                               <div class="col-md-6">
                                   <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                                       <ul class="pagination">
                                           <li class="page-item disabled"><a class="page-link" aria-label="Previous" href="#"><span aria-hidden="true">«</span></a></li>
                                           <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                           <li class="page-item"><a class="page-link" href="#">2</a></li>
                                           <li class="page-item"><a class="page-link" href="#">3</a></li>
                                           <li class="page-item"><a class="page-link" aria-label="Next" href="#"><span aria-hidden="true">»</span></a></li>
                                       </ul>
                                   </nav>
                               	</div>
								 -->
                           	
                           	</div>
                       
                       </div>
                   </div>
                   
                   
                   <!-- 그룹 리더만 -->
                   <c:if test="${authUser.userNo == map.leader}">
	                    
	                    <!-- 그룹원 초대 -->
	                    <div id="groupmem-invt" class="card shadow">
	                       <div class="card-header py-3">
	                           <p class="text-primary m-0 fw-bold">그룹원으로 초대하기</p>
	                       </div>
	                       <div class="card-body">
	                       		<div>
	                           		<input type="email" placeholder="이메일을 입력해주세요" name="userEmail" />
	                           		<button id="btn-invite"class="btn btn-primary btn-groupmem-invt" type="button">초대하기</button>
	                               	<div class="form-check">
	                               		<input id="chk-boss-user" class="form-check-input" type="checkbox" />
	                               		<label class="form-check-label" for="chk-boss-user">부장님이면 체크해주세요</label>
	                               	</div>
	                           </div>
	                       </div>
	                    </div>
	                   
	                    <!-- 그룹원 추가 -->
						<div id="groupmem-add" class="card shadow">
	                       	<div class="card-header py-3">
	                           	<p class="text-primary m-0 fw-bold">그룹원 직접 추가하기</p>
	                       	</div>
	                       	<div class="card-body">
	                          	<div>
	                          		<input type="text" name="userName" placeholder="이름을 입력해주세요" />
	                          		<input type="text" name="userBirthYear" placeholder="출생연도를 입력해주세요" />
	                               	<select class="text-dark" name="userSex">
                                       <option selected disabled>성별</option>
                                       <option value="male">남자</option>
                                       <option value="female">여자</option>
	                               	</select>
	                               	<button id="btn-add" class="btn btn-primary btn-groupmem-invt" type="button">추가하기</button>
	                            </div>
	                           	<div class="form-check">
	                           		<input id="chk-boss-notuser" class="form-check-input" type="checkbox" name="bossCheck" value="1"/>
	                           		<label class="form-check-label" for="chk-boss-notuser">부장님이면 체크해주세요<br /></label>
	                           	</div>
							</div>
	              		</div>
                   </c:if>
                   
				</div>
			</div>
           
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
           
    </div>
       
	<a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
</div>

   
<!-- 그룹 이름 변경 모달 -->
<div id="modal-group-name-change" class="modal fade" role="dialog" tabindex="-1" data-bs-auto-close="outside" aria-expanded="false">
    <div class="modal-dialog modal-sm modal-dialog-top" role="document">
        <div class="modal-content">
            <div class="modal-header modal-header-custom">
                <div><span>그룹 이름 변경</span></div><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body modal-body-custom">
                <p class="modal-group-p">현재 그룹 이름 : 
                	<span class="group-color-blue">${map.groupName}</span>
                </p>
                <input type="text" name="groupName" placeholder="그룹 이름을 입력해주세요" />
            </div>
            <div class="modal-footer-custom">
            	<a href="${pageContext.request.contextPath}/group/list?no=${map.groupNo}"><button id="btn-name-change"  class="btn btn-primary" type="submit">변경</button></a>
            	<button class="btn btn-light" type="button" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
   
   
<!-- 그룹 탈퇴 확인 모달 -->
<div id="modal-group-leave" class="modal fade" role="dialog" tabindex="-1" aria-expanded="false">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body-custom">
                <div class="modal-group-p">
                    <p class="modal-group-p group-color-blue">${map.groupName}</p>
                    <p class="modal-group-p">탈퇴하시겠습니까?<br /></p>
                </div>
            </div>
            <div class="modal-footer-custom">
           		<a href="${pageContext.request.contextPath}/group/leave?no=${map.groupNo}&lead=${map.leader}"><button id="btn-out-group" class="btn btn-primary" type="submit">확인</button></a>
           		<button class="btn btn-light" type="button" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
   
     
<!-- 그룹장 위임 모달 -->
<div id="modal-group-leader-pass" class="modal fade" role="dialog" tabindex="-1" aria-expanded="false">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body-custom">
                <div>
                    <p class="modal-group-p">그룹장을 위임할 회원을</p>
                    <p class="modal-group-p">선택해주세요</p>
                    <select id="dropdown-group-leader-pass" class="text-center" name="leaderNo">
						<option class="text-center"selected disabled>그룹원(회원) 선택</option>
						<c:forEach items="${map.memberList}" var="memberVo" varStatus="status">
							<c:if test="${memberVo.userNo != authUser.userNo && memberVo.groupOrder > 0}">
								<option value="${memberVo.userNo}">${memberVo.userName}</option>
							</c:if>
						</c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-footer-custom">
            	<a href="${pageContext.request.contextPath}/group/list?no=${map.groupNo}"><button class="btn btn-primary" type="submit">확인</button></a>
            	<button class="btn btn-light" type="button" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
   

<script type="text/javascript">

var groupNo = $("#thisGpNo").val()
console.log(groupNo+"번 그룹")


if("${authUser.userNo}" == "${map.leader}"){

	//그룹원초대 > 엔터
	var inputInvt = document.getElementById("groupmem-invt")
	inputInvt.addEventListener("keyup", function (event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			document.getElementById("btn-invite").click()
		}
	})
	
	
	//그룹원추가 > 엔터
	var inputAdd = document.getElementById("groupmem-add")
	inputAdd.addEventListener("keyup", function (event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			document.getElementById("btn-add").click()
		}
	})
}



//그룹이름변경 > 엔터
var changeName = document.getElementById("modal-group-name-change")
changeName.addEventListener("keyup", function (event) {
	if (event.keyCode === 13) {
		event.preventDefault();
		document.getElementById("btn-name-change").click()
	}
})


$("#out-group").on("click", function(){
	
	if("${authUser.userNo}" == "${map.leader}"){
		var memberCount = Number($("#memberCount").text()) + Number($("#inviteCount").text())
		
		if(memberCount > 1){
			alert("다른 그룹원이 존재하여 탈퇴가 불가능합니다.")
			return false
		}
	}
	
	$("#modal-group-leave").modal("show")
})


//그룹탈퇴 > 엔터
var outGroup = document.getElementById("modal-group-leave")
outGroup.addEventListener("keyup", function (event) {
	if (event.keyCode === 13) {
		event.preventDefault();
		document.getElementById("btn-out-group").click()
	}
})


$("#pass-leader").on("click", function(){
	if("$(map.userCount)" == 1){
		alert("그룹장을 위임할 그룹원이 없습니다.")
		return false
	}
})


// 탈퇴알림 보내기
$("#btn-out-group").on("click", function(){
	if("${authUser.userNo}" != "${map.leader}"){
		//리더한테 보내야해
		var notiVo = {
			userNo: "${map.leader}",
			notiType: 4
		}
		
		alertUpdate(notiVo)
	}
})


$(".form-check-input").on("click", function(){
	//console.log("부장님 여부 체크")
	
	if($(".form-check-input").is(":checked")){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/group/beBoss",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(groupNo),
			dataType : "json",
			
			success : function(result){
				
				if(result == "can't"){
					if(confirm("부장님을 교체하시겠습니까?") != true) {
						$(".form-check-input").prop("checked", false)
					}
				
				//초대중
				}else if(result != "can"){
					alert("이미 부장님을 초대중입니다. 초대중에는 변경이 불가합니다.")
					$(".form-check-input").prop("checked", false)
				}
				
			}, 
			
			error : function(XHR, status, error) {
				//console.error(status + " : " + error)
				
			}
		})
	}
	
})


/* 초대할 그룹원 확인 */
$("#groupmem-invt button").on("click", function(){
	//console.log("그룹원 초대 버튼 클릭")
	
	var members = $("#memberCount").text() + $("inviteCount").text()
	if(members == 15){
		alert("그룹원은 최대 15명까지입니다")
		return false
	}
	
	var userEmail = $("[name = 'userEmail']").val()
	if(userEmail == null || userEmail == ""){
		alert("이메일을 입력해주세요")
		return false
	}
	
	var inviteMap = {
		groupNo: groupNo,
		userEmail : userEmail
	}

	$.ajax({
		url : "${pageContext.request.contextPath}/group/userCheck",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(inviteMap),
		dataType : "json",
		
		success : function(checkMap){
			//console.log(checkMap.state)
			
			//해당 이메일 유저 초대 가능
			if(checkMap.state == "possible"){
				memberCheck(checkMap.userNo, userEmail, checkMap.gpCount)
				
			//이미 초대 중
			}else if(checkMap.state == "already invite"){
				alert(userEmail+"님에게 이미 초대장을 보냈습니다")
				
			//해당 이메일 유저 초대 불가(그룹 개수 초과)
			}else if(checkMap.state == "impossible"){
				alert(userEmail + " 님을 초대할 수 없습니다")
			
			//지 이메일 썼을 때
			}else if(checkMap.state == "It's U"){
				alert("본인은 초대가 불가능합니다")
				
			//이메일 회원 없음
			}else{
				alert("회원이 아닙니다")
			}
		}
	})
})


/* 이 그룹 멤버인가요? */
function memberCheck(userNo, userEmail, gpCount){
	var groupVo = {
			userNo: userNo,
			groupNo: groupNo,
			groupOrder: gpCount+1
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/memberCheck",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(state){
			//console.log(state)
			
			if(state == "already"){
				alert("이미 그룹 멤버입니다")
			
			}else if(confirm(userEmail + " 님을 초대하시겠습니까?(취소 불가)") == true){
				invt(groupVo)
				
			}
		}
	})
}

	
/* 회원 > 그룹원으로 초대 하기 */
function invt(groupVo){
	
	var bossCheck = 0
 	if($("#chk-boss-user").is(":checked")){
 		bossCheck = 1
 	}
		
	groupVo.bossCheck = bossCheck
	
	$.ajax({
		url : "${pageContext.request.contextPath }/group/invtMember",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(result){
			
			$("[name = 'userEmail']").val("")
			$(".form-check-input").prop("checked", false)

			if(result == "success"){
				
				alert("초대장을 보냈습니다")
				
				var inviteCount = $("#inviteCount").text()
				$("#inviteCount").text(Number(inviteCount)+1)
				
				if(bossCheck == 1){
					$(".group-bujang").html("")
				}
				
				var notiVo = {
					userNo: groupVo.userNo,
					notiType: 0
				}
				alertUpdate(notiVo)
				//테이블 표기 안함
				
			}else{
				alert("초대 실패")
			}
			
		}, 
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
			
		}
	})
}



/* 그룹원 직접 추가 */
$("#groupmem-add button").on("click", function(){
	//console.log("비회원 그룹 멤버 추가 버튼 클릭")
	
	var members = $("#memberCount").text() + $("inviteCount").text()
	if(members == 15){
		alert("그룹원은 최대 15명까지입니다")
		return false
	}

	var userName = $("#groupmem-add [name ='userName']").val()
	if(userName == null || userName == ""){
		alert("이름을 입력해주세요")
		return false
	}
	
	if(userName.length < 2 || userName.length > 5){
		alert("이름을 두 자리 이상 5자리 이하로 입력해주세요")
	}
	
	var userBirthYear = $("#groupmem-add [name ='userBirthYear']").val()
	if(userBirthYear == null || userBirthYear == ""){
		alert("출생연도를 입력해주세요")
		return false
	}
	
	if(userBirthYear > 2022 || userBirthYear < 1900){
		alert("출생연도는 1901이상 2022이하의 숫자만 가능합니다")
		return false
	}
	
	var userSex = $("#groupmem-add [name = 'userSex']").val()
	if(userSex == null || userSex == ""){
		alert("성별을 선택해주세요")
		return false
	}
	
	var bossCheck = 0
 	if($("#chk-boss-notuser").is(":checked")){
 		bossCheck = 1
 	}
	
	var groupVo = {
			groupNo: groupNo,
			userName: userName,
			userBirthYear: userBirthYear,
			userSex: userSex,
			bossCheck: bossCheck
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath }/group/addMember",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(memberVo){
			
			alert("멤버가 추가되었습니다")

			$("#groupmem-add [name ='userName']").val("")
			$("#groupmem-add [name ='userBirthYear']").val("")
			$("#groupmem-add [name = 'userSex']").val("성별")
			$(".form-check-input").prop("checked", false)
			
			var memberCount = $("#memberCount").text()
			$("#memberCount").text(Number(memberCount)+1)
			
			if(memberVo.bossCheck == 1){
				$(".group-bujang").html("")
			}
			
			render(memberVo)
			
		}, 
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
			
		}
	})
	
})


/* 멤버 직접 추가 > 테이블 추가 */
function render(memberVo){
	//console.log("render()")
	
	var str = ''
		str += '<tr id="member-' + memberVo.userNo + '">'
		str += '	<td class="group-bujang">'
	
	if(memberVo.bossCheck == 1){
		str += '		<img src="${pageContext.request.contextPath}/assets/img/bujang.png" width="24px" />'
	}
		str += '	</td>'
		str += '	<td></td>'	
		str += '	<td>' + memberVo.userName + '</td>'
		str += '	<td>' + memberVo.userSex + '</td>'
		str += '	<td>' + memberVo.userBirthYear + '</td>'
		str += '	<td>' + memberVo.userAge + '</td>'
		str += '	<td></td>'
		str += '	<td>'
		str += '		<svg class="text-danger groupmem-delete" data-no="' + memberVo.userNo +'" data-user="' + memberVo.userName +'" xmlns="http://www.w3.org/2000/svg" viewBox="-96 0 512 512" width="1em" height="1em" fill="currentColor">'
        str += '				<path d="M310.6 361.4c12.5 12.5 12.5 32.75 0 45.25C304.4 412.9 296.2 416 288 416s-16.38-3.125-22.62-9.375L160 301.3L54.63 406.6C48.38 412.9 40.19 416 32 416S15.63 412.9 9.375 406.6c-12.5-12.5-12.5-32.75 0-45.25l105.4-105.4L9.375 150.6c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L160 210.8l105.4-105.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-105.4 105.4L310.6 361.4z"></path>'
	    str += '		</svg>'
	    str += '	</td>'
	    str += '</tr>'
		
	    
	    $("#memberListArea").append(str)
}


/* 그룹 이름 변경 모달 띄우기 */
$(".group-content-title .btn-sm").on("click", function(){
	//console.log("그룹 이름 변경 버튼 클릭")
	$("#modal-group-name-change [name = 'groupName']").val("")
	return true
})


/* 그룹 이름 변경 결정 */
$("#modal-group-name-change .btn-primary").on("click", function(){
	var groupName = $("#modal-group-name-change [name = 'groupName']").val()
	
	if(groupName == null || groupName == ""){
		alert("변경할 그룹 이름을 입력해주세요")
		return false
	}
	
	if(groupName.length>6){
		alert("그룹 이름을 6자리 이하로 입력해주세요")
		return false
	}
	
	var groupVo = {
		groupNo: groupNo,
		groupName: groupName,
		beforeGroupName : "${map.groupName}"
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/nameChange",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(map){
			
			if(map.result = "success"){
				alert("그룹 이름이 변경되었습니다")
				location.replace("${pageContext.request.contextPath}/group/list?no=${map.groupNo}")
				
				for(var i=0; i<map.members.length; i++){
					var notiVo = {
						userNo: map.members[i],
						notiType: 7
					}
					alertUpdate(notiVo)
				}
			}
			
		}, 
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
			
		}
	})
})


/* 그룹원 강퇴 */
$("#memberListArea").on("click", ".groupmem-delete", function(){
	var $this = $(this)
	var userName = $this.data("user")
	
	if(confirm(userName + "님을 내보내시겠습니까?") == false){
		return false
	}

	var userNo = $this.data("no")
	var groupOrder = $this.data("order")
	
	var groupVo = {
		userNo: userNo,
		groupNo: groupNo,
		groupOrder: groupOrder
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/outMember",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(result){
			
			if(result == "success"){
				alert("삭제되었습니다")
				var notiVo = {
						userNo: userNo,
						notiType: 5
					}
				alertUpdate(notiVo)
				
			}else{
				alert("그룹원이 이미 탈퇴하였습니다)")
			}

			$("#member-"+userNo).remove()
			var memberCount = $("#memberCount").text()
			$("#memberCount").text(Number(memberCount)-1)
			
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	})
	
})
 

$(".btn-leader-pass").on("click", function(){
	//console.log("그룹장 위임 버튼 클릭 > 모달")
	$("#dropdown-group-leader-pass").val("그룹원(회원) 선택")
})


$("#modal-group-leader-pass .btn-primary").on("click", function(){
	var groupLeader = $("[name = 'leaderNo']").val()
	var userName = $("[val = '" + groupLeader + "']").text()
	
	if(groupLeader == null || groupLeader == ""){
		alter("그룹원을 선택해주세요")
		return false
	}
	
	var groupVo = {
		groupLeader: groupLeader,
		groupNo: groupNo
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/leaderChange",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(groupVo),
		dataType : "json",
		
		success : function(result){
			
			if(result != "success"){
				alert("그룹장 위임을 실패했습니다")
				
				return false
				
			}else{
				alert("그룹장을 " + userName + "님에게 위임하였습니다")
				var notiVo = {
					userNo: groupLeader,
					notiType: 6
				}
				alertUpdate(notiVo)
				
				return true
				
			}
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
		
	})
})




</script>

</body>

</html>