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
					<c:choose>
						<c:when test="${orderList.ORDER_NUMBER ne previousOrderNumber}">
							<c:set var="previousOrderNumber"
								value="${orderList.ORDER_NUMBER}" />
							<tr>
								<td class="order-detail order-info">
									<div class="order-detail-order-info-container"
										onclick="openDeatilModal(this)">
										<div class="order-detail-order-info date">
											주문일자 <span class="send-order-date"><fmt:formatDate
													value="${orderList.ORDER_DATE}" pattern="yyyy-MM-dd" /></span>
										</div>
										<div class="order-detail-order-info order-number">
											주문번호 <span class="send-order-number">${orderList.ORDER_NUMBER}</span>
										</div>
									</div>
								</td>

								<c:choose>
									<c:when test="${orderList.TRADE_HISTORY_NUMBER < 3}">
										<td class="order-detail state">
											<div class="order-detail-state-container">
												<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
												<div class="order-detail-state buttons">
													<button class="disabled refund-button" disabled>환불접수</button>
													<button class="disabled confirm-button" disabled>거래확정</button>
												</div>
											</div>
										</td>
									</c:when>
									<c:when test="${orderList.TRADE_HISTORY_NUMBER eq 3}">
										<td class="order-detail state">
											<div class="order-detail-state-container">
												<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
												<div class="order-detail-state buttons">
													<button class="active refund-button"
														onclick="openRefundModal('${orderList.ORDER_NUMBER}')">환불접수</button>
													<button class="active confirm-button" onclick="confirmPurchase('${orderList.ORDER_NUMBER}')">거래확정</button>
												</div>
											</div>
										</td>
									</c:when>
									<c:when test="${orderList.TRADE_HISTORY_NUMBER eq 4}">
										<td class="order-detail state">
											<div class="order-detail-state-container">
												<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
												<div class="order-detail-state buttons">
													<button class="disabled refund-button" disabled>환불접수</button>
													<button class="active review-button">리뷰작성</button>
												</div>
											</div>
										</td>
									</c:when>
									<c:when test="${orderList.TRADE_HISTORY_NUMBER eq 5}">
										<td class="order-detail state">
											<div class="order-detail-state-container">
												<div class="order-detail-state now">${orderList.TRADE_STEP}</div>
												<div class="order-detail-state buttons">
													<button class="disabled refund-button" disabled>환불접수</button>
													<button class="disabled review-button" disabled>리뷰작성</button>
												</div>
											</div>
										</td>
									</c:when>
								</c:choose>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 주문 번호가 동일한 경우에는 아무 작업도 하지 않음 -->
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<%@ include file="./refundModal.jsp"%>
<%@ include file="./detailModal.jsp"%>
<script src="${appPath}/js/refundModal.js"></script>
<script src="${appPath}/js/detailModal.js"></script>

<script>
	function confirmPurchase(orderNumber) {
		var confirmCheck =  confirm("구매 확정하시겠습니까?");
		if(confirmCheck) {
			$.ajax({
				url: "${appPath}/myPage/confirmPurchase",
				type: 'POST',
				data: {orderNumber: orderNumber},
				success : function(res) {
					if(res === "success") {
						alert("구매확정 완료되었습니다. 리뷰를 작성해 중세요");
					}
					else {
						alert("구매확정 중 문제가 발생했습니다.");
					}				
					orderList();
				}	
			});			
		}		
	}
</script>

