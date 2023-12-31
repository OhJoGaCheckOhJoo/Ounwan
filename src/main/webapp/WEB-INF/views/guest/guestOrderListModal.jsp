<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
	
<div class="guest-order-list-modal-container">
        <div class="guest-modal-content">
            <span class="close-button">&times;</span>
            <div class="guest-modal header">
                <div class="guest-modal-title">
                    <div class="ounwan">ounwan</div>
                    <div class="guest-order-list-title">비회원주문조회</div>
                </div>
                <div class="guest-modal info">
                    <div class="guest-modal-info order-number">
                        <span class="info-title order-number">주문번호&nbsp;&nbsp;|&nbsp;</span>
                        <span class="info-content order-number">123451234512</span>
                    </div>
                    <div class="guest-modal-info order-date">
                        <span class="info-title order-date">주문날짜&nbsp;&nbsp;|&nbsp;</span>
                        <span class="info-content order-date">2023-11-12</span>
                    </div>
                </div>
            </div>
            <div class="guest-modal body">
                <!-- foreach로 돌릴거임 -->
                <div class="proudct-container">
                    <a href="#">
                        <div class="product-detail-content">
                            <div class="product-detail image">
                                <img>
                            </div>
                            <diV class="product-detail content">
                                <div class="product-detail-content name">
                                    <div class="product-detail-name title">상품명</div>
                                    <div class="product-detail-name value">XXXXX</div>
                                </div>
                                <div class="product-detail-content option">
                                    <div class="product-detail-option title">옵션</div>
                                    <div class="product-detail-option value">XXXX</div>
                                </div>
                                <div class="product-detail-content price">
                                    <div class="product-detail-option title">가격</div>
                                    <div class="product-detail-option value">XXXX원</div>
                                </div>
                                <div class="product-detail-content quantity">
                                    <div class="product-detail-quantity title">수량</div>
                                    <div class="product-detail-quantity value">XXXX개</div>
                                </div>
                            </diV>
                        </div>
                    </a>
                </div>
                <!-- 여기까지 foreach -->
            </div>
            <div class="guest-modal-footer">
                <div class="total-container">
                    <div class="total-price-container">
                        <div class="total-price total-title">총 결제 금액</div>
                        <div class="total-price total-value">XXX원</div>
                    </div>
                    <div class="total-quantity-container">
                        <div class="total-quantity total-title">총 수량</div>
                        <div class="total-quantity total-value">XXX개</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="guest-order-list-modal-overlay"></div>