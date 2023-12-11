<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<!--<meta name=description content="This site was generated with Anima. www.animaapp.com"/>-->
<!-- <link rel="shortcut icon" type=image/png href="https://animaproject.s3.amazonaws.com/home/favicon.png" /> -->
<meta name="viewport" content="width=1920, maximum-scale=1.0" />

<meta name="og:type" content="website" />
<meta name="twitter:card" content="photo" />
<link rel="stylesheet" type="text/css" href="../css/main.css" />
<link rel="stylesheet" type="text/css" href="../css/cart.css" />
<link rel="stylesheet" type="text/css" href="../css/styleguide.css" />
<link rel="stylesheet" type="text/css" href="../css/globals.css" />
</head>
<body style="margin: 0;">
	<!--
	<input type="hidden" id="anPageName" name="page"
		value="u9734-basket-page-u40u4364u4449u4540u4359u4449u4352u4462u4354u4469u41" />
-->
	<div class="container-center-horizontal">
		<div class="cartPage">
			<!--	<img class="union" src="img/union@2x.png" alt="Union" />-->
			<!-- 	<div class="flex-col-1">-->
			<!-- header -->
			<header>
				<a class="logo" href="#"></a>
				<div class="float-right">
					<a href="./html/signup.html">회원가입</a> 
					<a class="pointer"
						id="loginSelect">로그인</a>
					<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
					<button class="pointer">Basket (#)</button>
				</div>
			</header>
			​
			<div class="container">
				<!-- nav -->
				<nav>
					<div class="nav-main">
						<div class="pointer">
							<a id="hamberger-btn" class="menu-trigger"> <span></span> <span></span>
								<span></span>
							</a>
						</div>
						<div>
							<a href="#">쇼핑몰</a>
							<div id="navSubmenu" class="nav-submenu">
								<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강
									보조 식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
							</div>
						</div>
						<div>
							<a href="#">중고거래</a>
							<div id="navSubmenu" class="nav-submenu">
								<a href="#">전체 보기</a> <a href="#">관심 상품</a>
							</div>
						</div>
						<div>
							<a href="#">커뮤니티</a>
							<div id="navSubmenu" class="nav-submenu">
								<a href="#">오운완 커뮤니티</a> <a href="#">고민 게시판</a>
							</div>
						</div>
						<div>
							<a href="#">고객센터</a>
							<div id="navSubmenu" class="nav-submenu">
								<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
									href="#">커뮤니티</a>
							</div>
						</div>
					</div>
					<div id="navMenu" class="nav-menu">
						<div>
							<div>
								<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강
									보조 식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
							</div>
							<div>
								<a href="#">전체 보기</a> <a href="#">관심 상품</a>
							</div>
							<div>
								<a href="#">오운완 커뮤니티</a> <a href="#">고민 게시판</a>
							</div>
							<div>
								<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
									href="#">커뮤니티</a>
							</div>
						</div>
					</div>
				</nav>
				<div class="cartList">
					<c:forEach var="cart" items="${cartList }">
						<div class="productContainer">
							<div class="product">
								<div class="checkbox">
									<input type="checkbox" id="checkbox" name="checkbox">
								</div>
								<div class="productImage"></div>
								<div class="flex-col flex">
									<div
										class="coupungName valign-text-middle inter-normal-black-16px">
										상품명 : ${cart.coupung.name}</div>
									<div
										class="coupungOption valign-text-middle inter-normal-star-dust-12px">
										구매옵션 : ${cart.coupung.option }</div>
								</div>
								<div class="num">
									<span>수량</span> <span class="count"> <a href="#"
										class="minus">-</a> <span id="result">${cart.quantity }</span>
										<a href="#" class="plus">+</a>
									</span>
								</div>

								<div class="text-1 valign-text-middle inter-normal-black-16px">8,000원</div>
							</div>
						</div>
						<br>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="payOption">
			<div class="overlap-group2">
				<div class="option">
					<button class="orderButton" onclick="openPopupPage()">
						<div class="text-11 valign-text-middle">주문하기</div>
					</button>
				</div>
				<div class="view-3 view-4">
					<div class="text-12 valign-text-middle inter-normal-black-16px">결제
						금액</div>
					<div class="text-13 valign-text-middle">14,500원</div>
				</div>
			</div>
		</div>
	</div>
	function openPopupPage() {
  	window.location.href = 'popup.jsp'; // 버튼을 클릭하면 popup.jsp로 이동
	}
	<script>
	
	</script>
</body>
</html>