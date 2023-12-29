<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/signUp.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
// 페이지가 로드될 때 setInputValueFromModel 함수 호출
$(document).ready(function() {
	if ('${kakaoClient}' != '') {
		$('#clientEmail').val('${kakaoClient.email}');
		$('#clientEmail').attr('readOnly', true);
		$('#emailCheckBtn').attr('value', 'Y');
		$('#emailCheckBtn').attr('disabled', true);
		$('#profileImage').attr('src', '${kakaoClient.profileUrl}');
	} 
	if ('${naverClient}' != '') {
		$('#clientName').val('${naverClient.name}');
		$('#clientName').attr('readOnly', true);
		$('#clientEmail').val('${naverClient.email}');
		$('#clientEmail').attr('readOnly', true);
		$('#emailCheckBtn').attr('value', 'Y');
		$('#emailCheckBtn').attr('disabled', true);
		$('#phoneNum').val('${naverClient.phone}');
		$('#phoneNum').attr('readOnly', true);
		$('#clientBirthday').val('${naverClient.birthday}');
		$('#clientBirthday').attr('readOnly', true);
		$('#profileImage').attr('src', '${naverClient.profileUrl}');
	} 
	if ('${googleClient}' != '') {
		$('#clientName').val('${googleClient.name}');
		$('#clientName').attr('readOnly', true);
		$('#clientEmail').val('${googleClient.email}');
		$('#clientEmail').attr('readOnly', true);
		$('#emailCheckBtn').attr('value', 'Y');
		$('#emailCheckBtn').attr('disabled', true);
		$('#profileImage').attr('src', '${googleClient.profileUrl}');
	}
});
</script>
<title>오운완 회원가입</title>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<br><br><br>
    <div class="container">
    
	<div class="title">회원가입</div>
	<br>

		<div class="profile-photo">
			<img class="profile-photo-file" src="img/default_profile.png" id="profileImage">
			<label for="uploadImageInput">사진등록</label>
			<input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*"/>
			<br>
			<br>
		</div>
		<div class="profile-info">

			<div class="profile-name">

				<label class="attribute-name"> 이름<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					 placeholder="이름을 입력하세요"id="clientName" required />
			</div>
			<div class="profile-id">
				<label class="attribute-name" >아이디<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					placeholder="아이디를 입력하세요" id='clientId' required />
				<button id="checkId" type="button" value="N">중복확인</button>
			</div>

			<div class="profile-email">
				<label class="attribute-name" >이메일<span
					class="red-star">*</span></label> <input type="email" class="input-form"
					placeholder="이메일을 입력하세요" id="clientEmail" required/>
				<button id="emailCheckBtn" type="button" value="N">중복확인</button>
			</div>
			<div class="profile-phone">
				<label class="attribute-name" >연락처<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					placeholder="전화번호를 입력하세요" id="phoneNum" required/>
			</div>
			<div class="profile-password">
				<label class="attribute-name" >비밀번호<span
					class="red-star">*</span></label> <input type="password" class="input-form" id="firstPass" placeholder="비밀번호를 입력하세요">
					<div id="wrongForm-inform">잘못된 형식입니다.</div>
			</div>
			<div class="profile-password">
				<label class="attribute-name" >비밀번호 확인
				<span class="red-star">*</span>
				</label> <input type="password" class="input-form" placeholder="비밀번호를 입력하세요"  id="secondPass" required/>
					<div id="notMatch-inform">비밀번호가 일치하지 않습니다.</div>
			</div>
			<div class="profile-birthday">
				<label class="info-title attribute-name">생년월일</label>
                <input class="input-form" type="date" id="clientBirthday" max="2077-12-31" min="1900-01-01" required/>
			</div>
			<div class="profile-address">
				<label class="attribute-name">주소</label> 
				<input class="form-address" size="10" id="zipCode" readOnly />
				<button id="findAddr" type="button">우편번호 검색</button>
				<br> 
				<label class="attribute-name" ></label> 
				<input class="form-address" size="35" id="addr" readOnly/> 
				<br>
				<label class="attribute-name" ></label> 
				<input class="form-address" size="35" id="addrDetail" readOnly />
			</div>
		</div>
		<br>
		<hr>



		<div class="agreement-title">
			<h5 class="agreement-text">이용약관</h5>
		</div>
		<div class="agreement">
			<label for="agree1">
				<input type="checkbox" id="agree1" required>
				<i class="circle"></i> [필수] 개인정보 수집 및 이용 동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree2">
				<input type="checkbox" id="agree2" required>
				<i class="circle"></i> [필수] 오운완 이용 약관 동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree3">
				<input type="checkbox" id="agree3">
				<i class="circle"></i> [선택] 마케팅 수신 동의
			</label>
		</div>
		<br>
		<hr>
		<div class="sign-up-button">
			<button id='submitBtn' type='button'>회원가입</button>
		</div>
	</div>
	<br><br><br>
	<div id="agreementPersonalData">
		<h3>개인정보 수집 및 이용 동의</h3>
		<%@ include file="./common/agreementPersonalData.jsp" %>
		<button>확인</button>
	</div>
	
	<div id="agreementAccessTerms">
		<h3>오운완 이용 약관 동의</h3>
		<%@ include file="./common/agreementAccessTerms.jsp" %>
		<button>확인</button>
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    var phone = "";
    $('#phoneNum').on('input', function() {
        if ($(this).val().length < 14) {
            $(this).val($(this).val()
                .replace(/[^0-9]/g, '')
                .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3"));
            phone = $(this).val();
        } else {
            $(this).val(phone);
        }

    });

    $('#checkId').on('click', function() {
        var id = $('#clientId').val();
        alert(id);
        var idFormat = /^[a-z]+[a-z0-9]{5,11}$/g;
        if (!idFormat.test(id)) {
            alert('형식에 맞게 작성해 주세요 (6 ~ 12자리)');
            $('#checkId').attr('value', 'N');
            $('#clientId').val('');
        } else {
        	
            $.ajax({
                url: "${appPath}/clients/checkId",
                type: "get",
                data: {
                    "clientId": id
                },
                success: function(res) {
                    if ("exist" === res) {
                        alert("이미 존재하는 아이디 입니다.");
                        $('#clientId').val('');
                        $('#clientId').focus();
                    } else {
                    	if(confirm("해당 아이디를 사용하시겠습니까?")) {
                    		$('#checkId').attr('value', 'Y');
          					$('#clientId').attr('readOnly', true);
          					$('#checkId').attr('disabled', true);
                    	} else {
                    		$('#clientId').val('');
                    		$('#clientId').focus();
                    	}
                    }
                },
                error: function(request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
        }
    });
	
	$('#emailCheckBtn').on('click', function() {
		var email = $('#clientEmail').val();
		var emailFormat = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		
		if (!emailFormat.test(email)) {
			alert('잘못된 형식입니다!');
			$('#clientEmail').val('');
			$('#emailCheckBtn').attr('value', 'N');
		} else {
			$.ajax({
				url : "${appPath}/clients/checkEmail",
				type : "get",
				data : {
					"email" : email
				},
				success : function(res) {
					if ("exist" === res) {
						alert("이미 존재하는 이메일 입니다.");
						$('#clientEmail').val('');
						$('#clientEmail').focus();
					} else {
						if(confirm('해당 이메일을 사용하시겠습니까?')) {
							$('#emailCheckBtn').attr('value', 'Y');
							$('#emailCheckBtn').attr('disabled', true);
							$('#clientEmail').attr('readOnly', true);
						} else {
							$('#clientEmail').val('');
							$('#clientEmail').focus();
						}
					}
				},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
			});
		}
	});
	
	$('#firstPass').on('input', function() {
		var password = $('#firstPass').val();
		var passwordFormat =  /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		/*
		if (!passwordFormat.test(password) && password.length > 0) {
			$('#wrongForm-inform').css('visibility', 'visible');
		} else {
			$('#wrongForm-inform').css('visibility', 'hidden');
		}
		*/
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
	
	$('#findAddr').on('click', function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = ''; 
	            var extraAddr = ''; 

	            if (data.userSelectedType === 'R') { 
	                addr = data.roadAddress;
	            } else {
	                addr = data.jibunAddress;
	            }

	            if(data.userSelectedType === 'R'){
	               
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	              
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	              
	                if(extraAddr !== ''){
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
	
	var formData = new FormData();
	var changeImage = false;
	var formData = new FormData();
	var imgUrl = '';
	var readAgreement1 = false;
	var readAgreement2 = false;
	
	$("#agree1").on('change', function() {
		if($(this).prop('checked') && !readAgreement1 && $("#agreementPersonalData").css('display') == 'none') {
			$("#agree1").attr('disabled', true);
			$("#agree2").attr('disabled', true);
			$("#agree3").attr('disabled', true);
			$("#agreementPersonalData").css('display', 'block');
		}
	});
	
	$("#agreementPersonalData button").on("click", function() {
		readAgreement1 = true;
		$("#agree1").attr('disabled', true);
		if(!readAgreement2) {
			$("#agree2").attr('disabled', false);
		}
		$("#agree3").attr('disabled', false);
		$("#agreementPersonalData").css('display', 'none');
	});
	
	$("#agree2").on('change', function() {
		if($(this).prop('checked') && !readAgreement2 && $("#agreementAccessTerms").css('display') == 'none') {
			$("#agree1").attr('disabled', true);
			$("#agree2").attr('disabled', true);
			$("#agree3").attr('disabled', true);
			$("#agreementAccessTerms").css('display', 'block');
		}
	});
	
	$("#agreementAccessTerms button").on("click", function() {
		readAgreement2 = true;
		if(!readAgreement1) {
			$("#agree1").attr('disabled', false);
		}
		$("#agree3").attr('disabled', false);
		$("#agreementAccessTerms").css('display', 'none');
	});
	
	$("#uploadImageInput").on("change", function() {
	    var imgTag = $("#profileImage");
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
	        	    url: "${appPath}/clients/setImage",
	        	    type: "post",
	        	    data: formData,
	        	    processData: false,
	        	    contentType: false,
	        	    success: function(res) {
	        	        imgUrl = res;
	        	        $('#uploadImageInput').attr('disabled', true);
	        	    },
	        	    error: function(request, status, error) {
	        	        alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	        	    }
	        	});	 
	    	}
	    }
	});
	
	$('#submitBtn').on('click', function() {
        var idCheck = $('#checkId').val();
        var emailCheck = $('#emailCheckBtn').val();
        var firstPwdCheck = $('#wrongForm-inform').css('visibility');
        var secondPwdCheck = $('#notMatch-inform').css('visibility');
       	
        
        if (idCheck === 'N') {
            alert('아이디 중복확인 해주세요.');
            $('#clientId').focus();
        } else if (emailCheck === 'N') {
            alert('이메일 중복확인 해주세요.');
            $('#clientEmail').focus();
        } else if (firstPwdCheck === 'visible') {
            alert('비밀번호 형식이 알맞지 않습니다.');
            $('#firstPass').val('');
            $('#firstPass').focus();
        } else if (secondPwdCheck === 'visible') {
            alert('비밀번호가 일치하지 않습니다.');
            $('#secondPass').val('');
            $('#secondPass').focus();
        } else if (!$('#agree1').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree1').focus();
		} else if (!$('#agree2').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree2').focus();
		} else {
        	var obj = {};
        	var email = $('#clientEmail').val();
        	if ('${kakaoClient}' != '') {
        		if (imgUrl === '') imgUrl = "${kakaoClient.profileURL}";
        		obj = setKakao(email, imgUrl);
        	} else if ('${naverClient}' != '') {
        		if (imgUrl === '') imgUrl = "${naverClient.profileURL}";
        		obj = setNaver(email, imgUrl);
        	} else if ('${googleClient}' != '') {
        		if (imgUrl === '') imgUrl = "${googleClient.profileURL}";
        		obj = setGoogle(email, imgUrl);
        	} else {
        		if (imgUrl === '') imgUrl = $('#profileImage').attr('src');
	        	obj = setUser(imgUrl);
        	}
        	
        	 $.ajax({
                 url: "${appPath}/clients/signUp",
                 type: "post",
                 data: JSON.stringify(obj),
                 contentType: 'application/json',
                 success: function(res) {
                	 if (res === 'success') {
	                     alert("회원가입에 성공하셨습니다!");
	                     location.href='${appPath}';
                	 }
                 },
                 error: function(request, status, error) {
                     alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                 }
             });
        }
    });
	
	 var setKakao = function(email, imgUrl) {
     	var email = "k-" + $('#clientEmail').val()
 		 return {
     		    "clientId" : $('#clientId').val(),
     		    "name" : $('#clientName').val(),
     		    "password" : $('#firstPass').val(),
     		    "email" : email,
     		    "birthday" : $('#clientBirthday').val(),
     		    "phone" : $('#phoneNum').val(),
     		    "address" : $('#addr').val(),
     		    "addressDetail" : $('#addrDetail').val(),
     		    "zipCode" : $('#zipCode').val(),
     		    "privacyTerms" : "3",
     		    "profileUrl" : imgUrl,
     		    "socialType" : "KAKAO",
     		    "socialId" : "${kakaoClient.socialId}"
     		};
     }
	 
	 var setNaver = function(email, imgUrl) {
		var email = "n-" + $('#clientEmail').val();
 		return {
     		    "clientId" : $('#clientId').val(),
     		    "name" : $('#clientName').val(),
     		    "password" : $('#firstPass').val(),
     		    "email" : email,
     		    "birthday" : $('#clientBirthday').val(),
     		    "phone" : $('#phoneNum').val(),
     		    "address" : $('#addr').val(),
     		    "addressDetail" : $('#addrDetail').val(),
     		    "zipCode" : $('#zipCode').val(),
     		    "privacyTerms" : "3",
     		    "profileUrl" : imgUrl,
     		    "socialType" : "NAVER",
     		    "socialId" : "${naverClient.socialId}"
     		};
	 }
	 
	 var setGoogle = function(email, imgUrl) {
			var email = "g-" + $('#clientEmail').val();
	 		return {
	     		    "clientId" : $('#clientId').val(),
	     		    "name" : $('#clientName').val(),
	     		    "password" : $('#firstPass').val(),
	     		    "email" : email,
	     		    "birthday" : $('#clientBirthday').val(),
	     		    "phone" : $('#phoneNum').val(),
	     		    "address" : $('#addr').val(),
	     		    "addressDetail" : $('#addrDetail').val(),
	     		    "zipCode" : $('#zipCode').val(),
	     		    "privacyTerms" : "3",
	     		    "profileUrl" : imgUrl,
	     		    "socialType" : "GOOGLE",
	     		    "socialId" : "${googleClient.socialId}"
	     		};
		 }
	 
	 var setUser = function(imgUrl) {
		return {
     		    "clientId" : $('#clientId').val(),
     		    "name" : $('#clientName').val(),
     		    "password" : $('#firstPass').val(),
     		    "email" : $('#clientEmail').val(),
     		    "birthday" : $('#clientBirthday').val(),
     		    "phone" : $('#phoneNum').val(),
     		    "address" : $('#addr').val(),
     		    "addressDetail" : $('#addrDetail').val(),
     		    "zipCode" : $('#zipCode').val(),
     		    "privacyTerms" : "3",
     		    "profileUrl" : imgUrl
     		};
	 }
</script>
</body>
</html>