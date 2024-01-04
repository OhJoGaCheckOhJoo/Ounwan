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
<title>오운완</title>
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
<link href="${appPath }/css/main.css" rel="stylesheet">
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link href="${appPath }/css/footer.css" rel="stylesheet">
<link href="${appPath }/css/coupung/coupung.css" rel="stylesheet">
<link href="${appPath }/css/coupung/modal.css" rel="stylesheet">

</head>
<body>
	<div id="block" class="coupung-product-block"></div>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="../common/nav.jsp"%>
		<div>
			<div class="product-detail" id="productDetail">
				<div class="product-img-2">
					<c:forEach var="image" items="${detail.image }" begin='1'>
						<img class="detail-img" src="${image.url }">
					</c:forEach>
				</div>
				<div class="product-img-1">
					<img src="${detail.image[0].url }">
				</div>
				<div class="product-box">
					<div class="product-title">
						<div>
							<span>${detail.name }</span>
						</div>
						<div class="product-share" onclick="clip()"></div>
					</div>
					<div>
						<div class="product-score">
							<div id="detailScore"></div>
							<img src="${appPath}/images/star.png">
						</div>
						<span class="review-count">(<span id="reviewTotalCount"></span>)
						</span>
					</div>
					<div class="product-info">
						<div class="delivery">
							<span>당일 배송</span>
						</div>
						<div class="product-unit-price">
							<span id="unitPrice">${detail.price}</span>원
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
							<span>리뷰&nbsp;</span> <span id="reviewTotalCount"></span>
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
	<div id="block"></div>
	  <div id="guestModal" class="hidden">
	    	<div class="modal-content">
		    	<div class="modal-body">
			    	<div class="modal-title">
			    		<div>비회원 개인정보 수집 및 이용동의</div>
			    		<div class="modal-close">
		    				<span id="closeBtn" class="close-button">&times;</span>
		    			</div>
			    	</div>
			    	<div class="modal-body-wrap">
			    		<div class="agreement">
							<label for="agree1">
								<input type="checkbox" id="agree1" required>
								<i class="circle"></i> [필수] 개인정보 수집 및 이용 동의
							</label>
						</div>
						<div>
							<div class="modal-input">
						    	<div>
						    		<label class="modal-attribute-name" for="">이메일 </label> 
						    		<input class="box" type="text" id="guestEmail" required/>
						    	</div>
						    	<div>
						    		<label class="modal-attribute-name" for="">연락처 </label> 
						    		<input class="box" type="text" id="guestPhone" required/>
						    	</div>
					    	</div>
					    	<div class="modal-check">
						    	<div>
						    		<button type="button" id="guestSubmitBtn">주문하기</button>
						    	</div>
					    	</div>
				    	</div>
			    	</div>
		    	</div>
	    	</div>
	    </div>
	<%@ include file="../common/footer.jsp"%>
	<script src="${appPath }/js/main.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<script>
    document.addEventListener("DOMContentLoaded", function() {
        if(!${detail.availableCheck} && '${admin}' == "") {
            document.getElementById('block').style.display = 'block';
            
            setTimeout(function() {
            	alert("판매 중지된 상품입니다.\ncoupung 메인 화면으로 이동합니다");           	
            	location.href="${appPath}/coupung/products";
            }, 100); 
        }
    });

	</script>
	<script>
const unitPrice = $("#unitPrice").html().replaceAll(",",""); 
$("#unitPrice").html(makeComma(unitPrice));

function makeComma(n) {
	return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
}
const scoreList = [
    <c:forEach var="score" items="${scoreList}" varStatus="loopStatus">
        ${score}<c:if test="${!loopStatus.last}">, </c:if>
    </c:forEach>
];

	const scoreNum = scoreList.reduce((acc, cur) => {return acc + cur}, 0); 
	const productScore = (scoreList[0]*1 + scoreList[1]*2 + scoreList[2]*3 + scoreList[3]*4 + scoreList[4]*5) /scoreNum;  
	console.log("scoreNum:"+scoreNum);
	$("#reviewTotalCount").text(scoreNum);

if(scoreNum != 0) {
	$(".total").text((productScore).toFixed(1));
	$("#mainScore").css('width', productScore * 60 + 'px');
	$("#detailScore").css('width', productScore * 30 + 'px');
}
else {
	$(".total").text((0.0).toFixed(1));
	$("#mainScore").css('width', 0 + 'px');
	$("#detailScore").css('width', 0 + 'px');
}

$("#miniScore").css('width', productScore * 30 + 'px');
for(var i = 0; i < 5; i++) {
    $("#score" + (i + 1)).css('width', (scoreList[i] / scoreNum) * 300 + 'px');
}

	$(".product-detail").on("click", ".detail-img", function() {
	    var detailsrc = $(this).attr("src");
	    $(this).attr("src", $(".product-img-1 img").attr("src"));
	    $(".product-img-1 img").attr("src", detailsrc);
	});
	
    $("#productOption").on("change", function() {
        if($(this).val() > 0) {
            $(".product-quantity input").attr("disabled", false);
            $(".product-quantity input").val(1);
            $("#totalPrice").html((unitPrice * $("#quantity").val()).toLocaleString());
            $("#plus").attr("disabled", false);
            $("#minus").attr("disabled", false);
        }
    });

    $(".product-quantity input").on("change", function() {
        if($(this).val() < 1) {
            $(this).val(1);
        }
        $("#totalPrice").html((unitPrice * $(this).val()).toLocaleString());
    });
 	
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

    $("#explain").on("click", function() {
        if($(this).attr("class") != "selected") {
            $(".product-explain").attr("hidden", false);
            $(".product-comment").attr("hidden", true);
            $("#explain").addClass("selected");
            $("#comment").removeClass("selected");
        }
    });
 	
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
			if(confirm('비회원으로 주문하시겠습니까?')) {
				$('#guestModal').removeClass('hidden'); 
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
	
	var modal = document.getElementById("guestModal");
	var closeBtn = document.getElementById("closeBtn");

	closeBtn.addEventListener("click", function() {
		modal.classList.add("hidden");
	});

	modal.addEventListener("click", function(event) {
		if (event.target === modal) {
			modal.classList.add("hidden");
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
		var phone = $('#guestPhone').val();
		var phoneFormat = /(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g;
		console.log("len: " + phone.length);
		if (!emailFormat.test(email)) {
			alert('잘못된 이메일 형식입니다!');
			$('#guestEmail').val('');
			$('#guestEmail').focus();
		}  
		else if(!$('#agree1').is(':checked')) {
			alert('필수 동의 사항을 확인해 주세요');
		} 
		else if(!phoneFormat.test(phone)) {
			alert('잘못된 전화번호 형식입니다.');
			$('#guestPhone').val('');
			$('#guestPhone').focus();
		}
		else {
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