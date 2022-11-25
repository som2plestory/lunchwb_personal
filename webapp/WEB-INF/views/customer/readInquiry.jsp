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


    <title>내 문의 상세보기</title>
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

                <div class="container-fluid" id="main-content">

                    <div class="d-sm-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-dark mb-0">문의하기</h3>
                    </div>
                    <div class="bg-light border rounded border-light jumbotron py-5 px-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">문의 및 의견</h4>

                                <form method="post" class="mt-4 row row-cols-2" action="${pageContext.request.contextPath}/customer/readInquiry" enctype="multipart/form-data">
                                    <div class="col-1 text-center jumbotron py-1 px-4">제목</div>
                                    <div class="col-10">
                                        <textarea class="form-control h-50" name="inquiryTitle" readonly="readonly">${inqVo.inquiryTitle}</textarea>
                                    </div>
                                    <div class="col-1"></div>
                                    <div class="col-12 mt-2"></div>
                                    <div class="col-1 text-center jumbotron py-4 px-4">상세내용</div>
                                    <div class="col-10">
                                        <textarea class="form-control h-100" name="inquiryContent" readonly="readonly">${inqVo.inquiryContent}</textarea>
                                    </div>
                                    <div class="col-1"></div>
                                    <div class="col-1 text-center mt-4 pt-3">이메일</div>
                                    <div class="mt-4 col-10">
                                        <div id="loading" class="bg-light border rounded border-light jumbotron py-3 px-4">
                                            <div>${inqVo.userEmail}</div>
                                        </div>
                                    </div>
                                    <div class="col-1"></div>
                                    <div class="col-12 mt-4"></div>
                                    <div class="col-1 text-center">이미지</div>
                                    <div class="col-10 mb-4">
                                  <!--       <input id="inputFileToLoad" class="form-control" type="file" name="file" /> -->
                                    </div>
                                    <div class="col-1"></div>
                                    <div class="col-1"></div>
                                    <div class="col-11">문제 해결에 도움이 될만한 스크린샷이 있으신가요?</div>
                                    <div class="col-1"></div>
                                    <div class="col-11">1MB 이하의 JPG 또는 PNG 이미지 파일을 첨부해주세요</div>
                                    <div class="col-9"></div>
                                    <button class="btn btn-success btn-lg mt-3" style="width: 150px;" type="button" onclick="location.href='${pageContext.request.contextPath}/customer/reviewReport/${authUser.userNO}">확인</button>

                                </form>
                            </div>
                        </div>

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
