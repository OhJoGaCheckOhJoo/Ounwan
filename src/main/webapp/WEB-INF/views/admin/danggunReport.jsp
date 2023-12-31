<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div class="danggun-report-wrap">
    <div>
        <div id="danggunList">
            <div class="danggun-menu">
                <input type="checkbox">
                <span>게시글번호</span>
                <span>상품명</span>
                <span>가격</span>
                <span>작성자</span>
                <span>작성 일자</span>
            </div>
            <c:if test="${danggun ne null}">
	            <c:forEach var="product" items="${danggun}">
	            	<div class="danggun-info">
	            		<input class="danggunNumber" type="hidden" value="${product.danggunNumber }">
						<a href="${appPath}/danggun/detail?danggunNumber=${product.danggunNumber}"> 
			                <input type="checkbox" value="${product.danggunNumber}">
			                <span>${product.danggunNumber}</span>
			                <span>${product.productName}</span>
			                <span>${product.price}</span>
			                <span>${product.clientId}</span>
			                <span>${product.uploadDate}</span>
			            </a>    
			            <button class="restoreDanggun" type="button">복구</button>
	            	</div>
	            </c:forEach>
            </c:if>
        </div>
        <%--
        <div id="productPages">
        	<c:forEach var="index" begin="1" end="${pages}">
        		<c:if test="${index eq offset}">
        			<a href="#" class="selected">${index}</a>
        		</c:if>
        		<c:if test="${index ne offset}">
        			<a href="#">${index}</a>
        		</c:if>
        	</c:forEach>
        </div>
         --%>
    </div>
</div>



<script>
       $(".restoreDanggun").on("click", function(){
       	var danggunNumber = $(this).parent().find(".danggunNumber").val();
       	if(confirm("정말로 복구하시겠습니까?")){   	
       		$.ajax({
	               url : "${appPath}/admin/danggun/restore",
	               type : "post",
	               data : {"danggunNumber" : danggunNumber},
	               success : function(res){
	                   alert("복구에 성공하였습니다.");    
	               }
	           });
       	}
       });
   </script>
