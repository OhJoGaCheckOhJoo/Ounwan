<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-detail-wrap">
	<div id="productInput">
		<div>
			<div>물품명</div>
        	<textarea id="productName" placeholder="물품 이름을 입력해주세요"></textarea>
		</div>
        <div>
        	<div>가격</div>
        	<input id="productPrice" placeholoder="가격을 입력해주세요" value="0">
        </div>
        <div>
	        <div>재고 수량</div>
	        <input id="availableStock" type="number" placeholder="재고 수량을 입력해주세요." value="1">
        </div>
        <div>
        	<div>카테고리</div>
        	<select id="selectCategory">
        		<option value="0" hidden>카테고리</option>
        		<c:forEach var="category" items="${categories}">
        			<option value="${category.COUPUNG_CATEGORY_NUMBER}">${category.NAME}</option>
        		</c:forEach>
        	</select>
        </div>
        <div>
    		<div><button id="optionButton">옵션 추가/삭제</button></div>
	        <div id="optionUpdate">
	        	<div>옵션 추가/삭제</div>
	        	<input type="text" placeholder="추가할 옵션을 입력해주세요">
	        	<button>추가</button>
	        	<div id="optionList"></div>
	        	<a>닫기</a>
	        </div>
    	</div>
        <div>
        	<div>메인 이미지</div>
	        <img id="mainImg" src="${appPath}/images/add_image.png">
	        <div id="mainImgInput">
	        	<div>메인 이미지 입력</div>
	        	<input type="text">
	        	<button id="mainImgUpdate">입력</button>
	        	<button id="mainImgCancel">취소</button>
	        </div>
        </div>
        <div>
        	<button id="subImgBtn">서브 이미지</button>
        	<div id="subImageList">
        		<div>서브 이미지</div>
        		<div>
        			<input type="text">
        			<button>추가</button>
        		</div>
        		<div id="subImageWrap"></div>
		        <div><a>닫기</a></div>
        	</div>
        </div>
        <div>
        	<button id="detailImgBtn">디테일 이미지</button>
        	<div id="detailImageList">
        		<div>디테일 이미지</div>
        		<div>
        			<input type="text">
        			<button>추가</button>
        		</div>
        		<div id="detailImageWrap"></div>
		       	<div><a>닫기</a></div>
	       	</div>
        </div>
       	<button>추가</button>
    </div>

    <div id="productPreview">
    	<div>미리보기</div>
        <div id="namePreview">상품명</div>
        <img id="mainPreview" src="/">
        <div id="subPreview"></div>
        <div id="pricePreview">0</div>
        <div id="explanationPreview"></div>
    </div>
    
</div>

<script>
	var options = [];
	var images = ["."];
	var detailImages = [];
	var optionNum = 0;
	
    $("#pricePreview").html($("#pricePreview").html().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원")

    $("#productName").on("input", function() {
        $("#namePreview").html($(this).val());
    });

    $("#productPrice").on("input", function() {
        $("#pricePreview").html($(this).val().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원");
    });

    $("#mainImg").on("click", function() {
    	$("#mainImgInput").css("visibility", "visible");
    });

    $("#mainImgUpdate").on("click", function() {
    	images[0] = $('#mainImgInput input').val();
    	$("#mainImgInput").css("visibility", "hidden");
    	$("#mainImg").attr('src', $('#mainImgInput input').val());
    	$("#mainPreview").attr('src', $('#mainImgInput input').val());
    });
    
    $("#mainImgCancel").on("click", function() {
    	$("#mainImgInput input").val("");
    	$("#mainImgInput").css("visibility", "hidden");
    })
    
    $("#optionButton").on("click", function() {
    	$("#optionUpdate").css("visibility", "visible");
    });
    
    $("#optionUpdate").on("click", "div > button", function() {
    	if($(this).val() > 0) {
    		deleteOptions.push($(this).val());
    	} else {
    		addOptions[$(this).val() * -1] = "";
    	}
    	$("#options option[value='" + $(this).val() + "']").remove();
    	$(this).parent().css({"visibility": "hidden", "height": "0"});
    });
    
    $("#optionUpdate").on("click", " > button", function() {
    	if($("#optionUpdate > input").val().length > 0) {
    		var newOption = $("#optionUpdate > input").val();
    		$("#optionUpdate > input").val('');
    		$("#optionList").append(`<div>\${newOption}<button value="\${optionNum}">삭제</button></div>  `);
    		$("#options").append(`<option value="\${optionNum}">\${newOption}</option>`);
    		addOptions.push(newOption);
    		optionNum -= 1;
    	}
    });
    
    $("#optionUpdate a").on("click", function() {
    	$("#optionUpdate > input").val('');
    	$("#optionUpdate").css("visibility", "hidden");
    });
    
    $("#subImgBtn").on("click", function() {
    	$("#subImageList").css("visibility", "visible");
    });
    
    $("#subImageList a").on("click", function() {
    	$("#subImageList").css("visibility", "hidden");
    });
    
    $("#detailImgBtn").on("click", function() {
    	$("#detailImageList").css("visibility", "visible");
    });
    
    $("#detailImageList a").on("click", function() {
    	$("#detailImageList").css("visibility", "hidden");
    });
    
    $("#subImageWrap").on("click", "img", function() {
    	var index = 0;
    	for(var i = 0; i < $("#subPreview img").length; i++) {
    		if($("#subPreview img").eq(i).attr('src') == $(this).attr('src')) {
    			index = i;
    		}
    	}
   		for(var i = 1; i < images.length; i++) {
   			if($(this).attr('src') == images[i]) {
   				images[i] = '.';
   				break;
   			}
   		}
    	$("#subPreview img").eq(index).remove();
		$(this).remove();
    });
    
    $("#subImageList button").on("click", function() {
    	var input = $("#subImageList input").val();
    	if(input.length > 0) {
    		$("#subImageWrap").append(`<img src="\${input}">`);
    		$("#subPreview").append(`<img src="\${input}">`);
    		images.push(input);
    	}
    });
    
    $("#detailImageWrap").on("click", "img", function() {
    	var index = 0;
    	for(var i = 0; i < $("#explanationPreview img").length; i++) {
    		if($("#explanationPreview img").eq(i).attr('src') == $(this).attr('src')) {
    			index = i;
    		}
    	}
   		for(var i = 1; i < detailImages.length; i++) {
   			if($(this).attr('src') == detailImages[i]) {
   				detailImages[i] = '.';
   				break;
   			}
   		}
    	$("#explanationPreview img").eq(index).remove();
		$(this).remove();
    });
    
    $("#detailImageList button").on("click", function() {
    	var input = $("#detailImageList input").val();
    	if(input.length > 0) {
    		$("#detailImageWrap").append(`<img src="\${input}">`);
    		$("#explanationPreview").append(`<img src="\${input}">`);
    		detailImages.push(input);
    	}
    });
    
    $("#productInput > button").on("click", function() {
    	if($("#productName").val().length == 0) {
    		alert("상품명을 입력해주세요.");
    	}
    	else if($("#selectCategory").val() == 0) {
    		alert("카테고리를 선택해주세요.");
    	} else if ($("#productPrice").val() < 0) {
    		alert("가격을 올바르게 입력해주세요.");
    	} else if (images[0] == ".") {
    		alert("메인 이미지를 등록해주세요.");
    	} else if(options.length == 0) {
    		alert("옵션을 추가해주세요.");
    	} else {
    		var obj = {
   	    		'coupungCategoryNumber': $("#category").val(),
   	    		'name': $("#productName").val(),
   	    		'price': $("#productPrice").val(),
   	    		'availableStock': $('#availableStock').val(),
   	    		'options': options,
   	    		'images': images,
   	    		'detailImages': detailImages
   	    	};
   	    	$.ajax({
   	        	url: "${appPath}/admin/coupung/insert.do",
   	        	type: 'post',
   	        	data: obj,
   	        	traditional: true,
   	        	success: function(res) {
   	        		if(res == 'success') {
   	        			alert("수정하였습니다.");
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
   	               			}
   	                	});
   	        		}
   	        	}
   	        });
    	}
    });
</script>