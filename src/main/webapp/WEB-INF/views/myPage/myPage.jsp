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
                        <a href="${appPath}/myPage">
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
                            <a href="javascript:reviewList()">
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
                            <a href="javascript:danggunWishList()">
                                <div class="danggun-menu wish-list">
                                    관심 상품
                                </div>
                            </a>
                        </div>
                        
                        <div class="menu-container aeta">
                            <a href="javascript:aetaList()">
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
                            <h2>최근 주문 정보_coupung</h2>
                            	<c:forEach var="oList" items="${orderList}">
                            		<div>
                            			주문일자: <span>${oList.ORDER_DATE}</span>
                            		</div>
                            		<div>
                            			이미지 url: <span>${oList.PRODUCT_IMAGE_URL}</span>
                            		</div>
                            		<div>
                            			상품명: <span>${oList.COUPUNG_NAME}</span>
                            		</div>
                            		<div>
                            			주문번호: <span>${oList.ORDER_NUMBER}</span>
                            		</div>
                            		<div>
                            			가격: <span>${oList.PRICE}</span>
                            		</div>
                            		<div>
                            			수량: <span>${oList.QUANTITY}</span>
                            		</div>
                            		<div>
                            			상품 번호: <span>${oList.COUPUNG_NUMBER}</span>
                            		</div>
                            		
                            	</c:forEach>
                            	<br><br>
                            <h2>최근 등록 게시글_aeta</h2>
                            	<c:forEach var="aList" items="${aetaList}">
                            		<div>
                            			제목: <span>${aList.title}</span>
                            		</div>
                            		<div>
                            			작성일: <span>${aList.createdDate}</span>
                            		</div>
                            		<div>
                            			조회수: <span>${aList.views}</span>
                            		</div>
                            		<div>
                            			게시글 번호: <span>${aList.aetaNumber}</span>
                            		</div>
                            	</c:forEach>
                            	<br><br>
                            <h2>장바구니</h2>
                            	<c:forEach var="cList" items="${cartList}">
                            		<div>
                            			상품명: <span>${cList.COUPUNG_NAME}</span>
                            		</div>
                            		<div>
                            			이미지 URL: <span>${cList.URL}</span>
                            		</div>
                            		<div>
                            			수량: <span>${cList.QUANTITY}</span>
                            		</div>
                            		<div>
                            			가격: <span>${cList.PRICE}</span>
                            		</div>
                            		<div>
                            			재고: <span>${cList.AVAILABLE_STOCK}</span>
                            		</div>
                            		<div>
                            			비활 여부: <span>${cList.AVAILABLE_CHECK}</span>
                            		</div>
                            		<div>
                            			장바구니 번호: <span>${cList.CART_NUMBER}</span>
                            		</div>
                            		<div>
                            			상품 번호: <span>${cList.COUPUNG_NUMBER}</span>
                            		</div>                           		
                            	</c:forEach>                       
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="./js/main.js"></script>
        <script>
        	function danggunSaleList() {
        		$.ajax({
        			type: "GET",
        			url: "${appPath}/myPage/danggunSaleList",
        			success: function(res){
        				$("#content").html(res);
        			}
        		});
        	}
        	
        	function danggunWishList() {
        		$.ajax({
        			type: "GET",
        			url: "${appPath}/myPage/danggunWishList",
        			success: function(res){
        				$("#content").html(res);
        			}
        		})
        	}
        	
        	function aetaList() {
        		$.ajax({
        			type: "GET",
        			url: "${appPath}/myPage/aetaList",
        			success: function(res){
        				$("#content").html(res);
        			}
        		})
        	}
        	
        	function reviewList() {
        		$.ajax({
        			type: "GET",
        			url: "${appPath}/myPage/coupungReviewList",
        			success: function(res) {
        				$("#content").html(res);
        			}
        		});
        	}
        </script>
</body>

</html>