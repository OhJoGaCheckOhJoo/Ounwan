	var appPath = '/myapp';
	
	function openRefundModal(clickedElement) {
		document.getElementById("refundModal").style.display = "block";
		document.getElementById("refundtModalOverlay").style.display = "block";
		
		var orderNumber = $(clickedElement).parent().parent().parent().parent().find(".send-order-number").text();
	}
	
	function closeRefundModal() {
		document.getElementById("refundModal").style.display = "none";
		document.getElementById("refundtModalOverlay").style.display = "none";
	}
	
	function submitRefund(orderNumber) {
		var selectedReason = document.querySelector('.refund-reason inp`ut[name="refundReason"]:checked');
		
				
		console.log("NUM: " + orderNumber);
		var reason = "";
		console.log("R: "+selectedReason);
		if (selectedReason) {
			reason = selectedReason.value;
			console.log("2: " + reason);
			var obj = {
				"orderNumber" : orderNumber,
				"reason" : reason
			};

			$.ajax({
				url : appPath + '/myPage/refund',
				type : 'POST',
				data : JSON.stringify(obj),
				contentType : 'application/json',
				success : function(res) {
					alert(res + " 환불 접수가 완료되었습니다.");
				}
			});

			closeRefundModal();
		}

		else {
			alert("환불 사유를 선택해주세요.");
		}
	}
