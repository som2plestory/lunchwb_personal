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


    <title>문의내역</title>
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



                <!-- 회원들 문의내역 읽기  -->
                <div class="container-fluid">
                    <h3 class="text-dark mb-4">문의내역</h3>
                    <div class="card shadow">
                        <div class="card-header py-3">
                            <p class="text-danger m-0 fw-bold">허위사실 신고, 욕설, 도배행위등은 경고없이 계정이 정지될 수 있습니다.</p>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 text-nowrap">
                                    <div id="dataTable_length" class="dataTables_length" aria-controls="dataTable">
                                        <label class="form-label">Show&nbsp; <select class="d-inline-block form-select form-select-sm">
                                                <option value="10" selected="">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>&nbsp;
                                        </label>
                                    </div>
                                </div>


                                <div class="col-md-6">
                                    <div class="text-md-end dataTables_filter" id="dataTable_filter">
                                        <label class="form-label"> <input type="search" class="form-control form-control-sm" aria-controls="dataTable" placeholder="Search">
                                        </label>
                                        <button class="btn btn-primary py-0" type="button">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>

                            </div>
                            <!-- row 종료 -->


                            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                                <table class="table my-0" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>답변상태</th>
                                            <th>문의번호</th>
                                            <th>공란</th>
                                            <th>문의날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach items="${inqList}" var="inqVo" varStatus="status">
                                            <tr onclick="location.href='${pageContext.request.contextPath}/customer/readInquiryForm/${inqVo.inquiryNo}'">
                                                <td>${status.count}</td>
                                                <td>${inqVo.inquiryTitle}</td>

                                                <c:choose>
                                                    <c:when test="${inqVo.inquiryStatus eq '접수'}">
                                                        <td class="text-primary">접수</td>
                                                    </c:when>
                                                    <c:when test="${inqVo.inquiryStatus eq '접수중'}">
                                                        <td class="text-warning">접수중</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td class="text-secondary">답변완료</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>${inqVo.inquiryNo}</td>
                                                <td>----</td>
                                                <td>${inqVo.inquiryDate }</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td><strong></strong></td>
                                            <td><strong></strong></td>
                                            <td><strong></strong></td>
                                            <td><strong></strong></td>
                                            <td><strong></strong></td>
                                            <td><strong></strong></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                                        <ul class="pagination">
                                            <li class="page-item disabled">
	                                            <a class="page-link" aria-label="Previous" href="#">
                                            		<span aria-hidden="true">«</span>
	                                            </a>
                                            </li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item">
                                            	<a class="page-link" href="#">2</a></li>
                                            <li class="page-item">
                                            	<a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                            	<a class="page-link" aria-label="Next" href="#"> 
                                            		<span aria-hidden="true">»</span>
                                            	</a>
                                           	</li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- row 종료 -->

                        </div>
                    </div>
                </div>
                <!-- 문의내역 읽기 종료 -->
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
