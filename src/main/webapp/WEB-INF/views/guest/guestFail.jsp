<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="${appPath}/css/guest/guestCheck.css" rel="stylesheet">

<div class="guest-check-container">
	<div class="guest-check-title">비회원 주문 조회</div>
	<div class="guest-check-content">
		<div class="input-container">
			<div class="input-info order-number">
				<div class="input-title order-number">주문번호</div>
				<input class="input order-number" id="orderNumberInput"
					autocomplete="off" placeholder="주문번호를 입력하세요.">
			</div>
			<div class="input-info email">
				<div class="input-title email">이메일</div>
				<input class="input email" id="emailInput" autocomplete="off"
					placeholder="이메일을 입력하세요.">
			</div>
		</div>
		<button type="button" class="guest-check-button"
			onclick="checkGuestInfo()">확인</button>
	</div>
</div>
<script src="${appPath}/js/guest.js"></script>
<script>
	alert('${alarm}');
	$('#orderNumberInput').focus();
</script>