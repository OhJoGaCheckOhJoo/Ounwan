<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/reviewList.css" rel="stylesheet">

<h1>coupung 리뷰 리스트 가져오기</h1>
<c:forEach var="list" items="${coupungReviewList}">
<br><br>
	<div> 
		상품명 <span>${list.COUPUNG_NAME}</span>
	</div>
	<div> 
		옵션명 <span>${list.COUPUNG_OPTION_NAME }</span>
	</div>
	<div> 
		이미지url <span>${list.IMAGE_URL }</span>
	</div>
	<div> 
		내용 <span>${list.CONTENTS }</span>
	</div>
	<div> 
		별점 <span>${list.SCORE }</span>
	</div>
	<div> 
		업로드날짜 <span>${list.CREATED_DATE }</span>
	</div>
</c:forEach>