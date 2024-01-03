var appPath = '/myapp';

$(function() {
	$(".photos").on("click", ".detail-img", function() {
	    var detailsrc = $(this).attr("src");
	    $(this).attr("src", $(".product-img-1 img").attr("src"));
	    $(".product-img-1 img").attr("src", detailsrc);
	});

	$("#danggunDelete").on("click", function() {
		var danggunNumber = document.getElementById('danggunModal').getAttribute('danggunNumber');	
		var clientId = document.getElementById('danggunModal').getAttribute('clientId');
		var obj = {
			"danggunNumber" : danggunNumber,
			"clientId" : clientId
		};

		var confirmDelete = confirm("정말 삭제하시겠습니까?");
		if (confirmDelete) {
			$.ajax({
				url : appPath + '/danggun/delete',
				type : 'DELETE',
				contentType : 'application/json; charset=utf-8',
				dataType : 'text',
				data : JSON.stringify(obj),
				success : function(responseData) {
					alert("삭제에 성공하였습니다.");
				}
			});
		}
	});
	
	$("#wishListBtn").on("click",function(){
		var danggunNumber = document.getElementById('danggunModal').getAttribute('danggunNumber');	
		$.ajax({
			url: appPath + "/danggun/wishLists",
			data: {"danggunNumber" : danggunNumber},
			type: "get",
			success: function(responseData){
				if(responseData.likesCheck < 2) {
					alert(responseData.zzimCount);
					$("#wishListImg").attr("src","../images/danggun_wishlist_" + responseData.likesCheck + ".png");
					$("#small").text(responseData.zzimCount);
				} else {
					alert("찜하기에 실패하였습니다.");
				}		
			}
		});
	});
	
})
$("#chatting").on("click",function(e){
	e.preventDefault();
	
    var seller = encodeURIComponent(document.getElementById('danggunModal').getAttribute('clientId'));
    var danggunNumber = encodeURIComponent(document.getElementById('danggunModal').getAttribute('danggunNumber'));
	var url = appPath + "/danggun/bixSiri/chat?seller="+seller+"&danggunNumber="+danggunNumber;
	
	window.open(url, "/chat/danggunChat", "width=500, height=800, top=200, left=200");
});
