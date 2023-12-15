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

	
})