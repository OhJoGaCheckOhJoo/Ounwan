<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/coupung/productDetail.css" rel="stylesheet" />
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 전체 화면 모달 -->
<div class="modal fade" id="fullScreenModal" tabindex="-1" aria-labelledby="fullScreenModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-fullscreen">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="fullScreenModalLabel">전체 화면 모달</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 모달 내용 -->
       	이메일 : <input type="text" id="guestEmail" />
        핸드폰 번호 : <input type="text" id="guestPhone"/>
        <button type="button" id="guestSubmitBtn">입력</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary">저장</button>
      </div>
    </div>
  </div>
</div>
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
 <!-- 여기 아래에 추가 -->
	<div class="product-detail">
		<div class="product-main">
			<div class="product-main-detail">
				<div class="product-images">
					<div class="product-images-mini">
						<div class="mini-image">
							<img class="mini-image" src="../${detail.image[1].url}"/>
						</div>
						<div class="mini-image">
							<img class="mini-image" src="../${detail.image[2].url}"/>
						</div>
						<div class="mini-image">
							<img class="mini-image" src="../${detail.image[3].url}"/>
						</div>
					</div>
					<div class="product-images-main" id="product">
						<img class="product-images-main" src="../${detail.image[0].url}" />
					</div>
				</div>
				<div class="product-info">
					<div class="product-name-bar">
						<div class="product-name" id="productName">${detail.name}</div>
						<div class="share-button"  onclick="clip()">
							공유
						</div>
					</div>
					<div class="product-info-line">
						<hr>
					</div>
					<div class="product-mini-info">
						<div class="product-star-zone">
							<span class="product-star">★★★★★</span> (100)
						</div>
						<div class="product-price-zone">
							<span class="product-price" id="productPrice">${detail.price }</span> 임
						</div>
					</div>
					<div class="option-bar">
						<select class="option-select-box" id="optionBox">
							<option value="empty">선택</option>
							<c:forEach var="opt" items="${detail.options}">
								<option value="${opt.coupungOptionNumber}">${opt.name}</option>
							</c:forEach>
						</select>
						<div class="counting">
							<input type='button' class="plus-button" value='+'/>
							<div class="quantity-number" id='quantityVal'>0</div>
							<input type='button' class="minus-button" value='-'/>
						</div>
					</div>
					<div class="product-info-line">
						<hr>
					</div>
					<div class="total-price-bar">
						<span class="total-price" id="totalPrice">0</span> 원
					</div>
					<div class="order-buttons">
						<button id='cartBtn' type='button'>장바구니</button>
						<button type='button' id='payBtn'>결제하기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="product-category-bar">
			<div class="product-detail-menu">
				<div class="about-product" id="productInfo">
					상품 상세
				</div>
				<div class="about-product" id="productReview">
					상품 후기
				</div>
			</div>
		</div>
		<div class="product-explain-review">
			<div class="product-explain">
				<div class="product-explain-body" id="detailBody">
					상세 페이지
				</div>
			</div>
		</div>
    </div>
</div>
<hr>
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
		<br><br>
		<div><a href="#">이벤트</a></div>
		<div><a href="#">개인정보처리방침</a></div>
		<div><a href="#">이용약관</a></div>
		<div><img class="float-right img-1 pointer" src="./images/insta.png"></div>
	</div>
</footer>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
	$('.plus-button').on('click', function() {
		var optionVal = $('#optionBox option:selected').val();
		if (optionVal != "empty") {
			var cnt = $(this).parent().find('.quantity-number').html();
			var price = $('#productPrice').html();
			var total = $('#totalPrice').html();
			cnt = parseInt(cnt) + 1;
			total = parseInt(price) * cnt;
			$('.quantity-number').html(cnt);
			$('#totalPrice').html(total);
		}
	});

	$('.minus-button').on('click', function() {
		var cnt = $(this).parent().find('.quantity-number').html();
		var price = $('#productPrice').html();
		var total = $('#totalPrice').html();

		cnt = parseInt(cnt) - 1;
		total = parseInt(price) * cnt;

		if (cnt < 0) {
			cnt = 0;
			total = 0;
		}
		$('.quantity-number').html(cnt);
		$('#totalPrice').html(total);
	});

	$('.option-select-box').on('change', function() {
		var optionVal = $('#optionBox option:selected').val();
		if (optionVal === "empty") {
			$('.quantity-number').html("0");
			$('#totalPrice').html("0");
		} else {
			$('.quantity-number').html("1");
			var price = $('#productPrice').html();
			$('#totalPrice').html(price);
		}
	});

	$('#productInfo').on('click', function() {
		$('#detailBody').remove();
		var inside =`<div class="product-explain-body" id="detailBody">
						상세 페이지
					</div>`;
		$('.product-explain').append(inside);
	});

	$('#productReview').on('click', function() {
		$('#detailBody').remove();
		var inside =`<div class="product-explain-body" id="detailBody">
						리뷰에 대해서어ㅓ
					</div>`;
		$('.product-explain').append(inside);
	});
	
	function clip(){
		var url = '';
		var textarea = document.createElement("textarea8");
		document.body.appendChild(textarea);
		url = window.document.location.href;
		textarea.value = url;
		textarea.select();
		document.execCommand("copy");
		document.body.removeChild(textarea);
		alert("URL이 복사되었습니다.")
	}
	
	$('#cartBtn').on('click', function() {
		var quantity = $('#quantityVal').text();
		alert($('#optionBox option:selected').val());
		if (quantity === '0') {
			alert('수량을 선택해 주세요');
		} else {
			var option = $('#optionBox option:selected').val();
			var obj = {
					'coupungNumber' : ${detail.coupungNumber},
					'quantity' : quantity,
					'coupungOptionNumber' : option,
					'name' : '${detail.name}',
					'option' : "$('#optionBox option:selected').text()",
					'url' : '${detail.image[0].url}',
					'price' : '${detail.price }'
				};
			
			$.ajax({
				url : '${appPath}/coupung/cart',
				type : 'post',
				data : JSON.stringify(obj),
				contentType : 'application/json',
				success : function(res) {
					if (res === 'success') {
						if(confirm('장바구니 담기에 성공하였습니다. 장바구니 페이지로 이동하시겠습니까?')) {
							location.href='${appPath}/coupung/cart';
						} else {
							window.location.href = window.location.href;
						}
					}
				},
                error: function(request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
			});
		}
	});
	
	$('#payBtn').on('click', function() {
		var quantity = $('#quantityVal').text();
		if (quantity === '0') {
			alert('수량을 선택해 주세요');
		} else if('${userInfo}' === '') {
			if(!confirm('로그인 하시겠습니까?')) {
				$('#fullScreenModal').modal('show'); // 모달을 띄우는 부분
			} else {
				location.href="${appPath}/clients/login";
			}
		} else {
			var productList = [${detail.coupungNumber}];
			var optionList = [$('#optionBox option:selected').val()];
			var quantityList = [$('#quantityVal').text()];
			console.log(productList);
			console.log(optionList);
			location.href = '${appPath}/coupung/order?productList=' + productList + '&optionList=' + optionList +'&quantityList=' + quantityList;
		}
	});
	
	var phone = "";
    $('#guestPhone').on('input', function() {
        if ($(this).val().length < 14) {
            $(this).val($(this).val()
                .replace(/[^0-9]/g, '')
                .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3"));
            phone = $(this).val();
        } else {
            $(this).val(phone);
        }

    });
    
	$('#guestSubmitBtn').on('click', function() {
		var email = $('#guestEmail').val();
		var emailFormat = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		
		if (!emailFormat.test(email)) {
			alert('잘못된 이메일 형식입니다!');
			$('#guestEmail').val('');
			$('#guestEmail').focus();
		} else {
			var obj = {
					'email' : email,
					'phone' : phone
			}
			$.ajax({
				url : '${appPath}/guest',
				type : 'post',
				data : JSON.stringify(obj),
				contentType : 'application/json',
				success : function(res) {
					if (res === 'success') {
						alert("성공하셨습니다.");
						var productList = [${detail.coupungNumber}];
						var optionList = [$('#optionBox option:selected').val()];
						var quantityList = [$('#quantityVal').text()];
						console.log(productList);
						console.log(optionList);
						location.href = '${appPath}/coupung/order?productList=' + productList + '&optionList=' + optionList +'&quantityList=' + quantityList;
					}
				},
	            error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
			});
		}
	});
</script>
</body>
</html>