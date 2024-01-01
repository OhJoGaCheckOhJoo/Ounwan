<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div class="guest-order-list-modal-container" id="guestModal">
	<div class="guest-modal-content">
		<span class="close-button" onclick="closeGuestOrderListModal()">&times;</span>
		<div class="guest-modal head">
			<div class="guest-modal-title">
				<div class="ounwan">ounwan</div>
				<div class="guest-order-list-title">비회원주문조회</div>
			</div>
			<div class="guest-modal info">
				<div class="guest-modal-info order-number">
					<span class="info-title order-number">주문번호&nbsp;&nbsp;|&nbsp;</span>
					<span class="info-content order-number">${orderList.orderNumber}</span>
				</div>
				<div class="guest-modal-info order-date">
					<span class="info-title order-date">주문날짜&nbsp;&nbsp;|&nbsp;</span>
					<span class="info-content order-date">${orderList.orderDate}</span>
				</div>
			</div>
		</div>
		<div class="guest-modal body">
			<c:forEach var="detailList" items="${orderList.orderDetails}">
				<div class="proudct-container">
					<a href="#">
						<div class="product-detail-content">
							<div class="product-detail image">
								<img src="${detailList.coupungDTO.image[0].url}">
							</div>
							<diV class="product-detail content">
								<div class="product-detail-content name">
									<div class="product-detail-name title">상품명</div>
									<div class="product-detail-name value">${detailList.coupungDTO.name}</div>
								</div>
								<div class="product-detail-content option">
									<div class="product-detail-option title">옵션</div>
									<div class="product-detail-option value">${detailList.coupungDTO.options[0].name}</div>
								</div>
								<div class="product-detail-content price">
									<div class="product-detail-option title">가격</div>
									<div class="product-detail-option value">${detailList.price}원</div>
								</div>
								<div class="product-detail-content quantity">
									<div class="product-detail-quantity title">수량</div>
									<div class="product-detail-quantity value">${detailList.quantity}개</div>
								</div>
							</diV>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
		<div class="guest-modal-footer">
			<div class="total-container">
				<div class="total-price-container">
					<div class="total-price total-title">총 결제 금액</div>
					<div class="total-price total-value">${orderList.totalPrice}원</div>
				</div>
				<div class="total-quantity-container">
					<div class="total-quantity total-title">총 수량</div>
					<div class="total-quantity total-value">${orderList.totalQuantity}개</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="guest-order-list-modal-overlay" id="guestModalOverlay"
	onclick="closeGuestOrderListModal()"></div>