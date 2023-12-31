<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-detail-wrap">
	<c:if test="${product ne null}">
		<div id="productInput">
	    	<div>물품명</div>
	        <textarea id="productName" placeholder="물품 이름을 입력해주세요">${product.name}</textarea>
	        <div>옵션</div>
	        <%--
	        <select>
	        	<option hidden>옵션</option>
	        	<c:forEach>
	        	
	        	</c:forEach>
	        </select>
	         --%>
	        <div>가격</div>
	        <input id="productPrice" placeholoder="가격을 입력해주세요" value="${product.price}">
	        <div>메인 이미지</div>
	        <img src="${product.image[0].url}">
	        <div>서브 이미지</div>
	        <c:forEach var="i" begin="1" end="${product.image.size()}">
				<img src="${product.image[i].url}">
	        </c:forEach>
	        <div>재고 수량</div>
	        <input id="availableStock" type="number" placeholder="재고 수량을 입력해주세요." value="${product.availableStock}">
	       	<c:forEach var="detailImg" items="${product.detailImages}">
	       		<img src="${detailImg.url}">
	       	</c:forEach>
	       	<button>수정</button>
	    </div>
	</c:if>

    
   	<%--
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
     --%>
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
    	} else if($("#productPrice").val() <= 0) {
    		alert("상품가격을 입력해주세요.");
    	} else if(mainImage.length == 0) {
    		alert("상품 메인이미지를 등록해주세요.");
    	} else if($("#availableStock").val() <= 0) {
    		alert("재고 수량을 입력해주세요.");
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
            formData.set("availableStock", $("#availableStock").val());
            
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