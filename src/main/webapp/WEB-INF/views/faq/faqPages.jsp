<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="page" begin="1" end="${pages}">
	<button value="${page}" class="faq-page-btn<c:if test="${page eq 1}"> selected</c:if>">
		[${page}]
	</button>
</c:forEach>