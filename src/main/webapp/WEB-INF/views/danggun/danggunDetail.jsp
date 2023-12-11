<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/danggunDetail.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!-- header -->
	<header>
		<a class="logo" href="../"></a>
		<div class="float-right">
			<a href="./html/signup.html">회원가입</a> <a class="pointer"
				id="loginSelect">로그인</a>
			<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
			<button class="pointer">Basket (#)</button>
		</div>
	</header>
	<main id="main">
		<div class="container">
			<nav>
				<div class="nav-main">
					<div class="pointer">
						<a id="hamberger-btn" class="menu-trigger"> <span></span> <span></span>
							<span></span>
						</a>
					</div>
					<div>
						<a href="#">쇼핑몰</a>
						<div class="nav-submenu">
							<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
								식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
						</div>
					</div>
					<div>
						<a href="#">중고거래</a>
						<div class="nav-submenu">
							<a href="${appPath}/danggun/danggunDetail">전체 보기</a> <a href="#">관심
								상품</a>
						</div>
					</div>
					<div>
						<a href="#">커뮤니티</a>
						<div class="nav-submenu">
							<a href="#">오운완 커뮤니티</a> <a href="#">고민 게시판</a>
						</div>
					</div>
					<div>
						<a href="#">고객센터</a>
						<div class="nav-submenu">
							<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
								href="#">커뮤니티</a>
						</div>
					</div>
				</div>
			</nav>

			<div class="product-all">
				<div class="toList">
					<a href="${appPath}/danggun/main">목록으로 > </a>
				</div>
				<div class="details">
					<div class="photos">
						<div class="small-img">
							<c:forEach var="images" items="${danggunImage}">
								<c:if test="${images.type eq 1}">
									<div>
										<img class="small-img" src="${images.url}" />
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- small_img -->
						<div class="big-img">
							<c:forEach var="images" items="${danggunImage}">
								<c:if test="${images.type eq 0}">
									<img class="big-img" src="${images.url }" />
								</c:if>
							</c:forEach>
						</div>
						<!-- big_img -->
					</div>
					<!-- photo -->

					<div class="product">
						<div class="product-detail">
							<div class="product-top">
								<div class="product-name">${post.name}</div>
								<div class="hamburger">
									<a class="dot3" id="dot3"></a> <span>공유</span> <span>신고</span>
								</div>
								<!-- hamburger -->
							</div>
							<!-- product_top -->
							<div class="seller" id="seller">판매자 : ${post.clientId}</div>
							<div class="product-price" id="product-price">가격 :
								${post.price}</div>
							<div class="registered-date" id="registered-date">등록일 :
								${post.uploadDate}</div>
							<c:if test="${clientId != post.clientId}">
								<div class="trade_step">${tradeStep}</div>
							</c:if>
							<c:if test="${clientId == post.clientId}">
								<select id="options" name="options">
									<option value="option1" selected>판매 중</option>
									<option value="option2">예약 중</option>
									<option value="option3">거래 완료</option>
								</select>
							</c:if>

							<div class="product-bottom">
								<c:if test="${clientId != post.clientId}">
									<!-- session의 clientid와 작성자의 clientid가 다를 때 -->
									<%-- <button class="zzim" id="zzim" type="button">찜하기
										${zzimCount}</button>
									<button class="chatting main-btn" id="chatting" type="button">
										채팅하기</button> --%>
									<button class="danggunUpdate white-btn" id="danggunUpdate"
										type="submit">수정하기</button>
									<button class="danggunDelete main-btn" id="danggunDelete"
										type="button">삭제하기</button>

								</c:if>
								<c:if test="${clientId == post.clientId}">
									<!-- session의 clientid와 작성자의 clientid가 같을 때 -->
									<!-- <button class="danggunUpdate" id="danggunUpdate" type="button">수정하기</button>
									<button class="danggunDelete" id="danggunDelete" type="button">삭제하기</button> -->
								</c:if>
							</div>
							<!-- product_bottom -->
						</div>
						<!-- product detail -->
					</div>
					<!-- product -->
				</div>
				<!-- details -->
				<hr />
				<div class="here">${post.detail}</div>
			</div>
			<!-- product ALL-->
		</div>
		<hr />
	</main>

	<!-- footer -->
	<footer id="footer">
		<div>
			<div>오운완 쇼핑몰 & 커뮤니티</div>
			<div>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</div>
			<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층
			</div>
			<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
			<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
			<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
		</div>
		<div class="float-right">
			<div>
				<a href="#">이벤트</a>
			</div>
			<div>
				<a href="#">개인정보처리방침</a>
			</div>
			<div>
				<a href="#">이용약관</a>
			</div>
			<div>
				<img class="float-right img-1 pointer" src="../images/insta.png"
					alt="인스타 사진" />
			</div>
		</div>
	</footer>
	<script src="./js/main.js"></script>
</body>
</html>