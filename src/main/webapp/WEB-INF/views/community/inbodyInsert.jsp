<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${appPath}/css/main.css" rel="stylesheet" >
    <link href="${appPath}/css/main2.css" rel="stylesheet" />
    <link href="${appPath}/css/header.css" rel="stylesheet" />
    <link href="${appPath}/css/nav.css" rel="stylesheet" />
    <link href="${appPath}/css/community.css" rel="stylesheet" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
	<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
    ​
    <div class="container">
        <%@ include file = "../common/nav.jsp" %>
        
        <div id="inbodyInsertBody">
	        <div id="inbodyInputForm">
	        	<form id="insertData">
		        	<div class="inbodyInput">
		        		<span>키 : </span>
		        		<input name="height" type="number"
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].height}"
		        		</c:if>
		        		required >
		        	</div>
		        	<div class="inbodyInput">
		        		<span>몸무게 : </span>
		        		<input name="weight" type="number"
		        		 <c:if test="${inbody ne null}">
		        			value="${inbody[0].weight}"
		        		</c:if>
		        		 required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>골격근량 : </span>
		        		<input name="skeletalMusclesMass" type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].skeletalMusclesMass}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>체수분량 : </span>
		        		<input name="bodyWater" type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bodyWater}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>기초대사량 : </span>
		        		<input name="bmr" type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bmr}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>BMI : </span>
		        		<input name="bmi" type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bmi}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>인바디점수 : </span>
		        		<input name="inbodyScore" type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].inbodyScore}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>날짜 : </span>
		        		<input name="updatedDate" type="date" required>
		        	</div>
		        	<div class="inbodyInput border-0">
		        		<button type="button" id="inbodyInsertBtn">추가</button>
		        	</div>
	        	</form>	
	        </div>
	        <div id="inbodyDetail">
	        	<c:if test="${inbody ne null}">
	        		<h3>내 인바디 정보</h3>
	        		<div class="inbodyTableHead">
	        			<span>날짜</span>
	        			<span>키</span>
	        			<span>몸무게</span>
	        			<span>인바디점수</span>
	        			<span>골격근량</span>
	        			<span>체수분량</span>
	        			<span>기초대사량</span>
	        			<span>BMI</span>
	        		</div>
	        	</c:if>
	        	<c:forEach var="inbody" items="${inbody}">
	        		<div class="inbodyInfo">
	        			<form>
	        				<input name="inbodyNumber" value="${inbody.inbodyNumber}" hidden>
		        			<input name="updatedDate" type="date" value="${inbody.updatedDate}" readonly>
		        			<input name="height" type="number" value="${inbody.height}">
		        			<input name="weight" type="number" value="${inbody.weight}">
		        			<input name="inbodyScore" type="number" value="${inbody.inbodyScore}">
		        			<input name="skeletalMusclesMass" type="number" value="${inbody.skeletalMusclesMass}">
		        			<input name="bodyWater" type="number" value="${inbody.bodyWater}">
		        			<input name="bmr" type="number" value="${inbody.bmr}">
		        			<input name="bmi" type="number" value="${inbody.bmi}">
	        				<button id="updateInbody" type="button">수정</button>
	        			</form>
	        		</div>
	        	</c:forEach>
	        </div>
        </div>
    </div>
    
    <script src="${appPath}/js/main.js"></script>
    <script src="${appPath}/js/community.js"></script>
</body>
</html>