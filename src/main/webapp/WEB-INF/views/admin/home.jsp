<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">
    <link href="${appPath}/css/admin.css" rel="stylesheet">
    <title>Ounwan Admin</title>
    <script>
    	$(document).ready(function() {
    		if('${admin.adminId}' == null) {
    			location.href = "${appPath}/admin/login.do";
    		}
     	});
    </script>
</head>
<body>
    <header>
        <span>OUNWAN</span>
    </header>
    <div class="container">
        <nav>
            <ul class="menu">
                <li>
                    <a href="#">오늘의 쿠펑</a>
                    <ul class="submenu">
                        <li><a id="coupungProductList" href="#">상품 확인</a></li>
                        <li><a id="coupungAddProduct" href="#">상품 추가</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">오늘의 당군</a>
                    <ul class="submenu">
                        <li><a href="#">거래중인 상품</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">오늘의 애타</a>
                    <ul class="submenu">
                        <li><a href="#">게시글 목록</a></li>
                        <li><a href="#">전체 댓글</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">오늘 운동했다그램</a>
                    <ul class="submenu">
                        <li><a href="#">최근 등록 게시물</a></li>
                        <li><a href="#">해시태그</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">고객센터</a>
                    <ul class="submenu">
                        <li><a href="#">문의 채팅</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">신고센터</a>
                    <ul class="submenu">
                        <li><a href="#">오늘의 쿠펑</a></li>
                        <li><a href="#">오늘의 당군</a></li>
                        <li><a href="#">오늘의 애타</a></li>
                        <li><a href="#">오늘의 운동했다그램</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <div class="admin-wrap">
            <div class="chatting-wrap">
                <div class="admin-chat-sub">
                    <input type="text">
                    <button class="user-profile">
                        <img src="./full_star.png">
                        <span>jj1234</span>
                    </button>
                    <button class="user-profile">
                        <img src="./half_star.png">
                        <span>test</span>
                    </button>
                    <button class="user-profile">
                        <img src="./right_1.png">
                        <span>test2</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>test3</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>aaaa</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>abcabc</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>jj12345</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>bbbbb</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>ccccc</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>vxsdsdg</span>
                    </button>
                    <button class="user-profile">
                        <img src="./ticket.png">
                        <span>jjjjjjj</span>
                    </button>
                </div>
                <div class="admin-chatting">
                    <div class="chatting-user">유저를 선택해주세요!</div>
                    <div class="chatting">

                    </div>
                    <form>
                        <textarea disabled>가나다라마바사아자차카타파하</textarea>
                        <button disabled type="button">보내기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(".admin-chat-sub input").on("input", function() {
            for(var i = 0; i < $(".user-profile span").length; i++) {
                if($(".user-profile span").eq(i).html().includes($(this).val())) {
                    $(".user-profile").eq(i).show();
                } else {
                    $(".user-profile").eq(i).hide();
                }
            }
        });

        $(".user-profile").on("click", function() {
            $('.chatting-user').html($(this).html());
            $('.admin-chatting form textarea').attr('disabled', false);
            $('.admin-chatting form button').attr('disabled', false);
        });
        
        $("#coupungProductList").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/coupung/select.do",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			}
        	});
        });
        
        $("#coupungAddProduct").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/coupung/insert.do",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			}
        	});
        });
        
        $("header span").on("click", function() {
        	location.reload();
        });
    </script>
</body>
</html>