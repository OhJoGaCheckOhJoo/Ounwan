<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />


<div id="aetaboardList">
	<div class="product-menu">
		<span>번호</span>
		<span>제목</span>
		<span>작성자</span>
		<span>작성일</span>
		<span>조회수</span>
	</div>
	<div class="">
		<c:forEach var="aeta" items="${aetaList}">	
			<div class="product-info">
				<span class="num">${aeta.aetaNumber}</span>
				<span class="title">${aeta.title}</span>
				<span class="writer">${aeta.clientId}</span>
				<span class="date"><fmt:formatDate value="${aeta.createdDate}" pattern="yyyy-MM-dd" /> </span>
				<span class="count">${aeta.views}</span>
				<span><a href="${appPath}/community/aetaPost?aetaNumber=${aeta.aetaNumber}">이동</a></span>
				<span class="aeta-blind">비공개</span>
			</div>
		</c:forEach>
	</div>
</div>	

<div id="productPages" class="aeta-pagination">
	

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
  $(".aeta-blind").click(function(){
	var aetaNumber =$(this).parent().find('.num').text();
		 $.ajax({
			url : appPath + "/admin/aeta/blind?aetaNumber="+aetaNumber,
			success : function(res) {
					$.ajax({
						url : appPath + "/admin/aeta/aetaBoard",
						success : function(response) {
							$('.admin-wrap').html(response);
						},
						error: function(request, status, error) {
			                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			            }
					});
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
		});   
});  
</script>
