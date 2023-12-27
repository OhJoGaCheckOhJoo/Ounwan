<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
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
    <%@ include file="../common/header.jsp" %>

    <div class="container">
        <%@ include file="../common/nav.jsp"%>

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
				<div class="faq-page"></div>
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
        	faqPages();
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
        	faqPages();
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
        		url:"/myapp/getFAQList",
        		data: {
        			'offset': offset,
        			'category': category
        		},
        		success: function(res) {
        			$("#faqList").html(res);
        		}
        	});
        }
        
        const faqPages = function() {
        	$.ajax({
        		url:"/myapp/getFAQPages",
        		data: {
        			'category': category
        		},
        		success: function(res) {
        			$(".faq-page").html(res);
        		}
        	});
        }
    </script>
</body>
</html>