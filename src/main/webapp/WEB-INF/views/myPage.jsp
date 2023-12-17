<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
    <!--
        <link href="./header.css" rel="stylesheet">
    -->

    <link href="${appPath}/css/nav.css" rel="stylesheet">
    <link href="${appPath}/css/mypagemain.css" rel="stylesheet">
</head>

<body>
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
                    <a href="#">���θ�</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">��ü ����</a>
                        <a href="#">� �ⱸ</a>
                        <a href="#">�ǰ� ���� ��ǰ</a>
                        <a href="#">�ｺ �̿��</a>
                        <a href="#">�Ƿ�</a>
                    </div>
                </div>
                <div>
                    <a href="#">�߰�ŷ�</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">��ü ����</a>
                        <a href="#">���� ��ǰ</a>
                    </div>
                </div>
                <div>
                    <a href="#">Ŀ�´�Ƽ</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a class="ounwangram" href="ounwangram">����� Ŀ�´�Ƽ</a>
                        <a href="#">��� �Խ���</a>
                    </div>
                </div>
                <div>
                    <a href="#">������</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">��ǰ����</a>
                        <a href="#">��۹���</a>
                        <a href="#">�߰�ŷ�</a>
                        <a href="#">Ŀ�´�Ƽ</a>
                    </div>
                </div>
            </div>
            <div id="navMenu" class="nav-menu">
                <div>
                    <div>
                        <a href="#">��ü ����</a>
                        <a href="#">� �ⱸ</a>
                        <a href="#">�ǰ� ���� ��ǰ</a>
                        <a href="#">�ｺ �̿��</a>
                        <a href="#">�Ƿ�</a>
                    </div>
                    <div>
                        <a href="#">��ü ����</a>
                        <a href="#">���� ��ǰ</a>
                    </div>
                    <div>
                        <a class="ounwangram" href="ounwangram">����� Ŀ�´�Ƽ</a>
                        <a href="#">��� �Խ���</a>
                    </div>
                    <div>
                        <a href="#">��ǰ����</a>
                        <a href="#">��۹���</a>
                        <a href="#">�߰�ŷ�</a>
                        <a href="#">Ŀ�´�Ƽ</a>
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
                            ����������
                        </a>
                    </div>
                    <div class="side-bar menu">
                        <div class="menu-container coupung">
                            <a href="#">
                                <div class="coupung-menu order-list">
                                    �ֹ����� ��ȸ
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu mileage">
                                    ���ϸ���
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu review">
                                    ���� ����
                                </div>
                            </a>
                        </div>
                        <div class="menu-container danggun">
                            <a href="#">
                                <div class="danggun-menu sale-list">
                                    �� �Ǹ� ����
                                </div>
                            </a>
                            <a href="#">
                                <div class="danggun-menu wish-list">
                                    ���� ��ǰ
                                </div>
                            </a>
                        </div>
                        
                        <div class="menu-container aeta">
                            <a href="#">
                                <div class="aeta-menu writing-list">
                                    �� �Խñ� ���
                                </div>
                            </a>
                        </div>
                        <div class="menu-container chat">
                            <a href="#">
                                <div class="chat-menu admin">
                                    �����ڿ� ä��
                                </div>
                            </a>
                            <a href="#">
                                <div class="chat-menu danggun">
                                    ���� ����
                                </div>
                            </a>
                        </div>
                        <div class="menu-container user">
                            <a href="#">
                                <div class="user-menu update-user-info">
                                    ȸ�� ���� ����
                                </div>
                            </a>
                        </div>
                    </div>

                </div>

                <div class="content-container">
                    <div class="preview-container">
                        <div class="preview user">
                            <p class="preview-user name">����ϴ�</p>
                            <p class="preview-user text">WELCOME</p>
                        </div>

                        <div class="preview menu">
                            <a href="#" class="preview-menu mileage">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>���ϸ���</p>
                                        <span>127</span><span> ��</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu wish-list">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>���� ��ǰ</p>
                                        <span>0</span><span> ��</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu cart">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>��ٱ���</p>
                                        <span>5</span><span> ��</span>
                                    </div>                            
                                </div>
                            </a>
                        </div>
                    </div>

                    <!--����κ��� ��� �ٲ� �����Դϴ�-->
                    <div class="content-info-container">
                        <div class="content-info">
                            ����
                        </div>

                    </div>

                </div>

            </div>

        </div>

        <script src="../js/main.js"></script>
</body>

</html>