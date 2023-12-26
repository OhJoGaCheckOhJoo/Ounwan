<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-detail-wrap">
    <div id="productInput">
    	<div>물품명</div>
        <textarea id="productName" placeholder="물품 이름을 입력해주세요"></textarea>
        <label for="mainImage">👉 메인이미지 👈</label>
        <input id="mainImage" name="mainImage" type="file" accept="image/*">
        <label for="subImage">👉 서브이미지 👈</label>
        <input id="subImage" name="subImage" type="file" accept="image/*" multiple>
        <div>가격</div>
        <input id="productPrice" type="number" placeholder="가격을 입력해주세요">
        <label id="explanationLabel" for="explanationImg">👉 설명이미지 👈</label>
        <input id="explanationImg" name="explanationImg" type="file" accept="image/*" multiple>
        <c:if test="${product eq null}">
        	<button>등록</button>
        </c:if>
        <c:if test="${product ne null}">
        	<button>수정</button>
        </c:if>
    </div>
    <div id="productPreview">
    	<div>미리보기</div>
        <div id="namePreview">${product.name}</div>
        <c:if test="${product.mainImage eq null}">
        	<img id="mainPreview" src="/">
        </c:if>
        <c:if test="${product.mainImage ne null}">
        	<img id="mainPreview" src="${product.mainImage}">
        </c:if>
        <div id="subPreview">
        	<c:forEach var="subImage" items="${product.subImages}">
        		<img src="${subImage}">
        	</c:forEach>
        </div>
        <div id="pricePreview">
        	<c:if test="${product.price eq null}">
	        	0원
	        </c:if>
	        <c:if test="${product.mainImage ne null}">
	        	${product.price}
	        </c:if>
        </div>
        <div id="explanationPreview">
        	<c:forEach var="explanationImage" items="${product.explanationImages}">
        		<img src="${explanationImage}">
        	</c:forEach>
        </div>
    </div>
</div>

<script>
    var mainImage = "";
    var subImage = [];
    var explanationImg = [];
    var reader = new FileReader(); 

    $("#productName").on("input", function() {
        $("#namePreview").html($(this).val());
    });

    $("#productPrice").on("input", function() {
        $("#pricePreview").html($(this).val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원");
    });

    $("#mainImage").on("change", function(e) {
        if(e.target.files.length > 0) {
            mainImage = e.target.files[0];
            reader.onload = function(read) {
                $("#mainPreview").attr("src", read.target.result);
            }
            reader.readAsDataURL(mainImage);
            $("#mainPreview").attr("hidden", false);
        }
    });

    $("#subImage").on("change", function(e) {
        if(e.target.files.length > 0) {
            $("#subPreview").html("");
            subImage = e.target.files;
            for(var i = 0; i < subImage.length; i++) {
                $("#subPreview").append('<img src="/">');
                var imageURL = URL.createObjectURL(subImage[i]);
                $("#subPreview img").eq(i).attr("src", imageURL);
            }
        }
    });

    $("#explanationImg").on("change", function(e) {
        if(e.target.files.length > 0) {
            $("#explanationPreview").html("");
            explanationImg = e.target.files;
            for(var i = 0; i < explanationImg.length; i++) {
                $("#explanationPreview").append('<img src="/">');
                var imageURL = URL.createObjectURL(explanationImg[i]);
                $("#explanationPreview img").eq(i).attr("src", imageURL);
            }
        }
    });

    $("#productInput button").on("click", function() {
    	if($("#productName").val().length == 0) {
    		alert("상품명을 입력해주세요.");
    	} else if($("#productPrice").val().length == 0) {
    		alert("상품가격을 입력해주세요.");
    	} else if(mainImage.length == 0) {
    		alert("상품 메인이미지를 등록해주세요.");
    	} else {
    		var formData = new FormData();
            
            formData.set("mainImage", mainImage);
            for(var i = 0; i < subImage.length; i++) {
            	formData.append('subImage', subImage[i]);
            }
            for(var i = 0; i < explanationImg.length; i++) {
            	formData.append('explanationImg', explanationImg[i]);
            }
            formData.set("name", $("#productName").val());
            formData.set("price", $("#productPrice").val());
            
            $.ajax({
            	url: "${appPath}/admin/coupung/addProduct",
            	data: formData,
            	type: 'post',
            	enctype: "multipart/form-data",
            	contentType: false,
            	processData: false,
            	success: function() {
            		console.log(1);
            	}
            });
    	}
    });
</script>