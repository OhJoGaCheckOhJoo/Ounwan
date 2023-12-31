<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div id="reportModal" class="report-modal">
  <div id="modalContent">
    <div id="modalBody" class="modal-body"> 
      <span id="closeBtn" class="close-button" onclick="closeReportModal()">&times;</span>
      <div>
      	<div>
      		<div id="reportTitle" class="report-title">
      			OUNWAN
      		</div>
      		<div>
	      		<span class="report-id">신고자</span>
	      		<span>|&nbsp;&nbsp;&nbsp;&nbsp;${userInfo.clientId}</span>
      		</div>
      		<div>
      			<span class="report-id">피신고자</span>
      			<span id="reportId">|&nbsp;&nbsp;&nbsp;&nbsp;${post.clientId}</span>
      		</div>
      	</div>
      	<hr class="reportHr">
      	<div id="reportReason" class="report-reason">
      		<div>신고 사유를 선택해주세요.</div>
      		<div><label><input class="reason" name="reportReason" value="0" type="radio">스팸홍보/도배글입니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="1" type="radio">음란물입니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="2" type="radio">불법정보를 포함하고 있습니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="3" type="radio">청소년에게 유해한 내용입니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="4" type="radio">욕설/생명경시/혐오/차별적 게시물입니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="5" type="radio">개인정보 노출 게시물입니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="6" type="radio">불쾌한 표현이 있습니다.</label></div>
      		<div><label><input class="reason" name="reportReason" value="7" type="radio">불법촬영물 등이 포함되어 있습니다.</label></div>
      		<button id="reportSubmit" class="danggun-report-button">신고하기</button>
      	</div>
      </div>
    </div>
  </div>
</div>

<div id="reportModalOverlay" class="report-modal-overlay" onclick="closeReportModal()"></div> 
<div id="reportSelectModal" postClientId="${post.clientId}" danggunNumber="${post.danggunNumber}" sessionClientId="${userInfo.clientId}"></div>