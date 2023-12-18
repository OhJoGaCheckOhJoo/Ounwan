<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
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
        <c:forEach var="saleInfo" items="${danggunList}" varStatus="loop">
            <tr>
                <td class="danggun-sale num">${danggunList.size() - loop.index}</td>
                <td class="danggun-sale info">
                    <div class="danggun-sale-info img">
                        <img src="${saleInfo.URL}">
                    </div>
                    <div class="danggun-sale-info name">
                        <span>${saleInfo.PRODUCT_NAME}</span>
                    </div>
                </td>
                <td class="danggun-sale price">${saleInfo.PRICE}</td>
                <td class="danggun-sale upload-date">
                	<fmt:formatDate value="${saleInfo.UPLOAD_DATE}" pattern="yyy-MM-dd"/> 
                </td>
                <td class="danggun-sale state">
                    <c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 6}">
                        <div>판매중</div>
                    </c:if>
                    <c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 7}">
                        <div>거래중</div>
                    </c:if>
                    <c:if test="${saleInfo.TRADE_HISTORY_NUMBER eq 8}">
                        <div>거래완료</div>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>