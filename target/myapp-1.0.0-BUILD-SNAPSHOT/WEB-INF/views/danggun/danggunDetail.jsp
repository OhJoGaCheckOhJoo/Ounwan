<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/danggunDetail.css" rel="stylesheet" />
<link href="${appPath}/css/danggunUpdateModal.css" rel="stylesheet" />
<link href="${appPath}/css/danggunReportModal.css" rel="stylesheet" />
<link href="${appPath}/css/danggunShareModal.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="icon" href="../images/logo.png" type="image/x-icon">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
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
							<a href="${appPath}/danggun/main">전체 보기</a> <a href="#">관심 상품</a>
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
							<c:forEach var="images" items="${post.productImagesList}">
								<c:if test="${images.type eq 1}">
									<div>
										<img class="small-img" src="${images.url}" />
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- small_img -->
						<div class="big-img">
							<c:forEach var="images" items="${post.productImagesList}">
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
								<div class="product-name">${post.productName}</div>
								<c:if test="${userInfo.clientId != post.clientId}">
									<div class="hamburger">
										<div class="post-menu">이미지들어간다</div>
										<div class="small-menu" id="small-menu">
											<button class="modal-button" onclick="openShareModal()">공유</button>
											<button class="modal-button" onclick="openReportModal()">신고</button>
										</div>
									</div>
									<!-- hamburger -->
								</c:if>
							</div>
							<!-- product_top -->
							<div class="seller" id="seller">판매자 : ${post.clientId}</div>
							<div class="product-price" id="product-price">가격 :
								${post.price}원</div>
							<div class="registered-date" id="registered-date">등록일 :
								${post.uploadDate}</div>
							<div class="trade_step">${post.tradeStep}</div>

							<div class="product-bottom">
								<c:if test="${userInfo.clientId != post.clientId}">
									<!-- session의 clientid와 작성자의 clientid가 다를 때 -->
									<button class="zzimBtn" id="wishListBtn" type="button" value="${post.danggunNumber}">
										<img id="wishListImg" class="wish-list-img" src="${appPath}/images/danggun_wishlist_${post.wishListImg}.png" /> 
										<div id="small" class="small">${post.countZzim}</div>
									</button>
									<button class="chatting main-btn" id="chatting" type="button">
										채팅하기</button>

								</c:if>
								<c:if test="${userInfo.clientId == post.clientId}">
									<!-- session의 clientid와 작성자의 clientid가 같을 때 -->
									<button class="modal-button white-btn"
										onclick="openModal(${post.tradeHistoryNumber})">수정하기</button>
									<button class="danggunDelete main-btn" id="danggunDelete"
										type="submit">삭제하기</button>
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
		<!-- container -->
		<hr />
	</main>
	<div id="danggunModal" danggunNumber="${post.danggunNumber}"
		clientId="${post.clientId}"></div>
	<%@ include file="../common/footer.jsp"%>
	<%@ include file="./danggunReportModal.jsp"%>
	<%@ include file="./danggunUpdateModal.jsp"%>
	<%@ include file="./danggunShareModal.jsp"%>
	<script src="${appPath}/js/danggunUpdateModal.js"></script>
	<script src="${appPath}/js/danggunReportModal.js"></script>
	<script src="${appPath}/js/danggunShareModal.js"></script>
	<script src="${appPath}/js/main.js"></script>
	<script src="${appPath}/js/danggunDetail.js"></script>
</body>
</html>