<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="faq" items="${faqList}">
	<div class="faq-content">
		<a>
			<span class="faq-num">${faq.faqNumber}</span>
			<div>[${faq.category}] ${faq.question}</div>
		</a>
		<div class="faq-detail">
			${faq.answer}
		</div>
	</div>
</c:forEach>