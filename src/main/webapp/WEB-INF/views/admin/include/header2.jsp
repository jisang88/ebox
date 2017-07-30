<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>

<!-- Bootstrap 3.3.4 -->
<link href="${pageContext.request.contextPath }/resources/dist/bootstrap-3.3.2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<!-- Font Awesome Icons -->
<link href="${pageContext.request.contextPath }/resources/dist/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Ionicons -->
<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />

<!-- Gnb Menu CSS -->
<link href="${pageContext.request.contextPath }/resources/css/admin/gnb_menu.css" rel="stylesheet">

<!-- Ripple Effect -->
<link href="${pageContext.request.contextPath }/resources/plugin/Waves-0.7.5/waves.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="${pageContext.request.contextPath }/resources/dist/jquery-3.2.1/jquery-3.2.1.min.js"></script>

<!-- Ripple Effect -->
<script src="${pageContext.request.contextPath }/resources/plugin/Waves-0.7.5/waves.min.js"></script>

<!-- pace-1.0.2 -->
<link href="${pageContext.request.contextPath }/resources/plugin/pace-1.0.2/themes/blue/pace-theme-minimal.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="mprogress"></div>
	<div class="navbar-wrapper">
		<nav class="navbar navbar-default">
			<div class="container-fluid">

				<div class="navbar-header">
					<ul class="ebox-navbar-nav navbar-left">
						<li id="gnb-navbar-header-wrap"><a href="#" class="text-primary waves-effect navbar-brand" id="gnb-navbar-header"> E BOX </a></li>
						<li id="btn-open-sidebar-wrap"><a href="#" class="text-muted waves-effect border-round" id="btn-open-sidebar"><i class="fa fa-bars fa-lg" aria-hidden="true"></i></a></li>
					</ul>
				</div>

				<ul class="ebox-navbar-nav navbar-right">
					<li><a href="#" class="text-muted  waves-effect border-round"><i class="fa fa-user-o fa-lg" aria-hidden="true"></i></a></li>
					<li><a href="#" class="text-muted  waves-effect border-round"><i class="fa fa-bell-o fa-lg" aria-hidden="true"></i></a></li>
					<li><a href="#" class="text-muted  waves-effect border-round"><i class="fa fa-envelope-o fa-lg" aria-hidden="true"></i></a></li>
				</ul>

			</div>
		</nav>
	</div>


	<div class="sidebar-wrapper">
		<nav class="sidebar ">

			<ul class="sidebar-nav">

				<li><a href="#" class="text-muted sidebar-nav-parent-item">시설 관리<span class="mark-arrow"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a>
					<ul id="sidebar-nav-item1" class=" sidebar-nav-item">
						<li><a href="${pageContext.request.contextPath }/admin/theater/list" class="  text-muted ">영화관</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/audi/list" class="  text-muted ">상영관</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/seat" class=" text-muted ">좌석</a></li>
					</ul></li>

				<li><a href="#" class="text-muted  sidebar-nav-parent-item">영화 관리 <span class="mark-arrow"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a>
					<ul id="sidebar-nav-item2" class=" sidebar-nav-item">
						<li><a href="${pageContext.request.contextPath }/admin/movie/list" class="  text-muted ">영화데이터</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/screen/list" class="  text-muted ">스크린</a></li>
					</ul></li>

				<li><a href="#" class="text-muted  sidebar-nav-parent-item">영업 관리<span class="mark-arrow"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a>
					<ul id="sidebar-nav-item3" class=" sidebar-nav-item">
						<li><a href="${pageContext.request.contextPath }/admin/schedule" class="  text-muted ">상영스케줄</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/price" class="  text-muted ">가격</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/booking" class=" text-muted ">예약</a></li>
						<li><a href="${pageContext.request.contextPath }/admin/sales" class="  text-muted ">매출현황</a></li>
					</ul></li>

				<li><a href="${pageContext.request.contextPath }/admin/notice" class="text-muted effect-wave "> 공지사항 관리</a></li>

				<li><a href="#" class="text-muted  sidebar-nav-parent-item"> 사내 게시판 <span class="mark-arrow"><i class="fa fa-angle-down" aria-hidden="true"></i></span>
				</a>
					<ul id="sidebar-nav-item3" class=" sidebar-nav-item">
						<li><a href="${pageContext.request.contextPath }/admin" class="  text-muted ">공지사항</a></li>
						<li><a href="${pageContext.request.contextPath }/admin" class="  text-muted ">건의사항</a></li>
					</ul></li>

				<li><a href="#" class="text-muted  sidebar-nav-parent-item"> 사내 관리 <span class="mark-arrow"><i class="fa fa-angle-down" aria-hidden="true"></i></span></a>
					<ul id="sidebar-nav-item3" class=" sidebar-nav-item">
						<li><a href="${pageContext.request.contextPath }/admin" class="  text-muted ">직원</a></li>
						<li><a href="${pageContext.request.contextPath }/admin" class="  text-muted ">일정</a></li>
					</ul></li>

			</ul>

		</nav>

	</div>




	<!-- Menu Toggle Script -->
	<script>
		$(function() {

			$(window).resize(function() {

				$('#btn-open-sidebar').removeClass('isPressed');

				var window_width = window.innerWidth

				//가로 1500px 이상
				if (window_width > 1400) {
					var marginLeft = $(".sidebar-wrapper").css('margin-left');
					marginLeft = marginLeft.replace('px', '');
					if (marginLeft < 0) {
						$(".sidebar-wrapper").css('margin-left', '0px');
						$(".ebox-content-fluid").css('padding-left', '215px');
					}

					var paddingLeft = $(".ebox-content-fluid").css('padding-left');
					paddingLeft = paddingLeft.replace('px', '');
					if (paddingLeft < 215) {
						$(".ebox-content-fluid").css('padding-left', '215px');
					}

				} else {
					//1500px 이하
					var marginLeft = $(".sidebar-wrapper").css('margin-left');
					marginLeft = marginLeft.replace('px', '');
					if (marginLeft >= 0) {
						//보이는 상태

						$(".sidebar-wrapper").css('margin-left', '-200px');
					}

				}

			});
		})

		$("#btn-open-sidebar").click(function(e) {

			e.preventDefault();
			setSidebarMenuItemInit();

			if (!$(this).hasClass('isPressed')) {
				$(".sidebar-wrapper").css('margin-left', '0px');
				$(this).addClass('isPressed');
				return;
			} else {
				$(".sidebar-wrapper").css('margin-left', '-200px');
				$(this).removeClass('isPressed')
				return;
			}

		});
	</script>

	<script type="text/javascript">
		function setSidebarMenuItemInit() {
			$('.sidebar-nav-parent-item').removeClass('press');
			$('.sidebar-nav-item').slideUp(200);
		}

		$(function() {
			$('.sidebar-nav-parent-item').click(function() {

				//디스플레이 상태는 sidebar menu item init 하기 전의 상태 값을 먼저 구해야 된다.
				//왜냐하면 init함수는 전체 메뉴아이템을 초기화 시키는 것이므로 
				var display = $(this).next('.sidebar-nav-item').css('display');

				setSidebarMenuItemInit();

				// 이 display 값을 이용하여 현재 누르는 menu item이 바로전에 클릭한  menu item과 같은 것인지 확인하고 처리 해준다.
				if (display != 'none') {
					$(this).addClass('press');
				}

				if ($(this).hasClass('press')) {
					$(this).next().slideUp(200);
					$(this).removeClass('press');
				} else {
					$(this).next().slideDown(200);
					$(this).addClass('press');
				}

			})
		})

		$(function() {
			Waves.attach('.sidebar a', [ 'waves-light' ]);
		})
	</script>




	<div class="content-wrapper">
		<div class="container-fluid ebox-content-fluid">


			<!-- 개별 JSP 파일 시작 -->
			<!-- --------------------------------------------------------------------------- -->

			<!-- DIV 파일 PAGE이름 + WRAPPER 로 시작하면 된다.  -->
			<!-- 
				EX)
					<div class="pagename-wrapper">
						
					</div> 
			-->








			<!-- --------------------------------------------------------------------------- -->
			<!-- 개별 JSP 파일 종료 -->



			<%-- <%@ include file="footer2.jsp"%> --%>