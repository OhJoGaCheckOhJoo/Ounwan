function openDeatilModal(selectedorderNumber, selectedDate) {
	document.getElementById("detailModal").style.display = "block";
	document.getElementById("detailModalOverlay").style.display = "block";

	var orderNumber = selectedorderNumber;
 	var orderDate = selectedDate.substring(0, 10);
	
	$("#modalOrderNumber").text(orderNumber);
	$("#modalOrderDate").text(orderDate);
	
	showOrderDetails(orderNumber);
}
 
function showOrderDetails(orderNumber) {
	$(".order-detail.product-info.modal").hide();
    $(".order-detail[order-number='" + orderNumber + "']").show();
}

function closeDetailModal() {
	document.getElementById("detailModal").style.display = "none";
	document.getElementById("detailModalOverlay").style.display = "none";

}