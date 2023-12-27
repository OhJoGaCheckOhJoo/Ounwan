<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">
    <title>Admin Login</title>
    <style>
        * {
            font-family: 'Dongle', sans-serif;
        }
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-color: #eee;
        }
        .container{
            position: relative;
            top: calc((100% - 400px) / 2);
            height: 400px;
            width: 600px;
            margin: auto;
            text-align: center;
            font-size: 32px;
            border: 1px solid #eee;
            border-radius: 30px;
            background-color: #fff;
        }
        .container > img {
            margin-top: 35px;
            width: 300px;
            height: 100px;
        }
        .container div span {
            font-weight: bold;
            letter-spacing: 1.2px;
            color: rgb(57, 46, 179);
        }
        .container div form div{
            display: inline-block;
            margin: 0px 10px 0px 10px;
        }
        .container div form div input {
            display: block;
            width: 300px;
            margin: 5px 0px 5px 0px;
            padding: 10px 20px 10px 20px;
            border: 0;
            border-bottom: 2px solid #eee;
            background-color: #fff;
            font-size: 32px;
            text-align: center;
        }
        input:focus {
            outline: none;
        }
        .button{
            position: relative;
            bottom: 20px;
            height: 151px;
        }
        .button button {
            width: 100px;
            height: 100px;
            font-size: 32px;
            color: #fff;
            border: 0;
            border-radius: 10px;
            background-color: rgb(57, 46, 179);
            cursor: pointer;
        }
        .button button:hover {
            box-shadow: 5px 5px rgb(0,0,0, 0.3) inset;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="./초록우산.jpg">
        <div><span>Ounwan</span> LogIn</div>
        <div>
			<form>
                <div class="input">
                    <input type="text" id="adminId" placeholder="아이디를 입력해주세요.">
                    <input type="password" id="adminPass" placeholder="비밀번호를 입력해주세요.">
                </div>
                <div class="button">
                    <button id="loginBtn">로그인</button>
                </div>
        	</form>
        </div>
    </div>
    <script>
    	$('#loginBtn').on('click', function() {
    		var obj = {
    				"adminId" : $('#adminId').val(),
    				"password" : $('#adminPass').val()
    		}
    		$.ajax({
    			url : '${appPath}/admin/login.do',
    			type : 'post',
    			contentType : 'application/json',
    			data : JSON.stringify(obj),
    			success : function (res) {
    				if (res === 'success') {
    					alert('어서오소');
    					location.href = "${appPath}/admin/main.do"
    				} else {
    					alert('아이디 / 비밀번호가 틀렸습니다.');
    				}
    			}
    		});
    	});
    </script>
</body>
</html>