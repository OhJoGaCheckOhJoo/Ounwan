<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="${appPath }/css/main.css" />
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${appPath }/css/cart.css" />
<link rel="stylesheet" type="text/css" href="${appPath }/css/styleguide.css" />
<link href="${appPath }/css/coupung/modal.css" rel="stylesheet">
</head>
<body>

	<%@ include file="../common/header.jsp" %>
    <div class="container">
    <%@ include file="../common/nav.jsp" %>
		<div class="contents">

			<div class="cartList" id="cartList">
				<c:choose>
		<c:when test="${clientId == null}">
			<!-- 비회원정보 -->
			<h1>비회원입니다.</h1>
			<c:forEach var="cart" items="${cartList}" varStatus="status">
				<div class="productContainer">
					<div class="product">

						<div class="checkbox">
							<input type="checkbox" name="checkbox" class="selectCheckbox">
							<input type="hidden" value="${cart.coupungNumber}" class="productNum" />
							<input type="hidden" value="${cart.coupungOptionNumber}" class="optionNum" />
							<input type="hidden" value="${cart.quantity}" class="productQuantity" />
						</div>

						<img src="${cart.url}" alt="productImage"
							style="height: 120px; margin-left: 16px; width: 120px;">
						<div class="flex-col flex">
							<div
								class="coupungName valign-text-middle inter-normal-black-16px">
								상품명 : ${cart.name}</div>
							<div
								class="coupungOption valign-text-middle inter-normal-star-dust-12px">
								구매옵션 : ${cart.option }</div>
							<div>
								<span>단가:${cart.price}원</span>
							</div>
						</div>
						<div class="num">
							<div>수량</div>
							<div class="count">
								<div class="minus">
									<input type='hidden' value='${cart.coupungNumber}'
										class='coupung-num' /> <input type='hidden'
										value='${cart.price}' class='coupung-price' /> <input
										type='hidden' value='${status.count}' class='index-num' /> -
								</div>
								<span id="result${status.count}">${cart.quantity}</span>
								<div class="plus">
									<input type='hidden' value='${cart.coupungNumber}'
										class='coupung-num' /> <input type='hidden'
										value='${cart.price}' class='coupung-price' /> <input
										type='hidden' value='${status.count}' class='index-num' /> +
								</div>

							</div>
						</div>
						<div class="text-1 valign-text-middle inter-normal-black-16px">
							<div>가격</div>

							<span id="resultPrice${status.count}">금액:${cart.price*cart.quantity}</span>원
						</div>
						<button class="delete-button"
							data-coupung-num="${cart.coupungNumber}" data-option-num="${cart.coupungOptionNumber}">X</button>
					</div>
				</div>
				<br>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<!-- 회원 정보 -->
			<h1>회원입니다.</h1>
			<c:forEach var="cart" items="${UserCartList}" varStatus="status">
				<div class="productContainer">
					<div class="product">

						<div class="checkbox">
							<input type="checkbox" name="checkbox" class="selectCheckbox">
							<input type="hidden" value="${cart.COUPUNG_NUMBER}" class="productNum" />
							<input type="hidden" value="${cart.COUPUNG_OPTION_NUMBER}" class="optionNum" />
							<input type="hidden" value="${cart.QUANTITY}" class="productQuantity" />
						</div>


						<img src="${cart.URL}" alt="productImage"
							style="height: 120px; margin-left: 16px; width: 120px;">
						<div class="flex-col flex">
							<div
								class="coupungName valign-text-middle inter-normal-black-16px">
								상품명 : ${cart.name}</div>
							<div
								class="coupungOption valign-text-middle inter-normal-star-dust-12px">
								
								구매옵션 : ${cart.option }</div>
							<div>
								<span>단가:${cart.price}원</span>
							</div>
						</div>
						<div class="num">
							<div>수량</div>
							<div class="count">
								<div class="minus">
									<input type='hidden' value='${cart.COUPUNG_NUMBER}'
										class='coupung-num' /> <input type='hidden'
										value='${cart.price}' class='coupung-price' /> 
									<input type='hidden' value='${status.count}' class='index-num' /> -
								</div>
								<span id="result${status.count}">${cart.QUANTITY}</span>
								<div class="plus">
									<input type='hidden' value='${cart.COUPUNG_NUMBER}' class='coupung-num' /> 
									<input type='hidden' value='${cart.price}' class='coupung-price' /> 
									<input type='hidden' value='${status.count}' class='index-num' /> +
								</div>

							</div>
						</div>
						<div class="text-1 valign-text-middle inter-normal-black-16px">
							<div>가격</div>
 							금액:<span id="resultPrice${status.count}">${cart.price*cart.QUANTITY}</span>원
						</div>
						<button class="delete-button"
							data-coupung-num="${cart.COUPUNG_NUMBER}" data-option-num="${cart.COUPUNG_OPTION_NUMBER}">X</button>
					</div>
				</div>
				<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
			</div>
			<div class="payOption">
				<div class="overlap-group2">
					<div class="option">
						<button id="orderBtn" type='button'>
							<div class="text-11 valign-text-middle">주문하기</div>
						</button>
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
	 <div id="modalContainer" class="hidden">
    	<div id="modalContent">
    		이메일 : <input type="text" id="guestEmail" />
    		<br>
    		핸드폰 번호 : <input type="text" id="guestPhone" />
    		<br>
    		<button type="button" id="guestSubmitBtn">입력</button>
    	</div>
    </div>
	
	<script>
	
	$('.selectCheckbox').on('change', function() {
		  let totalPrice = 0;
		  $('.selectCheckbox:checked').each(function() {
		    var index = $(this).parent().parent().find(".index-num").val();
		    var resultPriceText = $('#resultPrice' + index).text();
		    var price = parseInt(resultPriceText.replace(/\D/g,''), 10);
		    totalPrice += price;
		  });
		  $('#totalAmount').text(totalPrice);
	});
	
	$(".delete-button").on("click",function(){
		 var coupungNum = $(this).data("coupung-num");
		 var optionNum = $(this).data('option-num');
		 alert(optionNum);
			$.ajax({
				url:"${appPath}/coupung/cartDelete",
				data : {
					"coupungNumber" : coupungNum,
					"optionNumber" : optionNum
				},
				success : function(res){
					if(res === "cart"){
						location.href = "${appPath}/coupung/cart";
					}
				}
			}); 	
		});
		
	</script>

	<script>
		var totalPrice = 0;
			
			$(".plus").on("click", function(){
				var price = $(this).find(".coupung-price").val();
				var index = $(this).find(".index-num").val();
				var coupungNum = $(this).find(".coupung-num").val();
				var quantity = Number($("#result" + index).html()) + 1;
				$('#result'+index).html(quantity);totalPrice += price;
				
				$.ajax({
					url:"${appPath}/coupung/cartUpdate",
					data : {
						"coupungNumber" : coupungNum,
						"quantity" : quantity
					},
					success : function(res){
						if(res === "cart"){
							location.href = "${appPath}/coupung/cart";
						}
					}
				}); 
			});
			
			$(".minus").on("click", function(){
				var index = $(this).find(".index-num").val();
				if($("#result" + index).html() > 1) {
					var price = $(this).find(".coupung-price").val();
					var coupungNum = $(this).find(".coupung-num").val();
					var quantity = Number($("#result" + index).html()) - 1;
					$('#result'+index).html(quantity);
					
					$.ajax({
						url:"${appPath}/coupung/cartUpdate",
						data : {
							"coupungNumber" : coupungNum,
							"quantity" : quantity
						},
						success : function(res){
							if(res === "cart"){
								location.href = "${appPath}/coupung/cart";
							}
						}
					}); 
				}
			});

		
		var productList = [];
		var optionList = [];
		var quantityList = [];
		$("#orderBtn").on("click", function() {
		    $('.selectCheckbox:checked').each(function() {
		        var coupungNum = $(this).parent().find('.productNum').val();
		        var optionNum = $(this).parent().find('.optionNum').val();
		        var quantity = $(this).parent().find('.productQuantity').val();
				productList.push(coupungNum);
				optionList.push(optionNum);
				quantityList.push(quantity);
		    });
		    
			if('${userInfo.clientId}' === '') {
				if(!confirm('로그인 하시겠습니까?')) {
					$('#modalContainer').removeClass('hidden'); // 모달을 띄우는 부분
				} else {
					location.href="${appPath}/clients/login";
				}
			} else {
				
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