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
    <title>Document</title>
    <link href="${appPath}/css/main2.css" rel="stylesheet">
 
    <link href="${appPath}/css/header.css" rel="stylesheet">
  

    <link href="${appPath}/css/nav.css" rel="stylesheet">
    <link href="${appPath}/css/mypagemain.css" rel="stylesheet">
</head>
<style>


.pwd-check {
  width: 300px;
  height: 80px;
  margin-top: 10px;
  position: relative;
}

.pwd-check-container {
  width: 1100px;
  height: 300px;
  padding: 100px 75px 100px 75px;
  border: 1px solid #ccc;
  border-radius: 20px;
}

.pwd-check-container > div h3 {
  width: 300px;
  font-size: 1.1em;
  padding-bottom: 20px;
}

.pwd-check-wrap-1 {
  width: 300px;
  height: 300px;
  display: inline-block;
  border-left: #ccc solid 1px;
  padding: 0px 100px 0px 149.5px;
}

.pwd-check-wrap-2 {
  width: 300px;
  height: 300px;
  display: inline-block;
  padding: 0px 149.5px 0px 100px;

}

.social-wrap {
  width: 300px;
  height: 300px;
  display: inline-block;
  padding: 0px 149.5px 0px 100px;
}

.pwd-check-wrap-1 > *, .pwd-check-wrap-2 > * {
  float: inherit;
}

.pwd-check-wrap-1 > form div button, .pwd-check-wrap-2 > form div button {
  width: 300px;
  height: 65px;
  border-radius: 10px;
  border: 0px;
  background-color: var(--main-color);
  color: #fff;
  cursor: pointer;
}

.pwd-check-wrap-1 > div, .pwd-check-wrap-2 > div {
  margin-top: 5px;
}

.pwd-check-wrap-1 > div a, .pwd-check-wrap-2 > div a {
  width: 400px;
}

.pwd-check-wrap-1 > div button, .pwd-check-wrap-2 > div button {
  background-color: var(--main-color);
  color: #fff;
}

.pwd-check-wrap-1 > .btn, .pwd-check-wrap-2 > .btn {
  padding:0px;
  background-color: var(--main-color);
}

.pwd-check-radius {
  border-radius: 10px;
}

.line {
  width: 0px;
  height: 300px;
  border: 1px solid #ddd;
  display: inline-block;
  margin: auto;
}

.pwd-check-sub {
  width: 300px;
  text-align: center !important;
}

.pwd-check-sub-1 {
  color: var(--main-color);
}

.pwd-check-sub-2 {
  color: #aaa;
  text-decoration-line: underline;
}

.pwd-check-menu {
  border-bottom: 4px solid #eee;
  margin: 10px 0px 20px 0px;
  padding-bottom: 10px;
  width: 1250px;
}

.pwd-check-menu > div {
  display: inline-block;
  width: 615px;
  text-align: center !important;
}

.pwd-check-menu div a {
  font-size: 1.5em;
}

.pwd-check-menu-selected {
  padding-bottom: 10px;
  border-bottom: 4px solid var(--main-color);
}

.img-border {
  border-radius: 5px;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);
}

.pwd-check span {
  display: block;
  position: absolute;
  bottom: 0;
  left: 0%;
  background-color: #666;
  width: 0;
  height: 2px;
  border-radius: 2px;
  transition: 0.5s;
}

.pwd-check label {
  position: absolute;
  color: #555;
  left: 10px;
  font-size: 20px;
  bottom: 8px;
  transition: all .2s;
}

.pwd-check input {
  font-size: 1.3em;
  color: #222222;
  width: 270px;
  height: 51.8px;
  border: none;
  border-bottom: solid #aaaaaa 1px;
  padding: 22px 10px 0px 20px;
  position: relative;
  background: none;
  z-index: 5;
}

.pwd-check span {
  display: block;
  position: absolute;
  bottom: 0;
  left: 0%;
  background-color: #666;
  width: 0;
  height: 2px;
  border-radius: 2px;
  transition: 0.5s;
  margin-bottom: 3.7px;
}

.pwd-check label {
  position: absolute;
  color: #aaa;
  left: 10px;
  font-size: 20px;
  bottom: 10px;
  transition: all .2s;
}

.pwd-check input:focus ~ label, .pwd-check input:valid ~ label {
  font-size: 16px;
  bottom: 50px;
  color: #666;
  font-weight: bold;
}

.pwd-check input:focus ~ span, .pwd-check input:valid ~ span {
  width: 300px;
}

.pwd-check input::placeholder { color: #aaaaaa; }
.pwd-check input:focus {outline: none; }

.social-wrap a img {
  box-shadow: 3px 3px 3px #ccc;
  border: 1px solid #ddd;
}

</style>

<body>
   <header>
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="profileImage" href="#">
                    <img src="../images/google.png">
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
                            <a href="#">
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
                        <div class="content-info">
                          <div class="pwd-check-wrap-1 float-right">
                          <p>비밀번호 재확인</p>
			                <form>
			                    <div class="pwd-check">
			                        <input id="pwd-checkId" type="text" readonly="readonly">
			                        <label>${clientId}</label>
			                        <span></span>
			                    </div>
			                    <div class="pwd-check">
			                        <input id="pwd-checkPassword" type="password" required>
			                        <label>비밀번호</label>
			                        <span></span>
			                    </div>
			                    <div class="pwd-check-buttons">
					                <div class="pwd-check pwd-check-radius"><button id="cancleButton">취소</button></div>
					                <div class="pwd-check pwd-check-radius"><button id="confirmButton">확인</button></div> 
			               		</div>
			                </form>
	           			 </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
       <script>
      
       </script>
</body>

</html>