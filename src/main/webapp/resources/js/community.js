/* 검색 */
 $("#searchBtn").click(function() {
			
			var obj = {
				"selectedValue" : $('select[name="option"]').val(),
				"input" : $("#searchWord").val()
			};		
			$.ajax({
				type : "GET",
				url : appPath+"/community/aetaSearch",
				data : obj,
				success : function(response) {
					console.log("button works");
					$('#aetaList').html(response);
				},
				error : function() {
					alert("error");
				}
			});
		})
		
/*  */