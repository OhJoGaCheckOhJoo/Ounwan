var appPath = '/myapp';
// 모달 열기
function openModal(tradeHistoryNumber) {
	document.getElementById("myModal").style.display = "block";
	document.getElementById("modalOverlay").style.display = "block";

	const optionSelect = document.getElementById("options");
	const options = optionSelect.options;

	for (let i = 0; i < options.length; i++) {
		if (options[i].value == tradeHistoryNumber) {
			options[i].selected = true;
			break;
		}
	}
	
}

// 모달 닫기
function closeModal() {
	document.getElementById("myModal").style.display = "none";
	document.getElementById("modalOverlay").style.display = "none";
}
function getSelectedValue() {
	const selectedOptionValue = document.getElementById("options").value;
	return selectedOptionValue;
}

document.addEventListener("DOMContentLoaded", function() {
	const textArea = document.getElementById("modalInputText");
	const detail_counter = document.getElementById("detail-count");
	const detail_maxLength = 2000;

	const inputArea = document.getElementById("modalDanggunName");
	const name_counter = document.getElementById("name-count");
	const name_maxLength = 40;

	updateCounter(textArea, detail_counter, detail_maxLength);
	textArea.addEventListener("input", function() {
		updateCounter(textArea, detail_counter, detail_maxLength);
	});
	
	updateCounter(inputArea, name_counter, name_maxLength);
	inputArea.addEventListener("input", function(){
		updateCounter(inputArea, name_counter, name_maxLength);
	});
	
	function updateCounter(inputElement, counterElement, maxLength) {
		const inputText = inputElement.value;
		if(inputText.length > maxLength){
			inputText = inputText.substring(0, maxLength);
			inputElement.value = inputText;
		}
		counterElement.textContent = inputText.length + "/"+ maxLength;
	}
});

// 초기 이미지 설정 
var initialImageArr = []; // 초기 이미지에 저장에 사용 
var formImage = [];

function setInitialImageURL(productImageNumber) {
    var initialImage = document.getElementById("detailImage" + productImageNumber);
    
    if (initialImage) {
    	initialImageArr[productImageNumber] = initialImage.src;
    }
}

function setMainInitialImageURL(productImageNumber){
	var mainInitialImage = document.getElementById("mainImage");
	
	if (mainInitialImage) {
    	initialImageArr[productImageNumber] = mainInitialImage.src;
    }
}

// 메인 이미지
function updateMainImage(mainImage, productImageNumber) {
    const input = document.getElementById("uploadImageInput");
    const img = document.getElementById("mainImage");
    const previousImageUrl = mainImage;

    if (!initialImageArr[productImageNumber]) {
        setMainInitialImageURL(productImageNumber);
    }

    if (input.files && input.files[0]) {
        const reader = new FileReader();

        reader.onload = function (event) {
            img.src = event.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    } else {
        img.src = img.src;
        return;
    }

    const mainImageURL = $("#uploadImageInput").val();

    const changeImageInfo = {
        "imageNumber": productImageNumber,
        "oldImageURL": initialImageArr[productImageNumber],
        "presentImageURL": mainImageURL,
        "imageFile" : input.files[0]
    };

    updateFormImageArray(changeImageInfo);
}

// 상세 이미지
function updateDetailImage(productImageNumber) {
	var input = document.getElementById("uploadDetailImageInput" + productImageNumber);
    var img = document.getElementById("detailImage" + productImageNumber);
	
    // 초기 이미지 URL이 설정되어 있지 않으면 설정
    if (!initialImageArr[productImageNumber]) {
   		setInitialImageURL(productImageNumber);
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
	var imageURL = $("#uploadDetailImageInput" + productImageNumber).val();
	
	var changeImageInfo = {
			"imageNumber" : productImageNumber,
			"oldImageURL" : initialImageArr[productImageNumber],
			"presentImageURL" : imageURL,
			"imageFile" : input.files[0]
		};
	
	updateFormImageArray(changeImageInfo);
}

function updateFormImageArray(changeImageInfo) {
    if (formImage.length === 0) {
        formImage.push(changeImageInfo);
    } else {
        const foundIndex = formImage.findIndex((image) => image.imageNumber === changeImageInfo.imageNumber);

        if (foundIndex !== -1) {
            formImage[foundIndex] = changeImageInfo;
        } else {
            formImage.push(changeImageInfo);
        }
    }
}

$(function() {
	$("#danggunUpdate").on("click", function() {
		var danggunNumber = document.getElementById('danggunModal').getAttribute('danggunNumber');	
		var clientId = document.getElementById('danggunModal').getAttribute('clientId');
		
		var mainImageInput = document.getElementById("uploadImageInput");
		var detailImageInput = document.getElementById("uploadDetailImageInput");
		var formData = new FormData();
		var modalInputTextValue = $("#modalInputText").val();
		var formattedValue = modalInputTextValue.replace(/\n/g, '<br>');
		
		formData.append("danggunNumber",danggunNumber);
		formData.append("name", $("#modalDanggunName").val());
		formData.append("price", $("#modalDanggunPrice").val());
		formData.append("detail", formattedValue);
		
		formData.append("tradeHistoryNumber",getSelectedValue());
		formData.append("clientId", clientId);
		
        for(var i = 0; i < formImage.length; i++){
        	formData.append('imageFilesNumber', formImage[i].imageNumber);
        	formData.append('imageFiles', formImage[i].imageFile);
        	formData.append('oldImageURL', formImage[i].oldImageURL);
        }
        formData.append("imagesLength",formImage.length);
        
		for(var i = 0; i < newImage.length; i++){
			formData.append('newDetailImages', newImage[i].imageFile);
		}
		formData.append("newImagesLength", newImage.length);
		
		$.ajax({
			url : appPath + '/danggun/update',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(responseData) {
				if(responseData == true){
					alert("success");
					window.location.href = appPath + "/danggun/detail?danggunNumber="+danggunNumber;
				}
				else{
					alert("fail");
				}
			},
			error : function() {
				alert("error");
			}
		});

	});
})


