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
    <link href="${pageContext.request.contextPath}/assets/css/alone.css" rel="stylesheet" type="text/css">

    <!-- fonts -->
    <link href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css" rel="stylesheet" type="text/css">

    <!-- js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>

    <title>따로갔어요~ 등록폼</title>
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
                    <div id="main-content" class="container-fluid card mt-2 mb-2">
                        <h1>리뷰남기기</h1>
                        <div class="card mb-4">
                            <form id="contactForm-1" action="javascript:void(0);" method="get">
                                <input class="form-control" type="hidden" name="Introduction" value="This email was sent from www.awebsite.com" /> <input class="form-control" type="hidden" name="subject" value="Awebsite.com Contact Form" /><input class="form-control" type="hidden" name="to" value="email@awebsite.com" />
                                <div class="row">
                                    <div class="col-md-6">
                                        <div id="successfail-1"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-3">

                                        <img src="../../assets/img/assets/img/ramen.jpeg">


                                    </div>
                                    <div id="message-1" class="col-12 col-md-6">
                                        <h2 class="h4">
                                            <i class="fa fa-envelope"></i>치킨집
                                            <small>
                                                <small class="required-input">분식/라면,치킨</small>
                                            </small>
                                        </h2>
                                        <div class="form-group mb-3">
                                            <label class="form-label" for="from-name">서울특별시 관악구 3333로 222길 12-5</label>
                                            <span class="required-input">*</span>
                                            <div class="input-group">
                                                <span class="input-group-text"> <i class="fa fa-user"></i>
                                                </span> <input id="from-name-1" class="form-control" type="text" name="name" readonly="readonly" required placeholder="${authUser.userEmail}" />
                                            </div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label class="form-label" for="from-file">이미지를 선택해주세요</label><span class="required-input">*</span>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fa fa-image"></i></span><input id="from-file-1" class="form-control-file" type="file" name="file" required />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 col-sm-6 col-md-12 col-lg-6">
                                                <div class="form-group mb-3">
                                                    <label class="form-label" for="from-calltime">별점</label>

                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text"><i class="fa fa-star"></i>
                                                                <select id="from-calltime-1" class="form-select" name="call time">
                                                                    <optgroup label="주고싶은 별점을 선택하세요">
                                                                        <option value="0">☆☆☆☆☆</option>
                                                                        <option value="1" selected>★☆☆☆☆</option>
                                                                        <option value="2">★★☆☆☆</option>
                                                                        <option value="3">★★★☆☆</option>
                                                                        <option value="4">★★★★☆</option>
                                                                        <option value="5">★★★★★</option>
                                                                    </optgroup>
                                                                </select>
                                                            </span>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 col-md-12 col-lg-6">
                                                <div class="form-group mb-3">
                                                    <label class="form-label" for="from-calltime">함께한 그룹</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text"><i class="fa fa-users"></i></span>
                                                        </div>
                                                        <select id="from-calltime-1" class="form-select" name="call time">
                                                            <optgroup label="그룹을 선택해주세요">
                                                                <option value="Morning" selected>동기그룹</option>
                                                                <option value="Afternoon">개발1팀</option>
                                                                <option value="Evening">개발2팀</option>
                                                            </optgroup>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label class="form-label" for="from-comments">리뷰</label>
                                            <textarea id="from-comments-1" class="form-control" name="comments" placeholder="리뷰를 남겨주세요" rows="5"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col">
                                                    <button class="btn btn-primary d-block w-100" type="reset">
                                                        <i class="fa fa-undo"></i> 초기화
                                                    </button>
                                                </div>
                                                <div class="col">
                                                    <button class="btn btn-primary d-block w-100" type="submit">
                                                        리뷰남기기 <i class="fa fa-chevron-circle-right"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <hr class="d-flex d-md-none" />
                                    </div>
                                </div>
                            </form>
                        </div> <!-- class="card" 끝 -->
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

</html>