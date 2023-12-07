<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <header>
        <a class="logo" href="#"></a>
        <div class="float-right">
            <a href="./html/signup.html">회원가입</a>
            <a class="pointer" id="loginSelect">로그인</a>
            <!--# : DB(회원)/세션(비회원)에서 가져올 것-->
            <button class="pointer">Basket (#)</button>
        </div>
    </header>
    ​
    <div class="container">
        <!-- nav -->
        <nav>
            <div class="nav-main">
                <div class="pointer">
                    <a id="hamberger-btn" class="menu-trigger">
                        <span></span>
                        <span></span>
                        <span></span>
                    </a>
                </div>
                <div>
                    <a href="#">쇼핑몰</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">전체 보기</a>
                        <a href="#">운동 기구</a>
                        <a href="#">건강 보조 식품</a>
                        <a href="#">헬스 이용권</a>
                        <a href="#">의류</a>
                    </div>
                </div>
                <div>
                    <a href="#">중고거래</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                </div>
                <div>
                    <a href="#">커뮤니티</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                </div>
                <div>
                    <a href="#">고객센터</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
            <div id="navMenu" class="nav-menu">
                <div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">운동 기구</a>
                        <a href="#">건강 보조 식품</a>
                        <a href="#">헬스 이용권</a>
                        <a href="#">의류</a>
                    </div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                    <div>
                        <a href="#">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                    <div>
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
        </nav>
        
        <div class="ounwangram">
            <div class="ounwangram-option">
                <a class="pointer">전체 보기</a>
                <a class="pointer">친구 보기</a>
            </div>
            <div class="ounwangram-main">
            	<div>
	                <div class="pointer ounwangram-profile">
	                    <img src="./images/insta.png">
	                    <div>Nickname</div>
	                </div>
	                <div class="ounwangram-threedot-div">
	                    <button class="ounwangram-threedot"><img class="ounwangram-threedot" src="./images/three_dot.png"></button>
	                </div>
	                <div class="ounwangram-board">
	                	<img src="./images/v606_26.png">
	                </div>
	                <div class="ounwan-like">
	                	<button><img src="./images/ounwan_like.png"></button>
	                	<span>555</span><span>Likes</span>
	                </div>
	                <div class="ounwangram-content">
	                	<div class="userid">Nickname</div>
	                	<div>aaaaaaaaaaaaa</div>
	                </div>
                </div>
            </div>
        </div>
        
    </div>
    <hr>

	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>