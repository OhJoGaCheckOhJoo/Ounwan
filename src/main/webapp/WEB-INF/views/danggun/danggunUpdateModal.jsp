<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<c:set var="imageCounter" value="0" />
<!-- 모달 창 -->
<div id="myModal" class="modal">
	<!-- 여기 아래에 추가 -->
	<div class="danggun-container">

		<div class="register-container">
			<div class="register-info">상품 수정하기</div>
		</div>

		<hr />

		<!-- 상품 등록 전체 form -->
		<div class="register-content">
			<!-- 대표 이미지 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					대표 이미지 <span>*</span>
				</div>
				<div class="danggun-main-image">
					<label for="uploadImageInput"></label>
					<c:forEach var="images" items="${danggunImage}">
						<c:if test="${images.type eq 0}">
							<img class="small-img" id="mainImage" src="${images.url}" />
							<input type="file" name="uploadImageInput" id="uploadImageInput"
								accept="image/*"
								onchange="updateMainImage('${danggunImage[0].url}',${images.productImageNumber})">
						</c:if>
					</c:forEach>
				</div>
			</div>

			<!-- 상세 이미지 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					상세 이미지<br /> (최대 3장 추가 가능)
				</div>

				<div class="image-container">
					<c:forEach var="images" items="${danggunImage}"
						varStatus="loopStatus">
						<c:if test="${imageCounter lt 3 && images.type eq 1}">
							<div class="danggun-detail-image">
								<label for="uploadDetailImageInput${images.productImageNumber}"></label>
								<img class="small-img"
									id="detailImage${images.productImageNumber}"
									src="${images.url}" /> 
								<input type="file"
									name="uploadDetailImageInput"
									id="uploadDetailImageInput${images.productImageNumber}"
									accept="image/*"
									onchange="updateDetailImage(${images.productImageNumber})"></input>
							</div>
							<c:set var="imageCounter" value="${imageCounter + 1}" />
						</c:if>
					</c:forEach>
					<c:if test="${imageCounter lt 3}">
						<c:forEach begin="0" end="${2 - imageCounter}"
							varStatus="loopStatus">
							<div class="danggun-detail-image">
								<label
									for="newDetailImageInput${loopStatus.index}"></label>
								<img class="small-img"
									id="detailNewImage${loopStatus.index}"
									src="../images/danggunInsertDefault.png" /> 
									<input type="file"
									name="newDetailImageInput"
									id="newDetailImageInput${loopStatus.index}"
									accept="image/*"
									onchange="newDetailImage(${loopStatus.index})" />
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<!-- 상품명 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					상품명 <span>*</span>
				</div>
				<div class="text-input-description">
					<div class="input-area">
						<input class="input-area" id="modalDanggunName"
							value="${post.productName}" required />
					</div>
					<div>
						<div id="name-count"></div>
					</div>
				</div>
			</div>
			<!-- 거래현황 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					거래 현황 <span>*</span>
				</div>
				<div class="text-input-description">
					<select id="options" name="options">
						<option value="6">판매 중</option>
						<option value="7">예약 중</option>
						<option value="8">거래 완료</option>
					</select>
				</div>
			</div>
			<!-- 가격 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					가격<span> *</span>
				</div>
				<input class="input-area" id="modalDanggunPrice"
					value="${post.price}" required type="number" />
			</div>
			<!-- 설명 라인 -->
			<div class="danggun-product">
				<div class="product-explain">
					설명 <span>*</span>
				</div>
				<div class="text-input-description">
					<textarea class="input-area" id="modalInputText" required>${post.detail}</textarea>
					<div>
						<div class="text-count" id="detail-count"></div>
					</div>
				</div>

			</div>
		</div>
		<hr />
		<button id="danggunUpdate" class="danggunUpdate" type="button">수정</button>
		<button onclick="closeModal()">취소</button>
	</div>
</div>
<!-- 배경 회색 불투명도 -->
<div id="modalOverlay" class="modal-overlay" onclick="closeModal()"></div>

<script>
var newImage = [];
var newInitialImageArr = [];
function setInitialNewImageURL(index) {
    var initialNewImage = document.getElementById("detailNewImage" + index);
    
    if (initialNewImage) {
    	newInitialImageArr[index] = initialNewImage.src;
    }
}

function newDetailImage(index) {
    var input = document.getElementById('newDetailImageInput' + index);
    var img = document.getElementById("detailNewImage" + index);
    
    if (!newInitialImageArr[index]) {
    	setInitialNewImageURL(index);
    }
    
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            img.src = e.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    }else {
        img.src = img.src;
        return;
    }
    
    const newImageURL = $("#newDetailImageInput"+index).val();

    var newImageInfo = {
			"index" : index,
			"imageFile" : input.files[0]
		};
    
	if(newImage.length === 0){
		newImage.push(newImageInfo);
	} else {
		const foundIndex = newImage.findIndex((image) => image.index === newImageInfo.index);
		
		if(foundIndex !== -1){
			newImage[foundIndex] = newImageInfo;
		} else {
			newImage.push(newImageInfo);
		}
	}
}

</script>