<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>부장님요기요: 블랙리스트</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/bujang.png">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Bold-BS4-Responsive-Pricing-Table-Snippet.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/yogiyo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-jw.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customModal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/group.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/alert.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/ionicons.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/storeInfo.css">
	
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/bs-init.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>

</head>

<body id="page-top">

	<div id="wrapper" class="no-drag">

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
					</h3>
					<div id="group-blacklist" class="card shadow">
						<div class="card-header py-3">
							<p class="text-primary m-0 fw-bold">블랙리스트 목록</p>
						</div>
						<div class="card-body">
							<!-- 
							<span class="blacklist-search"><input type="text"
								placeholder="가게 이름을 입력해주세요" />
							<button class="btn btn-primary btn-store-search" type="button">검색</button></span>
							 -->
							<div class="table-responsive table mt-2 store-list-table" role="grid" aria-describedby="dataTable_info">
								<table id="dataTable" class="table my-0">
									<thead>
										<tr>
											<th style="width: 25%;">가게 이름</th>
											<th style="width: 15%;">카테고리</th>
											<th style="width: 50%;">가게 위치</th>
											<th style="width: 10%;">
												<c:if test="${map.groupLeader == authUser.userNo}">삭제</c:if>
											</th>
										</tr>
									</thead>
									<tbody id="black-body" class="text-dark">
										<c:if test="${map.blackCount == 0}">
											<tr id="nonBlack">
												<td colspan="4" >블랙리스트에 추가된 음식점이 존재하지 않습니다</td>
											<tr>
										</c:if>
										<c:forEach items="${map.blacklist}" var="blackVo" varStatus="status">
											<tr id="black-${blackVo.storeNo}">
												<td class="black-store-name" data-storeno="${blackVo.storeNo}">${blackVo.storeName}</td>
												<td>${blackVo.menu2ndCateName}</td>
												<td>${blackVo.storeRoadAddress}</td>
												<c:if test="${map.groupLeader == authUser.userNo}">
													<td class="text-warning">
														<i class="fas fa-trash group-black-delete" data-storeno="${blackVo.storeNo}"></i>
													</td>
												</c:if>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<div class="row">
								<div class="col-md-6 align-self-center">
									<p class="dataTables_info" role="status" aria-live="polite">
										총 개수 : <span id="black-count">${map.blackCount}</span>
									</p>
								</div>
								
								<!-- 
								<div class="col-md-6">
									<nav
										class="d-lg-flex justify-content-lg-end visible dataTables_paginate paging_simple_numbers">
										<ul class="pagination">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Previous" href="#"><span aria-hidden="true">«</span></a></li>
											<li class="page-item active"><a class="page-link"
												href="#">1</a></li>
											<li class="page-item"><a class="page-link" href="#">2</a></li>
											<li class="page-item"><a class="page-link" href="#">3</a></li>
											<li class="page-item"><a class="page-link"
												aria-label="Next" href="#"><span aria-hidden="true">»</span></a></li>
										</ul>
									</nav>
								</div>
								 -->
								
							</div>							

						</div>
					</div>
					
					<c:if test="${authUser.userNo == map.groupLeader}">
						<div id="group-blacklist-add" class="card shadow">
							<div class="card-header py-3">
								<p class="text-primary m-0 fw-bold">
									<strong>블랙리스트 추가하기</strong><br />
								</p>
							</div>
							<div class="card-body">
								<div id="black-add-search">
									<input id="store-search" type="text" placeholder="가게 이름을 입력해주세요" name="keyword"/>
									<button id="search2" class="btn btn-primary btn-store-search" type="button">검색</button>
									<div>
										<span id="store-search-limit">
											<!-- 현재위치에서 1km 이내의 음식점이 검색됩니다 -->
											현재 블랙리스트에 포함된 음식점은 검색결과에 포함되지 않습니다										
										</span>
									</div>
								</div>
								<div class="table-responsive table mt-2 store-list-table" role="grid" aria-describedby="dataTable_info">
									<table id="dataTable-1" class="table my-0">
										<thead>
											<tr>
												<th style="width: 25%;">가게 이름</th>
												<th style="width: 15%;">카테고리</th>
												<th style="width: 50%;">가게 위치</th>
												<th style="width: 10%;">추가</th>
											</tr>
										</thead>
										<tbody id="black-add-body">
											<tr id="nonSearch">
												<td colspan="4" >음식점을 검색해주세요</td>
											<tr>											
										</tbody>
									</table>
								</div>
								<div class="row">
									<div class="col-md-6 align-self-center">
										<p class="dataTables_info" role="status" aria-live="polite">
											총 개수 : <span id="black-search-count">0</span>
										</p>
									</div>
									
									<!-- 
									페이징
									<div class="col-md-6">
										<nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
											<ul class="pagination">
												<li class="page-item disabled"><a class="page-link"
													aria-label="Previous" href="#"><span aria-hidden="true">«</span></a></li>
												<li class="page-item active"><a class="page-link"
													href="#">1</a></li>
												<li class="page-item"><a class="page-link" href="#">2</a></li>
												<li class="page-item"><a class="page-link" href="#">3</a></li>
												<li class="page-item"><a class="page-link"
													aria-label="Next" href="#"><span aria-hidden="true">»</span></a></li>
											</ul>
										</nav>
									</div>
									 -->
									 
								</div>
							</div>
						</div>
					</c:if>
					
				</div>
				<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
				
			</div>
		</div>
	<a class="border rounded d-inline scroll-to-top" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	</div>


<!--  가게 정보 모달 삽입 -->
<c:import url="/WEB-INF/views/includes/storeInfo.jsp" />


<script type="text/javascript">

//검색 결과 > 추가시 배열에 저장: 
var blackAdded = []

//블랙할 가게 검색 > 엔터
var input = document.getElementById("store-search")

input.addEventListener("keyup", function (event) {
	if (event.keyCode === 13) {
		event.preventDefault();
		document.getElementById("search2").click()
	}
})


//블랙할 가게 검색하기
$("#black-add-search button").on("click", function(){
	var keyword = $("#black-add-search [name = 'keyword']").val()
	var groupNo = "${map.groupNo}"
	
	if(keyword == null || keyword == ""){
		alert("검색어를 입력해주세요")
		return false
	}
	
	if(keyword.length < 2){
		alert("검색어를 두 글자 이상 입력해주세요")
		return false
	}
	
	var blackVo = {
		keyword : keyword,
		groupNo : groupNo
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/black/store/search",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(blackVo),
		dataType : "json",
		
		success : function(searchList){
			
			if(searchList.length == 0){
				alert("검색결과가 존재하지 않습니다")
				$("#black-add-search [name = 'keyword']").val("")
				return false
			}
			
			$("#nonSearch").remove()
			$("#black-add-search [name = 'keyword']").val("")
			$("#black-add-body").html("")
			
			for(var i=0; i<searchList.length; i++){
				renderTable(searchList[i], 2)
			}
			
			$("#black-search-count").text(searchList.length)
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
		
	})
})


//블랙리스트/검색목록 row 그리기
//어차피 블랙 추가/제거는 리더만 가능 그릴 때 검사하지 않겠다
//opt = 1 : 블랙리스트 목록에 > prep / opt = 2 : 검색목록 > append
function renderTable(blackVo, opt){
	var str = ''
	
	if(opt == 1){
		str += '<tr id="black-' + blackVo.storeNo + '">'
		str += '	<td class="black-store-name" data-storeno="' + blackVo.storeNo + '">' + blackVo.storeName + '</td>'
	
	}else {
		str += '<tr id="search-'+ blackVo.storeNo +'">'
		str += '	<td class="store-search-name" data-storeno="' + blackVo.storeNo + '">' + blackVo.storeName + '</td>'
	}
	
	str += '	<td>' + blackVo.menu2ndCateName +'</td>'
	str += '	<td>' + blackVo.storeRoadAddress + '</td>'
	
	if(opt == 1){
		str += '		<td class="text-warning">'
		str += '			<i class="fas fa-trash group-black-delete" data-storeno="' + blackVo.storeNo + '"></i>'
		
	}else{
		str += '	<td>'
		str += '		<svg class="text-primary group-black-add" data-storeno="' + blackVo.storeNo + '" xmlns="http://www.w3.org/2000/svg" viewBox="-32 0 512 512" width="1em" height="1em" fill="currentColor">'
		str += '			<path d="M432 256c0 17.69-14.33 32.01-32 32.01H256v144c0 17.69-14.33 31.99-32 31.99s-32-14.3-32-31.99v-144H48c-17.67 0-32-14.32-32-32.01s14.33-31.99 32-31.99H192v-144c0-17.69 14.33-32.01 32-32.01s32 14.32 32 32.01v144h144C417.7 224 432 238.3 432 256z"></path>'
		str += '		</svg>'
	}

	str += '	</td>'
	str += '</tr>'
	
	if(opt == 1){
		$("#black-body").prepend(str)
		
	}else{
		$("#black-add-body").append(str)
	}
	
}


//그룹블랙리스트 페이지) black-add-body 테이블/가게모달/리뷰모달/메뉴모달 블랙 추가 버튼 클릭
//모달에서 온 애들은 검색해서 가져와야해서
//addNo = 0 검색해서 추가 / addNo = 1 모달에서 추가
$("#black-add-body").on("click", ".group-black-add", function(){
	if(confirm("블랙리스트로 추가하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
	}
	
	addBlackThis(blackVo, 0)
})

$("#modal-store").on("click", ".modal-btn-add-black", function(){
	if(confirm("블랙리스트로 추가하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
	}
	
	addBlackThis(blackVo, 1)
})

$("#modal-reviews").on("click", ".modal-btn-add-black", function(){
	if(confirm("블랙리스트로 추가하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
	}
	
	addBlackThis(blackVo, 1)
})

$("#modal-all-menu").on("click", ".modal-btn-add-black", function(){
	if(confirm("블랙리스트로 추가하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
	}
	
	addBlackThis(blackVo, 1)
})


//블랙추가 함수 
//addNo = 0 > 테이블에서 추가
//addNo = 1 > 모달에서 추가
function addBlackThis(blackVo, addNo){
	$.ajax({
		url : "${pageContext.request.contextPath}/group/blacklist/add",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(blackVo),
		dataType : "json",
		
		success : function(addBlackVo){
			if(addBlackVo != null){
				
				alert("블랙리스트 추가 완료")

				$("#nonBlack").remove()
				$("#black-count").text(Number($("#black-count").text()) +1)
				
				//검색테이블에서 블랙추가 버튼 삭제
				$("#search-" + addBlackVo.storeNo + " .group-black-add").remove()
				
				//블랙리스트 목록에 추가
				renderTable(addBlackVo, 1)
				//추가된 목록
				blackAdded.push(addBlackVo.storeNo)
				//console.log(blackAdded)
				
			}else{
				alert("블랙리스트 추가 실패")
			}
		},
		error : function(XHR, status, error) {
			//console.error(status + " : " + error);
		}
	})
}



//그룹블랙리스트 페이지) black-body 테이블/가게모달/리뷰모달/메뉴모달 블랙 삭제 버튼 클릭
$("#black-body").on("click", ".group-black-delete", function(){
	if(confirm("삭제하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
		
		blackDel(blackVo, 1)
	}
})
		
$("#modal-store").on("click", ".modal-btn-del-black", function(){
	if(confirm("삭제하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
		
		blackDel(blackVo, 1)
	}
})
		
$("#modal-reviews").on("click", ".modal-btn-del-black", function(){
	if(confirm("삭제하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
		
		blackDel(blackVo, 1)
	}
})

$("#modal-all-menu").on("click", ".modal-btn-del-black", function(){
	if(confirm("삭제하시겠습니까?")){
		var blackVo = {
			storeNo : $(this).attr("data-storeno"),
			groupNo : "${map.groupNo}"
		}
		
		blackDel(blackVo, 1)
	}
})


//블랙리스트 삭제 > 테이블에서 삭제
function delBlackTable(storeNo){
	$("#black-count").text($("#black-count").text() -1)
	$("#black-" + storeNo).remove()
}



</script>

</body>
</html>