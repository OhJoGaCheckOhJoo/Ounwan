<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-detail-wrap">
	<c:if test="${product ne null}">
		<div id="productInput">
			<div>
				<div>물품명</div>
	        	<textarea id="productName" placeholder="물품 이름을 입력해주세요">${product.name}</textarea>
			</div>
	    	<div>
	    		<div>옵션<button id="optionButton">추가/수정</button></div>
		        <select id="options">
		        	<option hidden>옵션</option>
		        	<c:forEach var="option" items="${product.options}">
						<option value="${option.coupungOptionNumber}">${option.name}</option>	        	
		        	</c:forEach>
		        </select>
		        <div id="optionUpdate">
		        	<div>옵션 추가/수정</div>
		        	<input type="text" placeholder="추가할 옵션을 입력해주세요">
		        	<button>추가</button>
		        	<div id="optionList">
			        	<c:forEach var="option" items="${product.options}">
							<div>${option.name}<button value="${option.coupungOptionNumber}">삭제</button></div>      	
			        	</c:forEach>
		        	</div>
		        	<a>닫기</a>
		        </div>
	    	</div>
	        <div>
	        	<div>가격</div>
	        	<input id="productPrice" placeholoder="가격을 입력해주세요" value="${product.price}">
	        </div>
	        <div>
		        <div>재고 수량</div>
		        <input id="availableStock" type="number" placeholder="재고 수량을 입력해주세요." value="${product.availableStock}">
	        </div>
	        <div>
	        	<div>메인 이미지</div>
		        <img id="mainImg" src="${product.image[0].url}">
		        <div id="mainImgInput">
		        	<div>메인 이미지 수정</div>
		        	<input type="text">
		        	<button id="mainImgUpdate">수정</button>
		        	<button id="mainImgCancel">취소</button>
		        </div>
	        </div>
	        <div>
	        	<div>서브 이미지</div>
		        <c:forEach var="i" begin="1" end="${product.image.size() - 1}">
					<img src="${product.image[i].url}">
		        </c:forEach>
	        </div>
	        <div>
	        	<div>상품 설명</div>
	        	<c:forEach var="detailImg" items="${product.detailImages}">
		       		<img src="${detailImg.url}">
		       	</c:forEach>
	        </div>
	       	<button>수정</button>
	    </div>
	</c:if>

    <div id="productPreview">
    	<div>미리보기</div>
        <div id="namePreview">${product.name}</div>
        <c:if test="${product eq null}">
        	<img id="mainPreview" src="/">
        </c:if>
        <c:if test="${product ne null}">
        	<img id="mainPreview" src="${product.image[0].url}">
        </c:if>
        <div id="subPreview">
        	<c:forEach var="i" begin="1" end="${product.image.size() - 1}">
				<img src="${product.image[i].url}">
	        </c:forEach>
        </div>
        <div id="pricePreview">
        	<c:if test="${product eq null}">
	        	0원
	        </c:if>
	        <c:if test="${product ne null}">
	        	${product.price}
	        </c:if>
        </div>
        <div id="explanationPreview">
        	<c:forEach var="detailImage" items="${product.detailImages}">
        		<img src="${detailImage.url}">
        	</c:forEach>
        </div>
    </div>
    
</div>

<script>
	var deleteOptions = [];
	var optionNum = 0;
	
    $("#pricePreview").html($("#pricePreview").html().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원")

    $("#productName").on("input", function() {
        $("#namePreview").html($(this).val());
    });

    $("#productPrice").on("input", function() {
        $("#pricePreview").html($(this).val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원");
    });

    $("#mainImg").on("click", function() {
    	console.log($("#mainImgInput").css("visibility"));
    	$("#mainImgInput").css("visibility", "visible");
    });

    $("#mainImgUpdate").on("click", function() {
    	$("#mainImgInput").css("visibility", "hidden");
    	$("#mainImg").attr('src', $('#mainImgInput input').val());
    	$("#mainPreview").attr('src', $('#mainImgInput input').val());
    });
    
    $("#mainImgCancel").on("click", function() {
    	$("#mainImgInput input").val("");
    	$("#mainImgInput").css("visibility", "hidden");
    })

    $("#productInput > button").on("click", function() {
    	console.log($("#mainImgInput input").val());
    });
    
    $("#optionButton").on("click", function() {
    	$("#optionUpdate").css("visibility", "visible");
    });
    
    $("#optionUpdate").on("click", "div > button", function() {
    	if($(this).val() > 0) {
    		deleteOptions.push();
    	}
    	$("#options option[value='" + $(this).val() + "']").remove();
    	$(this).parent().css({"visibility": "hidden", "height": "0"});
    });
    
    $("#optionUpdate").on("click", " > button", function() {
    	if($("#optionUpdate > input").val().length > 0) {
    		var inputOption = $("#optionUpdate > input").val();
    		$("#optionUpdate > input").val('');
    		$("#optionList").append(`<div>\${inputOption}<button value="\${optionNum}">삭제</button></div>  `);
    		$("#options").append(`<option value="\${optionNum}">\${inputOption}</option>`);
    		optionNum -= 1;
    	}
    });
    
    $("#optionUpdate a").on("click", function() {
    	$("#optionUpdate > input").val('');
    	$("#optionUpdate").css("visibility", "hidden");
    });
</script>