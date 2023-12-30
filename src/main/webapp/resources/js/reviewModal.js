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
								appPath + "/images/myPage/full_star.png");
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
			reader.onload = function(event) {
				img.src = event.target.result;
			}
			reader
					.readAsDataURL(document.getElementById("reviewImageInput").files[0]);
		}
	}
$(document).ready(function() {
    $("#ReviewSubmitButton").off("click").on("click", function(event) {
        var reviewDetailNumber = orderDetailNumber;
        var reviewScore = filledStar;
        var reviewContent = $("#reviewContent").val();
        var reviewImage = $("#reviewImageInput")[0].files;

        if (reviewScore === 0 || reviewContent.trim() === '') {
            alert("필수 항목을 작성해 주세요");
            return false; 
        }

        var formData = new FormData();

        formData.append("reviewDetailNumber", reviewDetailNumber);
        formData.append("reviewScore", reviewScore);
        formData.append("reviewContent", reviewContent);
        
        if (reviewImage.length > 0) {
            formData.append("reviewImage", reviewImage[0]);
        } else {
        	formData.append("reviewImage", null);
        }

        $(this).off("click");

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