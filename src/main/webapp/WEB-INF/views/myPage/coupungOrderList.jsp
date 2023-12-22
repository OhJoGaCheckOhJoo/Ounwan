<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/orderList.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div class="section-header">
	<h2 class="section-title">상세 주문 내역</h2>
</div>
<div class="check-container">
	<table>
		<thead>
			<tr class="head-tr">
				<th>주문정보</th>
				<th>상품정보</th>
				<th>진행상태</th>
			</tr>
		</thead>

		<tbody>
			<c:if test="${empty coupungOrderList}">
				<tr class="none-content">
					<td colspan="5">주문 내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty coupungOrderList}">
				<c:forEach var="orderList" items="${coupungOrderList}">
					<tr>
						<td class="order-detail order-info">
							<div class="order-detail-order-info-container">
								<div class="order-detail-order-info date">
									주문일자 <span><fmt:formatDate value="${orderList.ORDER_DATE}" pattern="yyyy-MM-dd" /></span>
								</div>
								<div class="order-detail-order-info order-number">
									주문번호 <span>${orderList.ORDER_NUMBER}</span>
								</div>
							</div>
						</td>
						<td class="order-detail product-info"><a href="#"
							class="order-detail-product-info-wrap">
								<div class="order-detail-product-info-container">
									<div class="order-detail-product-info image">
										<img src="${orderList.URL}">
									</div>
									<div class="order-detail-product-info content">
										<div class="order-detail-product-info-content name">${orderList.COUPUNG_NAME} <span>&nbsp;[옵션] ${orderList.COUPUNG_OPTION_NAME}</span></div>
										<div class="order-detail-product-info-content price">
											${orderList.PRICE}<span> 원</span>
										</div>
										<div class="order-detail-product-info-content quantity">
											[수량] <span>${orderList.QUANTITY}</span> <span> 개</span>
										</div>
									</div>
								</div>
						</a></td>
						<c:if test="${orderList.TRADE_HISTORY_NUMBER < 3}">
							<td class="order-detail state">
								<div class="order-detail-state-container">
									<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
									<div class="order-detail-state buttons">
										<button class="disabled refund-button" disabled>환불접수</button>
										<button class="disabled confirm-button" disabled>거래확정</button>
									</div>
								</div>
							</td>
						</c:if>					
						<c:if test="${orderList.TRADE_HISTORY_NUMBER eq 3}">
							<td class="order-detail state">
								<div class="order-detail-state-container">
									<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
									<div class="order-detail-state buttons">
										<button class="active refund-button">환불접수</button>
										<button class="active confirm-button">거래확정</button>
									</div>
								</div>
							</td>
						</c:if>
						<c:if test="${orderList.TRADE_HISTORY_NUMBER eq 4}">
							<td class="order-detail state">
								<div class="order-detail-state-container">
									<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
									<div class="order-detail-state buttons">
										<button class="disabled refund-button" disabled>환불접수</button>
										<button class="active review-button">리뷰작성</button>
									</div>
								</div>
							</td>
						</c:if>
						<c:if test="${orderList.TRADE_HISTORY_NUMBER eq 5}">
							<td class="order-detail state">
								<div class="order-detail-state-container">
									<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
									<div class="order-detail-state buttons">
										<button class="disabled refund-button" disabled>환불접수</button>
										<button class="disabled review-button" disabled>리뷰작성</button>
									</div>
								</div>
							</td>
						</c:if>																			
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>