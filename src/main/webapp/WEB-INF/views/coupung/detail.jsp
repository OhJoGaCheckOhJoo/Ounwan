<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Document</title>
<link href="${appPath }/css/main.css" rel="stylesheet">
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link href="${appPath }/css/coupung/coupung.css" rel="stylesheet">
<link href="${appPath }/css/coupung/modal.css" rel="stylesheet">
<title>Document</title>
</head>
<body>
<script>
	$(function() {
		if (!${detail.availableCheck}) {
			location.href="${appPath}/unsellableProduct";
		}
	});
</script>
	<%@ include file="../common/header.jsp" %>
    <div class="container">
        <%@ include file="../common/nav.jsp" %>

		<div>
			<div class="product-detail">
				<div class="product-img-2">
					<c:forEach var="image" items="${detail.image }" begin='1'>
						<img class="detail-img" src="${image.url }">
					</c:forEach>
				</div>
				<div class="product-img-1">
					<!-- <%-- 메인 이미지 수정--%> -->
					<img src="${detail.image[0].url }">
				</div>
				<div class="product-box">
					<div class="product-title">
						<div>
							<!-- <%-- 상품명 수정--%> -->
							<span>${detail.name }</span>
						</div>
						<div class="product-share" onclick="clip()"></div>
					</div>
					<div>
						<div class="product-score">
							<!-- <%-- 하단 평점 별이미지 forEach (java에서 처리 필요해보임) --%> -->
							<img src="./full_star.png"> <img src="./full_star.png">
							<img src="./full_star.png"> <img src="./full_star.png">
							<img src="./half_star.png">
							<!-- <%-- ==================== --%> -->
						</div>
						<span>(<span>62</span>)
						</span>
					</div>
					<div class="delivery">
						<span>당일 배송</span>
					</div>
					<div class="product-info">
						<div class="product-point">
							<img src="./poing.png"> <span>구매시 15 포인트로 적립</span>
						</div>
						<!-- <%-- 물품 가격 수정--%> -->
						<div class="product-unit-price">
							<span id="unitPrice">${detail.price }</span>원
						</div>
					</div>
					<div class="product-select">
						<div class="product-option">
							<select id="productOption">
								<option value="0" hidden>옵션선택</option>
								<c:forEach var="opt" items="${detail.options}">
									<option value="${opt.coupungOptionNumber}">${opt.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="product-quantity">
							<input type="number" id="quantity" placeholder="0" disabled>
							<div class="quantity-button">
								<button id="plus" disabled>
									<span>+</span>
								</button>
								<button id="minus" disabled>
									<span>-</span>
								</button>
							</div>
						</div>
						<div class="product-total">
							<span>총 금액 : </span> <span id="totalPrice">0</span> <span>원</span>
						</div>
					</div>
					<div class="product-order">
						<button id='cartBtn' type='button'>장바구니</button>
						<button id='payBtn' type='button'>바로구매</button>
					</div>
				</div>
			</div>
			<div>
				<div class="product-view-option">
					<a href="#" id="explain" class="selected">상품 설명</a> <a href="#"
						id="comment">후기</a>
				</div>
				<div class="product-additional-view">
					<div class="product-explain">
						<c:forEach var="image" items="${detail.detailImages }">
							<img class="detail-img" src="${image.url}">
						</c:forEach>
					</div>
					<div class="product-comment" hidden>
						<div class="comment-info">
							<span>리뷰&nbsp;</span> <span class="reviewTotalCount"></span>
						</div>
						<div class="comment-total">
							<div class="total-score">
								<div>
									<div id="mainScore"></div>
									<img src="${appPath}/images/star.png">
								</div>
								<div class="total"></div>
							</div>
							<div class="total-detail">
								<c:forEach var="score" items="${scoreList}"
									varStatus="loopStatus">
									<c:if test="${score ne 0}">
										<div>
											<div class="detail-score">${loopStatus.index+1}점</div>
											<div class="detail-bar exist">
												<div id="score${loopStatus.index+1}"></div>
												<img src="${appPath}/images/bar.png"> <span>${score}</span>
											</div>
										</div>
									</c:if>
									<c:if test="${score eq 0}">
										<div>
											<div class="detail-score">${loopStatus.index+1}점</div>
											<div class="detail-bar non">
												<div id="score${loopStatus.index+1}"></div>
												<img src="${appPath}/images/bar.png"> <span>${score}</span>
											</div>
										</div>
									</c:if>

								</c:forEach>
							</div>
						</div>
						<div>
							<c:forEach var="reviewList" items="${reviewList}">
								<c:if test="${reviewList eq null }">
									<div class="personal-comment">
										<div class="comment-user">
											<div class="comment-user-info">
												<img src="${reviewList.PROFILE_URL}">
												<div>
													<div class="comment-user-id">${reviewList.CLIENT_ID}</div>
													<div class="comment-option">[옵선명]
														${reviewList.COUPUNG_OPTION_NAME}</div>
												</div>
											</div>
											<div class="personal-score">
												<div style="width: calc(${reviewList.SCORE} * 50px);"></div>
												<img src="${appPath}/images/star.png">
											</div>
										</div>
										<div class="personal-comment-content">${reviewList.CONTENTS}</div>
										<c:if test="${reviewList.IMAGE_URL ne null}">
											<div class="personal-review-image">
												<img src="${reviewList.IMAGE_URL}">
											</div>
										</c:if>
										<c:if test="${reviewList.IMAGE_URL == null}">
										</c:if>
									</div>
								</c:if>
								<c:if test="${reviewList ne null}">
									<c:if test="${reviewList.IMAGE_URL eq null}">
										<div class="personal-comment no-image">
											<div class="comment-user">
												<div class="comment-user-info">
													<img src="${reviewList.PROFILE_URL}">
													<div>
														<div class="comment-user-id">${reviewList.CLIENT_ID}</div>
														<div class="comment-option">[옵션명]
															${reviewList.COUPUNG_OPTION_NAME}</div>
													</div>
												</div>
												<div class="personal-score">
													<div style="width: calc(${reviewList.SCORE} * 50px);"></div>
													<img src="${appPath}/images/star.png">
												</div>
											</div>
											<div class="personal-comment-content">${reviewList.CONTENTS}</div>



										</div>
									</c:if>
									<c:if test="${reviewList.IMAGE_URL ne null}">
										<div class="personal-comment image-exist">
											<div class="comment-user">
												<div class="comment-user-info">
													<img src="${reviewList.PROFILE_URL}">
													<div>
														<div class="comment-user-id">${reviewList.CLIENT_ID}</div>
														<div class="comment-option">[옵션명]
															${reviewList.COUPUNG_OPTION_NAME}</div>
													</div>
												</div>
												<div class="personal-score">
													<div style="width: calc(${reviewList.SCORE} * 50px);"></div>
													<img src="${appPath}/images/star.png">
												</div>
											</div>
											<div class="personal-comment-content">${reviewList.CONTENTS}</div>
											<div class="personal-review-image">
												<img src="${reviewList.IMAGE_URL}">
											</div>
										</div>
									</c:if>

								</c:if>

							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="modalContainer" class="hidden">
		<div id="modalContent">
			이메일 : <input type="text" id="guestEmail" /> <br> 핸드폰 번호 : <input
				type="text" id="guestPhone" /> <br>
			<button type="button" id="guestSubmitBtn">입력</button>
		</div>
	</div>
	<script src="../js/main.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script>
const unitPrice = $("#unitPrice").html().replaceAll(",",""); // jsp에서는 DB에서 가져온 가격으로 설정


const scoreList = [
    <c:forEach var="score" items="${scoreList}" varStatus="loopStatus">
        ${score}<c:if test="${!loopStatus.last}">, </c:if>
    </c:forEach>
];

	const scoreNum = scoreList.reduce((acc, cur) => {return acc + cur}, 0); // 총 리뷰 개수
	const productScore = (scoreList[0]*1 + scoreList[1]*2 + scoreList[2]*3 + scoreList[3]*4 + scoreList[4]*5) /scoreNum;  // 평균 별점
	console.log("scoreNum:"+scoreNum);
	$(".reviewTotalCount").text(scoreNum);

if(scoreNum != 0) {
	$(".total").text((productScore).toFixed(1));
	$("#mainScore").css('width', productScore * 60 + 'px');
}
else {
	$(".total").text((0.0).toFixed(1));
	$("#mainScore").css('width', 0 + 'px');
}


// 막대, 별모양 평점 그래프 출력
$("#miniScore").css('width', productScore * 30 + 'px');
for(var i = 0; i < 5; i++) {
    $("#score" + (i + 1)).css('width', (scoreList[i] / scoreNum) * 300 + 'px');
}

	// 상세이미지 클릭하였을 때, 메인이미지와 변경
	$(".product-detail").on("click", ".detail-img", function() {
	    var detailsrc = $(this).attr("src");
	    $(this).attr("src", $(".product-img-1 img").attr("src"));
	    $(".product-img-1 img").attr("src", detailsrc);
	});
	
	 // 옵션 선택하면 수량 선택 가능
    $("#productOption").on("change", function() {
        if($(this).val() > 0) {
            $(".product-quantity input").attr("disabled", false);
            $(".product-quantity input").val(1);
            $("#totalPrice").html((unitPrice * $("#quantity").val()).toLocaleString());
            $("#plus").attr("disabled", false);
            $("#minus").attr("disabled", false);
        }
    });

 	// 수량을 직접 입력하는 경우
    $(".product-quantity input").on("change", function() {
        if($(this).val() < 1) {
            $(this).val(1);
        }
        $("#totalPrice").html((unitPrice * $(this).val()).toLocaleString());
    });
 	
 	// 수량 + / - 버튼
    $("#plus").on("click", function() {
        $(".product-quantity input").val((Number)($(".product-quantity input").val()) + 1);
        $("#totalPrice").html((unitPrice * $(".product-quantity input").val()).toLocaleString());
    });
    $("#minus").on("click", function() {
        if($(".product-quantity input").val() > 1) {
            $(".product-quantity input").val((Number)($(".product-quantity input").val()) - 1);
            $("#totalPrice").html((unitPrice * $(".product-quantity input").val()).toLocaleString());
        }
    });

 	// 상품설명 버튼 클릭
    $("#explain").on("click", function() {
        if($(this).attr("class") != "selected") {
            $(".product-explain").attr("hidden", false);
            $(".product-comment").attr("hidden", true);
            $("#explain").addClass("selected");
            $("#comment").removeClass("selected");
        }
    });
 	
 	// 후기 버튼 클릭
    $("#comment").on("click", function() {
        if($(this).attr("class") != "selected") {
            $(".product-explain").attr("hidden", true);
            $(".product-comment").attr("hidden", false);
            $("#explain").removeClass("selected");
            $("#comment").addClass("selected");
        }
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
		if ($('#productOption option:selected').val() === '0') {
			alert('수량을 선택해 주세요');
		} else {
			var option = $('#productOption option:selected').val();
			var quantity = (Number)($('#quantity').val());
			alert(quantity);
			var obj = {
					'coupungNumber' : ${detail.coupungNumber},
					'quantity' : quantity,
					'coupungOptionNumber' : option,
					'name' : '${detail.name}',
					'option' : $('#productOption option:checked').text(),
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
		if ($('#productOption option:selected').val() === '0') {
			alert('수량을 선택해 주세요');
		}  else if('${userInfo}' === '') {
			if(!confirm('로그인 하시겠습니까?')) {
				$('#modalContainer').removeClass('hidden'); // 모달을 띄우는 부분
			} else {
				location.href="${appPath}/clients/login";
			}
		} else {
			var productList = [${detail.coupungNumber}];
			var optionList = [$('#productOption option:selected').val()];
			var quantityList = [$('#quantity').val()];
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
						var optionList = [$('#productOption option:selected').val()];
						var quantityList = [$('#quantity').val()];
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