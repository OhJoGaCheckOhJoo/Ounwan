<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
	<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
    <link href="${appPath }/css/main2.css" rel="stylesheet">
    <link href="${appPath }/css/main.css" rel="stylesheet">
    <link href="${appPath }/css/header.css" rel="stylesheet">
    <link href="${appPath }/css/nav.css" rel="stylesheet">
    <link href="${appPath }/css/coupung/coupung.css" rel="stylesheet">
    <link href="${appPath }/css/footer.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <div class="container">
        <%@ include file="../common/nav.jsp" %>

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
			                		<div class='product-name'>${product.name}</div>
			                		<div><span>${product.price }</span>원</div>
		                		</a>
		            		</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
    </div>
	<%@ include file="../common/footer.jsp"%>
	<script src="${appPath}/js/main.js"></script>
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
				$('.productList').html('');
                var inside = '';
                if(res.length == 0) {
                	inside += '<div>상품이 존재하지 않습니다</div>';
                } else {
                	res.forEach(function(product) {
	                    inside += '<div class="product"><a><input type="hidden" value="' + product.coupungNumber + '"class="item-number">' + 
	                    '<img class="product-image" src="' + product.image[0].url + '">' + 
	                    '<div class="product-name">' + product.name + '</div>' + 
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
                $('.productList').html('');
                var inside = '';
                if(res.length == 0) {
                	inside += '<div class="product">상품이 존재하지 않습니다</div>';
                } else {
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
		location.href="${appPath}/coupung/product/detail?coupungId=" + cNum;
	});
</script>
</body>
</html>