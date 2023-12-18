<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<%-- 모달 --%>
<div id="reportModal" class="reportModal">
  <div id="modalContent">
    <div id="modalBody">
      <span id="closeBtn" onclick="closeReportModal()">&times;</span>
      <div>
      	<div>
      		<div id="reportTitle">
      			OUNWAN
      		</div>
      		<div>
	      		<span class="reportId">신고자</span>
	      		<span>|&nbsp;${clientInfo.clientId}</span>
      		</div>
      		<div>
      			<span class="reportId">피신고자</span>
      			<span id="reportId"></span>
      		</div>
      	</div>
      	<hr>
      	<div id="reportReason">
      		<div>신고 사유를 선택해주세요.</div>
      		<div><input class="reason" value="0" type="checkbox">스팸홍보/도배글입니다.</div>
      		<div><input class="reason" value="1" type="checkbox">음란물입니다.</div>
      		<div><input class="reason" value="2" type="checkbox">불법정보를 포함하고 있습니다.</div>
      		<div><input class="reason" value="3" type="checkbox">청소년에게 유해한 내용입니다.</div>
      		<div><input class="reason" value="4" type="checkbox">욕설/생명경시/혐오/차별적 게시물입니다.</div>
      		<div><input class="reason" value="5" type="checkbox">개인정보 노출 게시물입니다.</div>
      		<div><input class="reason" value="6" type="checkbox">불쾌한 표현이 있습니다.</div>
      		<div><input class="reason" value="7" type="checkbox">불법촬영물 등이 포함되어 있습니다.</div>
      		<button id="reportSubmit">신고하기</button>
      	</div>
      </div>
    </div>
  </div>
</div>
<!-- 배경 회색 불투명도 -->
<div id="reportModalOverlay" class="report-modal-overlay" onclick="closeReportModal()"></div>