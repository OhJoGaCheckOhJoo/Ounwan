var appPath = '/myapp';

function insertReview(detailNumber, url, productName, option) {
	closeDetailModal();
	openReviewModal(detailNumber, url, productName, option);
}

var orderDetailNumber;
function openReviewModal(detailNumber, url, productName, option) {
	document.getElementById("reviewModal").style.display = "block";
	document.getElementById("reviewModalOverlay").style.display = "block";
		
	orderDetailNumber = detailNumber;
		
	$('#reviewName').text(productName);
	$('#reviewOption').text(option);
	$('#reviewImage').attr("src", url);
	console.log(orderDetailNumber);

}

	$('#reviewContent').keyup(function(e) {
		let content = $(this).val();

		if (content.length == 0 || content == '') {
			$('#reviewCount').text('0/50');
		} else {
			$('#reviewCount').text(content.length + '/50');
		}

		if (content.length > 50) {
			alert('글자수는 50자까지 입력 가능합니다.');
			$(this).val($(this).val().substring(0, 50));
			$('#reviewCount').text('50/50');
			
		};
		
	});

	var filledStar = 0;
	$(".score-setting").on(
			"click",
			function() {
				filledStar = 0;
				for (var i = 0; i < 5; i++) {
					if (i < $(this).val()) {
						$(".score-setting img").eq(i).attr("src",
								appPath + "/images/myPage/full_star2.png");
						filledStar++;
					} else {
						$(".score-setting img").eq(i).attr("src",
								appPath + "/images/myPage/empty_star.png");
					}
				}
			})

	var reviewImage;
	$("#reviewImageInput").change(function(e) {
		setReviewImage(e);
	});

	function setReviewImage(event) {
		var f = event.target.files[0];

		var reader = new FileReader();
		var input = document.getElementById("reviewImageInput");
		var img = document.getElementById("reviewImagePreview");

		if (f == undefined) {
			$('#reviewImageInput').replaceWith(reviewImage);
			$("#reviewImageInput").on("change", setReviewImage);

		} else {
			reviewImage = $(event.target).clone(true);
			console.log("cloneImage: " + reviewImage);

			reader.onload = function(event) {
				img.src = event.target.result;
			}
			reader
					.readAsDataURL(document.getElementById("reviewImageInput").files[0]);
			console.log("mainImage: " + $('#reviewImageInput')[0].files[0]);
		}
	}
$(document).ready(function() {
    // 이벤트 핸들러 중복 방지
    $("#ReviewSubmitButton").off("click").on("click", function(event) {
        var reviewDetailNumber = orderDetailNumber;
        var reviewScore = filledStar;
        var reviewContent = $("#reviewContent").val();
        var reviewImage = $("#reviewImageInput")[0].files;

        if (reviewScore === 0 || reviewContent.trim() === '') {
            alert("필수 항목을 작성해 주세요");
            return false; // 유효성 검사 통과하지 못하면 함수 종료
        }

        var formData = new FormData();

        // 폼 데이터에 필요한 내용 추가
        formData.append("reviewDetailNumber", reviewDetailNumber);
        formData.append("reviewScore", reviewScore);
        formData.append("reviewContent", reviewContent);
        
        // 이미지가 있다면 폼 데이터에 추가
        if (reviewImage.length > 0) {
            formData.append("reviewImage", reviewImage[0]);
        } else {
        	formData.append("reviewImage", null);
        }

        // 핸들러 제거
        $(this).off("click");

        // 여기에 나머지 처리 코드 추가

        // 예를 들어, Ajax 요청 등의 코드를 추가할 수 있습니다.
         $.ajax({
             url: appPath + "/myPage/writeReview",
             type: "POST",
             data: formData,
             processData: false,
             contentType: false,
             success: function(res) {
             	if(res === "success") {
             		alert("리뷰 작성이 완료되었습니다.");
             	}
             	else {
             		alert("리뷰 작성에 실패했습니다.");
             	}
            	
            	$.ajax({
            		url: appPath + "/myPage",
            		type: "GET",
            		success: function() {
            			orderList();
            		}
            	});
            
             }
         });

    });
});

	
function closeReviewModal() {
    document.getElementById("reviewModal").style.display = "none";
    document.getElementById("reviewModalOverlay").style.display = "none";
}