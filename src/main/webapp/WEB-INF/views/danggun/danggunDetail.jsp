<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/nav.css" rel="stylesheet" />
<link href="${appPath}/css/danggunDetail.css" rel="stylesheet" />
<link href="${appPath}/css/danggunUpdateModal.css" rel="stylesheet" />
<link href="${appPath}/css/danggunReportModal.css" rel="stylesheet" />
<link href="${appPath}/css/danggunShareModal.css" rel="stylesheet" />
<link href="${appPath}/css/footer.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>오운완</title>
<link rel="icon" href="../images/logo.png" type="image/x-icon">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="overlay"></div>
	<%@ include file="../common/header.jsp"%>

	<div class="container">
		<%@ include file="../common/nav.jsp"%>

		<div class="product-all">
			<div class="details">
				<div class="photos">
					<c:if test="${post.productImagesList.size() ne 1}">
						<div class="product-img-2 small-img">
							<c:forEach var="images" items="${post.productImagesList}">
								<c:if test="${images.type eq 1}">
									<div>
										<img class="small-img detail-img" src="${images.url}" />
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
					<c:if test="${post.productImagesList.size() eq 1}">
					</c:if>
					<div class="product-img-1 big-img">
						<c:forEach var="images" items="${post.productImagesList}">
							<c:if test="${images.type eq 0}">
								<img class="big-img" src="${images.url }" />
							</c:if>
						</c:forEach>
					</div>
				</div>

				<div class="product">
					<div class="product-detail">
						<div class="product-top">
							<div class="product-name">${post.productName}</div>
							<c:if test="${admin ne null}"></c:if>
							<c:if
								test="${admin eq null and userInfo.clientId != post.clientId}">
								<div class="hamburger">
									<div class="post-menu" onclick="toggle()">
										<img src="${appPath}/images/toggleButton.png">
									</div>
									<div class="small-menu" id="smallMenu">
										<button class="modal-button" onclick="openShareModal()">공유</button>
										<button class="modal-button" onclick="openReportModal()">신고</button>
									</div>
								</div>
							</c:if>
						</div>
						<div class="seller" id="seller">판매자 : ${post.clientId}</div>
						<div class="product-price" id="product-price">가격 :
							<sapn id="danggunPrice">${post.price}</sapn>원</div>
						<div class="registered-date" id="registered-date">등록일 :
							${post.uploadDate}</div>
						<div class="trade_step">${post.tradeStep}</div>

						<div class="product-bottom">
							<c:if test="${admin ne null}"></c:if>
							<c:if
								test="${admin eq null and userInfo.clientId != post.clientId}">
								<button class="zzimBtn" id="wishListBtn" type="button"
									value="${post.danggunNumber}">
									<img id="wishListImg" class="wish-list-img"
										src="${appPath}/images/danggun_wishlist_${post.wishListImg}.png" />
									<div id="small" class="small">${post.countZzim}</div>
								</button>
								<button class="chatting main-button" id="chatting" type="button">
									채팅하기</button>
							</c:if>
							<c:if test="${userInfo.clientId == post.clientId}">
								<button class="white-button"
									onclick="openModal(${post.tradeHistoryNumber})">수정하기</button>
								<button class="danggun-delete main-button" id="danggunDelete"
									type="submit">삭제하기</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="here">${post.detail}</div>
		</div>
	</div>
	<hr />
	<div id="danggunModal" danggunNumber="${post.danggunNumber}"
		clientId="${post.clientId}"></div>
	<%@ include file="../common/footer.jsp"%>
	<%@ include file="./danggunReportModal.jsp"%>
	<%@ include file="./danggunUpdateModal.jsp"%>
	<%@ include file="./danggunShareModal.jsp"%>
	<script src="${appPath}/js/danggunUpdateModal.js"></script>
	<script src="${appPath}/js/danggunReportModal.js"></script>
	<script src="${appPath}/js/danggunShareModal.js"></script>
	<script src="${appPath}/js/main.js"></script>
	<script src="${appPath}/js/danggunDetail.js"></script>
	<script>
	$(document).ready(function() {
	    var danggunPriceElement = $("#danggunPrice");
	    var danggunPriceValue = danggunPriceElement.text();
	    var formattedDanggunPrice = makeComma(parseFloat(danggunPriceValue));
	    danggunPriceElement.text(formattedDanggunPrice);
	});

	function makeComma(n) {
	    return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	}	
	
	function toggle() {
		$("#smallMenu").toggle();
	}
	$(function() {
		if ('${post.visibility}'==0 && '${admin}' == "") {
			$(".overlay").show();
			setTimeout(function() {
	            alert("판매가 중지된 상품입니다.");
	            location.href= "${appPath}/danggun/main";
	        }, 100); 
	    }
		
	});
</script>
</body>
</html>
