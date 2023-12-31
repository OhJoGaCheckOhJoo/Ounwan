<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/nav.css" rel="stylesheet" />
<link href="${appPath}/css/danggunInsert.css" rel="stylesheet" />
<link href="${appPath}/css/danggunProhibitedListModal.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
</head>
<body> 
    <!-- header -->
<%@ include file="../common/header.jsp" %>

    <div class="container">
        <%@ include file="../common/nav.jsp" %>	
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
               <div class="prohibit-list" id="prohibitedList">
                    <button onclick="openProhibitedListModal()">거래금지 품목 보기</button>
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
            <button id="submitButton" class="submit-button">등록</button> 
        </div>      
    </div>
<hr>
​<%@ include file="../common/footer.jsp"%>


<%@ include file="./danggunProhibitedListModal.jsp"%>
<script src="../js/danggunProhibitedListModal.js"></script>
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