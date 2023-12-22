<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
    <link href="${appPath }/css/coupung/main2.css" rel="stylesheet">
    <link href="${appPath }/css/coupung/header.css" rel="stylesheet">
    <link href="${appPath }/css/coupung/nav.css" rel="stylesheet">
    <link href="${appPath }/css/coupung/coupung.css" rel="stylesheet">
    <title>Document</title>
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
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="signUp" href="./html/signup.html"></a>
                <a id="loginSelect" href="#"></a>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
        </div>
    </header>

    <div class="container">
        <nav>
            <div class="nav-main">
                <div class="pointer">
                    <a id="hamberger-btn" class="menu-trigger">
                        <span></span>
                        <span></span>
                        <span></span>
                    </a>
                </div>
                <div>
                    <a href="${appPath}/coupung/products">쇼핑몰</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="${appPath}/coupung/products">전체 보기</a>
                        <a href="${appPath}/coupung/products?categoryNum=3">운동 기구</a>
                        <a href="${appPath}/coupung/products?categoryNum=2">건강 보조 식품</a>
                        <a href="${appPath}/coupung/products?categoryNum=4">헬스 이용권</a>
                        <a href="${appPath}/coupung/products?categoryNum=1">의류</a>
                    </div>
                </div>
                <div>
                    <a href="#">중고거래</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                </div>
                <div>
                    <a href="#">커뮤니티</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                </div>
                <div>
                    <a href="#">고객센터</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
            <div id="navMenu" class="nav-menu">
                <div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">운동 기구</a>
                        <a href="#">건강 보조 식품</a>
                        <a href="#">헬스 이용권</a>
                        <a href="#">의류</a>
                    </div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                    <div>
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                    <div>
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
        </nav>

        <div>
            <div class="product-detail">
                <div class="product-img-2">
                	<c:forEach var="image" items="${detail.image }" begin='1'>
                		<img class="detail-img" src="../${image.url }">
                	</c:forEach>
                </div>
                <div class="product-img-1">
                    <!-- <%-- 메인 이미지 수정--%> -->
                    <img src="../${detail.image[0].url }">
                </div>
                <div class="product-box">
                    <div class="product-title">
                        <div>
                            <!-- <%-- 상품명 수정--%> -->
                            <span>${detail.name }</span>
                        </div>
                        <div class="product-share" onclick="clip()">
                        </div>
                    </div>
                    <div>
                        <div class="product-score">
                            <!-- <%-- 하단 평점 별이미지 forEach (java에서 처리 필요해보임) --%> -->
                            <img src="./full_star.png">
                            <img src="./full_star.png">
                            <img src="./full_star.png">
                            <img src="./full_star.png">
                            <img src="./half_star.png">
                            <!-- <%-- ==================== --%> -->
                        </div>
                        <span>(<span>62</span>)</span>
                    </div>
                    <div class="delivery">
                        <span>당일 배송</span>
                    </div>
                    <div class="product-info">
                        <div class="product-point">
                            <img src="./poing.png">
                            <span>구매시 15 포인트로 적립</span>
                        </div>
                        <!-- <%-- 물품 가격 수정--%> -->
                        <div class="product-unit-price"><span id="unitPrice">${detail.price }</span>원</div>
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
                                <button id="plus" disabled><span>+</span></button>
                                <button id="minus" disabled><span>-</span></button>
                            </div>
                        </div>
                        <div class="product-total">
                            <span>총 금액 : </span>
                            <span id="totalPrice">0</span>
                            <span>원</span>
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
                    <a href="#" id="explain" class="selected">상품 설명</a>
                    <a href="#" id="comment">후기</a>
                </div>
                <div class="product-additional-view">
                    <div class="product-explain">
                        <img src="./hamberger.png">
                    </div>
                    <div class="product-comment" hidden>
                        <div>
                            <div>
                                <!-- <%-- 하단 평점 별이미지 forEach (java에서 처리 필요해보임) --%> -->
                                <img src="./full_star.png">
                                <img src="./full_star.png">
                                <img src="./full_star.png">
                                <img src="./full_star.png">
                                <img src="./half_star.png">
                                <!-- <%-- ==================== --%> -->
                            </div>
                            <div>
                                <div>5점</div>
                                <div>4점</div>
                                <div>3점</div>
                                <div>2점</div>
                                <div>1점</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/main.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
const unitPrice = $("#unitPrice").html().replaceAll(",",""); // jsp에서는 DB에서 가져온 가격으로 설정
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
				$('#fullScreenModal').modal('show'); // 모달을 띄우는 부분
			} else {
				location.href="${appPath}/clients/login";
			}
		} else {
			var productList = [${detail.coupungNumber}];
			var optionList = [$('#productOption option:selected').val()];
			var quantityList = [$('#quantity').val()];
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