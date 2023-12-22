<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
    <link href="${appPath}/css/main2.css" rel="stylesheet">
    <link href="${appPath}/css/header.css" rel="stylesheet">
    <link href="${appPath}/css/nav.css" rel="stylesheet">
    <link href="${appPath}/css/mypagemain.css" rel="stylesheet">
</head>

<body>
	<header>
		<div class="header">
			<a class="logo" href="/ounwan"></a>
			<div class="float-right">
				<a id="profileImage" href="#"> <img src="./images/google.png">
				</a> <span>0000님 환영합니다</span>
				<button id="cart"></button>
				<div id="cartNotice"></div>
			</div>
		</div>
		<div class="header-sub-menu">
			<div>
				<a href="#">마이페이지</a> <a href="#">로그아웃</a>
			</div>
		</div>
	</header>
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
					<div id="navSubmenu" class="nav-submenu">
						<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
							식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
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
						<a class="ounwangram" href="ounwangram">오운완 커뮤니티</a> <a href="#">고민
							게시판</a>
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
						<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
							식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
					</div>
					<div>
						<a href="#">전체 보기</a> <a href="#">관심 상품</a>
					</div>
					<div>
						<a class="ounwangram" href="ounwangram">오운완 커뮤니티</a> <a href="#">고민
							게시판</a>
					</div>
					<div>
						<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
							href="#">커뮤니티</a>
					</div>
				</div>
			</div>
		</nav>

		<!--mypage content-->
		<div class="mypage-container">
			<div class="mypage-content">
				<div class="side-bar-container">
					<div class="side-bar title">
						<a href="${appPath}/myPage"> 마이페이지 </a>
					</div>
					<div class="side-bar menu">
						<div class="menu-container coupung">
							<a href="javascript:orderList()">
								<div class="coupung-menu order-list">주문내역 조회</div>
							</a> <a href="#">
								<div class="coupung-menu mileage">마일리지</div>
							</a> <a href="javascript:reviewList()">
								<div class="coupung-menu review">리뷰 관리</div>
							</a>
						</div>
						<div class="menu-container danggun">
							<a href="javascript:danggunSaleList()">
								<div class="danggun-menu sale-list">내 판매 내역</div>
							</a> <a href="javascript:danggunWishList()">
								<div class="danggun-menu wish-list">관심 상품</div>
							</a>
						</div>

						<div class="menu-container aeta">
							<a href="javascript:aetaList()">
								<div class="aeta-menu writing-list">내 게시글 목록</div>
							</a>
						</div>
						<div class="menu-container chat">
							<a href="#">
								<div class="chat-menu admin">관리자와 채팅</div>
							</a> <a href="#">
								<div class="chat-menu danggun">쪽지 내역</div>
							</a>
						</div>
						<div class="menu-container user">
<%-- 							<a href="${appPath}/myPage/checkPwd"> --%>
							<a href="javascript:checkPassword()">
								<div class="user-menu update-user-info">회원 정보 수정</div>
							</a>
						</div>
					</div>
				</div>

				<div class="content-container">
					<div class="preview-container">
						<div class="preview user">
							<img>
							<div>
								<p class="preview-user text">반갑습니다</p>
								<p class="preview-user name">
									<span>${userInfo.clientId}</span> 님
								</p>
							</div>
						</div>

						<div class="preview menu">
							<a href="#" class="preview-menu mileage">
								<div>
									<img class="preview-menu-image">
									<div class="preview-menu-text">
										<p>마일리지</p>
										<span>127</span><span> 점</span>
									</div>

								</div>
							</a> <a href="javascript:danggunWishList()"
								class="preview-menu wish-list">
								<div>
									<img class="preview-menu-image">
									<div class="preview-menu-text">
										<p>관심 상품</p>
										<span>${wishListCount}</span><span> 개</span>
									</div>

								</div>
							</a> <a href="#" class="preview-menu cart">
								<div>
									<img class="preview-menu-image">
									<div class="preview-menu-text">
										<p>장바구니</p>
										<span>${cartListCount}</span><span> 개</span>
									</div>
								</div>
							</a>
						</div>
					</div>

					<!--여기부분이 계속 바뀔 예정입니당-->
					<div class="content-info-container">
						<div class="content-info" id="content">
							<div class="recent-info order">
								<div class="section-header">
									<h2 class="section-title">최근 주문 정보</h2>
									<a href=#>더보기 > </a>
								</div>
								<table>
									<thead>
										<tr class="head-tr">
											<th>주문일자</th>
											<th>상품정보</th>
											<th>주문번호</th>
											<th>결제금액</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty orderList}">
											<tr class="none-content">
												<td colspan="5">최근 주문 정보가 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${not empty orderList}">
											<c:forEach var="oList" items="${orderList}">
												<tr>
													<td><fmt:formatDate value="${oList.ORDER_DATE}"
															pattern="yyyy-MM-dd" /></td>
													<td><a href="#">
															<div>
																<img src="${oList.PRODUCT_IMAGE_URL}"
																	style="width: 60px; height: 60px;">
															</div>
															<div>
																<span>${oList.COUPUNG_NAME}</span>
															</div>
													</a></td>
													<td>${oList.ORDER_NUMBER}</td>
													<td>${oList.PRICE * oList.QUANTITY}원</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>

							<div class="recent-info aeta">
								<div class="section-header">
									<h2 class="section-title">최근 등록 게시글_aeta</h2>
									<a href="javascript:aetaList()">더보기 > </a>
								</div>

								<table>
									<thead>
										<tr class="head-tr">
											<th>번호</th>
											<th>제목</th>
											<th>작성일</th>
											<th>작성자</th>
											<th>조회수</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty aetaList}">
											<tr class="none-content">
												<td colspan="5">게시글 내역이 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${not empty aetaList}">
											<c:forEach var="list" items="${aetaList}" varStatus="loop">
												<tr class="content-tr">
													<td class="aeta-list num">${aetaList.size() - loop.index }</td>
													<td class="aeta-list title"><a href="#">${list.title}</a>
													</td>
													<td class="aeta-list upload-date"><fmt:formatDate
															value="${list.createdDate}" pattern="yyyy-MM-dd" /></td>
													<td class="aeta-list client-id">${list.clientId}</td>
													<td class="aeta-list views">${list.views}</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>

							</div>

							<div class="recent-info cart">
								<div class="section-header">
									<h2 class="section-title">장바구니</h2>
									<a href=#>더보기 > </a>
								</div>
								<table>
									<thead>
										<tr class="head-tr">
											<th>번호</th>
											<th>상품정보</th>
											<th>수량</th>
											<th>재고</th>
											<th>가격</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty cartList}">
											<tr class="none-content">
												<td colspan="5">장바구니가 비어있습니다.</td>
											</tr>
										</c:if>
										<c:if test="${not empty cartList}">
											<c:forEach var="cList" items="${cartList}" varStatus="loop">
												<tr>
													<td>${cartList.size() - loop.index}</td>
													<c:if test="${cList.AVAILABLE_STOCK <=10 }">
														<td>
															<div class="coupung-block-container">
																<img src="${cList.URL}"
																	style="width: 60px; height: 60px;">
																<div class="coupung-block" /></div>
															</div>
															<div>
																<span>${cList.COUPUNG_NAME}</span>
															</div>
														</td>
														<td>${cList.QUANTITY}</td>
														<td>품절</td>
													</c:if>
													<c:if test="${cList.AVAILABLE_STOCK > 10 }">
														<td><a href="#">
																<div>
																	<img src="${cList.URL}"
																		style="width: 60px; height: 60px;">
																</div>
																<div>
																	<span>${cList.COUPUNG_NAME}</span>
																</div>
														</a></td>
														<td>${cList.QUANTITY}</td>
														<td>재고있음</td>
													</c:if>
													<td>${cList.PRICE * cList.QUANTITY}원</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="./js/main.js" ></script>
		<script>
			function orderList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/coupungOrderList",
					success : function(res) {
						$("#content").html(res);
					}
				});
			}
		
			function danggunSaleList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/danggunSaleList",
					success : function(res) {
						$("#content").html(res);
					}
				});
			}

			function danggunWishList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/danggunWishList",
					success : function(res) {
						$("#content").html(res);
					}
				})
			}

			function aetaList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/aetaList",
					success : function(res) {
						$("#content").html(res);
					}
				})
			}

			function reviewList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/coupungReviewList",
					success : function(res) {
						$("#content").html(res);
					}
				});
			}
			
			function checkPassword() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/checkPwd",
					success : function(res) {
						$("#content").html(res);
					}
				});
			}
		</script>

</body>

</html>