	var appPath = '/myapp';
	
	var selectedOrderNumber;
	
	function openRefundModal(orderNumber) {
		document.getElementById("refundModal").style.display = "block";
		document.getElementById("refundtModalOverlay").style.display = "block";
		
		selectedOrderNumber = orderNumber
		console.log("openNumber: " + selectedOrderNumber);
	}
	
	function closeRefundModal() {
		document.getElementById("refundModal").style.display = "none";
		document.getElementById("refundtModalOverlay").style.display = "none";
	}
	
	function submitRefund(orderNumber) {
		var selectedReason = document.querySelector('.refund-reason input[name="refundReason"]:checked');
		var reason = "";		
		
		if (selectedReason) {
			reason = selectedReason.value;
			var obj = {
				"orderNumber" : selectedOrderNumber,
				"reason" : reason
			};

			$.ajax({
				url : appPath + '/myPage/refund',
				type : 'POST',
				data : JSON.stringify(obj),
				contentType : 'application/json',
				success : function(res) {
					if(res === "success") {
						alert("환불 접수가 완료되었습니다.");
					}
					else {
						alert("환불 중 문제가 발생했습니다." )
					}
					
					$.ajax({
						type : "GET",
						url : appPath + "/myPage/coupungOrderList",
						success : function(res) {
							$("#content").html(res);
						}
					});
					
				}
			});
			closeRefundModal();
		}

		else {
			alert("환불 사유를 선택해주세요.");
		}
	}
