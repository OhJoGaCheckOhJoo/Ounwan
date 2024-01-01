<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-wrap">
    <div id="danggunProductSearch">
        <select id="searchOption">
            <option value=''>전체조회</option>
            <c:if test='${searchOption eq "name"}'>
            	<option value='1' selected>물품이름</option>
            	<option value='2'>카테고리</option>
            	<option value='3'>판매여부</option>
            </c:if>
            <c:if test='${searchOption eq "category"}'>
            	<option value='1'>물품이름</option>
            	<option value='2' selected>카테고리</option>
            	<option value='3'>판매여부</option>
            </c:if>
            <c:if test='${searchOption eq "availableCheck"}'>
            	<option value='1'>물품이름</option>
            	<option value='2'>카테고리</option>
            	<option value='3' selected>판매여부</option>
            </c:if>
            <c:if test='${searchOption.length() == 0}'>
	            <option value='1'>물품이름</option>
	           	<option value='2'>카테고리</option>
	            <option value='3'>판매여부</option>
            </c:if>
        </select>
        <div>
        	<c:if test='${searchOption eq "name"}'>
            	<input id="searchName" type="text" placeholder="검색할 물품을 입력해주세요.">
            </c:if>
            <c:if test='${searchOption eq "category"}'>
            	<select id="selectCategory">
                    <option hidden>카테고리선택</option>
                    <option value='1'>의류</option>
                    <option value='2'>식품</option>
                    <option value='3'>운동기구</option>
                    <option value='4'>헬스이용권</option>
                </select>
            </c:if>
            <c:if test='${searchOption eq "availableCheck"}'>
            	<select id="selectAvailableCheck">
                    <option hidden>선택</option>
                    <option value='1'>판매중</option>
                    <option value='0'>판매중단</option>
                </select>
            </c:if>
            <c:if test='${searchOption.length() == 0}'>
	            <input type="text" placeholder="검색 조건을 선택해주세요." disabled>
            </c:if>
        </div>
       	<button>검색</button>
    </div>
    <div>
        <div id="option">
            <div id="productOption">
                <button id="addProduct">상품 추가</button>
                <button id="stopSales">일괄 판매 중단</button>
                <button id="startSales">일괄 판매 시작</button>
            </div>
            <div id="sortingOption">
            	<c:if test='${sortOption eq "name"}'>
            		<button value="name" class="selected">이름순</button>
	                <button value="price">가격순</button>
	                <button value="salesRate">총 판매량순</button>
            	</c:if>
                <c:if test='${sortOption eq "price"}'>
            		<button value="name">이름순</button>
	                <button value="price" class="selected">가격순</button>
	                <button value="salesRate">총 판매량순</button>
            	</c:if>
            	<c:if test='${sortOption eq "salesRate"}'>
            		<button value="name">이름순</button>
	                <button value="price">가격순</button>
	                <button value="salesRate" class="selected">총 판매량순</button>
            	</c:if>
            </div>
        </div>
        <div id="productList">
            <div class="product-menu">
                <input type="checkbox">
                <span>제목</span>
                <span>가격</span>
                <span>판매자</span>
                <span>등록일</span>
                <span>판매현황</span>
                <span> sd</span>
            </div>
            <c:forEach var="product" items="${danggun}">
            	<div class="product-info">
	                <input type="checkbox" value="${product.danggunNumber}">
	                <span>${product.productName}</span>
	                <span>${product.price}</span>
	                <span>${product.clientId}</span>
	                <span>${product.uploadDate}</span>
	                <span>${product.tradeHistoryNumber}</span>
	                <a href="${appPath}/danggun/detail?danggunNumber=${product.danggunNumber}">이동</a>
            	</div>
            </c:forEach>
        </div>
        <div id="productPages">
        	<c:forEach var="index" begin="1" end="${pages}">
        		<c:if test="${index eq offset + 1}">
        			<a href="#" class="page selected">${index}</a>
        		</c:if>
        		<c:if test="${index ne offset + 1}">
        			<a href="#" class="page">${index}</a>
        		</c:if>
        	</c:forEach>
        </div>
    </div>
</div>

<script>
	console.log('${offset}');
    var searchOption = '${searchOption}';
    var searchValue = '${searchValue}';
    var sortOption = '${sortOption}';

    // 검색 옵션
    $("#searchOption").on("change", function() {
        if($(this).val() == 1) {
            $("#adminProductSearch div").html('<input id="searchName" type="text" placeholder="검색할 물품을 입력해주세요.">');
            searchOption = "name";
        } else if($(this).val() == 2) {
            $("#adminProductSearch div").html(`
                <select id="selectCategory">
                    <option hidden>카테고리선택</option>
                    <option value='1'>의류</option>
                    <option value='2'>식품</option>
                    <option value='3'>운동기구</option>
                    <option value='4'>헬스이용권</option>
                </select>
            `);
            searchOption = "category";
        } else if($(this).val() == 3) {
            $("#adminProductSearch div").html(`
                <select id="selectAvailableCheck">
                    <option hidden>선택</option>
                    <option value='1'>판매중</option>
                    <option value='0'>판매중단</option>
                </select>
            `);
            searchOption = "availableCheck";
        } else {
        	$("#adminProductSearch div").html('<input type="text" placeholder="검색 조건을 선택해주세요." disabled>');
        	searchOption = '';
        }
        $("#adminProductSearch button").attr("disabled", false);
        searchValue = "";
    });

    $("#adminProductSearch").on("input", "#searchName", function() {
        searchValue = $(this).val();
    });

    $("#adminProductSearch").on("change", "#selectCategory", function() {
        searchValue = $(this).val();
    });

    $("#adminProductSearch").on("change", "#selectAvailableCheck", function() {
        searchValue = $(this).val();
    });

    // 검색
    $("#adminProductSearch button").on("click", function() {
        if(searchValue.length > 0 || searchOption == '') {
            var obj = {
            	"offset": 0,
                "searchOption": searchOption,
                "searchValue": searchValue,
                "sortOption": sortOption
            }
            $.ajax({
            	url: "${appPath}/admin/coupung/product.do",
            	data: obj,
            	success: function(res) {
            		$(".admin-wrap").html(res);
            	}
            });
        } else {
            alert("상세조건을 입력해주세요");
        }
    });

    // 정렬 옵션
    $("#sortingOption button").on("click", function() {
        var obj = {
        	"offset": 0,
            "searchOption": searchOption,
            "searchValue": searchValue,
            "sortOption": $(this).val()
        }
        $.ajax({
        	url: "${appPath}/admin/coupung/product.do",
        	data: obj,
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	}
        });
    });

    // 전체선택, 전체해제
    $(".product-menu input").on("change", function() {
        $(".product-info input").prop('checked', $(this).is(":checked"));
    });

    // 페이징처리
    $("#productPages").on("click", ".page", function() {
        var obj = {
            "offset": ((Number)($(this).html()) - 1) * 20,
            "searchOption": searchOption,
            "searchValue": searchValue,
            "sortOption": sortOption
        };
        console.log(obj);
        $.ajax({
        	url: "${appPath}/admin/coupung/product.do",
        	data: obj,
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	}
        });
    });

    $("#addProduct").on("click", function() {
       	$.ajax({
       		url: "${appPath}/admin/coupung/insert.do",
      			success: function(res) {
      				$(".admin-wrap").html(res);
      			}
       	});
    });
</script>
