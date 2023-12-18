<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>ounwan</title>
    <link href="${appPath}/css/main2.css" rel="stylesheet">
    <link href="${appPath}/css/header.css" rel="stylesheet">
    <link href="${appPath}/css/nav.css" rel="stylesheet">
    <link href="${appPath}/css/mypagemain.css" rel="stylesheet">
</head>

<body>
   <header>
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="profileImage" href="#">
                    <img src="./images/google.png">
                </a>
                <span>0000님 환영합니다</span>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
        </div>
        <div class="header-sub-menu">
            <div>
                <a href="#">마이페이지</a>
                <a href="#">로그아웃</a>
            </div>
        </div>
    </header>
     
    <div class="container">
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
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
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
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
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

        <!--mypage content-->
        <div class="mypage-container">
            <div class="mypage-content">
                <div class="side-bar-container">
                    <div class="side-bar title">
                        <a href="#">
                            마이페이지
                        </a>
                    </div>
                    <div class="side-bar menu">
                        <div class="menu-container coupung">
                            <a href="#">
                                <div class="coupung-menu order-list">
                                    주문내역 조회
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu mileage">
                                    마일리지
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu review">
                                    리뷰 관리
                                </div>
                            </a>
                        </div>
                        <div class="menu-container danggun">
                            <a href="javascript:danggunSaleList()">
                                <div class="danggun-menu sale-list">
                                    내 판매 내역
                                </div>
                            </a>
                            <a href="#">
                                <div class="danggun-menu wish-list">
                                    관심 상품
                                </div>
                            </a>
                        </div>
                        
                        <div class="menu-container aeta">
                            <a href="#">
                                <div class="aeta-menu writing-list">
                                    내 게시글 목록
                                </div>
                            </a>
                        </div>
                        <div class="menu-container chat">
                            <a href="#">
                                <div class="chat-menu admin">
                                    관리자와 채팅
                                </div>
                            </a>
                            <a href="#">
                                <div class="chat-menu danggun">
                                    쪽지 내역
                                </div>
                            </a>
                        </div>
                        <div class="menu-container user">
                            <a href="#">
                                <div class="user-menu update-user-info">
                                    회원 정보 수정
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="content-container">
                    <div class="preview-container">
                        <div class="preview user">
                            <p class="preview-user name">오운완님</p>
                            <p class="preview-user text">WELCOME</p>
                        </div>

                        <div class="preview menu">
                            <a href="#" class="preview-menu mileage">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>마일리지</p>
                                        <span>127</span><span> 점</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu wish-list">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>관심 상품</p>
                                        <span>0</span><span> 개</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu cart">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>장바구니</p>
                                        <span>5</span><span> 개</span>
                                    </div>                            
                                </div>
                            </a>
                        </div>
                    </div>

                    <!--여기부분이 계속 바뀔 예정입니당-->
                    <div class="content-info-container">
                        <div class="content-info" id="content">
                            여기
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="./js/main.js"></script>
        <script>
        	function danggunSaleList() {
        		alert("danggunSaleList()");
        		$.ajax({
        			type: "GET",
        			url: "${appPath}/myPage/danggunSaleList",
        			success: function(res){
        				$("#content").html(res);
        			}
        		});
        	}
        </script>
</body>

</html>