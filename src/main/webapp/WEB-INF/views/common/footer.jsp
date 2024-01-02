<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<footer>
	<div class="footer">
		<div class="footer-wrap-1">
			<div>
				 <a class="logo" href="${appPath}/"></a>
			</div>
			<div class="ounwan-info-1">
				<div class="location-info">
					<img class="location" src="${appPath}/images/location_icon.png" alt="location" />
					<span>03993 서울특별시 마포구 월드컵북로4길 77, 1층</span>
				</div>
				<div class="other-info">
					<div class="phone-info">
						<img class="phone" src="${appPath}/images/phone_icon.png" alt="phone" />
						<span>010-9424-2784</span>
					</div>
					<div class="fax-info">
						<img class="fax" src="${appPath}/images/fax_icon.png" alt="fax" />
						<span>(123)456-7890</span>
					</div>
				</div>
				<div class="social-media">
					<div class="social-media-title">
						<span>SNS</span>
					</div>
					
						<a href="#">
							<img class="instagram" src="${appPath}/images/Instagram_icon.png" alt="instagram"/>
						</a>
						<a href="#">
							<img class="google" src="${appPath}/images/Google_icon.png" alt="google"/>
						</a>
						<a href="#">
							<img class="github" src="${appPath}/images/Github_icon.png" alt="github"/>
						</a>
						<a href="#">
							<img class="figma" src="${appPath}/images/Figma_icon.png" alt="figma"/>
						</a>
				</div>
			</div>
		</div>
		<div class="footer-wrap-2">
			<div class="footer-text-1">
				<span>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</span>
			</div>
			<div class="footer-text-2">
				<span>Copyright © 2023 • Ounwan.</span>
			</div>
		</div>
	</div>

<!-- 	<div>
		<div>오운완 쇼핑몰 & 커뮤니티</div>
		<div>대표자 : 김태완, 박정우, 박지원, 방은지, 신서영, 윤윤성</div>
		<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층</div>
		<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
		<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
		<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
	</div>
	<div class="float-right">
		<br>
		<br>
		<div>
			<a href="#">이벤트</a>
		</div>
		<div>
			<a href="#">개인정보처리방침</a>
		</div>
		<div>
			<a href="#">이용약관</a>
		</div>
		<div>
			<img class="float-right img-1 pointer" src="${appPath}/images/insta.png">
		</div>
	</div>
 -->
</footer>
