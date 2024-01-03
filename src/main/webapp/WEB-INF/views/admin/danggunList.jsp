<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="productList">
	<div class="product-menu">
		<span>제목</span> 
		<span>가격</span> 
		<span>판매자</span>
		<span>등록일</span> 
		<span>판매현황</span> 
		<span>이동</span>
		<span>비공개</span>
	</div>
	<c:forEach var="product" items="${danggun}">
		<div class="product-info">
			<input class="danggunNumber" type="hidden" value="${product.danggunNumber }">
			<span>${product.productName}</span>
			<span>${product.price}</span> 
			<span>${product.clientId}</span> 
			<span>${product.uploadDate}</span>
			<c:if test="${product.tradeHistoryNumber eq '6'}"><span>판매중</span></c:if>
			<c:if test="${product.tradeHistoryNumber eq '7'}"><span>예약중</span></c:if>
			<c:if test="${product.tradeHistoryNumber eq '8'}"><span>거래완료</span></c:if>
			<span><button class="goDanggun" type="button">이동</button></span>
			<span><button class="danggunBlind" type="button">비공개</button></span>
		</div>
	</c:forEach>
</div>

<div id="productPages" class="danggun-pagination">
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
$(".goDanggun").on("click", function(){
	var danggunNumber = $(this).parent().parent().find(".danggunNumber").val();
	window.location.href = "${appPath}/danggun/detail?danggunNumber=" + danggunNumber;
});
$(".danggunBlind").on("click", function(){
   	var danggunNumber = $(this).parent().parent().find(".danggunNumber").val();
   	if(confirm("비공개로 변경하시겠습니까?")){   	
   		$.ajax({
               url : "${appPath}/admin/danggun/blind",
               type : "post",
               data : {"danggunNumber" : danggunNumber},
               success : function(res){
            	   if(res == "success"){
            		   alert("비공개 처리에 성공하셨습니다."); 
            		   $.ajax({
            			   url : "${appPath}/admin/danggun/danggunBoard",
            			   success : function(res){
            				   $(".admin-wrap").html(res);
            			   }
            		   });
            	   }
               }
           });
   	}
   });
</script>
