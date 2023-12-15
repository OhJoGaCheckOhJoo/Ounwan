<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/main.css" />
<link rel="stylesheet" type="text/css" href="../css/order.css" />
<link rel="stylesheet" type="text/css" href="../css/styleguide.css" />

</head>
<body>

	<header>
		<a class="logo" href="#"></a>
		<div class="float-right">
			<a href="./html/signup.html">회원가입</a> <a class="pointer"
				id="loginSelect" href="${appPath}/clients/login">로그인</a>
			<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
			<button class="pointer" onclick="goToCart()">Basket (#)</button>
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
					<div class="nav-submenu">
						<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
							식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
					</div>
				</div>
				<div>
					<a href="${appPath}/danggun/main">중고거래</a>
					<div class="nav-submenu">
						<a href="#">전체 보기</a> <a href="#">관심 상품</a>
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

		<div class="contents">
			<div class="flex-col-1 flex-col-3">
				<div class="view-container">
					<div id="order-list">

						<details id="order-details">
							<summary>주문서</summary>
							<div class="view-3" style="display: none;">
								<div class="overlap-group1">
									<div class="view-4">
										<div class="navbar">
											<div class="rectangle-35"></div>
											<div
												class="navbar-link-text-2 valign-text-middle navbar-link-text inter-normal-black-12px">
												가격</div>
											<div
												class="navbar-link-text-3 valign-text-middle navbar-link-text inter-normal-black-12px">
												마일리지</div>
											<div
												class="navbar-link-text-4 valign-text-middle navbar-link-text inter-normal-black-12px">
												수량</div>
											<div
												class="navbar-link-text-5 valign-text-middle navbar-link-text inter-normal-black-12px">
												상품명</div>
										</div>
										<img class="line-21" src="../images/order/line-21.svg"
											alt="Line 21" /> <img class="line-19-1 line-19-4"
											src="../images/order/line-19.svg" alt="Line 19" />
									</div>
									<div>
										<c:forEach var="cart" items="${cartList}" varStatus="status">
											<div class="x01">
												<div class="x01-1">
													<img class="x50-2" src="../images/order/----50-1.png"
														alt="50" />
													<div class="text-container">
														<p class="jtext-10 valign-text-middle">-[옵션] :
															${cart.OPTION}</p>
														<div
															class="text-11 valign-text-middle inter-normal-black-12px">${cart.name}</div>
													</div>
												</div>
												<div class="text-12 valign-text-middle">${cart.quantity}</div>
												<div
													class="text-13 valign-text-middle juliussansone-normal-black-12px">${cart.OPTION }</div>
												<div
													class="text-14 valign-text-middle juliussansone-normal-black-12px">없음</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</details>
					</div>
					<!-- 분리 -->


					<div class="purchaser">
						<div class="overlap-group3">
							<div class="purchaser-info">
								<div class="overlap-group">
									<div>주문자 정보</div>
								</div>

							</div>
							<div class="name-info">
								<div class="purchaser-name">
									<div class="jtext-2 valign-text-middle inter-normal-black-12px">이름</div>
									<input class="box" id="name-txt" type="text" />
								</div>
							</div>
							<div class="phone-info">
								<div class="purchaser-phone">
									<div class="jtext-1 valign-text-middle inter-normal-black-12px">연락처</div>
									<input class="box" id="phone-txt" type="text" />
								</div>
							</div>
							<div class="email-info">
								<div class="purchaser-email">
									<div class="jtext-1 valign-text-middle inter-normal-black-12px">이메일</div>
									<input class="box" id="id-txt" type="text" />
									<div class="text-3 valign-text-middle">@</div>
									<input class="box" id="domain-txt" type="text" /> <select
										class="email-dropdown" id="domain-list">
										<option value="type">직접 입력</option>
										<option value="naver.com">naver.com</option>
										<option value="google.com">google.com</option>
										<option value="daum.net">daum.net</option>
										<option value="kakao.com">kakao.com</option>
										<option value="iCloud.com">iCloud.com</option>

									</select>
								</div>
							</div>

							<!-- 여기가지가 주문자 정보 -->

						</div>
					</div>
				</div>

				<!-- 분리 -->
				<div class="delivery">
					<div class="delivery-info">
						<div class=" dtext valign-text-middle inter-medium-black-15px">배송
							정보</div>
						<img class="line-7-1" src="../images/order/line-7.svg"
							alt="Line 7" />
						<div class="view-11">

							<div class="checkbox">
								<input type="checkbox" id="checkbox" name="checkbox"
									class="checkbox"><span>주문자 정보와 동일</span>
							</div>
						</div>
					</div>
					<div class="view-12">
						<div class="jtext-2 valign-text-middle inter-normal-black-12px">이름</div>
						<input class="box" id="name-txt" type="text" />
					</div>
					<img class="line-21-2 line-21-3" src="../images/order/line-21.svg"
						alt="Line 21" />
					<div class="contents-1 contents-3">
						<div class="view-13">
							<div class="text-2 valign-text-middle inter-normal-black-12px">이메일</div>
							<input class="box" id="id-txt" type="text" />
							<div class="text-3 valign-text-middle">@</div>
							<input class="box" id="domain-txt" type="text" /> <select
								class="email-dropdown" id="domain-list">
								<option value="type">직접 입력</option>
								<option value="naver.com">naver.com</option>
								<option value="google.com">google.com</option>
								<option value="daum.net">daum.net</option>
								<option value="kakao.com">kakao.com</option>
								<option value="iCloud.com">iCloud.com</option>

							</select>
						</div>
					</div>

					<img class="line-22-1" src="../images/order/line-21.svg"
						alt="Line 22" />
					<div class="view-14">
						<div class="jtext-1 valign-text-middle inter-normal-black-12px">연락처</div>
						<input class="box" id="phone-txt" type="text" />

					</div>
					<img class="line-23" src="../images/order/line-21.svg"
						alt="Line 23" />
					<div class="view-15">
						<div class="jtext-29 valign-text-middle inter-normal-black-12px">주소</div>
						<div class="flex-col-2 flex-col-3">
							<div class="contents-2 contents-3">
								<input class="box" id="adress-txt" type="text" />
								<div class="overlap-group-3">
									<div class="text-4 valign-text-middle">우편번호 검색</div>
								</div>
							</div>
							<input class="box" id="adress-txt" type="text" />
						</div>

					</div>
					<img class="line-19-3 line-19-4" src="../images/order/line-19.svg"
						alt="Line 19" />
				</div>
				<div class="view-17">
					<div class="overlap-group5">
						<div class="view-2">
							<div class="overlap-group">
								<div class="text valign-text-middle inter-medium-black-15px">마일리지</div>

							</div>
							<div class="view-18">
								<div class="jtext-11 valign-text-middle inter-normal-black-12px">마일리지</div>
								<input class="box" id="adress-txt" type="text" value="0" />
								<div class="overlap-group2-1">모두 사용</div>
								<div class="text-33 valign-text-middle">보유 127점</div>
							</div>
						</div>
					</div>
				</div>
				<div class="view-19">
					<div class="view-container-1">
						<div class="view-2">
							<div class="overlap-group">
								<div class="text valign-text-middle inter-medium-black-15px">결제정보</div>
							</div>
						</div>
						<div class="view-20 inter-normal-black-12px">
							<div class="text-35 inter-normal-black-12px">결제방법</div>
							<input type="checkbox">
							<div class="text-3-1 valign-text-middle">신용카드</div>
							<input type="checkbox">
							<div class="text-3-1 valign-text-middle">카카오페이</div>
						</div>
					</div>
				</div>
			</div>

			<!-- container에서 분리 -->

			<div class="pay-option">
				<div class="overlap-group7">
					<div class="option">
						<div class="payment-button">
							<button class="text-38 valign-text-middle">결제하기</button>
						</div>
					</div>
					<div class="view-23">
						<div class="text-39 valign-text-middle">결제 금액</div>
						<img class="line-28" src="../images/order/line-28.svg"
							alt="Line 28" />
						<div class="payment-box">
							<p class="total-product-amount valign-text-middle inter-normal-black-16px">
								<span><span class="inter-normal-black-16px">총 상품
										금액<br />마일리지 사용<br />
								</span><span class="total-payment-amount">총 결제 금액</span> </span>
							</p>
							<div class="text-41 valign-text-middle">
								<span><span class="inter-normal-black-16px">97,800원<br />-2000점<br /></span><span
									class="total-payment-amount-1">98,800원</span> </span>
							</div>
						</div>
						<img class="line-29" src="../images/order/line-28.svg"
							alt="Line 29" /> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			let isVisible = false;
			const $detailsContent = $('#order-details .view-3');

			$('#order-details summary').click(function() {
				isVisible = !isVisible;

				if (isVisible) {
					$detailsContent.slideDown(500);
				} else {
					$detailsContent.slideUp(500);
				}
			});

			// 초기에 숨겨진 상태로 시작
			$detailsContent.hide();
		});
	</script>

	<script>
		$(document).ready(function() {
			let isVisible = false;
			const $detailsContent = $('#order-details .view-3');

			$('#order-details summary').click(function() {
				isVisible = !isVisible;

				if (isVisible) {
					$detailsContent.slideDown(500);
				} else {
					$detailsContent.slideUp(500);
				}
			});
		});
	</script>

</body>
</html>
