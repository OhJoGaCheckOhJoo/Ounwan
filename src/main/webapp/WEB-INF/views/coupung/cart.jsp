<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="../css/main.css" />
<link rel="stylesheet" type="text/css" href="../css/cart.css" />
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
		<div class="cartList" id="cartList">
			<c:forEach var="cart" items="${cartList}" varStatus="status">
				<div class="productContainer">
					<div class="product">
						<div class="checkbox">
							<input type="checkbox" id="checkbox" name="checkbox"
								class="checkbox">
						</div>

						<img src="${cart.URL}" alt="productImage"
							style="height: 120px; margin-left: 16px; width: 120px;">
						<div class="flex-col flex">
							<div
								class="coupungName valign-text-middle inter-normal-black-16px">
								상품명 : ${cart.name}</div>
							<div
								class="coupungOption valign-text-middle inter-normal-star-dust-12px">
								구매옵션 : ${cart.OPTION }</div>
							<div>
								<span>단가:${cart.price}원</span>
							</div>
						</div>
						<div class="num">
							<span>수량</span> <span class="count"> <a
								href="javascript:minus(${cart.price}, ${status.count})"
								class="minus">-</a> <span id="result${status.count}">${cart.QUANTITY}</span>
								<a href="javascript:plus(${cart.price}, ${status.count })"
								class="plus">+</a>
							</span>
						</div>
						<div class="text-1 valign-text-middle inter-normal-black-16px">
							<div>가격</div>

							<span id="resultPrice${status.count}">금액:${cart.price*cart.QUANTITY}</span>원
						</div>
					</div>
				</div>
				<br>
			</c:forEach>
		</div>
		<div class="payOption">
			<div class="overlap-group2">
				<div class="option">
					<button id="modalOpenButton">
						<div class="text-11 valign-text-middle">주문하기</div>
					</button>
					<div id="modalContainer" class="hidden">
						<div id="modalContent">
							<p>주문하시겠습니까?</p>
							<button id=modalGoButton onclick="">주문페이지로 고고</button>
							<button id="modalCloseButton" onclick="">닫기</button>
						</div>
					</div>
				</div>
				<div class="view-3 view-4">
					<div class="text-12 valign-text-middle inter-normal-black-16px">결제
						금액</div>
					<div class="text-13 valign-text-middle">
						<span id="totalAmount">0</span>원
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


	<script>
	var totalPrice = 0;
	
		function is_checked(checkbox) {
			/*
			const productBox = checkbox.closest(".product");

			if (checkbox.checked) {
				productBox.classList.add("highlight");

			} else {
				productBox.classList.remove("highlight");
			}
			*/
		}

		function plus(price, index) {
			console.log(price);
			var quantity = Number($("#result" + index).html());
			
			$("#result" + index).html(quantity + 1);
			totalPrice += price;
			//체크 확인 필요
			$("#totalAmount").html(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			$("#resultPrice" + index).html("금액:" + (quantity + 1) * price);

		}
		function minus(price, index) {
			var quantity = Number($("#result" + index).html());
			if (quantity > 0) {
				$("#result" + index).html(quantity - 1);
				var totalAmount = Number($("#totalAmount").html());
				//체크 확인 필요
				totalPrice -= price;
				$("#totalAmount").html(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
				//체크 확인 필요
				if ((quantity - 1) * price >= 0) {
					$("#resultPrice" + index).html(
							"금액:" + (quantity - 1) * price);
				}
			}
		}
		
		
		$("#cartList").on("click", "#checkbox", function() {
			totalPrice = (Number)($("#totalAmount").html().replaceAll(',', ''));
			if($(this).is(":checked")) {
				$(this).parent().parent().addClass("highlight");
				totalPrice += (Number)($(this).parent().parent().find("div:eq(6)").find('span').html().replaceAll(',','').split(":")[1]);
				$("#totalAmount").html(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			} else{
				$(this).parent().parent().removeClass("highlight");
				totalPrice -= (Number)($(this).parent().parent().find("div:eq(6)").find('span').html().replaceAll(',','').split(":")[1]);
				$("#totalAmount").html(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			}
		})
      
		</script>

	<script>
		const modalOpenButton = document.getElementById('modalOpenButton');
		const modalCloseButton = document.getElementById('modalCloseButton');
		const modal = document.getElementById('modalContainer');

		modalOpenButton.addEventListener('click', () => {
		  modal.classList.remove('hidden');
		});

		
		modalCloseButton.addEventListener('click', () => {
		  modal.classList.add('hidden');
		});
		
		modalGoButton.addEventListener('click', () => {
		    // 다른 페이지의 URL을 여기에 입력합니다.
		    window.location.href = '${appPath}/coupung/products';
		})
		
		
	</script>
</body>
</html>