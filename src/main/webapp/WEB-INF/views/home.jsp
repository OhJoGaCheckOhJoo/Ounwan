<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<c:set
  var="appPath"
  scope="application"
  value="${pageContext.request.contextPath}"
/>
<!DOCTYPE html>

<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오운완</title>

<head>
	<c:set var="appPath" scope="application"  value="${pageContext.request.contextPath}" />
    <link href="${appPath}/css/main.css" rel="stylesheet" />
    <link href="${appPath}/css/main2.css" rel="stylesheet" />
    <link href="${appPath}/css/header.css" rel="stylesheet" />
    <link href="${appPath}/css/nav.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
</head>
<body>
	<script>
		$(function() {
			$.ajax({
				url : "${appPath}/coupung/product/top-five",
				type : "GET",
				success : function(res) {
					var tag = '';
					
					res.forEach(function(product) {
		                let price = numberComma(product.price);
		                var div = $("<div></div>").addClass("pointer");
		                div.append($("<img>").addClass("img-2 img-border").attr("src", product.image[0].url));
		                div.append($("<div></div>").text(product.name));
		                div.append($("<div></div>").text(price + ' 원'));

		                div.on("click", function() {
		                    window.location.href = '${appPath}/coupung/product/detail?coupungId=' + product.coupungNumber;
		                });

		                $("#populars").append(div);
		            });
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
			$.ajax({
				url : "${appPath}/danggun/product/top-five",
				type : "GET",
				success : function(res) {
					var tag = '';
					
					res.forEach(function(product) {
		                let price = numberComma(product.price);
		                var danggunDiv = $("<div></div>").addClass("pointer");
		                danggunDiv.append($("<div></div>").text("메롱"));
		                danggunDiv.append($("<img>").addClass("img-2 img-border").attr("src", product.url));
		                danggunDiv.append($("<div></div>").text(product.name));
		                danggunDiv.append($("<div></div>").text(price + ' 원'));

		                danggunDiv.on("click", function() {
		                    window.location.href = '${appPath}/danggun/detail?danggunNumber=' + product.danggunNumber;
		                });

		                $("#secondhands").append(danggunDiv);
		            });
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		function numberComma(n) {
		    return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		}
	</script>
    <%@ include file="./common/header.jsp" %>

    <div class="container">
        <%@ include file="./common/nav.jsp" %>

        <div id="main-banner" class="main-banner">
            <img src = './images/v616_37.png'>
        </div>
        <div>
            <div class="text-1">
            	<span>인기상품</span>
            	<a href='${appPath}/coupung/products'>전체보기</a>
            </div>
            <div id="populars" class="main-product"></div>
        </div>
        <br>
        <div>
            <div class="text-1">
            	<span>중고상품</span>
            	<a href='${appPath}/danggun/main'>전체보기</a>
            </div>
            <div id="secondhands" class="main-product"></div>
        </div>
        <br>
        <div class="main-community-wrap">
        	<div class='text-1'>오운완 커뮤니티 함께하기</div>
        	<a class='main-community' href="${appPath}/community/ounwangram">
        		<img src="https://src.hidoc.co.kr/image/lib/2023/10/10/1696929851545_0.jpg">
        		<span>운동했다그램 ❯</span>
        	</a>
        	<a class='main-community' href="${appPath}/community/aetaBoard">
        		<img src="https://img.freepik.com/premium-photo/senior-athlete-man-thinking-feeling-doubtful-and-confused-with-different-options-wondering-which-decision-to-make_1194-265930.jpg">
        		<span>애타 ❯</span>
        	</a>
        </div>
    </div>
    <hr>
    
    <%@ include file="./common/footer.jsp" %>
    <script src="${appPath}/js/main.js"></script>
  </body>
</html>
