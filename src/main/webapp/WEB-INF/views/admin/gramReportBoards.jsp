<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="gram-report-wrap">
    <div>
        <div id="gramBoardList">
            <div class="gram-board-menu">
                <input type="checkbox">
                <span>게시글번호</span>
                <span>작성자</span>
                <span>내용</span>
                <span>해시태그</span>
                <span>작성일</span>
                <span>신고횟수</span>
                <span>차단여부</span>
            </div>
            <c:forEach var="board" items="${boards}">
            	<div class="gram-board-info">
                <input type="checkbox" value="${board.COMMUNITY_NUMBER}">
                <span>${board.COMMUNITY_NUMBER}</span>
                <span>${board.CLIENT_ID}</span>
                <span>${board.CONTENTS}</span>
                <select>
            		<option hidden>해시태그</option>
               		<c:forEach var="hashTag" items="${board.hashTags}">
                		<option>hashTag</option>
               		</c:forEach>
               	</select>
                <span>${board.CREATED_DATE}</span>
                <span>${board.REPORT_NUM}</span>
                <c:if test="${board.VISIBILITY eq 1}">
                	<button value="${board.COMMUNITY_NUMBER}">정상게시</button>
                </c:if>
                <c:if test="${board.VISIBILITY eq 0}">
                	<button value="${board.COMMUNITY_NUMBER}">임시차단</button>
                </c:if>
                <div>
                    <h3>${board.CLIENT_ID}</h3>
                    <img src="${board.IMAGE_URL}">
                    <div>
                    	<div>
                    		<span>신고자</span>
                    		<span>사유</span>
                    		<span>신고일</span>
                    	</div>
                    	<c:forEach var="report" items="${board.reportInfo}">
                    		<div>
                    			<span>${report.CLIENT_ID}</span>
                    			<span>${report.REASON}</span>
                    			<span>${report.REGISTERED_DATE}</span>
                    		</div>
                    	</c:forEach>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>