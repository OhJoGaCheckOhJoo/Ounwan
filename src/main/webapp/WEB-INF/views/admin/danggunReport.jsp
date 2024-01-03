<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-wrap">
	<div id="danggun-list">
		<div id="productList">
            <div class="report-menu">
                <span>게시글번호</span>
                <span>상품명</span>
                <span>가격</span>
                <span>작성자</span>
                <span>작성일자</span>
                <span>복구</span>
                <span>제거</span>
            </div>
            <c:if test="${danggun ne null}">
	            <c:forEach var="product" items="${danggun}">
	            	<div class="report-info">
	            		<input class="danggunNumber" type="hidden" value="${product.danggunNumber }">
						<a href="${appPath}/danggun/detail?danggunNumber=${product.danggunNumber}"> 
			                <span>${product.danggunNumber}</span>
			                <span>${product.productName}</span>
			                <span>${product.price}</span>
			                <span>${product.clientId}</span>
			                <span>${product.uploadDate}</span>
			            </a>    
			            <span><button class="restoreDanggun" type="button">복구</button></span>
			            <span><button class="deleteDanggun" type="button">제거</button></span>
	            	</div>
	            </c:forEach>
            </c:if>
        </div>
	</div>
</div>


<script>
$(".restoreDanggun").on("click", function(){
   	var danggunNumber = $(this).parent().parent().find(".danggunNumber").val();
   	if(confirm("정말로 복구하시겠습니까?")){   	
   		$.ajax({
               url : "${appPath}/admin/danggun/restore",
               type : "post",
               data : {"danggunNumber" : danggunNumber},
               success : function(res){
            	   if(res == "success"){
            		   alert("복구에 성공하였습니다."); 
            		   $.ajax({
            			   url : "${appPath}/admin/danggun/report",
            			   success : function(res){
            				   $(".admin-wrap").html(res);
            			   }
            		   });
            	   }
                      
               }
           });
   	}
   });
   
$(".deleteDanggun").on("click", function(){
   	var danggunNumber = $(this).parent().parent().find(".danggunNumber").val();
   	if(confirm("삭제 후엔 복구가 불가능합니다. \n정말로 삭제하시겠습니까?")){   	
   		$.ajax({
               url : "${appPath}/admin/danggun/delete",
               type : "post",
               data : {"danggunNumber" : danggunNumber},
               success : function(res){
            	   if(res == "success"){
            		   alert("삭제에 성공하였습니다."); 
            		   $.ajax({
            			   url : "${appPath}/admin/danggun/report",
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