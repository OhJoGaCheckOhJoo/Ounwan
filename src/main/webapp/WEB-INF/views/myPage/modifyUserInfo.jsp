<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/modifyUserInfo.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<div class="mypage-subtitle">회원정보 수정</div>
<div class="modifyUserInfo-container">
	
 	<div class="modifyUserInfo-container-wrap">
		<div class="profile-photo">
			<img class="profile-photo-file" src="${clientInfo.profileUrl}" id="registerProfileImage">
			<label for="uploadImageInput" class="custom-file-upload">
	    		<i class="fas fa-cloud-upload-alt"></i> 사진수정
			</label>
			<input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*" />
			<br> <br>
		</div>
	
		<div class="profile-info">
	
			<div class="profile-name">
	
				<label class="attribute-name" for=""> 이름</label> <input type="text"
					class="input-form" value="${clientInfo.name}" readonly />
			</div>
			<div class="profile-id">
				<label class="attribute-name" for="">아이디</label> <input type="text"
					class="input-form" value="${clientInfo.clientId}" readonly />
			</div>
	
			<div class="profile-email">
				<label class="attribute-name" for="">이메일</label> <input type="email"
					class="input-form" value="${clientInfo.email}" readonly />
	
			</div>
			<div class="profile-phone">
				<label class="attribute-name" for="">연락처</label> <input type="text"
					class="input-form" value="${clientInfo.phone}" id="phoneNum" />
			</div>
			
			<div class="profile-password">
				<label class="attribute-name" for="">비밀번호</label>
				<button id="modifyPwdBtn">수정</button>
			</div>
	
			<div id="myModal" class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<div class="profile-password">
						<label class="modal-attribute-name" for="">비밀번호</label> 
						<input type="password" class="modal-input-form" id="firstPass" placeholder="비밀번호를 입력하세요"> 
						<span id="wrongForm-inform">잘못된	형식입니다.</span>
					</div>
					<div class="profile-password">
						<label class="modal-attribute-name" for="">비밀번호 확인</label> 
						<input type="password" class="modal-input-form" placeholder="비밀번호를 입력하세요"	id="secondPass" required /> 
						<span id="notMatch-inform">비밀번호가 일치하지 않습니다.</span>
					</div>
					<button id="savePassword">저장</button>
				</div>
			</div>
	
			<div class="profile-address">
				<label class="attribute-name" for="">주소</label> <input
					class="form-address-" size="10" id="zipCode"
					value="${clientInfo.zipCode}" />
				<button id="findAddr" type="button" class="zip-code-button">우편번호 검색</button>
				<br> <label class="attribute-name" for=""></label> <input
					class="form-address" size="35" id="addr" value="${clientInfo.address}" />
				<br> <label class="attribute-name" for=""></label> <input
					class="form-address" size="35" id="addrDetail"
					value="${clientInfo.addressDetail}" />
			</div>
	
			<br>
	
			<div class="modify-button">
				<button id='submitBtn' type='button'>완료</button>
			</div>
		</div>
 	</div>
</div>
<br>
 <div class="withdrawl-btn-container">
 	<button id='withdrawlBtn' type='button'>탈퇴하기</button>
 </div>
 <!-- 모달창 -->
<div id="myModal2" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        	<div class="withdrawl-container">
		        <div class="withdrawl-container-wrap">
		            <label class="modal-attribute-name" for="storagePeriod">정보 저장 기간 선택</label>
		            <select id="storagePeriod" class="modal-input-form">
		                <option value="3">3개월</option>
		                <option value="6">6개월</option>
		                <option value="12">1년</option>
		                <option value="0">즉시</option>
		            </select>
		        </div>
		     	<div class="withdrawl-Completed-btn">
       		 		<button id="withdrawlCompleted">완료</button>
       		 	</div>
     	 </div>
	</div>
</div>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	var phone = "";
	$('#phoneNum').on('input',function() {
						if ($(this).val().length < 14) {
							$(this).val($(this).val().replace(/[^0-9]/g, '')
													.replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g,"$1-$2-$3"));
							phone = $(this).val();
						} else {
							$(this).val(phone);
						}
					});

	$('#firstPass').on('input',function() {
						var password = $('#firstPass').val();
						var passwordFormat = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;

						if (!passwordFormat.test(password)) {
							$('#wrongForm-inform').css('visibility', 'visible');
						} else {
							$('#wrongForm-inform').css('visibility', 'hidden');
						}

					});

	$('#secondPass').on('input', function() {
		var firstPassword = $('#firstPass').val();
		var secondPassword = $('#secondPass').val();

		if (firstPassword != secondPassword) {
			$('#notMatch-inform').css('visibility', 'visible');
		} else {
			$('#notMatch-inform').css('visibility', 'hidden');
		}

	});

	$('#findAddr').on(
			'click',
			function() {
				new daum.Postcode(
						{
							oncomplete : function(data) {
								var addr = '';
								var extraAddr = '';

								if (data.userSelectedType === 'R') {
									addr = data.roadAddress;
								} else {
									addr = data.jibunAddress;
								}

								if (data.userSelectedType === 'R') {

									if (data.bname !== ''
											&& /[동|로|가]$/g.test(data.bname)) {
										extraAddr += data.bname;
									}

									if (data.buildingName !== ''
											&& data.apartment === 'Y') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}

									if (extraAddr !== '') {
										extraAddr = ' (' + extraAddr + ')';
									}
								}

								$('#zipCode').val(data.zonecode);
								$('#addr').val(addr);
								$('#addrDetail').attr('readOnly', false);

								$('#addrDetail').focus();
							}
						}).open();

			});

	// 수정 버튼 클릭 시 모달 열기
	var modal = document.getElementById("myModal");
	var btn = document.getElementById("modifyPwdBtn");
	var closeBtn = document.querySelector("#myModal .close")

	btn.onclick = function() {
		modal.style.display = "block";
	}

	closeBtn.onclick = function() {
		modal.style.display = "none";
	}

	// 모달 콘텐츠 외부를 클릭했을 때 모달이 닫히도록 함
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}

	$('#savePassword').on('click',function() {
						var firstPass = $('#firstPass').val();
						var secondPass = $('#secondPass').val();

						// 비밀번호 확인
						if (firstPass !== secondPass) {
							document.getElementById("notMatch-inform").style.display = "block";
							return; // 비밀번호가 일치하지 않으면 중단
						}

						// 클라이언트 정보를 담은 DTO
						var obj = {
							clientId : "${clientInfo.clientId}", // 클라이언트 ID
							password : secondPass
						// 새 비밀번호
						};

						$.ajax({
							url : "${appPath}/myPage/modifyUserInfo/pwd", // 정보 변경을 위한 URL
							type : "post",
							data : JSON.stringify(obj), // DTO 전달
							contentType : 'application/json',
							success : function(res) {
								console.log(res);
								if (res === 'success') {
									alert("비밀번호가 변경되었습니다!");
									modal.style.display = "none";
								} else {
									alert("비밀번호 변경에 실패했습니다.");
								}
							},
							error : function(request, status, error) {
								alert("code:" + request.status + "\n"
										+ "message:" + request.responseText
										+ "\n" + "error:" + error);
							}
						});
					});

	var formData = new FormData();
	var imgUrl = '';
	var clientId = "${clientInfo.clientId}";

	$("#uploadImageInput").on("change", function() {
		var imgTag = $("#registerProfileImage");
		if ($('#uploadImageInput')[0].files.length > 0) {
			if (confirm("해당 이미지를 사용하시겠습니까?")) {
				var reader = new FileReader();
				formData = new FormData();
				formData.append('image', $("#uploadImageInput")[0].files[0]);
				reader.onload = function(data) {
					imgTag.attr("src", data.target.result);
				}
				reader.readAsDataURL($('#uploadImageInput')[0].files[0]);
				
				$.ajax({
					url : "${appPath}/myPage/updateImg",
					type : "post",
					data : formData,
					processData : false,
					contentType : false,
					success : function(res) {
						imgUrl = res;
						$('#uploadImageInput').attr('disabled', true);
						alert("이미지가 성공적으로 업데이트되었습니다!");
						location.href = '${appPath}/myPage';
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					}
				});
			}
		}
	});


	$('#submitBtn').on('click', function() {
		var phone = $('#phoneNum').val();
		var address = $('#addr').val();
		var addressDetail = $('#addrDetail').val();

		var obj = {
			clientId : "${clientInfo.clientId}", // 클라이언트 ID
			phone : phone,
			address : address,
			addressDetail : addressDetail
		};
		$.ajax({
			url : "${appPath}/myPage/modifyUserInfo",
			type : "post",
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(res) {
				if (res === 'success') {
					alert("회원정보가 수정되었습니다!");
					location.href = '${appPath}/myPage';
				}
			}
		});
	});
	
	// 수정 버튼 클릭 시 모달 열기
	var modal2 = document.getElementById("myModal2");
	var btn2 = document.getElementById("withdrawlBtn");
	var closeBtn2 = document.querySelector("#myModal2 .close"); // '닫기' 버튼 선택 부분을 수정

	btn2.onclick = function() {
	    modal2.style.display = "block";
	}

	// '닫기' 버튼을 클릭했을 때 모달이 닫히도록 함
	closeBtn2.onclick = function() {
	    modal2.style.display = "none";
	}

	// 모달 콘텐츠 외부를 클릭했을 때 모달이 닫히도록 함
	window.onclick = function(event) {
	    if (event.target == modal2) {
	        modal2.style.display = "none";
	    }
	}

	$('#withdrawlCompleted').on('click',function() {
							var privacyTerms = $('#storagePeriod').val();
							var clientId = "${clientInfo.clientId}";
							console.log(privacyTerms);
						    var obj = {
						        clientId: clientId,
						        privacyTerms: privacyTerms
						    };
							$.ajax({
								url : "${appPath}/myPage/withdrawal",
								type : "post",
								data : JSON.stringify(obj),
								contentType : 'application/json',
								success : function(res) {
									if (res === 'success') {
										alert("탈퇴가 완료되었습니다!");
										location.href = "${appPath}/myPage";
									}
								}
							});
					});
	
</script>
