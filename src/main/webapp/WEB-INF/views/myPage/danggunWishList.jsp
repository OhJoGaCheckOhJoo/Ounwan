<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/danggunSaleList.css" rel="stylesheet">

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>상품 정보</th>
			<th>가격</th>
			<th>업로드일</th>
			<th>거래상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="saleInfo" items="${danggunWishList}" varStatus="loop">
			<c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 6}">
				<tr>
					<td class="danggun-sale num">${danggunWishList.size() - loop.index}</td>
					<td class="danggun-sale info">
						<div class="danggun-sale-info img">
							<img src="${saleInfo.URL}">
						</div>
						<div class="danggun-sale-info name">
							<span>${saleInfo.PRODUCT_NAME}</span>
						</div>
					</td>
					<td class="danggun-sale price">${saleInfo.PRICE}</td>
					<td class="danggun-sale upload-date"><fmt:formatDate
							value="${saleInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
					<td class="danggun-sale state">
						<div>판매중</div>
					</td>
				</tr>
			</c:if>

			<c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 7}">
				<tr>
					<td class="danggun-sale num">${danggunWishList.size() - loop.index}</td>
					<td class="danggun-sale info">
						<div class="danggun-sale-info img">
							<img src="${saleInfo.URL}">
						</div>
						<div class="danggun-sale-info name">
							<span>${saleInfo.PRODUCT_NAME}</span>
						</div>
					</td>
					<td class="danggun-sale price">${saleInfo.PRICE}</td>
					<td class="danggun-sale upload-date"><fmt:formatDate
							value="${saleInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
					<td class="danggun-sale state">
						<div>거래중</div>
					</td>
				</tr>
			</c:if>

			<c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 8}">
				<tr>
					<td class="danggun-sale num completed">${danggunWishList.size() - loop.index}</td>
					<td class="danggun-sale info">
						<div class="danggun-sale-info img completed">
							<img src="${saleInfo.URL}">
						</div>
						<div class="danggun-sale-info name completed">
							<span>${saleInfo.PRODUCT_NAME}</span>
						</div>
					</td>
					<td class="danggun-sale price completed">${saleInfo.PRICE}</td>
					<td class="danggun-sale upload-date completed"><fmt:formatDate
							value="${saleInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
					<td class="danggun-sale state completed">
						<div>거래완료</div>
					</td>
				</tr>
			</c:if>

		</c:forEach>
	</tbody>
</table>