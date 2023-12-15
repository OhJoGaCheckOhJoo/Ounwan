<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/danggunInsert.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
</head>
<body> 
    <!-- header -->
<header>
	<a class="logo" href="#"></a>
	<div class="float-right">
		<a href="./html/signup.html">회원가입</a>
		<a class="pointer" id="loginSelect">로그인</a>
		<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
		<button class="pointer">Basket (#)</button>
	</div>
</header>
​
<div class="container">
	<!-- nav -->
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
				<a href="${appPath}/danggun/main">중고거래</a>
				<div id="navSubmenu" class="nav-submenu">
					<a href="#">전체 보기</a>
					<a href="#">관심 상품</a>
				</div>
			</div>
			<div>
				<a href="#">커뮤니티</a>
				<div id="navSubmenu" class="nav-submenu">
					<a href="#">오운완 커뮤니티</a>
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
	</nav>	
	<!-- 여기 아래에 추가 -->
    <div class = "danggun-container">
        <div>
            <div class="register-container">
                <div class="register-info">
                    당군 상품 등록 기본정보
                </div>
               <div class="register-required">
                    *필수입력사항
               </div>                
               <div class="prohibit-list">
                    거래금지 품목 보기
               </div>              
            </div>           
            <div class="register-content">
                <div class="danggun-product">
 					<div class="danggun-product-text">
                       	 대표 이미지
						<div class="register-required asterisk">*</div>
                    </div> 
					<div class="danggun-image">						
						<label for="imageInput"></label>			
						<input type="file" id="imageInput" name="dnaggunImage" class="input-file"/>    	
		<!-- 				<input type="file" id="imageInput" name="dnaggunImage" class="input-file" onchange="setMainImage(event)"/>    --> 	
						<img id = "mainPreview" src="../images/danggunInsertDefault.png">
					</div>
                </div>
				<div class="danggun-product">
                    <div class="danggun-product-text">
                        상세 이미지
						<div class="danggun-product-text plus">(최대 3장 추가 가능)</div>
                    </div> 
                    <div class = "danggun-images" id = "detailImageContainer">
                    	<div class="danggun-image">								
						<label for="detailInput" ></label>							
<!-- 						<input type="file" id="detailInput" name="dnaggunImage" class="input-file" onchange="setDetailImages(event)" multiple/>    	 -->
						<input type="file" id="detailInput" name="dnaggunImage" class="input-file" onchange="setDetailImages(event)" multiple/>    	
						<img id = "DetailPreview1" class="detail-preview" src="../images/danggunInsertDefault.png">	
					</div>
					<div class="danggun-image">						
						<label for="imageInput2"></label>						
						<img id = "DetailPreview2" class="detail-preview" src="../images/danggunInsertDefault.png">
					</div>
					<div class="danggun-image">						
						<label for="imageInput2"></label>
						<img id = "DetailPreview3" class="detail-preview" src="../images/danggunInsertDefault.png">
					</div>
                    </div>
<!-- 					<div class="danggun-image">								
						<label for="detailInput" ></label>							
						<input type="file" id="detailInput" name="dnaggunImage" class="input-file" onchange="setDetailImages(event)" multiple/>    	
						<input type="file" id="detailInput" name="dnaggunImage" class="input-file" onchange="setDetailImages(event)" multiple/>    	
						<img id = "DetailPreview1" class="detail-preview" src="../images/danggunInsertDefault.png">	
					</div>
					<div class="danggun-image">						
						<label for="imageInput2"></label>						
						<img id = "DetailPreview2" class="detail-preview" src="../images/danggunInsertDefault.png">
					</div>
					<div class="danggun-image">						
						<label for="imageInput2"></label>
						<img id = "DetailPreview3" class="detail-preview" src="../images/danggunInsertDefault.png">
					</div> -->
                </div>
                <div class="danggun-product">					
                    <div class="danggun-product-text">
                        상품명
						<div class="register-required asterisk">*</div>
						
                    </div> 
					<div class="text-input-name">
                    	<input placeholder="상품명을 입력해주세요" name="danggunName" id="danggunName"/> 
                    	<div class="text-count" id="nameCount">0/40</div>
					</div>               					
				</div>
				
                <div class="danggun-product">
                    <div class="danggun-product-text">
                        가격
						<div class="register-required asterisk">*</div>
                    </div> 
                    <input placeholder="가격을 입력해주세요" name="danggunPrice" id="danggunPrice" type="number"/>
                </div>
                <div class="danggun-product-description">
                    <div class="danggun-product-text">
                        설명
						<div class="register-required asterisk">*</div>
                    </div> 
					<div class="text-input-description">						
                    	<textarea placeholder="구매시기, 브랜드/모델명, 제품의 상태(사용감, 하자 유무) 등을 입력해 주세요" name="danggunDescription" id="danggunDescription"></textarea>
						<div class="text-count" id="detailCount">0/2000</div>
					</div>					
                </div>	
            </div>
            <button id="submitButton" class="submit-btn">등록</button> 
        </div>      
    </div>
<hr>
​
<!-- footer -->
<footer>
	<div>
		<div>오운완 쇼핑몰 & 커뮤니티</div>
		<div>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</div>
		<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층</div>
		<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
		<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
		<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
	</div>
	<div class="float-right">
		<br><br>
		<div><a href="#">이벤트</a></div>
		<div><a href="#">개인정보처리방침</a></div>
		<div><a href="#">이용약관</a></div>
		<div><img class="float-right img-1 pointer" src="../images/insta.png"></div>
	</div>
</footer>
<script src="../js/main.js"></script>
<script>	
var detailImageCount =0;	

	$(function(){	
		
		$("#submitButton").on("click", function(){
			var mainImage = document.getElementById("imageInput");
			var mainImageName = mainImage.value;
			var productName = document.getElementById("danggunName");
			var productPrice = document.getElementById("danggunPrice");
			var productDetail = document.getElementById("danggunDescription");
			var detail= document.getElementById("danggunDescription").value;
			var formattedDetail = detail.replace(/\n/g, '<br>');
			var detailImages = $("#detailInput")[0].files;
			var detailLength = $("#detailInput")[0].files.length;
			
			if(mainImageName.trim() === '' || productName.value.trim() ==='' || productPrice.value.trim() ==='' || productDetail.value.trim() ==='') {
				alert("필수 항목을 작성해 주세요");
			}		
			
			var formData = new FormData();		
			
			if(detailImageCount===0) {
				formData.append('detailImagesLength', 0);
				formData.append('detailImages', null);
			}
			else {
				formData.append('detailImagesLength', detailLength);
				for(var i = 0; i < detailLength; i++){
	                formData.append('detailImages', detailImages[i]);
	            }
			}

			formData.append('image', $("input[id='imageInput']")[0].files[0]);
			formData.append('clientId', "${userInfo.clientId}");
			formData.append('productName', $("#danggunName").val());
			formData.append('price', $("#danggunPrice").val());
			formData.append('detail', formattedDetail);
			$.ajax({
				url: "${appPath}/danggun/insert",
				data: formData,
				type: "POST",
				processData: false,
				contentType: false,
				success: function(res){
					alert(res);
					location.href="${appPath}/danggun/main";
				}
			});
		})
	});
	
	document.addEventListener("DOMContentLoaded", function(){
		const textArea = document.getElementById("danggunDescription");
		const detailCounter = document.getElementById("detailCount");
		const detailMaxLength = 2000;
		
		updateCounter(textArea, detailCounter, detailMaxLength);
		textArea.addEventListener("input", function(){
			updateCounter(textArea, detailCounter, detailMaxLength);
		});
		
		const input = document.getElementById("danggunName");
		const nameCounter = document.getElementById("nameCount");
		const nameMaxLength = 40;
		
		updateCounter(input, nameCounter, nameMaxLength);
		input.addEventListener("input", function(){
			updateCounter(input, nameCounter, nameMaxLength);
		});
		
		function updateCounter(inputElement, counterElement, maxLength) {
			let text = inputElement.value;
			if(text.length > maxLength) {
				text = text.substring(0,maxLength);
				inputElement.value = text;
			}
			counterElement.textContent = text.length + "/" + maxLength;
		}		
	});	

	var img;
	var reader;
	var input;
	var mainImage;
	
	$("#imageInput").change(function(e){
		setMainImage(e);
	});
	
	function setMainImage(event){
		var f = event.target.files[0];
	
		reader = new FileReader();
		input = document.getElementById("imageInput");
		img = document.getElementById("mainPreview");
		
		if(f==undefined) {

			$('#imageInput').replaceWith(mainImage);
			$("#imageInput").on("change", setMainImage);

			img.src = img.src;
			return;
			
		} else {

			mainImage = $(event.target).clone(true);
			console.log("cloneImage: " + mainImage);

			reader.onload = function(event) {
				img.src = event.target.result;
			}
			reader.readAsDataURL(document.getElementById("imageInput").files[0]);
			console.log("mainImage: " + $('#imageInput')[0].files[0]);
		}
	}
	
	var imgDetail;
	var readerDetail;
	var inputDetail;
	var detailImgaes;
	var detailContainer;
	
	$("#detailInput").change(function(e){				
		setDetailImages(e);
	})
	
	function setDetailImages(event) {
    var f = event.target.files[0];

    inputDetail = document.getElementById("detailInput");
    imgDetail = document.getElementsByClassName("detail-preview");

    if (f == undefined) {
        $('#detailInput').replaceWith(detailImgaes);
        $("#detailInput").on("change", setDetailImages);

        for (var i = 0; i < imgDetail.length; i++) {
            imgDetail[i].src = imgDetail[i].src;
        }
        return;
    } else {
        var max = 3;
        var files = $("#detailInput")[0].files;

        if (files.length > max) {
            alert("최대 " + max + "개 선택 가능합니다");
            $("#detailInput").val(""); 
            $("#detailInput").on("change", setDetailImages);

            for (var i = 0; i < imgDetail.length; i++) {
                imgDetail[i].src = "../images/danggunInsertDefault.png";
            }            
            return;
        } else {
            detailImageCount++;

            for (var i = 0; i < imgDetail.length; i++) {
                imgDetail[i].src = "../images/danggunInsertDefault.png";
            }

            detailImgaes = $(event.target).clone(true);
            console.log("cloneImage: " + detailImgaes);

            for (var i = 0; i < Math.min(inputDetail.files.length, imgDetail.length); i++) {
                readerDetail = new FileReader();

                (function(index) {
                    console.log(index + "번 onload");
                    readerDetail.onload = function(e) {
                        var image = imgDetail[index];
                        image.src = e.target.result;
                        console.log("O");
                    }
                })(i);
                readerDetail.readAsDataURL(inputDetail.files[i]);
                console.log("올라감");
            }
        }
    }
}
</script>
</body>
</html>