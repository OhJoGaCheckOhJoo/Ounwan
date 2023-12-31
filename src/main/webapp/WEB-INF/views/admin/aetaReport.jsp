<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div class="aeta-report-wrap">
    <div>
        <div id="aetaList">
            <div class="aeta-menu">
                <input type="checkbox">
                <span>게시글번호</span>
                <span>글 제목</span>
                <span>작성자</span>
                <span>작성 일자</span>
            </div>
            <c:if test="${aeta ne null}">
	            <c:forEach var="product" items="${aeta}">
	            	<div class="aeta-info">
	            		<input class="aetaNumber" type="hidden" value="${product.aetaNumber}">
						<a href="#"> 
			                <input class="aetaNumber" type="checkbox" value="${product.aetaNumber}">
			                <span>${product.aetaNumber}</span>
			                <span>${product.title}</span>
			                <span>${product.clientId}</span>
			                <span>${product.createdDate}</span>
			            </a>    
			            <button class="restoreAeta" type="button">복구</button>
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
   $(".restoreAeta").on("click", function(){
       	var aetaNumber = $(this).parent().find(".aetaNumber").val();
       	if(confirm("정말로 복구하시겠습니까?")){
	       	$.ajax({
	               url : "${appPath}/admin/aeta/restore",
	               type : "post",
	               data : {"aetaNumber" : aetaNumber},
	               success : function(res){
	                   alert("복구에 성공하였습니다.");  
	               },
	               error: function(jqXHR, textStatus, errorThrown) {
	            	    console.error("AJAX Error: " + textStatus + "error" +  errorThrown);
	            	}
	           });
       	}
   });
   </script>
