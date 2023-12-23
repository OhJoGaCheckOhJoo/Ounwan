 function openDeatilModal(clickedElement) {
	document.getElementById("detailModal").style.display = "block";
	document.getElementById("detailModalOverlay").style.display = "block";

	var orderNumber = $(clickedElement).find(".send-order-number").text();
 	var orderDate = $(clickedElement).find(".send-order-date").text();
	
	$("#modalOrderNumber").text(orderNumber);
	$("#modalOrderDate").text(orderDate);
	
	showOrderDetails(orderNumber);
}
 
function showOrderDetails(orderNumber) {
	$(".order-detail.product-info.modal").hide(); // 모든 주문 상세 정보 감추기
    $(".order-detail[order-number='" + orderNumber + "']").show();
}

function closeDetailModal() {
	document.getElementById("detailModal").style.display = "none";
	document.getElementById("detailModalOverlay").style.display = "none";

}