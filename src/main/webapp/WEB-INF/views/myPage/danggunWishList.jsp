<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/danggunWishList.css" rel="stylesheet">
<h3>관심 목록</h3>
<table>
	<thead>
		<tr class="head-tr">
			<th>체크박스</th>
			<th>상품 정보</th>
			<th>가격</th>
			<th>업로드일</th>
			<th>거래상태</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty danggunWishList}">
    		<tr class="none-content">
				<td colspan="5">관심 상품이 없습니다.</td>
			</tr>		
		</c:if>
		<c:if test="${not empty danggunWishList}">
			<c:forEach var="wishInfo" items="${danggunWishList}" varStatus="loop">
				<c:if test="${wishInfo.TRADE_HISTORY_NUMBER eq 6}">
					<tr>
						<td><input type="checkbox" value="${wishInfo.WISH_LIST_NUMBER }"></td>
						<td class="wish-list info">
							<a href="#">
								<div class="wish-list-info img">
									<img src="${wishInfo.URL}">
								</div>
								<div class="wish-list-info name">
									<span>${wishInfo.PRODUCT_NAME}</span>
								</div>
							</a>						
						</td>
						<td class="wish-list price">${wishInfo.PRICE}</td>
						<td class="wish-list upload-date"><fmt:formatDate
								value="${wishInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
						<td class="wish-list state">
							<div>판매중</div>
						</td>
					</tr>
				</c:if>
	
				<c:if test="${wishInfo.TRADE_HISTORY_NUMBER eq 7}">
					<tr>
						<td><input type="checkbox" value="${wishInfo.WISH_LIST_NUMBER }"></td>
						<td class="wish-list info">
						<a href="#">
							<div class="wish-list-info img">
								<img src="${wishInfo.URL}">
							</div>
							<div class="wish-list-info name">
								<span>${wishInfo.PRODUCT_NAME}</span>
							</div>
						</a>
						</td>
						<td class="wish-list price">${wishInfo.PRICE}</td>
						<td class="wish-list upload-date"><fmt:formatDate
								value="${wishInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
						<td class="wish-list state">
							<div>거래중</div>
						</td>
					</tr>
				</c:if>
	
				<c:if test="${wishInfo.TRADE_HISTORY_NUMBER eq 8}">
					<tr>
						<td><input type="checkbox" value="${wishInfo.WISH_LIST_NUMBER }"></td>
						<td class="wish-list info">
						<a href="#">
							<div class="wish-list-info img completed">
								<img src="${wishInfo.URL}">
							</div>
							<div class="wish-list-info name completed">
								<span>${wishInfo.PRODUCT_NAME}</span>
							</div>
						</a>
						</td>
						<td class="wish-list price completed">${wishInfo.PRICE}</td>
						<td class="wish-list upload-date completed"><fmt:formatDate
								value="${wishInfo.UPLOAD_DATE}" pattern="yyy-MM-dd" /></td>
						<td class="wish-list state completed">
							<div>거래완료</div>
						</td>
					</tr>
				</c:if>
	
			</c:forEach>		
		</c:if>

	</tbody>
</table>

<button id="deleteWishListButton">삭제</button>

<script>
$(document).ready(function () {
    $('#deleteWishListButton').click(function () {
        var selectedWishLists = [];
        
        $('input[type="checkbox"]:checked').each(function () {
            var wishNumber = $(this).val();
            selectedWishLists.push(wishNumber);
        });
        
        if (selectedWishLists.length === 0) {
            alert('선택된 항목이 없습니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${appPath}/myPage/deleteDanggunWishList',
            contentType: 'application/json',
            data: JSON.stringify({ selectedWishLists: selectedWishLists }),
            success: function (response) {
                $.ajax({
                	type:'GET',
                	url: '${appPath}/myPage/danggunWishList',
                	success: function (res) {
                		$('#content').html(res);
                	}
                });
            }
        });
    });
});
</script>