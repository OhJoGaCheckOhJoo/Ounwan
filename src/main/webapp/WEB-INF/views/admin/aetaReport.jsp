<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div class="product-wrap">
	<div id="danggun-list">
		<div id="productList">
            <div class="report-menu">
                <span>게시글번호</span>
                <span>글 제목</span>
                <span>작성자</span>
                <span>작성일자</span>
                <span>복구</span>
                <span>제거</span>
            </div>
            <c:if test="${aeta ne null}">
	            <c:forEach var="product" items="${aeta}">
	            	<div class="report-info">
	            		<input class="aetaNumber" type="hidden" value="${product.aetaNumber }">
						<a href="${appPath}/community/aetaPost?aetaNumber=${product.aetaNumber}"> 
			                <span>${product.aetaNumber}</span>
			                <span>${product.title}</span>
			                <span>${product.clientId}</span>
			                <span><fmt:formatDate value="${product.createdDate}" pattern="yyyy-MM-dd" /></span>
			            </a>    
			            <span><button class="restoreAeta" type="button">복구</button></span>
			            <span><button class="deleteAeta" type="button">제거</button></span>
	            	</div>
	            </c:forEach>
            </c:if>
        </div>
	</div>
</div>
<script>
   $(".restoreAeta").on("click", function(){
       	var aetaNumber = $(this).parent().parent().find(".aetaNumber").val();
       	if(confirm("정말로 복구하시겠습니까?")){
	       	$.ajax({
	               url : "${appPath}/admin/aeta/restore",
	               type : "post",
	               data : {"aetaNumber" : aetaNumber},
	               success : function(res){
	                   alert("복구에 성공하였습니다.");
	                   $.ajax({
	                	   url: "${appPath}/admin/aeta/report",
            			   success : function(res){
            				   $(".admin-wrap").html(res);
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
       	}
   });
   
   $(".deleteAeta").on("click", function(){
	   	var aetaNumber = $(this).parent().parent().find(".aetaNumber").val();
	   	if(confirm("삭제 후엔 복구가 불가능합니다. \n정말로 삭제하시겠습니까?")){   	
	   		$.ajax({
	               url : "${appPath}/admin/aeta/delete",
	               type : "post",
	               data : {"aetaNumber" : aetaNumber},
	               success : function(res){
	            	   if(res == "success"){
	            		   alert("삭제에 성공하였습니다."); 
	            		   $.ajax({
	            			   url : "${appPath}/admin/aeta/report",
	            			   success : function(res){
	            				   $(".admin-wrap").html(res);
	            			   },
	           				error: function(request, status, error) {
	        	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        	            }
	            		   });
	            	   }
	                      
	               },
					error: function(request, status, error) {
		                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		            }
	           });
	   	}
	   });
   </script>
