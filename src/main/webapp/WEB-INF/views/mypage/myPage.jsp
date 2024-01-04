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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
<link href="${appPath}/css/main2.css" rel="stylesheet">
<link href="${appPath}/css/main.css" rel="stylesheet">
<link href="${appPath}/css/header.css" rel="stylesheet">
<link href="${appPath}/css/nav.css" rel="stylesheet">
<link href="${appPath}/css/mypagemain.css" rel="stylesheet">
<link href="${appPath}/css/aetaList.css" rel="stylesheet">
<link href="${appPath }/css/footer.css" rel="stylesheet">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="../common/nav.jsp"%>

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
							</a> <a href="javascript:reviewList()">
								<div class="coupung-menu review">리뷰 관리</div>
							</a>
						</div>
						<div class="menu-container danggun">
							<a href="javascript:danggunSaleList()">
								<div class="danggun-menu sale-list">내 판매 내역</div>
							</a> <a href="javascript:danggunWishList()">
								<div class="danggun-menu wish-list">관심 상품</div>
							</a><a href="javascript:chatList()">
								<div class="danggun-menu danggun">내 채팅방</div>
							</a>
						</div>

						<div class="menu-container aeta">
							<a href="javascript:aetaList()">
								<div class="aeta-menu writing-list">내 게시글 목록</div>
							</a>
						</div>
						<div class="menu-container user">
							<a href="javascript:checkPassword()">
								<div class="user-menu update-user-info">회원 정보 수정</div>
							</a>
						</div>
					</div>
				</div>
				<div class="content-container">
					<div class="preview-container">
						<div class="preview user">
							<div class="preview-user-image">
								<img src="${userInfo.profileUrl}">
							</div>

							<div>
								<p class="preview-user text">반갑습니다</p>
								<p class="preview-user name">
									<span>${userInfo.clientId}</span> 님
								</p>
							</div>
						</div>
						<div class="preview menu">
							<a href="javascript:danggunWishList()"
								class="preview-menu wish-list">
								<div>
									<img class="preview-menu-image"
										src="${appPath}/images/myPage/mypage_wishlist.png">
									<div class="preview-menu-text">
										<p>관심 상품</p>
										<span>${wishListCount}</span><span> 개</span>
									</div>
								</div>
							</a> <a href="${appPath}/coupung/cart" class="preview-menu cart">
								<div>
									<img class="preview-menu-image"
										src="${appPath}/images/cart_0.png">
									<div class="preview-menu-text">
										<p>장바구니</p>
										<span>${cartListCount}</span><span> 개</span>
									</div>
								</div>
							</a>
						</div>
					</div>
					<div class="content-info-container">
						<div class="content-info" id="content">
							<div class="recent-info order">
								<div class="section-header">
									<div class="section-title">최근 주문 상품</div>
<!-- 									<h2 class="section-title">최근 주문 상품</h2> -->
									<a href="javascript:orderList()" class="expand">더보기 > </a>
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
												<td colspan="5">최근 주문 상품이 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${not empty orderList}">
											<c:forEach var="oList" items="${orderList}">
												<tr>
													<td class="recent-order-date"><fmt:formatDate
															value="${oList.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
													<td class="recent-order-info"><a
														href="${appPath}/coupung/product/detail?coupungId=${oList.COUPUNG_NUMBER}">
															<div class="recent-order-info-container">
																<div class="recent-order-info-image">
																	<img src="${oList.PRODUCT_IMAGE_URL}"
																		style="width: 60px; height: 60px;">
																</div>
																<div class="recent-order-info-name">
																	${oList.COUPUNG_NAME}</div>
															</div>
													</a></td>
													<td class="recent-order-number">${oList.ORDER_NUMBER}</td>
													<td class="recent-order-price">${oList.PRICE * oList.QUANTITY}원</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
							<div class="recent-info aeta">
								<div class="section-header">
									<div class="section-title">최근 등록 게시글</div>
<!-- 									<h2 class="section-title">최근 등록 게시글</h2> -->
									<a href="javascript:aetaList()" class="expand">더보기 > </a>
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
													<td class="aeta-list title"><a
														href="${appPath}/community/aetaPost?aetaNumber=${list.aetaNumber}">${list.title}</a>
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
									<div class="section-title">장바구니</div>
<!-- 									<h2 class="section-title">장바구니</h2> -->
									<a href="${appPath}/coupung/cart" class="expand">더보기 > </a>
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
													<td class="recent-cart-number">${cartList.size() - loop.index}</td>
													<c:if test="${cList.AVAILABLE_STOCK <=10 }">
														<td class="recent-cart-info">
															<div class="recent-cart-info-container">
																<div class="recent-cart-image coupung-block-container">
																	<img src="${cList.URL}"
																		style="width: 60px; height: 60px;">
																	<div class="coupung-block" /></div>
																</div>
																<div class="recent-cart-name block">
																	${cList.COUPUNG_NAME}</div>
															</div>
														</td>
														<td class="recent-cart-quantity block">${cList.QUANTITY}</td>
														<td class="recent-cart-stock-state block">품절</td>
														<td class="recent-cart-info-price block">${cList.PRICE * cList.QUANTITY}원</td>
													</c:if>
													<c:if test="${cList.AVAILABLE_STOCK > 10 }">
														<td class="recent-cart-info"><a
															href="${appPath}/coupung/product/detail?coupungId=${cList.COUPUNG_NUMBER}">
																<div class="recent-cart-info-container">
																	<div class="recent-cart-image">
																		<img src="${cList.URL}"
																			style="width: 60px; height: 60px;">
																	</div>
																	<div class="recent-cart-name">
																		${cList.COUPUNG_NAME}</div>
																</div>
														</a></td>
														<td class="recent-cart-quantity">${cList.QUANTITY}</td>
														<td class="recent-cart-stock-state">재고있음</td>
														<td class="recent-cart-info-price">${cList.PRICE * cList.QUANTITY}원</td>
													</c:if>
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
		</div>
		<%@ include file="../common/footer.jsp"%>

		<script src="./js/main.js"></script>
		<script>
			for(var i = 0; i < $('.recent-order-price').length; i++) {
				$('.recent-order-price').eq(i).html($('.recent-order-price').eq(i).html().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			}
			for(var i = 0; i < $('.recent-cart-info-price').length; i++) {
				$('.recent-cart-info-price').eq(i).html($('.recent-cart-info-price').eq(i).html().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			}
		
			function orderList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/coupungOrderList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				});
			}

			function danggunSaleList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/danggunSaleList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				});
			}

			function danggunWishList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/danggunWishList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				})
			}

			function aetaList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/aetaList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				})
			}

			function reviewList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/coupungReviewList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				});
			}

			function checkPassword() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/checkPwd",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				});
			}
			function chatList() {
				$.ajax({
					type : "GET",
					url : "${appPath}/myPage/chatList",
					success : function(res) {
						$("#content").html(res);
					},
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
				});
			}
		</script>
</body>
</html>