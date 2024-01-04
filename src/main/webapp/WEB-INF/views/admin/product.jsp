<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-wrap">
    <div id="adminProductSearch">
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
                <span>이름</span>
                <span>가격</span>
                <span>카테고리</span>
                <span>재고</span>
                <span>옵션</span>
                <span>판매량</span>
                <span>판매여부</span>
            </div>
            <c:forEach var="product" items="${productList}">
            	<div class="product-info">
                <input type="checkbox" value="${product.coupungNumber}">
                <span>${product.name}</span>
                <span>${product.price}</span>
                <span>${product.category}</span>
                <span>${product.availableStock}</span>
               	<select>
            		<option hidden>옵션</option>
               		<c:forEach var="option" items="${product.options}">
                		<option value="${option.coupungOptionNumber}">${option.name}</option>
               		</c:forEach>
               	</select>
                <span>${product.salesRate}</span>
                <c:if test="${product.availableCheck}">
                	<button value="${product.coupungNumber}">판매중</button>
                </c:if>
                <c:if test="${!product.availableCheck}">
                	<button value="${product.coupungNumber}">판매 중단</button>
                </c:if>
                <div>
                    <h3>${product.name}</h3>
                    <img src="${product.image[0].url}">
                    <button class="updateBtn" value="${product.coupungNumber}">상품 수정</button>
                    <c:if test="${product.availableCheck}">
                    	<button class="stopBtn" value="${product.coupungNumber}">판매 중단</button>
                    </c:if>
                    <c:if test="${!product.availableCheck}">
                    	<button class="restartBtn" value="${product.coupungNumber}">판매 재개</button>
                    </c:if>
                </div>
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
    var searchOption = '${searchOption}';
    var searchValue = '${searchValue}';
    var sortOption = '${sortOption}';

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

    $("#productList").on("click", ".product-info > button", function() {
    	var button = $(this);
        if(button.html() == "판매중") {
            if(confirm("판매를 중지하시겠습니까?")) {
                var obj = {
                    "productList": [$(this).val()]
                };
                $.ajax({
                	url: "${appPath}/admin/coupung/stopSales.do",
                	data: obj,
                	traditional: true,
                	success: function(res) {
                		if(res == 'success') {
                			button.html('판매 중단');
                			alert("해당 물품을 판매 중지하였습니다.");
                		}
                	},
    				error: function(request, status, error) {
    	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    	            }
                });
            }
        } else {
            if(confirm("판매를 시작하시겠습니까?")) {
                var obj = {
                    "productList": [$(this).val()]
                };
                $.ajax({
                	url: "${appPath}/admin/coupung/startSales.do",
                	data: obj,
                	traditional: true,
                	success: function(res) {
                		if(res == 'success') {
                			alert("해당 물품을 판매 시작했습니다.");
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
                		}
                	},
    				error: function(request, status, error) {
    	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    	            }
                });
            }
        }
    });
    
    $("#productList").on("click", ".stopBtn", function() {
    	var button = $(this);
    	if(confirm("판매를 중지하시겠습니까?")) {
            var obj = {
                "productList": [$(this).val()]
            };
            $.ajax({
            	url: "${appPath}/admin/coupung/stopSales.do",
            	data: obj,
            	traditional: true,
            	success: function(res) {
            		if(res == 'success') {
            			alert("해당 물품을 판매 중지하였습니다.");
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
            		}
            	},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
            });
        }
    });
    
	$("#productList").on("click", ".restartBtn", function() {
		var button = $(this);
		if(confirm("판매를 재개하시겠습니까?")) {
            var obj = {
                "productList": [$(this).val()]
            };
            $.ajax({
            	url: "${appPath}/admin/coupung/startSales.do",
            	data: obj,
            	traditional: true,
            	success: function(res) {
            		if(res == 'success') {
            			alert("해당 물품을 판매 시작하였습니다.");
            		}
            	},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
            });
        }
    });

    var productInfo = "";
    $("#productList").on("click", ".product-info span", function() {
        if($(this).parent().find('div').css("display") == "none") {
            if(productInfo != "") {
                productInfo.css("display", "none");
            }
            productInfo = $(this).parent().find('div');
            $(this).parent().find('div').css("display", "block");
        } else {
            productInfo = "";
            $(this).parent().find('div').css("display", "none");
        }
    });

    $("#productList").on("click", ".product-info div", function() {
        $(this).css("display", "none");
    });
 
    $(".product-info div").on("click", ".updateBtn", function() {
        var obj = {
            "coupungNumber": $(this).val()
        };
        $.ajax({
        	url: "${appPath}/admin/coupung/update.do",
        	data: obj,
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    });

    $(".product-menu input").on("change", function() {
        $(".product-info input").prop('checked', $(this).is(":checked"));
    });

    $("#productPages").on("click", ".page", function() {
        var obj = {
            "offset": ((Number)($(this).html()) - 1) * 20,
            "searchOption": searchOption,
            "searchValue": searchValue,
            "sortOption": sortOption
        };
        $.ajax({
        	url: "${appPath}/admin/coupung/product.do",
        	data: obj,
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    });

    $("#stopSales").on("click", function() {
        if(confirm("상품들의 판매를 중단하시겠습니까?")) {
            var productList = [];
            for(var i = 0; i < $(".product-info input").length; i++) {
                if($(".product-info input").eq(i).is(':checked')) {
                    productList.push($(".product-info input").eq(i).val());
                }
            }
            if(productList.length > 0) {
                var obj = {
                    "productList": productList
                };
                $.ajax({
                	url: "${appPath}/admin/coupung/stopSales.do",
                	data: obj,
                	traditional: true,
                	success: function(res) {
                		if(res == 'success') {
                			alert("해당 물품들을 판매 중지하였습니다.");
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
                		}
                	},
    				error: function(request, status, error) {
    	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    	            }
                });
            } else {
                alert("선택된 상품이 없습니다.");
            }
        }
    });

    $("#startSales").on("click", function() {
        if(confirm("상품들의 판매를 시작하시겠습니까?")) {
            var productList = [];
            for(var i = 0; i < $(".product-info input").length; i++) {
                if($(".product-info input").eq(i).is(':checked')) {
                    productList.push($(".product-info input").eq(i).val());
                }
            }
            if(productList.length > 0) {
                var obj = {
                    "productList": productList
                };
                $.ajax({
                	url: "${appPath}/admin/coupung/startSales.do",
                	data: obj,
                	traditional: true,
                	success: function(res) {
                		if(res == 'success') {
                			alert("해당 물품들을 판매 시작하였습니다.");
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
                		}
                	},
    				error: function(request, status, error) {
    	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    	            }
                });
            } else {
                alert("선택된 상품이 없습니다.");
            }
        }
    });
    
    $("#addProduct").on("click", function() {
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
</script>