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
    <link href="${pageContext.request.contextPath}/assets/css/calendar.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/assets/css/yogiyo.css" rel="stylesheet" type="text/css">

    <!-- fonts -->
    <link href="${pageContext.request.contextPath}/assets/fonts/fontawesome-all.min.css" rel="stylesheet" type="text/css">

    <!-- js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/liveReload.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>

    <title>부장님요기요-달력</title>
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

                <div id="main-content" class="container-fluid">
                    <div class="d-sm-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-dark mb-0">캘린더</h3>
                        <a class="btn btn-primary btn-sm d-none d-sm-inline-block" role="button" href="${pageContext.request.contextPath}/stat/addAlone">
                            <i class="fa fa-pen fa-sm text-white-50"></i>&nbsp;따로 갔다왔어요</a>
                    </div>

                    <div id="calendar-area" class="calendar card mb-4">
                        <!-- 달력js 들어가는 공간 -->
                    </div>

                </div>
                <!-- /main-content -->

            </div>
            <!-- /content -->

            <!-- footer -->
            <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
            <!-- /footer -->

        </div>
        <!-- /content-wrapper -->

    </div>
    <!-- /wrapper -->
    
    <!--  가게 정보 모달 삽입 -->
	<c:import url="/WEB-INF/views/includes/storeInfo.jsp" />
	
</body>
<script type="text/javascript">

    (function($) {
        var todayDate = new Date();
        todayDate.setHours(0, 0, 0, 0);

        //기본값들
        var defaults = {
            date: null,
            weekDayLength: 1,
            prevButton: "&lt",
            nextButton: "&gt",
            monthYearSeparator: " ",
            onClickDate: function(date) {},
            onChangeMonth: function(date) {},
            onClickToday: function(date) {},
            onClickMonthNext: function(date) {},
            onClickMonthPrev: function(date) {},
            onClickYearNext: function(date) {},
            onClickYearPrev: function(date) {},
            onShowYearView: function(date) {},
            onSelectYear: function(date) {},
            showThreeMonthsInARow: true,
            enableMonthChange: true,
            enableYearView: true,
            showTodayButton: true,
            addEventWeekday: true,
            addEventWeek: true,
            highlightSelectedWeekday: true,
            highlightSelectedWeek: true,
            todayButtonContent: "오늘",
            showYearDropdown: false,
            min: null,
            max: null,
            disable: function(date) {},
            startOnMonday: false,
            startOnSunday: true,
        };

        var el,
            selectedDate,
            yearView = false;

        var monthMap = {
            1: "1월",
            2: "2월",
            3: "3월",
            4: "4월",
            5: "5월",
            6: "6월",
            7: "7월",
            8: "8월",
            9: "9월",
            10: "10월",
            11: "11월",
            12: "12월",
        };
        
        // 1주를 일요일부터 시작하는 배열로 지정
        var dayMap = {
            0: "일요일",
            1: "월요일",
            2: "화요일",
            3: "수요일",
            4: "목요일",
            5: "금요일",
            6: "토요일",
        };

        var alternateDayMap = {
            1: "monday",
            2: "tuesday",
            3: "wednesday",
            4: "thursday",
            5: "friday",
            6: "saturday",
            7: "sunday",
        };

        //getMonth()는 0월부터 시작이여서 숫자1을 더해주어야 한다.
        function getFirstDayOfMonth(currentDate) {
            var thisDate =
                currentDate.getMonth() + 1 + "/1/" + currentDate.getFullYear();
            return new Date(thisDate);
        }

        // 이번달 마지막 날짜 구하기
        function getLastDayOfMonth(currentDate) {
            return new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
        }

        // 저번달 마지막날 구하기
        function getLastMonthLastDay(currentDate) {
            var month = currentDate.getMonth();
            var year = currentDate.getFullYear();

            if (month === 0) {
                year -= 1;
                month = 12;
            }

            return new Date(year, month, 0);
        }
        // ================================= /날짜데이터 가져오기 끝 =================================
        
        
        
        // ================================= 달력 그리기 =================================
        // 달력 정보 구성 배열로 하기
        function generateWeekData(currentDate, weekNo) {
            var firstDay = getFirstDayOfMonth(currentDate);
            var firstDayDate = firstDay.getDate();
            var lastDay = getLastDayOfMonth(currentDate);
            var lastDayFromLastMonth = getLastMonthLastDay(currentDate).getDate();
            var days = [];

            var daysFromLastMonth = firstDay.getDay();

            if (settings.startOnMonday) {
                daysFromLastMonth = daysFromLastMonth - 1;
            }

            // 달 넘어가면 1로 초기화
            var daysFromNextMonth = 1;

            if (weekNo === 1) {
                for (var dayFromLastMonth = daysFromLastMonth - 1; dayFromLastMonth >= 0; dayFromLastMonth--) {
                    var dateObj = new Date(
                        currentDate.getFullYear(),
                        currentDate.getMonth() - 1,
                        lastDayFromLastMonth - dayFromLastMonth
                    );
                    days.push(dateObj);
                }

                var daysLength = 7 - days.length;

                for (var monthDate = 0; monthDate < daysLength; monthDate++) {
                    var dateObj = new Date(
                        firstDay.getFullYear(),
                        firstDay.getMonth(),
                        firstDayDate + monthDate
                    );
                    days.push(dateObj);
                }
            } else {
                var startWeekFrom = (weekNo - 1) * 7 - daysFromLastMonth;

                for (var i = 1; i <= 7; i++) {
                    if (startWeekFrom + i <= lastDay) {
                        var dateObj = new Date(
                            currentDate.getFullYear(),
                            currentDate.getMonth(),
                            startWeekFrom + i
                        );

                        days.push(dateObj);
                    } else {
                        var dateObj = new Date(
                            currentDate.getFullYear(),
                            currentDate.getMonth() + 1,
                            daysFromNextMonth++
                        );
                        days.push(dateObj);
                    }
                }
            }
            return days;
        }

        // =====================================================================================
        //                            generateMonthData
        // =====================================================================================
        function generateMonthData(currentDate) {
            var lastMonthLast = getLastDayOfMonth(currentDate).getDate();
            var lastDayFromMonth = getLastDayOfMonth(currentDate).getDate();
            var weeks = parseInt(lastMonthLast / 7) + 1;
            var monthData = [];

            for (var weekNo = 1; weekNo <= weeks; weekNo++) {
                monthData.push(generateWeekData(currentDate, weekNo));
            }

            var lastBlock = monthData[monthData.length - 1];
            var lastDayInBlock = lastBlock[lastBlock.length - 1].getDate();

            if (
                lastDayInBlock < lastDayFromMonth &&
                lastDayFromMonth - lastDayInBlock < 7
            ) {
                monthData.push(generateWeekData(currentDate, weekNo));
            }
            return monthData;
        }


        //클릭하면 오늘로 초기화해주는 버튼
        function generateTodayButton() {
            return (
                "" +
                '<div class="special-buttons">' +
                '<button class="today-button btn btn-primary">' + settings.todayButtonContent + "</button>" +
                "</div>"
            );
        }

        //현재 연월, 일주일을 나열
        function generateYearHeaderDOM(currentDate) {
            var str = ''
            str += '<div class="d-flex align-items-center justify-content-center weeks-container">' +
                (settings.enableMonthChange ?
                    '<button class="prev-button">' + settings.prevButton + "</button>" :
                    "") +
                '<h1 class="month fw-bold mt-5 mb-5 text-uppercase">' +
                currentDate.getFullYear() + '년' +
                settings.monthYearSeparator + monthMap[currentDate.getMonth() + 1] +
                "</h1>" +
                (settings.enableMonthChange ?
                    '<button class="next-button">' + settings.nextButton + "</button>" :
                    "");
            if (settings.showTodayButton) {
                str += generateTodayButton();
              }

            str += '</div>';
            
            str +=
                '<ol class="day-names list-unstyled week' +
                (settings.startOnSunday ? " start-on-sunday" : "") +
                '" data-week-no="' +
                0 +
                '">';

            for (var weekDay in dayMap) {
                if (dayMap.hasOwnProperty(weekDay)) {
                    str +=
                        '<li class="fw-bold day" data-day="' +
                        weekDay +
                        '">' +
                        dayMap[weekDay] +
                        "</li>";
                }
            }
            str += "</ol>";
            return str;
        }
        // headerDom 끝


        // 일주일마다 방문한 곳 정보 올리기
        function generateWeekDOM(monthData, currentDate) {
            var str = "";

            // 달력에 날짜별로 for문출력
            monthData.forEach(function(week, weekNo) {

                str +=
                    '<ol class="days list-unstyled week' +
                    (settings.startOnSunday ? " start-on-sunday" : "") +
                    '" data-week-no="' +
                    (weekNo + 1) +
                    '">';

                week.forEach(function(day, dayNo) {
                    var disabled = false;
                    if (day.getMonth() !== currentDate.getMonth()) disabled = true;
                    disabled = disabled ? " disabled" : "";

                    var selected = false;
                    if (selectedDate) {
                        if (day == selectedDate.toString()) selected = true;
                        selected = selected ? " selected" : "";
                    } else {
                        selected = "";
                    }
			
                    var today = false;
                    var todayColor = false;

                    if (day == todayDate.toString()) today = true;
                    today = today ? " today" : "";
                    todayColor = today ? " bg-warning" : "";
			
                    var dateDisabled = "ola";
                    if (
                        (settings.min && settings.min > day) ||
                        (settings.max && settings.max < day) ||
                        (settings.disable &&
                            typeof settings.disable === "function" &&
                            settings.disable(day))
                    ) {
                        dateDisabled = 'disabled="disabled" ';
                    }

                    str += '<li class="';
                    
                     str +='day' + disabled + selected + today + '" data-date="' + day + '" ' + dateDisabled + '>' +
                        '<div class="date">' +
                        '<span class="d-flex flex-row-reverse"><span class="' + todayColor + '">' + day.getDate() + '</span></span>' +
                        '</div>';
                        
                    // 이전달이나 다음달이면 라벨제거   
                    if (disabled == false) {
                        str += '<div id="vday' + (day.getDate() - 1) + '" class="visited"' +
                            'data-vdate="' +
                            day +
                            '"></div>'
                    }
                    str += '</li>';
                });
                str += "</ol>";
            });
            return str;
        }

        // 모은 정보 html로 출력
        function generateDomString(monthData, currentDate) {


            var calendarDump = "";
            calendarDump += generateYearHeaderDOM(currentDate);
            calendarDump += generateWeekDOM(monthData, currentDate);

            return calendarDump;
        }

        // 날짜 강조
        function addEvent(monthData, currentDate) {

            var selectedElement = document.getElementsByClassName('visited');

            var userNo = '${authUser.userNo}';
            var selectMonth = currentDate.getFullYear() + settings.monthYearSeparator + (currentDate.getMonth() + 1);

            var vstVo = {
                userNo: userNo,
                selectMonth: selectMonth
            };

            // 달력라벨 띄우기
            $.ajax({
                url: "${pageContext.request.contextPath}/stat/showVstList",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(vstVo),

                dataType: "json",
                success: function(vstList) {
                	
                    var j = 0;
                    
                    if (vstList.length > 0) {

                    for (var i = 0; i < selectedElement.length; i++) {
                        var thisdate = selectedElement[i].dataset.vdate;

                        // DDD MM YYYY 형식으로 짤라주기
                        thisdate = thisdate.substring(4, 15)
                        
                        // 한달에 최대 5개의 그룹을 보여준다
                        var str = '';
                        
                        
	                        if (vstList[j].visitedDate === thisdate) {
	                            str += '<div class="event ';
	                            if (vstList[j].seq === 1) {
	                                str += 'bg-success ';
	                            } else if (vstList[j].seq === 2) {
	                                str += 'bg-warning ';
	                            } else if (vstList[j].seq === 3) {
	                                str += 'bg-danger ';
	                            } else if (vstList[j].seq === 4) {
	                                str += 'bg-info ';
	                            } else if (vstList[j].seq === 5) {
	                                str += 'bg-secondary ';
	                            }
	                            str += 'show-menu" data-visit="'+vstList[j].visitedDate+'" data-storeno="'+vstList[j].storeNo+'">' + vstList[j].menu1stCateName;
	                            
	                            if (vstList[j].menuName != null) {
	                        	    str += "/" + vstList[j].menuName
								}
	                            str += '</div>';
	                            
	                            str += '<div class="event ';
	                            if (vstList[j].seq === 1) {
	                                str += 'bg-success ';
	                            } else if (vstList[j].seq === 2) {
	                                str += 'bg-warning ';
	                            } else if (vstList[j].seq === 3) {
	                                str += 'bg-danger ';
	                            } else if (vstList[j].seq === 4) {
	                                str += 'bg-info ';
	                            } else if (vstList[j].seq === 5) {
	                                str += 'bg-secondary ';
	                            }
	
	                            str += 'show-menu" data-visit="'+vstList[j].visitedDate+'" data-storeno="'+vstList[j].storeNo+'">' + vstList[j].storeName + '</div>';
	                            $("#vday" + i).after(str);
	
	                            j++;
	
	                        }
                        
                        

                        if (vstList.length <= j) {
                            break;
                      	 	}
                    	}
                    }

                },
                error: function(XHR, status, error) {
                    console.error(status + " : " + error);
                }

            })
            // ajax 끝 
        }


        function highlightDays() {
            var selectedElement = el.find(".selected");

            if (selectedElement.length > 0) {
                var date = new Date(selectedElement.data("date"));
                var weekDayNo = date.getDay();
                el.find(".week").each(function(i, elm) {
                    $(elm)
                        .find(".day:eq(" + (weekDayNo - 0) + ")")
                        .addClass("highlight");
                });
            }
        }
        // 주간 강조
        function highlightWeek() {
            el.find(".selected").parents(".week").addClass("highlight");
        }

        // 렌더링
        function renderToDom(currentDate) {
            var monthData = generateMonthData(currentDate);

            el.html(generateDomString(monthData, currentDate));

            if (settings.addEventWeekday) {
                addEvent(monthData, currentDate);
            }
            if (settings.highlightSelectedWeekday) {
                highlightDays();
            }
            if (settings.highlightSelectedWeek) {
                highlightWeek();
            }
        }

        $.fn.updateCalendarOptions = function(options) {
            var updatedOptions = $.extend(settings, options);
            var calendarInitFn = $.fn.calendar.bind(this);
            calendarInitFn(updatedOptions);
        };


        $.fn.calendar = function(options) {
            settings = $.extend(defaults, options);
            if (settings.startOnMonday) {
                dayMap = alternateDayMap;
            }
            if (settings.min) {
                settings.min = new Date(settings.min);
                settings.min.setHours(0);
                settings.min.setMinutes(0);
                settings.min.setSeconds(0);
            }
            if (settings.max) {
                settings.max = new Date(settings.max);
                settings.max.setHours(0);
                settings.max.setMinutes(0);
                settings.max.setSeconds(0);
            }

            el = $(this);
            var currentDate;

            if (settings.date) {
                if (typeof settings.date === "string") {
                    selectedDate = new Date(settings.date);
                } else {
                    selectedDate = settings.date;
                }
                selectedDate.setHours(0, 0, 0, 0);
                currentDate = selectedDate;
            } else {
                currentDate = todayDate;
            }

            window.currentDate = currentDate;
            renderToDom(currentDate);

            if (settings.enableMonthChange) {
                el.off("click", ".weeks-container .prev-button").on(
                    "click",
                    ".weeks-container .prev-button",
                    function(e) {
                        currentDate = new Date(
                            currentDate.getFullYear(),
                            currentDate.getMonth() - 1,
                            1
                        );
                        settings.onClickMonthPrev(currentDate);
                        renderToDom(currentDate);
                    }
                );

                el.off("click", ".weeks-container .next-button").on(
                    "click",
                    ".weeks-container .next-button",
                    function(e) {
                        currentDate = new Date(
                            currentDate.getFullYear(),
                            currentDate.getMonth() + 1,
                            1
                        );
                        settings.onClickMonthNext(currentDate);
                        renderToDom(currentDate);
                    }
                );
            }

            el.off("click", ".day.disabled").on("click", ".day.disabled", function(e) {
                var date = $(this).data("date");
                var isDisabled = $(this).attr("disabled") === "disabled";
                if (isDisabled) return;
                settings.onClickDate(date);
            });

            if (settings.enableMonthChange && settings.enableYearView) {
                el.off("click", ".month-container").on(
                    "click",
                    ".month-container",
                    function(e) {
                        yearView = true;
                        currentDate = new Date(currentDate.getFullYear(), 0, 1);
                        settings.onShowYearView(currentDate);
                        renderToDom(currentDate);
                    }
                );

                el.off("click", ".months-container .month").on(
                    "click",
                    ".months-container .month",
                    function(e) {
                        var monthEl = $(this);
                        var month = monthEl.data("month");
                        var year = monthEl.data("year");
                        var selectedMonth = new Date(year, month - 1, 1);
                        settings.onChangeMonth(selectedMonth);

                        currentDate = selectedMonth;
                        yearView = false;

                        renderToDom(currentDate);
                    }
                );

                el.off("click", ".months-container .prev-button").on(
                    "click",
                    ".months-container .prev-button",
                    function(e) {
                        currentDate = new Date(currentDate.getFullYear() - 1, 0, 1);
                        settings.onClickYearPrev(currentDate);
                        settings.onSelectYear(currentDate);
                        renderToDom(currentDate);
                    }
                );

                el.off("click", ".months-container .next-button").on(
                    "click",
                    ".months-container .next-button",
                    function(e) {
                        currentDate = new Date(currentDate.getFullYear() + 1, 0, 1);
                        settings.onClickMonthNext(currentDate);
                        settings.onSelectYear(currentDate);
                        renderToDom(currentDate);
                    }
                );

                el.off("change", ".months-container .year-dropdown").on(
                    "change",
                    ".months-container .year-dropdown",
                    function(e) {
                        var year = $(this).val();
                        currentDate = new Date(year, 0, 1);
                        settings.onSelectYear(currentDate);
                        renderToDom(currentDate);
                    }
                );
            }

            if (settings.showTodayButton) {
                el.off("click", ".today-button").on(
                    "click",
                    ".today-button",
                    function(e) {
                        currentDate = todayDate;
                        selectedDate = todayDate;
                        settings.onClickToday(todayDate);
                        yearView = false;
                        renderToDom(currentDate);
                    }
                );
            }
            return this;
        };
    })(jQuery); //jquery로 취급하겠다 라고 선언
    


    // eval로 문구(String 타입)를 자바스크립트로 변환한다.
    var config =
        `function selectDate(date) {
      $('.calendar').updateCalendarOptions({
         date: date
      });
   }

   var defaultConfig = {
      weekDayLength: 1,
      date: new Date(),
      onClickDate: selectDate,
      showYearDropdown: true,
      startOnMonday: false,
      startOnSunday: true,
   };
   
   $('.calendar').calendar(defaultConfig);`;
    eval(config);
</script>

</html>
