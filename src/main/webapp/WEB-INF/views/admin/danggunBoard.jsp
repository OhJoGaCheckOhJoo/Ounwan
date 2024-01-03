<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="product-wrap">
	<div class="adminProductSearch">
		<div>
			<input id="inputValue" placeholder="검색어를 입력하세요.">
			<input type=button id="searchBtn" value="검색">
		</div>
	</div>
	<div id="danggun-list"></div>
</div>

<script>
	var appPath = "${appPath}";

	function search(page) {

		var obj = {
			"inputValue": $("#inputValue").val(),
			"page" : page
		};
		$.ajax({
			url : appPath + "/admin/danggun/AllList",
			data : obj,
			success : function(response) {
				$('#danggun-list').html(response);
			}
		});
	}

	$("#searchBtn").click(function() {
		search(1);
	});

	$("#inputValue").keypress(function(event) {
		if (event.which === 13) {
			event.preventDefault();
			search();
		}
	});

	$(function() {
		search(1);
	});	
</script>
