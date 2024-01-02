<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="aetaboardList">
	<h4>당군 관리자 페이지</h4>
	<table>
		<thead>
			<tr class="top">
				<th class="">당군번호</th>
				<th class="">판매자</th>
				<th class="">상품명</th>
				<th class="">가격</th>
				<th class="">업로드일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="danggun" items="${danggun}">
				<tr class="danggun-post" >
					<td class="danggun-number">${danggun.danggunNumber}</td>
					<td class="client-id">${danggun.clientId}</td>
					<td class="product-name">${danggun.productName}</td>
					<td class="price">${danggun.price}</td>
					<td class="upload-date"><fmt:formatDate value="${danggun.uploadDate}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
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
/* $(".danggun-post").click(function(){  
	var danggunNumber =$(this).find('.danggun-number').text();
	alert(danggunNumber);
		$.ajax({
			url : appPath + "/danggun/detail?danggunNumber="+danggunNumber,
			data : {"danggunNumber" : danggunNumber},
			success : function(res) {
				alert("off to danggunDetail");
				location.href=appPath+"/danggun/danggunDetail";
				$('#admin-wrap').html(res);
			}
		}); 
}); */ 

$(".danggun-post").click(function(){  
	var danggunNumber =$(this).find('.danggun-number').text();
	var clientId =$(this).find('.client-id').text();
		$.ajax({
			url : appPath + "/admin/danggun/danggunDetail?danggunNumber="+danggunNumber,
			data : { "danggunNumber" : danggunNumber},
			success : function(res) {
				$('.admin-wrap').html(res);
			}
		}); 
});
</script>
