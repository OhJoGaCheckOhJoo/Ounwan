<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/danggunDetail.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
	
</script>
</head>
<body>
	<!-- header -->
	<header>
		<a class="logo" href="#"></a>
		<div class="float-right">
			<a href="./html/signup.html">ȸ������</a> <a class="pointer"
				id="loginSelect">�α���</a>
			<!--# : DB(ȸ��)/����(��ȸ��)���� ������ ��-->
			<button class="pointer">Basket (#)</button>
		</div>
	</header>
	<main id="main">
		<div class="container">
			<nav>
				<div class="nav-main">
					<div class="pointer">
						<a id="hamberger-btn" class="menu-trigger"> <span></span> <span></span>
							<span></span>
						</a>
					</div>
					<div>
						<a href="#">���θ�</a>
						<div class="nav-submenu">
							<a href="#">��ü ����</a> <a href="#">� �ⱸ</a> <a href="#">�ǰ� ����
								��ǰ</a> <a href="#">�ｺ �̿��</a> <a href="#">�Ƿ�</a>
						</div>
					</div>
					<div>
						<a href="#">�߰�ŷ�</a>
						<div class="nav-submenu">
							<a href="#">��ü ����</a> <a href="#">���� ��ǰ</a>
						</div>
					</div>
					<div>
						<a href="#">Ŀ�´�Ƽ</a>
						<div class="nav-submenu">
							<a href="#">����� Ŀ�´�Ƽ</a> <a href="#">��� �Խ���</a>
						</div>
					</div>
					<div>
						<a href="#">������</a>
						<div class="nav-submenu">
							<a href="#">��ǰ����</a> <a href="#">��۹���</a> <a href="#">�߰�ŷ�</a> <a
								href="#">Ŀ�´�Ƽ</a>
						</div>
					</div>
				</div>
			</nav>

			<div class="product-all">
				<div class="toList">
					<a href="#">������� > </a>
				</div>
				<div class="details">
					<div class="photos">
						<div class="small-img">
							<div>
								<img class="small-img" src="camera.png" />
							</div>
							<div>
								<img class="small-img" src="camera.png" />
							</div>
							<div>
								<img class="small-img" src="camera.png" />
							</div>
						</div>
						<!-- small_img -->
						<div class="big-img">
							<img class="big-img" src="camera.png" />
						</div>
						<!-- big_img -->
					</div>
					<!-- photo -->

					<div class="product">
						<div class="product-detail">
							<div class="product-top">
								<div class="product-name">${post.name}</div>
								<div class="hamburger">
									<a class="dot3" id="dot3"></a> <span>����</span> <span>�Ű�</span>
								</div>
								<!-- hamburger -->
							</div>
							<!-- product_top -->
							<div class="seller" id="seller">${post.clientId}</div>
							<div class="product-price" id="product-price">${post.price}</div>
							<div class="registered-date" id="registered-date">����� :
								${post.uploadDate}</div>

							<div class="product-bottom">
								<button class="zzim" id="zzim" type="button">���ϱ�
									${zzimCount}</button>
								<button class="chatting" id="chatting" type="submit">
									ä���ϱ�</button>
							</div>
							<!-- product_bottom -->
						</div>
						<!-- product detail -->
					</div>
					<!-- product -->
				</div>
				<!-- details -->
				<hr />
				<div class="here">${post.detail}</div>
			</div>
			<!-- product ALL-->
		</div>
		<hr />
	</main>

	<!-- footer -->
	<footer id="footer">
		<div>
			<div>����� ���θ� & Ŀ�´�Ƽ</div>
			<div>��ǥ�� : ���¿�, ������, ������, ������, �ż���, ������</div>
			<div>��ǥ��ȭ : 010-9424-2784 / �ּ� : 03993 ����Ư���� ������ �����źϷ�4�� 77, 1��
			</div>
			<div>��ǰ&���� ���� ���� : ounwan50@gmail.com</div>
			<div class="text-1">������ : ���� ���� 10:00 ~ ���� 5:00</div>
			<div class="text-1">(���ɽð� 12:00 ~ 13:00) ��/��/������ �޹�</div>
		</div>
		<div class="float-right">
			<div>
				<a href="#">�̺�Ʈ</a>
			</div>
			<div>
				<a href="#">��������ó����ħ</a>
			</div>
			<div>
				<a href="#">�̿���</a>
			</div>
			<div>
				<img class="float-right img-1 pointer" src="../images/insta.png"
					alt="�ν�Ÿ ����" />
			</div>
		</div>
	</footer>
	<script src="./js/main.js"></script>
</body>
</html>