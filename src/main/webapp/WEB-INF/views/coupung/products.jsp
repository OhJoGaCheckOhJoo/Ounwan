<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/coupung/productBody.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<!-- header -->
	<header>
		<a class="logo" href="#"></a>
		<div class="float-right">
			<a href="./html/signup.html">회원가입</a> <a class="pointer"
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
					<a href="${appPath}/coupung/products?categoryNum=0">쇼핑몰</a>
					<div id="navSubmenu" class="nav-submenu">
						<a href="${appPath}/coupung/products?categoryNum=0">전체 보기</a> <a
							href="#">운동 기구</a> <a href="#">건강 보조 식품</a> <a href="#">헬스
							이용권</a> <a href="#">의류</a>
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
		</nav>

		<div class="event-banner">
			<h1>이벤트 배너다 이시키야</h1>
		</div>
		<div class="coupung-nav">
			<div class="coupung-nav-bar">
				<div class="coupung-category">
					<div id="productAll">
						전체 선택 <input type="hidden" value="0" class="categoryValue" />
					</div>
				</div>
				<div class="coupung-category">
					<div>
						식품 <input type="hidden" value="2" class="categoryValue" />
					</div>
				</div>
				<div class="coupung-category">
					<div>
						운동기구 <input type="hidden" value="3" class="categoryValue" />
					</div>
				</div>
				<div class="coupung-category">
					<div>
						의류 <input type="hidden" value="1" class="categoryValue" />
					</div>
				</div>
				<div class="coupung-category">
					<div>
						헬스 이용권 <input type="hidden" value="4" class="categoryValue" />
					</div>
				</div>
			</div>
		</div>
		<div class="ordering">
			<select class="select-option">
				<option>최신순</option>
				<option>인기순</option>
			</select>
			<div class="typing-area">
				<input class="input-box" id="inputBox" type="text"/> 
				<button id="findButton" class="find-button">입력</button>
			</div>
		</div>
		<div class="product-area">
			<div class="product-area-zone" id="productInside">
				<c:forEach var="product" items="${productList}">
					<div class="item">
						<div class="item-image">
							<img class="product-image" src="${product.image[0].url}" />
						</div>
						<div class="item-name">
							<h4>${product.name}</h4>
							<p>${product.price }원</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- 여기 아래에 추가 -->

	</div>
	<hr>
	​
	<!-- footer -->
	<footer>
		<div>
			<div>오운완 쇼핑몰 & 커뮤니티</div>
			<div>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</div>
			<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층</div>
			<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
			<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
			<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
		</div>
		<div class="float-right">
			<br> <br>
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
				<img class="float-right img-1 pointer" src="./images/insta.png">
			</div>
		</div>
	</footer>
	<script src="../js/main.js"></script>
	<script>
	$('.coupung-category').click(function() {
		var id = $(this).find('.categoryValue').val();
		$.ajax({
            url : "${appPath}/coupung/product/category",
            type : "get",
            data : {
            	"categoryNum" : id	
            },
            success: function(res) {
                // Remove the existing product area zone
                $('#productInside').remove();
                
                var inside = '<div class="product-area-zone" id="productInside">';
                
                if(res.length == 0) {
                	inside += '<div class="item">상품이 존재하지 않습니다</div>';
                } else {

                	// Loop through each product in the response and construct HTML
	                res.forEach(function(product) {
	                    inside += '<div class="item">' +
	                        '<div class="item-image">' +
	                        '<img class="product-image" src="' + product.image[0].url + '"/>' +
	                        '</div>' +
	                        '<div class="item-name">' +
	                        '<h4>' + product.name + '</h4>' +
	                        '<p>' + product.price + ' 원</p>' +
	                        '</div>' +
	                        '</div>';
                	});
                }
                inside += '</div>';
                $('.product-area').append(inside);
            },
            error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    });
	
	$('#findButton').click(function() {
		var txt = $('#inputBox').val();
		$.ajax({
            url : "${appPath}/coupung/product/name",
            type : "get",
            data : {
            	"text" : txt	
            },
            success: function(res) {
                // Remove the existing product area zone
                $('#productInside').remove();
                
                var inside = '<div class="product-area-zone" id="productInside">';
                
                if(res.length == 0) {
                	inside += '<div class="item">상품이 존재하지 않습니다</div>';
                } else {

                	// Loop through each product in the response and construct HTML
	                res.forEach(function(product) {
	                    inside += '<div class="item">' +
	                        '<div class="item-image">' +
	                        '<img class="product-image" src="' + product.image[0].url + '"/>' +
	                        '</div>' +
	                        '<div class="item-name">' +
	                        '<h4>' + product.name + '</h4>' +
	                        '<p>' + product.price + ' 원</p>' +
	                        '</div>' +
	                        '</div>';
                	});
                }
                inside += '</div>';
                $('.product-area').append(inside);
            },
            error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
		
	});
</script>
</body>
</html>