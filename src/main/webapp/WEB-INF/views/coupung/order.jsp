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
<link href="${appPath }/css/main.css" rel="stylesheet"/>
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link href="${appPath }/css/footer.css" rel="stylesheet">
<link href="${appPath }/css/order.css" rel="stylesheet"/>
<link href="${appPath }/css/coupung/agreementPersonalData.css" rel="stylesheet"/>
<title>오운완</title>
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<script>
		$(document).ready(function() {
			if ('${userInfo.clientId}' === '' && '${guest.email}' === '') {
				location.href = '${appPath}/clients/login';
			}
		    calculateTotalPrice();
		    function calculateTotalPrice() {
		        var totalPrice = 0;
		        $('.price-value').each(function() {
		            totalPrice += parseInt($(this).text(), 10);
		        });
		        $('#totalPrice').text(makeComma(totalPrice));
		        $('#totalOrderPrice').text(makeComma(totalPrice));
		    }
			function makeComma(n) {
				return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			}
		    var emailId = '';
		    var domain = '';
		    var phone = '';
		    if ('${userInfo}' != '') {
		    	if ('${userInfo.socialType}' === 'GOOGLE' || '${userInfo.socialType}' === 'NAVER' || '${userInfo.socialType}' === 'KAKAO')
		    		emailId = '${userInfo.email}'.substring(2, '${userInfo.email}'.length);
		    	else 
					emailId = "${userInfo.email}"; 
				phone = '${userInfo.phone}';
				$('#name-txt').val('${userInfo.name}');	
				$('#name-txt').attr('readOnly', true);
			} else if('${guest}' != '') {
				emailId = '${guest.email}';
				phone = '${guest.phone}';
			}
		    $('#id-txt').val(emailId);
		    $('#id-txt').attr('readOnly', true);
		    $('#domain-list').attr('disable', true);
		    $('#phone-txt').val(phone);	
		    $('#phone-txt').attr('readOnly', true);
		    
		    $(".detail-price, .price-value").each(function() {
		        var priceElement = $(this);
		        var priceValue = priceElement.text();
		        var numericValue = priceValue.replace(/[^0-9.-]/g, '');
		        var formattedValue = makeComma(parseFloat(numericValue));

		        priceElement.text(formattedValue + "원");
		    });
		});
		
	</script>
	<%@ include file="../common/header.jsp"%>

	<div class="container">
		<%@ include file="../common/nav.jsp"%>
		<div class="contents">
			<div class="order-info-container">
				<div class="order-info-wrap">
					<div id="orderList" class="order-list">
						<div class="order-list-title">
						    <div class="order-list-detail">
						        <div>주문서&nbsp;&nbsp;</div>
						        <div><button id="toggleButton">&gt;</button></div>
						    </div>
						</div>
						<div class="order-list-body">
							<table>
								<thead>
									<tr class="head-tr">
										<th>상품정보</th>
										<th>수량</th>
										<th>주문금액</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="product" items="${products}" varStatus="status">
							                <tr>
							                	<div>							                	
								                    <td>
									                 	<div class="product-info-container">
															<img class="x50-2" src="${product.image[0].url }" alt="50" />
										                    <div class="product-info">
										                    		<span>${product.name}</span>
										                    		<input type="hidden" value="${product.coupungNumber }" class="coupungNumber"/>
																	<input type="hidden" value="${product.options[0].coupungOptionNumber }" class="optionNumber"/>
																	<span class="text-container">
																		<p>-[옵션] : ${product.options[0].name}</p>												
																	</span>
																	<span class="detail-price">${product.price}원</span>
															</div>
								                    	</div>
								                    </td>
								                    <td>
								                    	<div class="product-quantity">${product.quantity}</div>
								                    </td>
								                    <td class="product-order-price">
								                    	<div
														class="price-value">${product.price*product.quantity}원</div>
								                    </td>
							                	</div>
							                </tr>
						                </c:forEach>
									</tbody>
								</table>
						</div>
					</div>	
					<div class="purchaser">
						<div class="purchaser-info-container">
							<div class="purchaser-info">
								<div class="overlap-group">
									<div>주문자 정보</div>
								</div>
							</div>
							<div class="name-info">
								<div class="purchaser-name-wrap">
									<div class="purchaser-name">이름</div>
									<div>
										<input class="box" id="name-txt" type="text" required />
									</div>
								</div>
							</div>
							<div class="phone-info">
								<div class="purchaser-phone-wrap">
									<div class="purchaser-phone">연락처</div>
									<input class="box" id="phone-txt" type="text" required />
								</div>
							</div>
							<div class="email-info">
								<div class="purchaser-email-wrap">
									<div class="purchaser-email">이메일</div>
									<div>
										<input class="box" id="id-txt" type="text" required />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="delivery">
						<div class="delivery-info-container">
							<div class="delivery-info">
								<div class=" overlap-group">배송 정보</div>
								<div class="view-11">
									<label for="orderCheckBox">
										<input type="checkbox" id="orderCheckBox" name="checkbox" class="checkbox">
										<i class="circle"></i>주문자 정보와 동일
									</label>
								</div>
							</div>
							<div class="name-info">
								<div class="purchaser-name-wrap">
									<div class="purchaser-name">이름</div>
									<div>
										<input class="box" id="name-txt-2" type="text" required />
									</div>
								</div>
							</div>
							<div class="phone-info">
								<div class="purchaser-phone-wrap">
									<div class="purchaser-phone">연락처</div>
									<input class="box" id="phone-txt-2" type="text" required />
								</div>
							</div>
							<div class="email-info">
								<div class="purchaser-email-wrap">
									<div class="purchaser-email">이메일</div>
									<div>
										<input class="box" id="id-txt-2" type="text" required />
									</div>
								</div>
							</div>
							<div class="address-info">
								<div class="purchaser-address-wrap">
									<div class="purchaser-address">주소</div>
									<div>
										<div class="purchaser-zipcode">
											<input class="box" id="zipcode-txt" type="text" readOnly required />
											<button id="findAddr" class="button" type="button">우편번호 검색</button>
										</div>
										<div>
											<input class="box" id="address-txt" type="text" readOnly required />
											<input class="box" id="address-detail-txt" type="text" readOnly />
										</div> 
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="pay-option">
						<div class="pay-option-container">
							<div class="payment-info">
								<div class="overlap-group">
									<div>결제 정보</div>
								</div>
							</div>
							<div class="purchaser-payment-wrap">
								<div class="purchaser-payment">결제 방법</div>
								<div class="pay-option-wrap">
									<input type="radio" class="paymentMethod" id="creditCard">
									<div >신용카드</div>
									<input type="radio" class="paymentMethod" id="kakaoPay">
									<div >카카오페이</div>				
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="total-payment-conatiner">
					<div class="total-payment-view">
						<div class="order-price">결제 금액</div>
						<div class="price-container">
							<div class="total-price-txt">
								<div>총 상품 금액</div>
								<div>배송비</div>
								<span>총 결제 금액</span>
							</div>
							<div class="total-order-price">
								<div id="totalPrice">978000</div>
								<div>+ 0원</div>
								<span id="totalOrderPrice">978000</span>
							</div>
						</div>
					</div>
					<div class="agreement-container">
						<div class="agreement">
							<label for="agree1">
								<input type="checkbox" id="agree1" required>
								<i class="circle"></i> [필수] 개인정보 수집 및 이용 동의
								<a id="agree" onclick="openPersonalData()">보기</a>
							</label>
						</div>
						<br>
						<div class="agreement">
							<label for="agree2">
								<input type="checkbox" id="agree2" required>
								<i class="circle"></i> [필수] 결제대행 서비스 이용약관 
								<a href="https://www.inicis.com/terms" target="_blank">(주)KG이니시스</a>
							</label>
						</div>
						<br>
						<div class="agreement">
							<label for="agree3">
								<input type="checkbox" id="agree3" required>
								<i class="circle"></i> 주문 내용을 확인했으며, 위의 내용에 모두 동의합니다.
							</label>
						</div>
					</div>
					<div>
						<button id="payment" class="button">결제하기</button>
					</div>	
				</div>							
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
	<div id="agreementPersonalData">
		<h3>개인정보 수집 및 이용 동의</h3>
		<%@ include file="../common/agreementPersonalData.jsp" %>
		<button>확인</button>
	</div>
	<div id="agreementOverlay" class="agreement-overlay"></div>
	
	<script>
	var readAgreement1 = false; 

	function openPersonalData() {
		document.getElementById("agreementPersonalData").style.display = "block";
		document.getElementById("agreementOverlay").style.display = "block";
		
	}

	$("#agreementPersonalData button").on("click", function() {
	    readAgreement1 = true;
	    $("#agreementPersonalData").hide(); 
	    $("#agreementOverlay").hide(); 
	    $("#agree").attr('disabled', true);
	});
	</script>
	
	<script src="${appPath}/js/main.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
			$detailsContent.hide();
		});
		
		$('.paymentMethod').on('click', function() {
			  $('.paymentMethod').prop('checked', false);
			  $(this).prop('checked', true);
		});
		
		$('#orderCheckBox').on('click', function() {
			if($('#orderCheckBox').is(':checked')) {
				if(!$('#name-txt').val()) {
					alert('이름을 입력해 주세요!');
					$('#name-txt').focus();
					$('#orderCheckBox').prop('checked', false);
			    } else {
					$('#id-txt-2').val($('#id-txt').val());
				    $('#id-txt-2').attr('readOnly', true);
				    $('#phone-txt-2').val($('#phone-txt').val());	
				    $('#phone-txt-2').attr('readOnly', true);
				    $('#name-txt-2').val($('#name-txt').val());
			    	$('#name-txt').attr('readOnly', true);
			    	$('#name-txt-2').attr('readOnly', true);
					if ('${userInfo}' != '') {
						$('#name-txt-2').val($('#name-txt').val());
						$('#name-txt-2').attr('readOnly', true);
						$('#zipcode-txt').val('${userInfo.zipCode}');
						$('#zipcode-txt').attr('readOnly', true);
						$('#address-txt').val('${userInfo.address}');
						$('#address-txt').attr('readOnly', true);
						$('#address-detail-txt').val('${userInfo.addressDetail}');
						$('#address-detail-txt').attr('readOnly', true);
						$('#findAddr').attr('disabled', true);
					}	
			    }
			} else {
				$('#id-txt-2').val('');
				$('#id-txt-2').attr('readOnly', false);
				$('#phone-txt-2').val('');
				$('#phone-txt-2').attr('readOnly', false);
				$('#name-txt-2').val('');
				$('#name-txt-2').attr('readOnly', false);
				$('#zipcode-txt').val('');
				$('#zipcode-txt').attr('readOnly', false);
				$('#address-txt').val('');
				$('#address-txt').attr('readOnly', false);
				$('#address-detail-txt').val('');
				$('#address-detail-txt').attr('readOnly', false);
				$('#findAddr').attr('disabled', false);
			}
		});
		$('#findAddr').on('click', function() {
			new daum.Postcode({
		        oncomplete: function(data) {
		            var addr = ''; 
		            var extraAddr = ''; 

		            if (data.userSelectedType === 'R') { 
		                addr = data.roadAddress;
		            } else {
		                addr = data.jibunAddress;
		            }

		            if(data.userSelectedType === 'R'){
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		            } 
		            
		            $('#zipcode-txt').val(data.zonecode);
		            $('#address-txt').val(addr);
		            $('#address-detail-txt').attr('readOnly', false);
		            $('#address-detail-txt').focus();
		        }
		    }).open();
		});
		
		
		
		$('#payment').on('click', function() {
			if ($('#name-txt').val() === '' || $('#phone-txt').val() === '' || $('#id-txt').val() === '') {
				alert('주문자 정보를 입력해 주세요');
				$('#name-txt').focus();
			} else if ($('#name-txt-2').val() === '' || $('#phone-txt-2').val() === '' 
					|| $('#id-txt-2').val() === '' || $('#zipcode-txt').val() === '' 
					|| $('#address-txt').val() === '' || $('#address-detail-txt').val() === '') {
				alert('배송 정보를 입력해 주세요');
				$('#name-txt-2').focus();
			} else if (!$('#agree1').is(':checked') || !$('#agree2').is(':checked') || !$('#agree3').is(':checked')) {
				alert('필수 동의 사항들을 확인해 주세요');
			} else if (!$('#creditCard').is(':checked') && !$('#kakaoPay').is(':checked')) {
				alert('결제 수단을 선택해 주세요');
			}else {
				var list = '${products}'.split('CoupungDTO');
				var productName = '${products[0].name}';
				var len = list.length;
				if (len > 2) {
					productName += ' 외 ' + (len - 2) + ' 개';
				}
				
				var coupungNumber = [];
				$('.coupungNumber').each(function() {
					coupungNumber.push($(this).val());
				});
				var quantities = [];
				$('.product-quantity').each(function() {
					quantities.push($(this).text());
				});
				var options = [];
				$('.optionNumber').each(function() {
					options.push($(this).val());
				});
				
				var price = 0;
				
				var priceUrl = "${appPath}/coupung/price?coupungNumbers=" + coupungNumber.join(',') + "&quantities=" + quantities.join(',');
				var orderer = $('#name-txt').val();
				var zipCode = $('#zipcode-txt').val();
				var address = $('#address-txt').val() + " " + $('#address-detail-txt').val();
				var phoneNumber = $('#phone-txt').val();
				var email = $('#id-txt').val() + "@" + $('#domain-txt').val();
				if ($('#creditCard').is(':checked')) {
					 $.ajax({
						 url : priceUrl,
						 type : 'get',
						 success : function(price) {
							 IMP.init("imp43370630");
		
				             IMP.request_pay({ 
				                 pg: "kcp",
				                 amount: price, 
				                 name: productName, 
				                 buyer_email: email, 
				                 buyer_name: orderer, 
				                 buyer_tel: phoneNumber, 
				                 buyer_addr: address, 
				                 buyer_postcode: zipCode
				             }, 
				             function (rsp) { 
				             	$.ajax({
				             		type: "POST",
				             		url : "${appPath}/coupung/orderCheck?imp_uid=" + rsp.imp_uid 
				             	}).done(function(data) {
				             		if (rsp.paid_amount === data.response.amount) {
				             			var orderList = [];
				             			var totalQuantity = 0;
				             			for (let i = 0; i < coupungNumber.length; i++) {
				             				var product = {
				             					'coupungNumber' : Number(coupungNumber[i]),
				             					'optionNumber' : Number(options[i]),
				             					'quantity' : Number(quantities[i])
				             				}
				             				orderList.push(product);
				             				totalQuantity += Number(quantities[i]);
				             			}
				             			var orders = {
				             					'totalPrice' : data.response.amount,
				             					'totalQuantity' : totalQuantity,
				             					'paymentMethod' : 'card',
				             					'receiverName' : $('#name-txt-2').val(),
				             					'receiverPhone' :  $('#phone-txt-2').val(),
				             					'shippingAddress' : zipCode + " " + address,
				             					'orderDetails' : orderList
				             			}
				             			$.ajax({
				             				url : "${appPath}/coupung/order",
				             				type : "post",
				             				data : JSON.stringify(orders),
				             				contentType : 'application/json',
				             				success : function (res) {
				             					if (res === 'success') {
				             						location.href = "${appPath}/coupung/order/complete";
				             					}
				             				},
				                            error: function(request, status, error) {
				                                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				                            }
				             			});
				             		} else {
				             			alert("결제에 실패하였습니다.");
				             		}
				             	});
				            });
						 } 
					});
				}
				
				if($('#kakaoPay').is(':checked')) {
					$.ajax({
						 url : priceUrl,
						 type : 'get',
						 success : function(price) {
							 IMP.init("imp43370630");
				             IMP.request_pay({ 
				                 pg: "kakaopay",
				                 amount: price, 
				                 name: productName, 
				                 buyer_email: email, 
				                 buyer_name: orderer,
				                 buyer_tel: phoneNumber,
				                 buyer_addr: address,
				                 buyer_postcode: zipCode
				             }, 
				             function (rsp) {
				    			console.log(rsp);
				             	$.ajax({
				             		type: "POST",
				             		url : "${appPath}/coupung/orderCheck?imp_uid=" + rsp.imp_uid 
				             	}).done(function(data) {
				             		console.log(data);
				             		if (rsp.paid_amount === data.response.amount) {
				             			var orderList = [];
				             			var totalQuantity = 0;
				             			for (let i = 0; i < coupungNumber.length; i++) {
				             				var product = {
				             					'coupungNumber' : Number(coupungNumber[i]),
				             					'coupungOptionNumber' : Number(options[i]),
				             					'quantity' : Number(quantities[i])
				             				}
				             				orderList.push(product);
				             				totalQuantity += Number(quantities[i]);
				             			}
				             			
				             			var orders = {
				             					'totalPrice' : data.response.amount,
				             					'totalQuantity' : totalQuantity,
				             					'paymentMethod' : 'kakaoPay',
				             					'receiverName' : $('#name-txt-2').val(),
				             					'receiverPhone' :  $('#phone-txt-2').val(),
				             					'shippingAddress' : zipCode + " " + address,
				             					'orderDetails' : orderList
				             			}
				             			$.ajax({
				             				url : "${appPath}/coupung/order",
				             				type : "post",
				             				data : JSON.stringify(orders),
				             				contentType : 'application/json',
				             				success : function (res) {
				             					if (res === 'success') {
				             						location.href = "${appPath}/coupung/order/complete";
				             					}
				             				},
				                            error: function(request, status, error) {
				                                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				                            }
				             			});
				             		} else {
				             			alert("결제에 실패하였습니다.");
				             		}
				             	});
				            });
						 } 
					});
				}
			}
		});
		
		var toggleButton = document.getElementById('toggleButton');
		
		function toggleOrderList() {
		    var orderListBody = document.querySelector('.order-list-body');
		    if (orderListBody.style.display === 'none') {
		        orderListBody.style.display = 'block';
		    } else {
		        orderListBody.style.display = 'none';
		    }
		}

		toggleButton.addEventListener('click', function() {
		    toggleOrderList(); 
		});

		document.addEventListener('DOMContentLoaded', function() {
		    var orderListBody = document.querySelector('.order-list-body');
		    orderListBody.style.display = 'none';
		});

	</script>
	
</body>
</html>
