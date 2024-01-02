var appPath ='/myapp';
document.addEventListener("DOMContentLoaded", function() {
	$('#orderNumberInput').focus();
});


$("#emailInput, #orderNumberInput").keydown(function (e) {
        if (e.keyCode === 13) {
            checkGuestInfo();
        }
});
	
function checkGuestInfo() {
	var orderNumber = $("#orderNumberInput").val();
	var email = $("#emailInput").val();

	if (orderNumber == "" || email == "") {
		alert("주문번호, 이메일을 모두 입력해주세요.");
		$("#orderNumberInput").val("");
		$("#emailInput").val("");
		$('#orderNumberInput').focus();
	}
	else {
		var data = {
			orderNumber : orderNumber,
			email : email
		};

		$.ajax({
			type : "POST", 
			url : appPath + "/guest/checkInfo",
			contentType : 'application/json; charset=utf-8', 
			data : JSON.stringify(data), 
			success : function(res) {
				$("#guestModal").html(res);	
			},
			error : function() {
			}
		});
	}
}	
	
function closeGuestOrderListModal() {
	document.getElementById("guestModal").style.display = "none";
	document.getElementById("guestModalOverlay").style.display = "none";
	
	window.location.href = appPath + "/guest";
}