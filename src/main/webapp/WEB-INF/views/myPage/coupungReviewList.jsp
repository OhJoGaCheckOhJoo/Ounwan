<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/reviewList.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div class="section-header">
	<h2 class="section-title">리뷰 관리</h2>
</div>
<div class="table-container">
	<table>
		<thead>
			<tr class="head-tr">
				<th></th>
				<th>상품정보</th>
				<th>상품평</th>
				<th>별점</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty coupungReviewList}">
				<tr class="none-content">
					<td colspan="5">리뷰 내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty coupungReviewList}">
				<c:forEach var="list" items="${coupungReviewList}">
					<tr>
						<td>
							<div class="review-list-input">
								<input type="checkbox" value="${list.REVIEW_NUMBER }" />
							</div>
						</td>


						<td>
							<div class="review-list-info">
								<div>${list.COUPUNG_NAME}</div>
								<div>[옵션] ${list.COUPUNG_OPTION_NAME}</div>
							</div>

						</td>
						<td>
							<div class="review-list-content">
								<c:if test="${empty list.IMAGE_URL}">
									<img class="review-list-content-image" src="./images/myPage/reviewDefault.png"
										style="width: 60px; height: 60px;">
								</c:if>
								<c:if test="${not empty list.IMAGE_URL}">
									<img class="review-list-content-image" src="${list.IMAGE_URL}" style="width: 60px; height: 60px;">
								</c:if>
								<div class="review-list-content-content ">${list.CONTENTS}</div>
							</div>

						</td>


						<td>
							<div class="review-list-personal-score">
								<div style="width: calc(${list.SCORE} * 30px);"></div>
								<img src="./images/myPage/star.png">
							</div>
						</td>
						<td>
							<div class="review-list-create-date">
								<fmt:formatDate value="${list.CREATED_DATE}"
									pattern="yyyy-MM-dd" />
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<button id="deleteReviewButton" class="delete-button">삭제</button>
</div>

<script>
	$(document).ready(function() {
		$('#deleteReviewButton').click(function() {
			var selectedReviews = [];

			$('input[type="checkbox"]:checked').each(function() {
				var reviewNumber = $(this).val();
				selectedReviews.push(reviewNumber);
			});

			if (selectedReviews.length === 0) {
				alert('선택된 항목이 없습니다.');
				return;
			}

			$.ajax({
				type : 'POST',
				url : '${appPath}/myPage/deleteCoupungReviewList',
				contentType : 'application/json',
				data : JSON.stringify({
					selectedReviews : selectedReviews
				}),
				success : function(response) {
					$.ajax({
						type : 'GET',
						url : '${appPath}/myPage/coupungReviewList',
						success : function(res) {
							$('#content').html(res);
						}
					});
				}
			});
		});
	});
</script>
