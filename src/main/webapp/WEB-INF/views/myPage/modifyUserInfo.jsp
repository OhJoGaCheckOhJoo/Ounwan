<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Document</title>
    <link href="${appPath}/css/main2.css" rel="stylesheet">
 
    <link href="${appPath}/css/header.css" rel="stylesheet">
  

    <link href="${appPath}/css/nav.css" rel="stylesheet">
    <link href="${appPath}/css/mypagemain.css" rel="stylesheet">
    <link href="${appPath}/css/signUp.css" rel="stylesheet">
</head>


<body>
   <header>
        <div class="header">
            <a class="logo" href="/ounwan"></a>
            <div class="float-right">
                <a id="profileImage" href="#">
                    <img src="../images/google.png">
                </a>
                <span>0000님 환영합니다</span>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
        </div>
        <div class="header-sub-menu">
            <div>
                <a href="#">마이페이지</a>
                <a href="#">로그아웃</a>
            </div>
        </div>
    </header>

    <div class="container">
        <nav>
            <div class="nav-main">
                <div class="pointer">
                    <a id="hamberger-btn" class="menu-trigger">
                        <span></span>
                        <span></span>
                        <span></span>
                    </a>
                </div>
                <div>
                    <a href="#">쇼핑몰</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">전체 보기</a>
                        <a href="#">운동 기구</a>
                        <a href="#">건강 보조 식품</a>
                        <a href="#">헬스 이용권</a>
                        <a href="#">의류</a>
                    </div>
                </div>
                <div>
                    <a href="#">중고거래</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                </div>
                <div>
                    <a href="#">커뮤니티</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                </div>
                <div>
                    <a href="#">고객센터</a>
                    <div id="navSubmenu" class="nav-submenu">
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
            <div id="navMenu" class="nav-menu">
                <div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">운동 기구</a>
                        <a href="#">건강 보조 식품</a>
                        <a href="#">헬스 이용권</a>
                        <a href="#">의류</a>
                    </div>
                    <div>
                        <a href="#">전체 보기</a>
                        <a href="#">관심 상품</a>
                    </div>
                    <div>
                        <a class="ounwangram" href="ounwangram">오운완 커뮤니티</a>
                        <a href="#">고민 게시판</a>
                    </div>
                    <div>
                        <a href="#">상품문의</a>
                        <a href="#">배송문의</a>
                        <a href="#">중고거래</a>
                        <a href="#">커뮤니티</a>
                    </div>
                </div>
            </div>
        </nav>

        <!--mypage content-->
        <div class="mypage-container">
            <div class="mypage-content">
                <div class="side-bar-container">
                    <div class="side-bar title">
                        <a href="#">
                            마이페이지
                        </a>
                    </div>
                    <div class="side-bar menu">
                        <div class="menu-container coupung">
                            <a href="#">
                                <div class="coupung-menu order-list">
                                    주문내역 조회
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu mileage">
                                    마일리지
                                </div>
                            </a>
                            <a href="#">
                                <div class="coupung-menu review">
                                    리뷰 관리
                                </div>
                            </a>
                        </div>
                        <div class="menu-container danggun">
                            <a href="#">
                                <div class="danggun-menu sale-list">
                                    내 판매 내역
                                </div>
                            </a>
                            <a href="#">
                                <div class="danggun-menu wish-list">
                                    관심 상품
                                </div>
                            </a>
                        </div>
                        
                        <div class="menu-container aeta">
                            <a href="#">
                                <div class="aeta-menu writing-list">
                                    내 게시글 목록
                                </div>
                            </a>
                        </div>
                        <div class="menu-container chat">
                            <a href="#">
                                <div class="chat-menu admin">
                                    관리자와 채팅
                                </div>
                            </a>
                            <a href="#">
                                <div class="chat-menu danggun">
                                    쪽지 내역
                                </div>
                            </a>
                        </div>
                        <div class="menu-container user">
                            <a href="#">
                                <div class="user-menu update-user-info">
                                    회원 정보 수정
                                </div>
                            </a>
                        </div>
                    </div>

                </div>

                <div class="content-container">
                    <div class="preview-container">
                        <div class="preview user">
                            <p class="preview-user name">오운완님</p>
                            <p class="preview-user text">WELCOME</p>
                        </div>

                        <div class="preview menu">
                            <a href="#" class="preview-menu mileage">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>마일리지</p>
                                        <span>127</span><span> 점</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu wish-list">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>관심 상품</p>
                                        <span>0</span><span> 개</span>
                                    </div>
                                    
                                </div>
                            </a>
                            <a href="#" class="preview-menu cart">
                                <div>
                                    <img class="preview-menu-image">
                                    <div class="preview-menu-text">
                                        <p>장바구니</p>
                                        <span>5</span><span> 개</span>
                                    </div>                            
                                </div>
                            </a>
                        </div>
                    </div>

                    <!--여기부분이 계속 바뀔 예정입니당-->
                    <div class="content-info-container">
                        <div class="content-info">	
							<div class="profile-photo">
								<input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*"/>
								<img class="profile-photo-file" src="../${userInfo.profileURL}" id="registerProfileImage">
								 <!--src="${userInfo.profileURL}"-->
								<button id="uploadImageButton">사진수정</button>
								<br>
								<br>
							</div>
							
							<div class="profile-info">
					
								<div class="profile-name">
					
									<label class="attribute-name" for=""> 이름</label> 
										<input type="text" class="input-form" value="${userInfo.name}" readonly/>
								</div>
								<div class="profile-id">
									<label class="attribute-name" for="">아이디</label> 
									<input type="text" class="input-form"
										value="${userInfo.clientId}" readonly/>
								</div>
					
								<div class="profile-email">
									<label class="attribute-name" for="">이메일</label> 
									<input type="email" class="input-form"
										value="${userInfo.email}" readonly/>
									
								</div>
								<div class="profile-phone">
									<label class="attribute-name" for="">연락처</label> 
									<input type="text" class="input-form"
										value="${userInfo.phone}" id="phoneNum"/>
								</div>
								<!-- 수정 버튼 클릭 시 모달창 띄우기 -->
								<div class="profile-password">
									<label class="attribute-name" for="">비밀번호</label> 
									<button id="openModal">수정</button>
								</div>
								
								<!-- 모달창 -->
								<div id="myModal" class="modal">
								  <div class="modal-content">
								    <span class="close">&times;</span>
										 <div class="profile-password">
											<label class="modal-attribute-name" for="">비밀번호</label> 
											<input type="password" class="input-form"
												id="firstPass" placeholder="비밀번호를 입력하세요"> <span id="wrongForm-inform">잘못된 형식입니다.</span>
										</div>
										<div class="profile-password">
											<label class="modal-attribute-name" for="">비밀번호 확인</label> 
											<input type="password" class="input-form"
												placeholder="비밀번호를 입력하세요"  id="secondPass" required/> <span id="notMatch-inform">비밀번호가 일치하지 않습니다.</span>
										</div>  
								  
								    <button id="savePassword">저장</button>
								  </div>
								</div>
								
								<div class="profile-address">
									<label class="attribute-name" for="">주소</label> 
									<input class="form-address" size="10" id="zipCode" value="${userInfo.zipCode}" />
									<button id="findAddr" type="button">우편번호 검색</button>
									<br> 
									<label class="attribute-name" for=""></label> 
									<input class="form-address" size="35" id="addr" value="${userInfo.address}"/> 
									<br>
									<label class="attribute-name" for=""></label> 
									<input class="form-address" size="35" id="addrDetail" value="${userInfo.addressDetail}" />
								</div>
								
								<br>
								
								<div class="modify-button">
									<button id='submitBtn' type='button'>수정</button>
								</div>
							</div>
	        			</div>
                     </div>
                  </div>
                </div>

            </div>

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
	    	
	    	
	    	
	    	// 수정 버튼 클릭 시 모달 열기
	    	var modal = document.getElementById("myModal");
	    	var btn = document.getElementById("openModal");
	    	var span = document.getElementsByClassName("close")[0];

	    	btn.onclick = function() {
	    	  modal.style.display = "block";
	    	}

	    	span.onclick = function() {
	    	  modal.style.display = "none";
	    	}

	   
	    	
	    	$('#savePassword').on('click', function() {
	    		var firstPass = $('#firstPass').val();
	    		var secondPass = $('#secondPass').val();
	    	  
	    	  console.log(secondPass);

	    	  // 비밀번호 확인
	    	  if (firstPass !== secondPass) {
	    	    document.getElementById("notMatch-inform").style.display = "block";
	    	    return; // 비밀번호가 일치하지 않으면 중단
	    	  }

	    	// 클라이언트 정보를 담은 DTO
	    	  var obj = {
	    	    clientId: "${userInfo.clientId}", // 클라이언트 ID
	    	    password: secondPass // 새 비밀번호
	    	  };

	    	  $.ajax({
	    	    url: "${appPath}/myPage/modifyUserInfo/pwd", // 정보 변경을 위한 URL
	    	    type: "post",
	    	    data: JSON.stringify(obj), // DTO 전달
	    	    contentType: 'application/json',
	    	    success: function(res) {
	    	    	console.log(res);
	    	      if (res === 'success') {
	    	        alert("비밀번호가 변경되었습니다!");
	    	        modal.style.display = "none";
	    	      } else {
	    	        alert("비밀번호 변경에 실패했습니다.");
	    	      }
	    	    },
	    	    error: function(request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
	    	  });

	    	  // 모달 닫기
	    	  modal.style.display = "none";
	    	});
	    	
	    	  var formData = new FormData();
	    	    var imgUrl = '';
	    	    var clientId = "${userInfo.clientId}";

	    	    $("#uploadImageInput").on("change", function() {
	    	        var imgTag = $("#registerProfileImage");
	    	        if ($('#uploadImageInput')[0].files.length > 0) {
	    	            if (confirm("해당 이미지를 사용하시겠습니까?")) {
	    	                var reader = new FileReader();
	    	                formData = new FormData();
	    	                formData.append('image', $("#uploadImageInput")[0].files[0]);
	    	                formData.append('clientId', clientId);
	    	                reader.onload = function(data) {
	    	                    imgTag.attr("src", data.target.result);
	    	                }
	    	                reader.readAsDataURL($('#uploadImageInput')[0].files[0]);
	    	            }
	    	        }
	    	    });

	    	    $("#uploadImageButton").on("click", function() {
	    	      
	    	            $.ajax({
	    	                url: "${appPath}/myPage/updateImg",
	    	                type: "post",
	    	                data: formData,
	    	                processData: false,
	    	                contentType: false,
	    	                success: function(res) {
	    	                    imgUrl = res;
	    	                    $('#uploadImageInput').attr('disabled', true);
	    	                    alert("이미지가 성공적으로 업데이트되었습니다!");
	    	                },
	    	                error: function(request, status, error) {
	    	                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	    	                }
	    	            });
	    	     
	    	    });
	    	
	    	
	    	
	    	$('#submitBtn').on('click', function() {
	    		var phone = $('#phoneNum').val();
	    		var address = $('#addr').val();
	    		var addressDetail = $('#addrDetail').val();
	    		
	            var obj = {
	    	    	    clientId: "${userInfo.clientId}", // 클라이언트 ID
	    	    	    phone: phone,
	            	    address: address,
	            	    addressDetail: addressDetail
	    	    	  };
	            $.ajax({
	                 url: "${appPath}/myPage/modifyUserInfo",
	                 type: "post",
	                 data: JSON.stringify(obj),
	                 contentType: 'application/json',
	                 success: function(res) {
	                	 if (res === 'success') {
		                     alert("회원정보가 수정되었습니다!");
		                    
	                	 }
	                 }
	             });
	    	});
        </script>
</body>
</html>