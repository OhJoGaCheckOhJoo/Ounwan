<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/detailModal.css" rel="stylesheet">



<%-- 모달 --%>
<div id="detailModal" class="detail-modal">
	<div id="modalContent">
		<div id="modalBody">
			<span id="closeBtn" class="close-button" onclick="closeDetailModal()">&times;</span>
			<div>
				<div class="modal-title">
					<div>
						주문번호 <span id="modalOrderNumber"></span>
					</div>
					<div>
						주문일자 <span id="modalOrderDate"></span>
					</div>
				</div>

				<hr>

				<c:forEach var="orderList" items="${coupungOrderList}">

					<!-- 주문 번호와 일치하는 경우에만 아래의 주문 상세 정보를 표시 -->
					<div class="order-detail product-info modal"
						order-number="${orderList.ORDER_NUMBER}">


						<a href="#" class="order-detail-product-info-wrap">
							<div class="order-detail-product-info-container">
								<div class="order-detail-product-info image">
									<img src="${orderList.URL}">
								</div>
								<div class="order-detail-product-info content">
									<div class="order-detail-product-info-content name">
										${orderList.COUPUNG_NAME}</div>
									<div class="order-detail-product-info-content option">
										[옵션]<span>&nbsp;${orderList.COUPUNG_OPTION_NAME}</span>
									</div>

									<div class="order-detail-product-info-content quantity">
										수량<span>&nbsp;${orderList.QUANTITY}</span> <span>개</span>
									</div>
									<div class="order-detail-product-info-content price">
										결제금액<span>&nbsp;${orderList.PRICE * orderList.QUANTITY}</span>
										<span>원</span>
									</div>
								</div>
							</div>
						</a>
						<div class="order-detail-product-info-content review-button modal">
							<c:choose>
								<c:when test="${orderList.TRADE_HISTORY_NUMBER eq 4 && orderList.REVIEW_CHECK eq 0}">
									<button class="active review-button modal"
										onclick="insertReview('${orderList.ORDER_DETAIL_NUMBER}', '${orderList.URL}', '${orderList.COUPUNG_NAME}', '${orderList.COUPUNG_OPTION_NAME}')">리뷰작성</button>
								</c:when>
								<c:when test="${orderList.TRADE_HISTORY_NUMBER eq 4 && orderList.REVIEW_CHECK eq 1}">
									<button class="disabled review-button modal" disabled>리뷰작성완료</button>
								</c:when>
								<c:otherwise>
									<button class="disabled review-button modal" disabled>리뷰작성</button>

								</c:otherwise>
							</c:choose>
						</div>


					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<!-- 배경 회색 불투명도 -->
<div id="detailModalOverlay" class="detail-modal-overlay"
	onclick="closeDetailModal()"></div>
<script src="${appPath}/js/detailModal.js"></script>
<script src="${appPath}/js/reviewModal.js"></script>

