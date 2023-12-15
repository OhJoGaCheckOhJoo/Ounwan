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
	<h1>danggun Main</h1>
	<div id="product1">
		<a href="${appPath}/danggun/detail?danggunNumber=1">1</a>
	</div>
	<div id="product2">
		<a href="${appPath}/danggun/detail?danggunNumber=7">7</a>
	</div>
	<div id="product3">
		<a href="${appPath}/danggun/detail?danggunNumber=11">11</a>
	</div>
	<div id="product4">
		<a href="${appPath}/danggun/detail?danggunNumber=12">12</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=13">13</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=15">15</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=16">16</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=17">17</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=19">19</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=20">20</a>
	</div>
	<div id="product6">
		<a href="${appPath}/danggun/detail?danggunNumber=21">21</a>
	</div>
</body>
</html>