/* 검색 function */
function search() {
			
			var obj = {
				"selectedOption" : $('select[name="option"]').val(),
				"inputValue" : $("#inputValue").val()
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
		}


/*검색 기능*/
$("#searchBtn").click(function(){
 	search();
});

/*Enter키로 검색*/		
$("#inputValue").keypress(function(event){
	if(event.which===13){
	event.preventDefault();
	search();
	}
});


/* 로그인 페이지 이동*/
$("#loginPageBtn").click(function(){
	location.href = appPath+"/clients/login";
})

/* 게시글 등록 페이지 이동 (로그인 시 가능)*/
$("#postBtn").click(function(){
	location.href = appPath+"/community/aetaPosting";
})

/*댓글*/
/*댓글입력 insertCommentBtn*/
$("#insertCommentBtn").click(function(){
	var boardNo = $('#boardNO').val();
	var contents = $('#inputComment').val();
	var obj = {
			"boardNumber": boardNo,
			"contents": contents
		};
	console.log(obj);
	$.ajax({
		type : "POST",
		url : appPath+"/community/aetaInsertComment",
		data : JSON.stringify(obj),
		contentType : "application/json",
		success : function(response) {
			alert(response);
			location.href=appPath+"/community/aetaPost?boardNumber="+boardNo;
		}
	});
})
/*댓글 삭제*/
$("#commentList").on('click', "#deleteCommentBtn", function(){
	var boardNo=$('#boardNO').val();
	var commentNo=$('#commentNo').val();
	var obj = {
			"boardNumber": boardNo,
			"commentNumber": commentNo
		};
		console.log(obj);
	$.ajax({
		type: "DELETE",
		url: appPath+"/community/aetaDeleteComment",
		data:JSON.stringify(obj),
		contentType : "application/json",
		success:function(res){
			alert("delete "+res);
			location.href=appPath+"/community/aetaPost?boardNumber="+boardNo;
		}
	})
});
/*애타 게시글삭제*/
$("#deletePostBtn").click(function(){
	var boardNo=$('#boardNO').val();
	
	var obj={
		"boardNumber":boardNo,
	};

	console.log(obj);
	$.ajax({
		type: "DELETE",
		url: appPath+"/community/aetaDeletePost",
		data:JSON.stringify(obj),
		contentType : "application/json",
		success:function(res){
			alert("delete "+res);
			location.href=appPath+"/community/aetaBoards";
		}
	})
});

/*	
	$('#inputImg').on("change",function(){
		var imgURL = $("#imgURL");
		var reader = new FileReader();
		reader.onload=function(data){
			imgURL.attr("src",data.target.result);
		}
	});
*/
	
	/*애타 게시글등록*/
	$('#PostingBtn').on('click',function(){
		
		var title=$('#inputTitle').val();
		var content=$('#inputContent').val();
		var obj = {
			"title": title,
			"contents": content
		};
		$.ajax({
		type : "POST",
		url : appPath+"/community/aetaPosting",
		data : JSON.stringify(obj),
		contentType : "application/json",
		success : function(response) {
			if(response=="success"){
				alert("게시물등록완료");
				location.href=appPath+"/community/aetaBoards";
			}else{
				alert("failed");
			}
		}
		})
	});
		/*
		var formData=new FormData();
		
		formData.append('title',$("#inputTitle").val());
		formData.append('content',$("#inputContent").val());
		formData.append('image',$("#inputImg")[0].files[0]);
		alert($("#inputTitle").val());
		alert($("#inputContent").val());
		alert($("#inputImg")[0].files[0]);
		
		
		$.ajax({
			type: "post",
			data:formData,
			url: appPath+"/community/aetaPosting",
			processData:false,
			contentType:false,
			enctype: 'multipart/form-data',
			success:function(res){
				if(res==='success'){
					alert("insert "+res);
					location.href=appPath+"/community/aetaBoards";
				}else{
					alert("게시글 등록 실패 ㅅㄱ")
				}

			}
		})
		*/

	