<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h1>오운완 회원 안내</h1>
<hr>

<c:if test="${userInfo eq null}">
	<div id="idResult">가입하신 아이디가 없습니다.</div>
	<div id="nonmemberComment">
		<div>*하단의 회원가입을 통해 회원가입 진행이 가능합니다.</div>
	</div>
	<hr>
	<div id="nonmemberBtn">
		<button>회원가입</button>
		<button id="findIdClose">확인</button>
	</div>
</c:if>
<c:if test="${userInfo ne null}">
	<div>
		<div id="findIdResult"><span>${userInfo.name}</span>님 가입하신 아이디입니다.</div>
		<div id="idResult">${userInfo.clientId}</div>
		<div id="memberComment">
			<div>*비밀번호가 생각나지 않으실 경우 임시비밀번호를 통해 재설정하실 수 있습니다.</div>
		</div>
	</div>
	<hr>
	<div id="memberBtn">
		<button>임시비밀번호 발급</button>
		<button id="findIdClose">확인</button>
	</div>
</c:if>
