var appPath = '/myapp';

$(function() {
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
					alert(responseData);
				},
				error : function() {
					alert("존재하지 않는 상품입니다.");
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
	
	window.open(url, "/bixSiri/danggunChat", "width=500, height=800, top=200, left=200");
});
