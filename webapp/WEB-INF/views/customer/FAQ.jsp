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

    <link href="${pageContext.request.contextPath}/assets/css/FAQ.css" rel="stylesheet" type="text/css">

    <!-- fonts -->
    <link href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css" rel="stylesheet" type="text/css">

    <!-- js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <!-- 아이콘용 -->
    <script src="https://kit.fontawesome.com/5e387cb6e5.js" crossorigin="anonymous"></script>


    <title>FAQ</title>
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

                <!-- content -->
                <div class="container-fluid" id="main-content">
                    <div class="d-sm-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-dark mb-0">FAQ</h3>
                        <a class="btn btn-primary btn-sm d-none d-sm-inline-block" role="button" href="${pageContext.request.contextPath}/customer/writeInquiry">
                            <i class="fas fa-download fa-sm text-white-50"></i> &nbsp;문의하러가기
                        </a>

                    </div>
                    <div class="row">
                        <div class="col-md-12 col-xl-12 mb-12">
                            <div class="card shadow border-start-success py-2">

                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="text-primary fw-bold m-0">자주 찾는 질문</h6>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <c:forEach items="${fMap.qList}" var="faqVo">
                                            <li class="list-group-item">
                                                <div class="row align-items-center no-gutters">
                                                    <div class="col me-2">
                                                        <details>
                                                            <summary>
                                                                <h6 class="mb-0">
                                                                    <strong class="txt-FAQ">${faqVo.faqTitle}</strong>
                                                                </h6>
                                                            </summary>
                                                            <br />
                                                            <span class="text-xm">${faqVo.faqContent}</span>
                                                        </details>
                                                    </div>

                                                </div>
                                            </li>
                                        </c:forEach>

                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-xl-12 mb-12">
                            <div class="card shadow border-start-success py-2">

                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="text-primary fw-bold m-0">문의 유형별 도움말</h6>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <c:forEach items="${fMap.hList}" var="faqVo">
                                            <li class="list-group-item">
                                                <div class="row align-items-center no-gutters">
                                                    <div class="col me-2">
                                                        <details>
                                                            <summary>
                                                                <h6 class="mb-0">
                                                                    <strong class="txt-FAQ">${faqVo.faqTitle }</strong>
                                                                </h6>
                                                            </summary>
                                                            <br />
                                                            <span class="text-xm">${faqVo.faqContent}</span>
                                                        </details>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- footer -->
            <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
            <!-- /footer -->
        </div>
        <!-- content-wrapper -->
    </div>
    <!-- wrapper -->
</body>

</html>
