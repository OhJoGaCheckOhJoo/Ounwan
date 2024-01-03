<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="aetaboardList">
	<h4>당군 관리자 페이지</h4>	
	<div class="top">
			<span>당군번호</span>
			<span>판매자</span>
			<span>상품명</span>
			<span>가격</span>
			<span>업로드일</span>
	</div>
	<div>
		<c:forEach var="danggun" items="${danggun}">
			<div class="danggun-post" >
				<span class="danggun-number">${danggun.danggunNumber}</span>
				<span class="client-id">${danggun.clientId}</span>
				<span class="product-name">${danggun.productName}</span>
				<span class="price">${danggun.price}</span>
				<span class="upload-date"><fmt:formatDate value="${danggun.uploadDate}" pattern="yyyy-MM-dd" /></span>
			</div>
		</c:forEach>
	</div>		
</div>	
<div id="danggun-pagination" class="danggun-pagination">
	<c:choose>
		<c:when test="${paginating.maxPageNumber==0}"></c:when>
		<c:when test="${paginating.pageNumber<=1}">
			<span class="prev">[<<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(1)">[<<]</a>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${paginating.maxPageNumber==0}"></c:when>
		<c:when test="${paginating.pageNumber<=1}">
			<span class="prev">[<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber-1})">[<]</a>
		</c:otherwise>
	</c:choose>

	<c:forEach begin="${paginating.startPageNumber}"
		end="${paginating.endPageNumber}" var="i" step="1">
		<c:if test="${paginating.pageNumber eq i}">
			<a href="javascript:search(${i})" class="selected">${i}</a>
		</c:if>
		<c:if test="${paginating.pageNumber ne i}">
			<a href="javascript:search(${i})">${i}</a>
		</c:if>
	</c:forEach>

	<c:choose>
		<c:when test="${paginating.maxPageNumber==0}"></c:when>
		<c:when test="${paginating.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber+1})">[>]</a>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${paginating.maxPageNumber==0}"></c:when>
		<c:when test="${paginating.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.maxPageNumber})">[>>]</a>
		</c:otherwise>
	</c:choose>
</div>
<script>
 $(".danggun-post").click(function(){
	var danggunNumber =$(this).find('.danggun-number').text();
	alert(danggunNumber);
		 $.ajax({
			url : appPath + "/danggun/detail",
			data : {"danggunNumber" : danggunNumber},
			success : function(res) {
				location.href='${appPath}/danggun/detail?danggunNumber='+danggunNumber;
			}
		});  
});  
</script>
