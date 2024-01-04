<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="${appPath}/css/bixSiri/adminChat.css" />
    <title>오운완 관리자</title>
    <script>
    	$(document).ready(function() {
    		if('${admin.adminId}' == null) {
    			location.href = "${appPath}/admin/login.do";
    		}
     	});
    </script>
</head>
<body>
    <header class="header">
        <span>OUNWAN</span> 
        <div>
        	<span><a href="${appPath}" class="goOunwan">go ounwan</a></span>
        	<span id="logout" class="logout">logout</span>
        </div>
    </header>
    <div class="container">
        <nav>
            <ul class="menu">
                <li>
                    <a href="#">오늘의 쿠펑</a>
                    <ul class="submenu">
                        <li><a id="coupungProductList" href="#">상품 확인</a></li>
                        <li><a id="coupungAddProduct" href="#">상품 추가</a></li>
                        <li><a id="coupungOrders" href="#">주문 조회</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" id="danggunAllList">오늘의 당군</a>
                </li>
                <li>
                    <a id="aetaAllList" href="#">오늘의 애타</a>
                </li>
                <li>
                    <a id="ounwanChat" href="#">문의 채팅</a>
                </li>
                <li>
                    <a href="#">신고센터</a>
                    <ul class="submenu">
                        <li><a id="danggunReport" href="#">오늘의 당군</a></li>
                        <li><a id="aetaReport" href="#">오늘의 애타</a></li>
                        <li><a id="gramReportBoards" href="#">오늘 운동했다그램</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <div class="admin-wrap">
        	<div class="admin-main-wrap">
	        	<div>
	        		<h3>주간 매출 추이</h3>
	            	<div><canvas id="weekSales" width="600px" height="300px"></canvas></div>
	        	</div>
	        	<div>
	        		<h3>카테고리 별 판매액</h3>
	            	<div><canvas id="categorySales" width="300px" height="300px"></canvas></div>
	        	</div>
	        	<div>
	        		<h3>당군 판매 물품 수</h3>
	            	<div><canvas id="DanggunSales" width="600px" height="300px"></canvas></div>
	        	</div>
	        	<div>
	        		<h3>커뮤니티 활동 추이</h3>
	            	<div><canvas id="communityAct" width="600px" height="300px"></canvas></div>
	        	</div>
	        	<div>
	        		<h3>신고 변동</h3>
	            	<div><canvas id="totalReports" width="600px" height="300px"></canvas></div>
	        	</div>
        	</div>         
        </div>
    </div>

    <script>
		var context = document
		   .getElementById('weekSales')
		   .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'bar',
		    data: {
		        labels: ${date},
		        datasets: [
		            {
		                label: '주간 매출',
		                data: ${totalPrice},
		                backgroundColor: 'rgb(123,0,123)'
		            }
		        ]
		    },
		    options: {
		        responsive: false,
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true
		                }
		            }]
		        }
		    }
		});
		
		var context = document
		   .getElementById('categorySales')
		   .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'doughnut',
		    data: {
		        labels: ${categories},
		        datasets: [
		            {
		                label: '카테고리별 판매액',
		                data: ${totalPriceCategory},
		                backgroundColor: ['rgb(255, 99, 132)',
		                    'rgb(54, 162, 235)',
		                    'rgb(255, 205, 86)',
		                    'rgb(10,50,20)']
		            }
		        ]
		    },
		    options: {
		        responsive: false
		    }
		});
		
		var context = document
		   .getElementById('DanggunSales')
		   .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'bar',
		    data: {
		        labels: ${date},
		        datasets: [
		            {
		                label: '당군 거래물품 수',
		                data: ${totalDanggun},
		                backgroundColor: 'rgb(255, 99, 132)'
		            }
		        ]
		    },
		    options: {
		        responsive: false,
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true
		                }
		            }]
		        }
		    }
		});
		
		var context = document
		   .getElementById('communityAct')
		   .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'bar',
		    data: {
		        labels: ${date},
		        datasets: [
		            {
		                label: '커뮤니티 활동',
		                data: ${communityAct},
		                backgroundColor: '#ff69b4'
		            }
		        ]
		    },
		    options: {
		        responsive: false,
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true
		                }
		            }]
		        }
		    }
		});
		
		var context = document
		   .getElementById('totalReports')
		   .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'line',
		    data: {
		        labels: ${date},
		        datasets: [
		            {
		                label: '커뮤니티 관련 신고',
		                data: ${communityCnt},
		                borderColor: 'rgb(50,10,20)'
		            },
		            {
		            	label: '상품 관련 신고',
		            	data: ${storeCnt},
		            	borderColor: 'rgb(10,50,20)'
		            }
		        ]
		    },
		    options: {
		        responsive: false,
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true
		                }
		            }]
		        }
		    }
		});
    
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
        		url: "${appPath}/admin/coupung/product.do",
        		data: {
        			'offset': 0,
        			'searchOption': '',
        			'searchValue': '',
        			'sortOption': 'name'
        		},
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#coupungAddProduct").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/coupung/insert.do",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#gramReportBoards").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/ounwangram/reports",
        		data: {
        			'offset': 0
        		},
        		success: function(res) {
        			$(".admin-wrap").html(res);
        		},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#ounwanChat").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/clients/chat.do",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#danggunAllList").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/danggun/danggunBoard",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#danggunReport").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/danggun/report",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("#aetaAllList").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/aeta/aetaBoard",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        $("#aetaReport").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/aeta/report",
       			success: function(res) {
       				$(".admin-wrap").html(res);
       			},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	});
        });
        
        $("header span").on("click", function() {
        	location.reload();
        });
        
        $("#logout").on("click", function(){
        	$.ajax({
        		url : "${appPath}/admin/logout",
        		success : function(res) {
        			if(res == "success"){
        				alert("로그아웃에 성공하였습니다.");
        				window.location.href = "${appPath}/admin/login.do";
        			}
        		},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
        	})
        });
        
        $("#coupungOrders").on("click", function() {
        	$.ajax({
        		url: "${appPath}/admin/coupung/order.do",
        		data: {'offset': 0},
        		success: function(res) {
        			$(".admin-wrap").html(res);
        		}
        	});
        });
    </script>
</body>
</html>