<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="admin-wrap">
	<div id="aeta-list">빈칸</div>
	<div class="search">
		<select name="option">

			<option value="aetaSearchAll"
				${selectedOption eq 'aetaSearchAll' ? 'selected' : ''}>전체(제목+작성자)</option>
			<option value="aetaSearchTitle"
				${selectedOption eq 'aetaSearchTitle' ? 'selected' : ''}>제목</option>
			<option value="aetaSearchId"
				${selectedOption eq 'aetaSearchId' ? 'selected' : ''}>작성자</option>
		</select>
		<form>
			<input id="inputValue" placeholder="검색어 입력">
			<c:choose>
				<c:when test="${selectedOption eq 'choose'}">
					<input type=button id="searchBtn" value="검색" disabled="disabled">
				</c:when>
				<c:otherwise>
					<input type=button id="searchBtn" value="검색">
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</div>

<script>
	var appPath = "${appPath}";

	function search(page) {

		var obj = {
			"selectedOption" : $('select[name="option"]').val(),
			"inputValue" : $("#inputValue").val(),
			"page" : page
		};
		$.ajax({
			url : appPath + "/admin/aeta/AllList",
			data : obj,
			success : function(response) {
				$('#aeta-list').html(response);
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
