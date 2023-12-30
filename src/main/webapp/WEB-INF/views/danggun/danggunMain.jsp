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
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/nav.css" rel="stylesheet" />
<link href="${appPath}/css/danggunMain.css" rel="stylesheet" />
<title>오운완</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>
<body>

	<%@ include file="../common/header.jsp" %>

    <div class="container">
        <%@ include file="../common/nav.jsp" %>

		<div class="danggun-container">
			<button id="upButton" class="up-button">위로</button>
			<div class="search">
				<div class="search-container">
					<input id="searchInput" class="search-input"
						placeholder="원하시는 상품을 입력해 주세요.">
					<button id="searchButton" class="search-button" name="searchName">검색</button>
				
				</div>

				<div class="register-container">
					<button id="registerButton" class="register-button"
						onclick="registerPage()">제품등록</button>
				</div>

				<div id="danggunProductList" class="danggun-product-list">

					<c:forEach var="list" items="${list}">
						<a
							href="${appPath}/danggun/detail?danggunNumber=${list.danggunNumber}">
							<div class="danggun-pointer">
								<img class="danggun-img-loc" src="${list.url}">
								<div class="danggun-name">
									<c:out value="${list.productName}" />
								</div>
								<div class="danggun-price">
									<c:out value="${list.price}원" />
								</div>
							</div>
						</a>
					</c:forEach>
				</div>

			</div>
		</div>
		<hr>
	</div>
	​
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
			<br> <br>
			<div>
				<a href="#">이벤트</a>
			</div>
			<div>
				<a href="#">개인정보처리방침</a>
			</div>
			<div>
				<a href="#">이용약관</a>
			</div>
			<div>
				<img class="float-right img-1 pointer" src="../images/insta.png">
			</div>
		</div>
	</footer>
	<script src="../js/main.js"></script>
	<script>
		$(function() {
			function search() {
				var obj = {
					"searchInput" : $("#searchInput").val()
				};
				$
						.ajax({
							type : 'POST',
							url : "${appPath}/danggun/main",
							data : obj,
							success : function(responseData) {
								console.log(responseData);
								var output = "";
								if (responseData.length === 0) {
									output += "<div class='none-search-list'>검색 결과가 없습니다.</div>"
								} else {
									for ( var i in responseData) {
										output += "<div class='danggun-pointer'>";
										output += "<img class='danggun-img-loc' src="+ responseData[i].url+">";
										output += "<div class='danggun-name'>"
												+ responseData[i].productName
												+ "</div>";
										output += "<div class='danggun-price'>"
												+ responseData[i].price
												+ "</div>";
										output += "</div>";
									}
								}
								$("#danggunProductList").html(output);
							}
						});
			}

			$("#searchInput").keypress(function(event) {
				if (event.which === 13) {
					event.preventDefault();
					search();
				}
			});

			$("#searchButton").click(function() {
				search();
			});

			$("#registerButton").click(function() {
				window.location.href = "${appPath}/danggun/insert";
			})

			$("#upButton").click(function() {
				window.scrollTo(0, 0);
			})
		});
	</script>
</body>
</html>