<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>부장님여기요</title>
    <link rel="stylesheet" href="../../../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo&amp;display=swap">
    <link rel="stylesheet" href="../../../assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="../../../assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="../../../assets/css/Features-Large-Icons-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="../../../assets/css/yogiyo.css">
    <link rel="stylesheet" href="../../../assets/css/group.css">
</head>
<body id="page-top">
    <div id="wrapper">
        <nav id="user-aside" class="navbar navbar-dark bg-primary align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0"><img id="bujang-logo-2" width="159" height="38" src="bujang-logo.png" href="../../그외/header+aside+footer.html" />
                <ul id="asdie-ul-2" class="navbar-nav">
                    <li class="nav-item"><a class="nav-link nav-title no-drag">나의정보</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">회원정보수정</a></li>
                    <li class="nav-item">
                        <hr class="nav-line" />
                    </li>
                    <li class="nav-item"><a class="nav-link nav-title no-drag">나의그룹</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">그룹목록</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">그룹추가</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">블랙리스트</a></li>
                    <li class="nav-item">
                        <hr class="nav-line" />
                    </li>
                    <li class="nav-item"><a class="nav-link nav-title no-drag">방문내역</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">캘린더</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">리뷰내역</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">방문통계</a></li>
                    <li class="nav-item">
                        <hr class="nav-line" />
                    </li>
                    <li class="nav-item"><a class="nav-link nav-title no-drag">고객센터</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">FAQ</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">문의하기</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">문의내역</a></li>
                    <li class="nav-item">
                        <hr class="nav-line" />
                    </li>
                    <li class="nav-item"><a class="nav-link nav-title no-drag">admin</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">가게</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">유저</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">리뷰</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">신고</a></li>
                    <li class="nav-item"><a class="nav-link nav-menu" href="#">문의</a></li>
                </ul>
            </div>
        </nav>
        <aside id="group-aside">
            <div id="group-aside-header"></div>
            <div>
                <p id="group-nav-title" class="nav-link no-drag">admin - STORE</p>
            </div>
            <ul id="group-aside-ul" class="text-center navbar-nav">
                <li class="nav-item"></li>
                <li class="nav-item"></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리1</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu group-nav-active" href="#">분식</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리3</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리4</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리5</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리6</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리7</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리8</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리9</a></li>
                <li class="nav-item"><a class="nav-link group-nav-menu" href="#">카테고리10</a></li>
            </ul>
            <ul class="navbar-nav">
                <li><button class="btn btn-primary group-nav-btn" type="button">새 가게 추가</button></li>
            </ul>
        </aside>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <nav id="header" class="navbar navbar-light navbar-expand bg-white shadow d-xxl-flex justify-content-xxl-end mb-4 topbar static-top">
                    <div class="container">
                        <div></div>
                        <ul class="navbar-nav d-xxl-flex align-items-xxl-center">
                            <li id="user-alert" class="nav-item dropdown d-xxl-flex"><a class="dropdown-toggle nav-link nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" data-bs-auto-close="outside"><span class="badge bg-danger badge-counter">3+</span><i class="fas fa-bell fa-fw"></i></a>
                                <div id="user-alert-list" class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in">
                                    <h6 class="dropdown-header">alerts center</h6><a class="dropdown-item d-flex align-items-center" href="#" style="padding: 8px 12px;">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">기주임님이 개발1팀을 ��퇴하였습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">feelis님이 초대를 거절하였습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">feelis님이 초대를 수락하였습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">개발1팀에서 퇴장당하였습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">개발1팀의 그룹장을 위임받았습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-basic">7월 23일에 남겨주신 리뷰가 광고/도배의 이유로 삭제되었습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">확인</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-choice">개발1팀에 초대되었습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">수락</button><button class="btn btn-primary btn-alert-opposite" type="button">거절</button></div>
                                    </a><a class="dropdown-item d-flex align-items-center" href="#">
                                        <div style="padding: 0px 8px 0px 0px;">
                                            <p class="alert-choice">남겨주신 문의에 답변이 등록되었습니다</p>
                                        </div>
                                        <div class="btn-group" role="group"><button class="btn btn-primary btn-alert-check" type="button">보기</button><button class="btn btn-primary btn-alert-opposite" type="button">확인</button></div>
                                    </a>
                                </div>
                            </li>
                            <li class="nav-item d-inline-flex"><button id="logout-btn" class="btn btn-primary" type="button">로그아웃</button></li>
                            <li id="menu-dropdown" class="nav-item dropdown d-xxl-flex"><a class="nav-link" aria-expanded="false" data-bs-toggle="dropdown" data-bs-auto-close="outside"><i class="fas fa-bars"></i></a>
                                <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item" href="#">나의정보</a><a class="dropdown-item" href="#">나의그룹</a><a class="dropdown-item" href="#">방문내역</a><a class="dropdown-item" href="#">고객센터</a></div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-fluid">
                    <h3 class="text-dark mb-4"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -32 576 576" width="1em" height="1em" fill="currentColor" style="font-size: 30px;">
                            <!--! Font Awesome Free 6.1.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. -->
                            <path d="M495.5 223.2C491.6 223.7 487.6 224 483.4 224C457.4 224 434.2 212.6 418.3 195C402.4 212.6 379.2 224 353.1 224C327 224 303.8 212.6 287.9 195C272 212.6 248.9 224 222.7 224C196.7 224 173.5 212.6 157.6 195C141.7 212.6 118.5 224 92.36 224C88.3 224 84.21 223.7 80.24 223.2C24.92 215.8-1.255 150.6 28.33 103.8L85.66 13.13C90.76 4.979 99.87 0 109.6 0H466.4C476.1 0 485.2 4.978 490.3 13.13L547.6 103.8C577.3 150.7 551 215.8 495.5 223.2H495.5zM499.7 254.9C503.1 254.4 508 253.6 512 252.6V448C512 483.3 483.3 512 448 512H128C92.66 512 64 483.3 64 448V252.6C67.87 253.6 71.86 254.4 75.97 254.9L76.09 254.9C81.35 255.6 86.83 256 92.36 256C104.8 256 116.8 254.1 128 250.6V384H448V250.7C459.2 254.1 471.1 256 483.4 256C489 256 494.4 255.6 499.7 254.9L499.7 254.9z"></path>
                        </svg>새 가게 추가</h3>
                    <div class="card shadow-lg o-hidden border-0 my-5">
                        <div class="card-body p-0">
                            <div class="row">
                                <div class="col-lg-7">
                                    <div class="p-5">
                                        <form class="user">
                                            <div>
                                                <div class="dropdown" style="height: 38px;"><button id="storeCate" class="btn btn-primary dropdown-toggle form-control-user" aria-expanded="false" data-bs-toggle="dropdown" type="button" style="height: 34px;margin: 0px 5px 10px 0px;padding: 5px 16px;width: 372px;" name="storeCate">카테고리</button>
                                                    <div class="dropdown-menu"><a class="dropdown-item" href="#">First Item</a><a class="dropdown-item" href="#">Second Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a><a class="dropdown-item" href="#">Third Item</a></div>
                                                </div>
                                            </div>
                                            <div style="width: 372px;"><input id="storeName" class="form-control form-control-user" type="text" placeholder="가게 이름" name="storeName" style="width: 372px;margin: 5px 0px 0px 0px;" /></div>
                                            <div><input id="starPoint" class="form-control form-control-user" type="text" placeholder="가게 별점" name="starPoint" style="margin: 5px 0px 0px 0px;width: 372px;" /></div>
                                            <div class="row mb-3" style="width: 372px;margin: 0px;"><input id="storeImg" class="form-control form-control-user" type="file" name="storeImg" style="padding: 7px 10px 5px 16px;height: 34px;width: 372px;margin: 5px 0px 0px 0px;" /></div>
                                            <div class="mb-3"><input id="storeAddress" class="form-control form-control-user" type="search" name="storeAddress" placeholder="가게 주소" style="height: 34px;padding: 16px;width: 372px;margin: 5px 0px 0px 0px;" /></div>
                                            <div class="row mb-3" style="margin: 0px 0px 0px 0px;"><a class="btn btn-warning btn-icon-split" role="button" style="width: 400px;"><span class="text-white text" style="font-weight: bold;">추가하기</span></a></div>
                                        </form>
                                    </div>
                                </div>
                                <div class="col"><img src="avatars/avatar5.jpeg" style="height: 275px;width: 250px;margin: 25px;" /></div>
                            </div>
                        </div>
                    </div>
                    <div id="cate-store-list" class="card shadow"></div>
                </div>
                <footer id="footer" class="bg-white sticky-footer" style="background-color: #ffffff;">
                    <div class="container my-auto">
                        <div class="text-center my-auto copyright"><span>Copyright © FEELIS 2022<br />https://github.com/FEELIS <br /></span></div>
                    </div>
                </footer><a class="btn btn-secondary btn-icon-split" role="button"></a>
            </div>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="assets/js/theme.js"></script>
    <script src="../../../assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="../../../assets/js/bs-init.js"></script>
    <script src="../../../assets/js/theme.js"></script>
</body>
</html>