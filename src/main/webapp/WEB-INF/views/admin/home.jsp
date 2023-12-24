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
    <title>Document</title>
    <style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        * {
            font-family: 'Dongle', sans-serif;
            font-size: 36px;
            margin: 0;
            padding: 0;
        }
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }
        header {
            padding: 10px 20px 10px 20px;
            background-color: rgb(57, 46, 179);
            height: 45px;
        }
        header > span {
            color: #fff;
            margin-left: 20px;
            letter-spacing: 1.2px;
            font-weight: bold;
        }
        nav {
            display: inline-block;
            width: 180px;
            height: 100%;
            background-color: rgb(57, 46, 179);
            border: 1px solid #fff;
        }
        li {
            list-style: none;
        }
        input:focus {
            outline: none;
        }
        .container {
            height: calc(100% - 67px);
        }
        .menu {
            overflow: hidden;
        }

        .menu > li {
            width: 100%;
            text-align: center;
            line-height: 40px;
            padding: 10px 0px 10px 0px;
        }

        .menu a {
            color: #fff;
            font-size: 28px;
            text-decoration: none;
        }

        .submenu > li {
            line-height: 50px;
            font-size: 24px;
            background-color: rgba(255,255,255,0.1);
            color: #fff;
        }

        .submenu {
            height: 0;
            overflow: hidden;
        }

        .menu > li:hover {
            transition-duration: 0.5s;
        }

        .menu > li:hover .submenu {
            height: auto;
            transition-duration: 1s;
        }
        .admin-wrap {
            display: inline-block;
            width: calc(100% - 200px);
            height: 100%;
            vertical-align: top;
            margin-top: 5px;
            background-color: #ddd;
        }
        .chatting-wrap {
            background-color: #fff;
            padding: 50px;
            width: 1000px;
            height: 600px;
            margin: 150px auto 0px auto;
            border-radius: 50px;
        }
        .admin-chat-sub {
            display: inline-block;
            width: 320px;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
            padding-right: 10px;
        }
        .admin-chat-sub > input {
            text-align: center;
            width: 300px;
        }
        .user-profile {
            width: 300px;
            height: 50px;
            border: 0;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            margin-top: 5px;
        }
        .user-profile:hover {
            background-color: #eee;
        }
        .user-profile img {
            height: 40px;
            width: 40px;
        }
        .user-profile span {
            position: relative;
            bottom: 12px;
        }
        .admin-chatting {
            display: inline-block;
            width: 620px;
            height: 100%;
            padding: 10px 10px 10px 20px;
            margin-left: 10px;
            border-left: 1px solid #ddd;
            vertical-align: top;
        }
        .chatting-user {
            height: 50px;
            text-align: center;
        }
        .chatting-user img {
            width: 40px;
            height: 40px;
        }
        .chatting {
            height: 420px;
            background-color: #eee;
            border-radius: 10px;
            margin: 5px 0px 5px 0px;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .admin-chatting form textarea {
            width: 500px;
            height: 90px;
            font-size: 18px;
            padding: 5px;
            border: 1px solid #ccc;
            font-family: 'GmarketSansMedium';
        }
        .admin-chatting form textarea:focus {
            outline: none;
        }
        .admin-chatting form button {
            width: 100px;
            height: 100px;
            vertical-align: top;
            border: 0;
            border-radius: 10px;
            background-color: rgb(57, 46, 179);
            color: #fff;
        }
        .admin-chatting form button:hover {
            background-color: rgb(49, 39, 156);
        }
    </style>
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
                        <li><a href="#">상품 확인</a></li>
                        <li><a href="#">주문 확인</a></li>
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
    </script>
</body>
</html>