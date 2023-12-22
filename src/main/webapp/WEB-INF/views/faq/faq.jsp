<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
    <link href="./css/main2.css" rel="stylesheet">
    <link href="./css/header.css" rel="stylesheet">
    <link href="./css/nav.css" rel="stylesheet">
    <link href="./css/faq.css" rel="stylesheet">
</head>
<body>
    <!--
    <header>
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="signUp" href="./html/signup.html"></a>
                <a id="loginSelect" href="#"></a>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
        </div>
    </header>
    -->
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
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="faq-wrap">
            <div class="faq-title">
                <span>FAQ</span>
            </div>
            <div class="faq-body">
                <div class="faq-search">
					<form>
						<span>질문을 입력하세요</span> <input type="text">
						<button type="button">검색</button>
					</form>
				</div>
				<div class="faq-category">
					<button value=0>전체보기</button>
					<button value=1>배송문의</button>
					<button value=2>중고거래</button>
					<button value=3>커뮤니티</button>
				</div>
				<div class="faq-main">
					<div class="faq-header">
						<span>NO.</span>
						<div>제목</div>
					</div>
					<div id="faqList"></div>
				</div>
				<div class="faq-page">
					<c:forEach var="page" begin="1" end="${pages}">
						<button value="${page}" class="faq-page-btn<c:if test="${page eq 1}"> selected</c:if>">
							[${page}]
						</button>
					</c:forEach>
				</div>
            </div>
        </div>
    </div>
    
    <%@ include file="../danggun/danggunProhibitedListModal.jsp"%>
    
    <script src="./js/main.js"></script>
    <script>
    	var offset = 0;
    	var category = 0;
    	
        $(window).on("load", function() {
        	faqAjax();
        });

        $('.faq-body').on("click", ".faq-content a", function() {
            if($(this).parent().find('.faq-detail').css("display") == "none") {
                $(this).parent().find('.faq-detail').show();
            } else {
                $(this).parent().find('.faq-detail').hide();
            }
        });
        
        $('.faq-category button').on("click", function() {
        	category = $(this).val();
        	$('.faq-page-btn').eq(offset / 10).removeClass("selected");
        	$('.faq-page-btn').eq(0).addClass("selected");
        	offset = 0;
        	faqAjax();
        });
        
        $('.faq-page').on("click", '.faq-page-btn', function() {
        	$('.faq-page-btn').eq(offset / 10).removeClass("selected");
        	$(this).addClass("selected");
        	offset = ($(this).val() - 1) * 10;
        	faqAjax();
        });
        
        function openProhibitedListModal() {
        	document.getElementById("prohibitedListModal").style.display = "block";
        	document.getElementById("ProhibitedModalOverlay").style.display = "block";
        }

        function closeProhibitedListModal() {
        	document.getElementById("prohibitedListModal").style.display = "none";
        	document.getElementById("ProhibitedModalOverlay").style.display = "none";
        }
        
        const faqAjax = function() {
        	$.ajax({
        		url:"/ounwan/getFAQList",
        		data: {
        			'offset': offset,
        			'category': category
        		},
        		success: function(res) {
        			$("#faqList").html(res);
        		}
        	});
        }
        
        /*
        for(var i = 0; i < 10; i++) {
            $('.faq-num').eq(i).css("bottom", ((($('.faq-content a div').eq(i).css("height")).replace("px", "") - ($('.faq-num').eq(i).css("height")).replace("px", "")) / 2 + "px"));
        }
    	*/
    </script>
</body>
</html>