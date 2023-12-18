<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./css/main.css" rel="stylesheet" >
    <link href="./css/community.css" rel="stylesheet" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
    ​
    <div class="container">
        <!-- nav -->
        <%@ include file = "../common/nav.jsp" %>
        
        <div id="inbodyInsertBody">
	        <div id="inbodyInputForm">
	        	<form>
		        	<div class="inbodyInput">
		        		<span>키 : </span>
		        		<input type="number"
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].height}"
		        		</c:if>
		        		required >
		        	</div>
		        	<div class="inbodyInput">
		        		<span>몸무게 : </span>
		        		<input type="number"
		        		 <c:if test="${inbody ne null}">
		        			value="${inbody[0].weight}"
		        		</c:if>
		        		 required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>골격근량 : </span>
		        		<input type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].skeletalMusclesMass}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>체수분량 : </span>
		        		<input type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bodyWater}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>기초대사량 : </span>
		        		<input type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bmr}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>BMI : </span>
		        		<input type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].bmi}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>인바디점수 : </span>
		        		<input type="number" 
		        		<c:if test="${inbody ne null}">
		        			value="${inbody[0].inbodyScore}"
		        		</c:if>
		        		required>
		        	</div>
		        	<div class="inbodyInput">
		        		<span>날짜 : </span>
		        		<input type="date" required>
		        	</div>
		        	<div class="inbodyInput border-0">
		        		<button>추가</button>
		        	</div>
	        	</form>
	        </div>
	        <div>
	        	<c:if test="${inbody ne null}">
	        		<h3>내 인바디 정보</h3>
	        		<div>
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
		        			<input type="date" value="${inbody.updatedDate}" readonly>
		        			<input type="number" value="${inbody.height}">
		        			<input type="number" value="${inbody.weight}">
		        			<input type="number" value="${inbody.inbodyScore}">
		        			<input type="number" value="${inbody.skeletalMusclesMass}">
		        			<input type="number" value="${inbody.bodyWater}">
		        			<input type="number" value="${inbody.bmr}">
		        			<input type="number" value="${inbody.bmi}">
		        			<button>수정</button>
	        			</form>
	        		</div>
	        	</c:forEach>
	        </div>
        </div>
    </div>
    
    <script src="./js/main.js"></script>
    <script src="./js/community.js"></script>
</body>
</html>