<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/community.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Document</title>

</head>
<body>
	<script>
		console.log("${aetaList}");
	</script>

	<!-- header -->
	<header>
		<a class="logo" href="#"></a>
		<div class="float-right">
			<a href="./html/signup.html">회원가입</a> <a class="pointer"
				id="loginSelect">로그인</a>
			<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
			<button class="pointer">Basket (#)</button>
		</div>
	</header>
	<div class="container">
		<!-- nav -->
		<nav>
			<div class="nav-main">
				<div class="pointer">
					<a id="hamberger-btn" class="menu-trigger"> <span></span> <span></span>
						<span></span>
					</a>
				</div>
				<div>
					<a href="#">쇼핑몰</a>
					<div id="navSubmenu" class="nav-submenu">
						<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
							식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
					</div>
				</div>
				<div>
					<a href="#">중고거래</a>
					<div id="navSubmenu" class="nav-submenu">
						<a href="#">전체 보기</a> <a href="#">관심 상품</a>
					</div>
				</div>
				<div>
					<a href="#">커뮤니티</a>
					<div id="navSubmenu" class="nav-submenu">
						<a href="#">오운완 커뮤니티</a> <a href="#">고민 게시판</a>
					</div>
				</div>
				<div>
					<a href="#">고객센터</a>
					<div id="navSubmenu" class="nav-submenu">
						<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
							href="#">커뮤니티</a>
					</div>
				</div>
			</div>
			<div id="navMenu" class="nav-menu">
				<div>
					<div>
						<a href="#">전체 보기</a> <a href="#">운동 기구</a> <a href="#">건강 보조
							식품</a> <a href="#">헬스 이용권</a> <a href="#">의류</a>
					</div>
					<div>
						<a href="#">전체 보기</a> <a href="#">관심 상품</a>
					</div>
					<div>
						<a href="#">오운완 커뮤니티</a> <a href="#">고민 게시판</a>
					</div>
					<div>
						<a href="#">상품문의</a> <a href="#">배송문의</a> <a href="#">중고거래</a> <a
							href="#">커뮤니티</a>
					</div>
				</div>
			</div>
		</nav>
	</div>
	<hr>
	<!-- 여기 아래에 추가 -->
	<div class="aeta">
		<div class="aeta-title">
			<strong>오늘의 애타</strong>
			<p>애타드립</p>
		</div>
		<hr>
		<div class="aeta-list">
			<table id="aetaList">
				<thead>
					<tr class="top">
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="writer">작성자</th>
						<th class="date">작성일</th>
						<th class="count">조회수</th>
					</tr>
				</thead>
				<tbody >
					<c:forEach var="aeta" items="${aetaList}">
						<tr class="content">
							<td class="num">${aeta.boardNumber}</td>
							<td class="title"><a href="">${aeta.title}</a></td>
							<td class="writer">${aeta.clientId}</td>
							<td class="date">${aeta.createdDate}</td>
							<td class="count">${aeta.views}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<button>글쓰기</button>
		<hr>
		<div class="aeta-page">
			<a href="#" class="bt first"><<</a> <a href="#" class="bt prev"><</a>
			<a href="#" class="num on">1</a> <a href="#" class="num">2</a> <a
				href="#" class="num">3</a> <a href="#" class="num">4</a> <a href="#"
				class="numf">5</a> <a href="#" class="bt next">></a> <a href="#"
				class="bt last">>></a>
		</div>
		<hr>
		<div class="search">
			<select name="option">
				<option>선택</option>
				<option value="aetaSearchAll">전체(제목+작성자)</option>
				<option value="aetaSearchTitle">제목</option>
				<option value="aetaSearchId">작성자</option>
			</select>
			<form>
				<input id="searchWord" placeholder="검색어 입력">
				<button type=button id="searchBtn">검색</button>
			</form>
		</div>
		<hr>
	</div>
	<!-- footer -->
	<footer>
		<div>
			<div>오운완 쇼핑몰 & 커뮤니티</div>
			<div>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</div>
			<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층</div>
			<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
			<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
			<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
		</div>
		<div class="float-right">
			<br> <br>
			<div>
				<a href="#">이벤트</a>
			</div>
			<div>
				<a href="#">개인정보처리방침</a>
			</div>
			<div>
				<a href="#">이용약관</a>
			</div>
			<div>
				<img class="float-right img-1 pointer" src="./images/insta.png">
			</div>
		</div>
	</footer>

	<script src="../js/community.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>
	
</body>
</html>