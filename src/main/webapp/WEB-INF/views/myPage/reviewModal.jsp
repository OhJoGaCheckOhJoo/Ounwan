<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/reviewModal.css" rel="stylesheet">

<div id="reviewModal" class="review-container-modal">
	<span id="closeBtn" class="close-button" onclick="closeReviewModal()">&times;</span>
	<div class="review head">
		<div class="review-head heading">리뷰작성</div>
		<div class="review-head required">*필수입력사항</div>
	</div>
	<div class="review-middle-container">
		<div class="review product">
			<div class="review-product image">
				<img id="reviewImage">
			</div>
			<div class="review-product info">
				<div class="review-product-info name">
					[상품명] <span id="reviewName"></span>
				</div>
				<div class="review-product-info option">
					[옵션] <span id="reviewOption"></span>
				</div>
			</div>
		</div>
		<div class="review-content-container">
			<div class="review content">
				<div class="review-content score">
					<div class="review-content-score entitle">
						별점
						<sapn class="asterisk">*</sapn>
					</div>
					<div class="review-content-score scores">
						<button class="score-setting" value=1>
							<img src="${appPath}/images/myPage/empty_star.png">
						</button>
						<button class="score-setting" value=2>
							<img src="${appPath}/images/myPage/empty_star.png">
						</button>
						<button class="score-setting" value=3>
							<img src="${appPath}/images/myPage/empty_star.png">
						</button>
						<button class="score-setting" value=4>
							<img src="${appPath}/images/myPage/empty_star.png">
						</button>
						<button class="score-setting" value=5>
							<img src="${appPath}/images/myPage/empty_star.png">
						</button>
					</div>
				</div>
				<div class="review-content Text">
					<div class="review-content-text entitle">
						상품평<span class="asterisk">*</span>
					</div>
					<div class="review-content-text input">
						<textarea placeholder="상품평을 남겨주세요(최대 50자까지 작성가능합니다.)" name="reviewContent"
							id="reviewContent"></textarea>
						<div class="text-count" id="reviewCount">0/50</div>
					</div>
				</div>
				<div class="review-content image">
					<div class="review-content-image entitle">이미지</div>
					<div class="review-content-image preview">
						<label for="reviewImageInput"></label> <input type="file"
							id="reviewImageInput" name="dnaggunImage" class="input-file" />
						<img id="reviewImagePreview"
							src="${appPath}/images/danggunInsertDefault.png">
					</div>
				</div>
			</div>
			<div class="button-container">
				<button id="ReviewSubmitButton" class="review-submit-button">리뷰등록</button>
			</div>
		</div>
	</div>
</div>
<div id="reviewModalOverlay" class="review-modal-overlay"
	onclick="closeReviewModal()"></div>