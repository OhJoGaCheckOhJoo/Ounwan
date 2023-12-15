<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
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
		$('#profileImage').attr('src', '${kakaoClient.profileURL}');
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
		$('#profileImage').attr('src', '${naverClient.profileURL}');
	} 
});
</script>
<title>회원정보입력</title>
</head>
<body>
	<div class="container">
	</div>
	<br><br><br>
	<div class="title">회원정보입력</div>
	<br>

		<div class="profile-photo">
			<input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*"/>
			<img class="profile-photo-file" src="img/default_profile.png" id="profileImage">
			<button>사진등록</button>
			<br>
			<br>
		</div>
		<div class="profile-info">

			<div class="profile-name">

				<label class="attribute-name" for=""> 이름<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					 placeholder="이름을 입력하세요"id="clientName" required />
			</div>
			<div class="profile-id">
				<label class="attribute-name" for="">아이디<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					placeholder="아이디를 입력하세요" id='clientId' required />
				<button id="checkId" type="button" value="N">중복확인</button>
			</div>

			<div class="profile-email">
				<label class="attribute-name" for="">이메일<span
					class="red-star">*</span></label> <input type="email" class="input-form"
					placeholder="이메일을 입력하세요" id="clientEmail" required/>
				<button id="emailCheckBtn" type="button" value="N">중복확인</button>
			</div>
			<div class="profile-phone">
				<label class="attribute-name" for="">연락처<span
					class="red-star">*</span></label> <input type="text" class="input-form"
					placeholder="전화번호를 입력하세요" id="phoneNum" required/>
			</div>
			<div class="profile-password">
				<label class="attribute-name" for="">비밀번호<span
					class="red-star">*</span></label> <input type="password" class="input-form"
					id="firstPass" placeholder="비밀번호를 입력하세요"> <span id="wrongForm-inform">잘못된 형식입니다.</span>
			</div>
			<div class="profile-password">
				<label class="attribute-name" for="">비밀번호 확인<span
					class="red-star">*</span></label> <input type="password" class="input-form"
					placeholder="비밀번호를 입력하세요"  id="secondPass" required/> <span id="notMatch-inform">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="profile-birthday">
				<div class="info-title">생년월일</div>
                <input class="input-form" type="date" id="clientBirthday" max="2077-12-31" min="1900-01-01" required/>
			</div>
			<div class="profile-address">
				<label class="attribute-name" for="">주소</label> 
				<input class="form-address" size="10" id="zipCode" readOnly />
				<button id="findAddr" type="button">우편번호 검색</button>
				<br> 
				<label class="attribute-name" for=""></label> 
				<input class="form-address" size="35" id="addr" readOnly/> 
				<br>
				<label class="attribute-name" for=""></label> 
				<input class="form-address" size="35" id="addrDetail" readOnly />
			</div>
		</div>
		<br>
		<hr>



		<div class="agreement-title">
			<h5 class="agreement-text">이용약관</h5>
		</div>
		<div class="agreement">
			<label for="agree1"> <input type="checkbox" id="agree1" required>
				<i class="circle"></i> [필수] 개인정보 수집 및 이용 동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree2"> <input type="checkbox" id="agree2" required>
				<i class="circle"></i> [필수] 쇼핑몰 이용동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree3"> <input type="checkbox" id="agree3" required>
				<i class="circle"></i> [필수] 중고거래 이용 동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree4"> <input type="checkbox" id="agree4" required>
				<i class="circle"></i> [필수] 오운완 이용 동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree5"> <input type="checkbox" id="agree5" checked>
				<i class="circle"></i> [필수] 탈퇴 시 일시적 정보 보유동의
			</label>
		</div>
		<br>
		<div class="agreement">
			<label for="agree6"> <input type="checkbox" id="agree6">
				<i class="circle"></i> [선택] 마케팅 수신 동의
			</label>
		</div>
		<br>

		<hr>


		<div class="sign-up-button">
			<button id='submitBtn' type='button'>회원가입</button>
		</div>
	<br><br><br>
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
            alert('아이디 중복확인 해라');
            $('#clientId').focus();
        } else if (emailCheck === 'N') {
            alert('이메일 중복확인 해라');
            $('#clientEmail').focus();
        } else if (firstPwdCheck === 'visible') {
            alert('비번 형식에 맞게 작성해라');
            $('#firstPass').val('');
            $('#firstPass').focus();
        } else if (secondPwdCheck === 'visible') {
            alert('비밀번호 다르다 확인해');
            $('#secondPass').val('');
            $('#secondPass').focus();
        } else if (!$('#agree1').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree1').focus();
		} else if (!$('#agree2').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree2').focus();
		} else if (!$('#agree3').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree3').focus();
		} else if (!$('#agree4').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree4').focus();
		} else if (!$('#agree5').is(':checked')) {
			alert('필수 등록 사항들을 체크해 주세요!');
			$('#agree5').focus();
		} else {
        	var obj = {};
        	var email = $('#clientEmail').val();
        	if ('${kakaoClient}' != '') {
        		if (imgUrl === '') imgUrl = "${kakaoClient.profileURL}";
        		obj = setKakao(email, imgUrl);
        	} else if ('${naverClient}' != '') {
        		if (imgUrl === '') imgUrl = "${naverClient.profileURL}";
        		obj = setNaver(email, imgUrl);
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
     		    "profileURL" : imgUrl,
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
     		    "profileURL" : imgUrl,
     		    "socialType" : "NAVER",
     		    "socialId" : "${naverClient.socialId}"
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
     		    "profileURL" : imgUrl
     		};
	 }
</script>
</body>
</html>