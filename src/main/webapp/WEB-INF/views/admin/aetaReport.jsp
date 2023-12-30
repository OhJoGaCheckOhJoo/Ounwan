<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>애타 신고 관리</h1>
	<div>
		<c:if test="${aeta ne null}">
		<c:forEach var="product" items="${aeta}" varStatus="loopStatus">
			<div>
				<input class="aetaNumber" value="${product.aetaNumber }" type="hidden">
				<a href=""> 
					<span>신고 번호: ${loopStatus.count}</span> 
					<span>애타 게시글 번호 : ${product.aetaNumber }</span> 
					<span>title : ${product.title}</span> 
					<span>작성자 : ${product.clientId }</span> 
					<span>작성 일자 : ${product.createdDate}</span> 
				</a>
				<button class="restoreAeta" type="button">복구</button>
			</div>
		</c:forEach>
		</c:if>
	</div>
	
	<script>
        $(".restoreAeta").on("click", function(){
        	var aetaNumber = $(this).parent().find(".aetaNumber").val();
        	$.ajax({
                url : "${appPath}/admin/aeta/restore",
                type : "post",
                data : {"aetaNumber" : aetaNumber},
                success : function(res){
                    alert("복구에 성공하였습니다.");  
                }
            });
        });
    </script>
</body>
</html>