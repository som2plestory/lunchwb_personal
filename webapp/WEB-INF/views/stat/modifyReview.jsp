<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="og:type" content="article">

    <!-- 파비콘 -->
    <link href="${pageContext.request.contextPath}/assets/img/bujang.png" rel="shortcut icon" type="image/x-icon">

    <!-- css -->
    <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/assets/css/yogiyo.css" rel="stylesheet" type="text/css">


    <!-- fonts -->
    <link href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css" rel="stylesheet" type="text/css">

    <!-- js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>


    <title>따로갔어요~ 수정폼</title>
</head>

<body>
    <div id="wrapper">
        <!-- aside -->
        <c:import url="/WEB-INF/views/includes/aside/userAside.jsp"></c:import>
        <!-- /aside -->

        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">

                <!-- header -->
                <c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
                <!-- /header -->
                <div>

                <div class="container-fluid card">
                    <h1 class="font-weight-bold card-head">리뷰 수정하기</h1>
                    <form id="contactForm-1" action="${pageContext.request.contextPath}/stat/modifyReview" method="post" class="card-body" enctype="multipart/form-data">
                        <input class="form-control" type="hidden" name="reviewNo" value="${aloneVo.reviewNo}" /> 
                        <div class="row">
                            <div class="col-md-6">
                                <div id="successfail-1"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3">
                                <img src="${pageContext.request.contextPath}/upload/${aloneVo.reviewFileName}" class="img-fluid w-100 h-75">
                            </div>
                            <div id="message-1" class="col-12 col-md-6">
                                <h2 class="h4">
                                    <i class="fas fa-utensils"></i> ${aloneVo.storeName} 
                                    <small> 
                                    	<small class="required-input">${aloneVo.menu1stCateName}/${aloneVo.menuName}</small>
                                    </small>
                                </h2>
                                <div class="form-group mb-3">
                                    <label class="form-label" for="from-name">${aloneVo.storeRoadAddress}</label> <span class="required-input">*</span>
                                    <div class="input-group col-auto">
                                        <span class="input-group-text"> <i class="fa fa-user"></i>
                                        </span> <input id="from-name-1" class="form-control bg-white" type="text" name="name" value="${aloneVo.userName}" 
                                        readonly="readonly" required />
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label" for="from-file">이미지를 선택해주세요</label> <span class="required-input">*</span>
                                    <div class="input-group">
                                        <span class="input-group-text"> <i class="fa fa-file"></i></span> 
                                        <input  id="from-file-1" class="form-control-file" type="file" name="file"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 col-sm-6 col-md-12 col-lg-6">
                                        <div class="form-group mb-3">
                                            <label class="form-label" for="from-calltime">별점</label>
                                            <div class="input-group col-auto">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="fa fa-star"></i></span>
                                                </div>
                                                <div id="today-star-icon" class="text-warning no-drag list-inline form-control">
                                                    <input type="hidden" name="userScore" value="0" /> 
                                                    <i id="star-1" class="far fa-star starScore" data-score="1" data-stt="off"></i> 
                                                    <i id="star-2" class="far fa-star starScore" data-score="2" data-stt="off"></i> 
                                                    <i id="star-3" class="far fa-star starScore" data-score="3" data-stt="off"></i> 
                                                    <i id="star-4" class="far fa-star starScore" data-score="4" data-stt="off"></i> 
                                                    <i id="star-5" class="far fa-star starScore" data-score="5" data-stt="off"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 col-md-12 col-lg-6">
                                        <div class="form-group mb-3 col-auto">
                                            <label class="form-label" for="from-calltime">함께한 그룹</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"> <i class="fa fa-users"></i>
                                                    </span>
                                                </div>
                                                <input  id="from-name-1" class="form-control bg-white" type="text" name="groupName" value="${aloneVo.groupName}" 
                                                		readonly="readonly"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label" for="from-comments">리뷰</label>
                                    <textarea id="from-comments-1" class="form-control" name="reviewContent" maxlength="40" placeholder="리뷰를 남겨주세요" rows="5">${aloneVo.reviewContent}</textarea>
                                </div>
                                <div class="form-group mb-3">
                                    <div class="row">
                                        <div class="col">
                                            <button class="btn btn-primary d-block w-100" type="button" 
                                            		onclick="location.href='${pageContext.request.contextPath}/stat/reviewList'">
                                                <i class="fa fa-chevron-circle-left "></i> 리뷰내역으로 돌아가기
                                            </button>
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-primary d-block w-100" type="submit">
                                                리뷰수정하기 <i class="fa fa-chevron-circle-right"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <hr class="d-flex d-md-none" />
                            </div>
                        </div>
                    </form>
                	</div>
                </div>

            </div>
            <!-- content -->



            <!-- footer -->
            <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
            <!-- /footer -->
        </div>
        <!-- content-wrapper -->
    </div>
    <!-- wrapper -->
</body>
<script type="text/javascript">
	// 첫 화면 이전 별점
	$(document).ready(function() {
	    var userScore = '${aloneVo.userScore}';
	
	    $("#star-" + userScore).click();
	})
	
	//리뷰 > 별점 그리기
	$("#today-star-icon")
	    .on(
	        "click",
	        ".starScore",
	        function() {
	            var score = $(this).attr("data-score")
	            var state = $(this).attr("data-stt")
	
	            if (state == "off") {
	                $("#today-star-icon [name='userScore']").val(score)
	                for (var i = 1; i <= score; i++) {
	                    document.getElementById("star-" + i).className = "fas fa-star starScore"
	                    $("#star-" + i).attr("data-stt", "on")
	                }
	
	            } else if (state == "on") {
	                $("#today-star-icon [name='userScore']").val(
	                    score - 1)
	                for (var i = score; i <= 5; i++) {
	                    document.getElementById("star-" + i).className = "far fa-star starScore"
	                    $("#star-" + i).attr("data-stt", "off")
	                }
	            }
	
	        })
	
	// 별 아이콘 위 마우스 올렸을 때        
	$(".starScore").hover(function() {
	    var score = $(this).attr("data-score")
	    var state = $(this).attr("data-stt")
	
	    // 마우스 hover 중일 때
	    if (state == "off") {
	        $("#today-star-icon [name='userScore']").val(score)
	        for (var i = 1; i <= score; i++) {
	            document.getElementById("star-" + i).className = "fas fa-star starScore"
	            $("#star-" + i).attr("data-stt", "on")
	        }
	
	    } else if (state == "on") {
	        $("#today-star-icon [name='userScore']").val(
	            score - 1)
	        for (var i = score; i <= 5; i++) {
	            document.getElementById("star-" + i).className = "far fa-star starScore"
	            $("#star-" + i).attr("data-stt", "off")
	        }
	    }
	
	}, function() {
	    var score = $(this).attr("data-score")
	    var state = $(this).attr("data-stt")
	
	    // 마우스 hover 후 마우스를 다른 곳으로 옮겼을 때
	    if (state == "off") {
	        $("#today-star-icon [name='userScore']").val(score)
	        for (var i = 1; i <= score; i++) {
	            document.getElementById("star-" + i).className = "fas fa-star starScore"
	            $("#star-" + i).attr("data-stt", "on")
	        }
	
	    } else if (state == "on") {
	        $("#today-star-icon [name='userScore']").val(
	            score - 1)
	        for (var i = score; i <= 5; i++) {
	            document.getElementById("star-" + i).className = "far fa-star starScore"
	            $("#star-" + i).attr("data-stt", "off")
	        }
	    }
	});
</script>

</html>
