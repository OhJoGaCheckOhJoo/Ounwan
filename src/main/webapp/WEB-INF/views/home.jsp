<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<c:set
  var="appPath"
  scope="application"
  value="${pageContext.request.contextPath}"
/>
<!DOCTYPE html>
<html>
  <head>
    <link href="${appPath}/css/main.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
  </head>
  <body>
    <%@ include file="./common/header.jsp" %>

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
            <div class="nav-submenu">
              <a href="#">전체 보기</a>
              <a href="#">운동 기구</a>
              <a href="#">건강 보조 식품</a>
              <a href="#">헬스 이용권</a>
              <a href="#">의류</a>
            </div>
          </div>
          <div>
            <a href="${appPath}/danggun/main">중고거래</a>
            <div class="nav-submenu">
              <a href="${appPath}/danggun/main">전체 보기</a>
              <a href="#">관심 상품</a>
            </div>
          </div>
          <div>
            <a href="#">커뮤니티</a>
            <div class="nav-submenu">
              <a href="#">오운완 커뮤니티</a>
              <a href="#">고민 게시판</a>
            </div>
          </div>
          <div>
            <a href="#">고객센터</a>
            <div class="nav-submenu">
              <a href="#">상품문의</a>
              <a href="#">배송문의</a>
              <a href="#">중고거래</a>
              <a href="#">커뮤니티</a>
            </div>
          </div>
        </div>
      </nav>

      <div id="main-banner" class="main-banner">
        <img src="./images/v616_37.png" />
      </div>

      <div>
        <div class="text-1">인기상품</div>
        <div id="populars" class="main-product"></div>
      </div>

      <br />

      <div>
        <div class="text-1">중고거래</div>
        <div id="secondhands" class="main-product"></div>
      </div>

      <br />
    </div>

    <hr />

    <%@ include file="./common/footer.jsp" %>
    <script src="./js/main.js"></script>
  </body>
</html>
