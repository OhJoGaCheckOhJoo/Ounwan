<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/refundModal.css" rel="stylesheet">
<%-- 모달 --%>
<div id="refundModal" class="refund-modal">
  <div id="modalContent">
    <div id="modalBody">
      <span id="closeBtn" class="close-button" onclick="closeRefundModal()">&times;</span>
      <div>
      	 <div class="title-container">
                    <div class="ounwan">
                        OUNWAN
                    </div>
                    <div class="refund-title">
                        환불 사유 선택
                    </div>
                </div>
      	<hr class="refund-hr">
      	<div id="refundReason" class="refund-reason">
      		<div>환불 사유를 선택해주세요.</div>
      		<div><input class="reason" name="refundReason" value="상품 결함/기능에 이상이 있습니다" type="radio">상품 결함/기능에 이상이 있습니다.</div>
      		<div><input class="reason" name="refundReason" value="상품의 구성품/부속품이 들어있지 않습니다." type="radio">상품의 구성품/부속품이 들어있지 않습니다.</div>
      		<div><input class="reason" name="refundReason" value="상품이 파손되어 배송되었습니다." type="radio">상품이 파손되어 배송되었습니다.</div>
      		<div><input class="reason" name="refundReason" value="다른 상품이 배송되었습니다." type="radio">다른 상품이 배송되었습니다.</div>
      		<button id="reportSubmit" onclick="submitRefund()">환불하기</button>
      	</div>
      </div>
    </div>
  </div>
</div>
<!-- 배경 회색 불투명도 -->
<div id="refundtModalOverlay" class="refund-modal-overlay" onclick="closeRefundModal()"></div>

<div id="refundSelectModal" orderNumber="${orderList.ORDER_NUMBER}"></div>

<script src="${appPath}/js/refundModal.js"></script>