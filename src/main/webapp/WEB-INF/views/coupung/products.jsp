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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
    <link href="${appPath }/css/coupung/main2.css" rel="stylesheet">
    <link href="${appPath }/css/coupung//header.css" rel="stylesheet">
    <link href="${appPath }/css/coupung//nav.css" rel="stylesheet">
    <link href="${appPath }/css/coupung//coupung.css" rel="stylesheet">
</head>
<body>
    <header>
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="profileImage" href="#">
                    <img src="../images/google.png">
                </a>
                <span>0000님 환영합니다</span>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
        </div>
        <div class="header-sub-menu">
            <div>
                <a href="#">마이페이지</a>
                <a href="${appPath }/clients/logout">로그아웃</a>
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

        <div class="coupung-main">
            <div class="banner">
                <a class="banner-pointer-left" href="#"></a>
                <a class="banner-pointer-right" href="#"></a>
                <span class="banner-page">
                    <span>1</span>
                    <span>/</span>
                    <span>7</span>
                </span>
            </div>
            <div class="category">
                <a class='category-detail'>
                    <div class="whole">
                    	<input type="hidden" value="0" class="categoryValue" />
                    </div>
                    <span>전체보기</span>
                </a>
                <a class='category-detail'>
                    <div class="clothing">
                    	<input type="hidden" value="1" class="categoryValue" />
                    </div>
                    <span>의류</span>
                </a>
                <a class='category-detail'>
                    <div class="vitamin">
                    	<input type="hidden" value="2" class="categoryValue" />
                    </div>
                    <span>건강 식품</span>
                </a>
                <a class='category-detail'>
                    <div class="ticket">
                    	<input type="hidden" value="4" class="categoryValue" />
                    </div>
                    <span>헬스 이용권</span>
                </a>
                <a class='category-detail'>
                    <div class="machine">
                    	<input type="hidden" value="3" class="categoryValue" />
                    </div>
                    <span>운동 기구</span>
                </a>
            </div>
            <form class="search">
                <input class="searchProduct" id="inputBox" type="text" placeholder="상품 검색">
                <button id="findButton" type="button"></button>
                <span></span>
            </form>
            <div class="productList">
            	<c:choose>
					<c:when test="${empty productList}">
						<div class="product">상품이 존재하지 않습니다</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="product" items="${productList}">
							<div class="product">
								<a>
			                		<input type="hidden" value="${product.coupungNumber}"class="item-number">
			                		<img class="product-image" src="${product.image[0].url }">
			                		<div>${product.name}</div>
			                		<div><span>${product.price }</span>원</div>
		                		</a>
		            		</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
    </div>
	<script src="../js/main.js"></script>
	<script>
	$('.category-detail').click(function() {
		var id = $(this).find('.categoryValue').val();
		$.ajax({
            url : "${appPath}/coupung/product/category",
            type : "get",
            data : {
            	"categoryNum" : id	
            },
            success: function(res) {
                // Remove the existing product area zone
$('.productList').html('');
                
                var inside = '';
                
                if(res.length == 0) {
                	inside += '<div>상품이 존재하지 않습니다</div>';
                } else {

                	// Loop through each product in the response and construct HTML
                	res.forEach(function(product) {
	                    inside += '<div class="product"><a><input type="hidden" value="' + product.coupungNumber + '"class="item-number">' + 
	                    '<img class="product-image" src="' + product.image[0].url + '">' + 
	                    '<div>' + product.name + '</div>' + 
	                    '<div><span>' + product.price + '</span>원</div></a></div>';
                	});
                }
                $('.productList').append(inside);
            },
            error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    });
	
	$('.search').on('submit', function() {
		event.preventDefault();
		var txt = $('#inputBox').val();
		$.ajax({
            url : "${appPath}/coupung/product/name",
            type : "get",
            data : {
            	"text" : txt	
            },
            success: function(res) {
                // Remove the existing product area zone
                $('.productList').html('');
                
                var inside = '';
                
                if(res.length == 0) {
                	inside += '<div class="product">상품이 존재하지 않습니다</div>';
                } else {

                	// Loop through each product in the response and construct HTML
                	res.forEach(function(product) {
	                    inside += '<div class="product"><a><input type="hidden" value="' + product.coupungNumber + '"class="item-number">' + 
	                    '<img class="product-image" src="' + product.image[0].url + '">' + 
	                    '<div>' + product.name + '</div>' + 
	                    '<div><span>' + product.price + '</span>원</div></a></div>';
                	});
                }
                $('.productList').append(inside);
            },
            error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
	
	});
	
	$('.productList').on('click', '.product', function() {
		var cNum = $(this).find('.item-number').val();
		console.log($(this).html());
		console.log(cNum);
		location.href="${appPath}/coupung/product/detail?coupungId=" + cNum;
	});
</script>
</body>
</html>