<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="order-wrap">
    <div>
        <div id="orderList">
            <div class="order-menu">
                <span>주문번호</span>
                <span>주문자</span>
                <span>가격</span>
                <span>주문일</span>
                <span class="tradeStep">배송상태</span>
            </div>
            <c:forEach var="order" items="${orders}">
            	<div class="order-info">
                <span>${order.ORDER_NUMBER}</span>
                <span>${order.CLIENT}</span>
                <span>${order.TOTAL_PRICE}</span>
                <span>${order.ORDER_DATE}</span>
               	<select>
               		<c:forEach var="step" items="${tradeStep}">
               			<c:if test="${step.TRADE_STEP eq order.TRADE_STEP}">
               				<option value="${step.TRADE_HISTORY_NUMBER}" selected>${step.TRADE_STEP}</option>
               			</c:if>
                		<c:if test="${step.TRADE_STEP ne order.TRADE_STEP}">
               				<option value="${step.TRADE_HISTORY_NUMBER}">${step.TRADE_STEP}</option>
               			</c:if>
               		</c:forEach>
               	</select>
               	<button value="${order.ORDER_NUMBER}">수정</button>
            </div>
            </c:forEach>
        </div>
        <div id="orderPages">
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
	var offset = "${offset}";
	var result = "${result}";
	
	if(result.length > 0) {
		if(result == 'success') {
			alert("배송 상태를 수정하였습니다.");
		} else {
			alert("수정에 실패하였습니다.");
		}
	}
	
	$("#orderList").on("click", ".order-info button", function() {
		var obj = {
				'orderNumber': $(this).val(),
				'tradeStep': $(this).parent().find("select :selected").val(),
				'offset': offset
		};
		$.ajax({
        	url: "${appPath}/admin/coupung/tradeStep.do",
        	data: obj,
        	type: 'post',
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	}
        });
	});
	
	$("#orderPages").on("click", "a", function() {
		offset = (Number)($(this).html()) - 1;
		$.ajax({
    		url: "${appPath}/admin/coupung/order.do",
    		data: {'offset': offset},
    		success: function(res) {
    			$(".admin-wrap").html(res);
    		}
    	});
	});
</script>