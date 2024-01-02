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
<link rel="stylesheet" type="text/css" href="${appPath }/css/main.css" />
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${appPath }/css/order.css" />

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
		        	console.log($(this).text());
		            totalPrice += parseInt($(this).text(), 10);
		        });
		        $('#totalPrice').text(totalPrice);
		        $('#totalOrderPrice').text(totalPrice);
		    }
		    var emailId = '';
		    var domain = '';
		    var phone = '';
		    if ('${userInfo}' != '') {
				emailId = "${userInfo.email}"; 
				phone = '${userInfo.phone}';
				$('#name-txt').val('${userInfo.name}');	
				$('#name-txt').attr('readOnly', true);
			} else if('${guest}' != '') {
				emailId = '${guest.email}'.split('@')[0];
				domain = '${guest.email}'.split('@')[1];
				phone = '${guest.phone}';
			}
		    $('#id-txt').val(emailId);
		    $('#id-txt').attr('readOnly', true);
		    $('#domain-list').attr('disable', true);
		    $('#phone-txt').val(phone);	
		    $('#phone-txt').attr('readOnly', true);
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
						        <div>주문서</div>
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
																	<span>${product.price}원</span>
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
									<div class="checkbox">
										<input type="checkbox" id="orderCheckBox" name="checkbox"
											class="checkbox"><span>주문자 정보와 동일</span>
									</div>
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
											<button id="findAddr" type="button">우편번호 검색</button>
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
									<input type="checkbox" class="paymentMethod" id="creditCard">
									<div >신용카드</div>
									<input type="checkbox" class="paymentMethod" id="kakaoPay">
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
								<a id="agree">보기</a>
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
						<button id="payment">결제하기</button>
					</div>	
				</div>							
			</div>
		</div>
	</div>
	
	<div id="agreementPersonalData">
		<h3>개인정보 수집 및 이용 동의</h3>
		<%@ include file="../common/agreementPersonalData.jsp" %>
		<button>확인</button>
	</div>
	
	<script>
	var readAgreement1 = false; // 변수를 초기화

	// 페이지 로드 시 실행되는 부분
	$(document).ready(function() {
	    $("#agreementPersonalData").hide(); // 페이지 로드 시 모달 숨기기
	});

	$("#agree").on('click', function(event) {
	    event.preventDefault();
	    if (!readAgreement1) {
	        $("#agreementPersonalData").show(); // '보기' 클릭 시 모달 보이기
	    }
	});

	$("#agreementPersonalData button").on("click", function() {
	    readAgreement1 = true;
	    $("#agreementPersonalData").hide(); // 확인 버튼 클릭 시 모달 다시 숨기기
	    $("#agree").attr('disabled', true);
	});


	</script>
	
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
			// 초기에 숨겨진 상태로 시작
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
				$('#phone-txt-2').val('');
				$('#name-txt-2').val('');
				$('#zipcode-txt').val('');
				$('#address-txt').val('');
				$('#address-detail-txt').val('');
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
			             // IMP.request_pay(param, callback) 결제창 호출
	
			             IMP.request_pay({ // param
			                 pg: "kcp",
			                 amount: price, // 상품 비용
			                 name: productName, // 상품명
			                 buyer_email: email, // 주문자 이메일
			                 buyer_name: orderer, // 주문자 명
			                 buyer_tel: phoneNumber, // 주문자 번호
			                 buyer_addr: address, // 주문자 주소
			                 buyer_postcode: zipCode// 우편번호
			             }, 
			             function (rsp) { // callback
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
			             						alert('success');
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
			             // IMP.request_pay(param, callback) 결제창 호출
			             IMP.request_pay({ // param
			                 pg: "kakaopay",
			                 amount: price, // 상품 비용
			                 name: productName, // 상품명
			                 buyer_email: email, // 주문자 이메일
			                 buyer_name: orderer, // 주문자 명
			                 buyer_tel: phoneNumber, // 주문자 번호
			                 buyer_addr: address, // 주문자 주소
			                 buyer_postcode: zipCode// 우편번호
			             }, 
			             function (rsp) { // callback
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
			             						alert('success');
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
		});
		
		// 클릭 이벤트 핸들러 함수
		function toggleOrderList() {
		    var orderListBody = document.querySelector('.order-list-body');
		    if (orderListBody.style.display === 'none') {
		        orderListBody.style.display = 'block';
		    } else {
		        orderListBody.style.display = 'none';
		    }
		}

		// 버튼 요소를 찾아 클릭 이벤트 연결
		var toggleButton = document.getElementById('toggleButton');

		toggleButton.addEventListener('click', function() {
		    toggleOrderList(); // 주문 목록 토글 함수 호출
		});

		// 초기에 주문 목록 숨기기
		document.addEventListener('DOMContentLoaded', function() {
		    var orderListBody = document.querySelector('.order-list-body');
		    orderListBody.style.display = 'none';
		});

	</script>
	
</body>
</html>
