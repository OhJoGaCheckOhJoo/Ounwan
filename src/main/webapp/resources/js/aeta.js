/* 애타 좋아요 버튼*/ 
	$("#like-button").on("click",function(){
		var aetaNumber = $("#aetaNumber").val();
		console.log(aetaNumber);
		var obj={
			"aetaNumber":aetaNumber
		}
		console.log(aetaNumber);
	$.ajax({
		url : appPath+"/community/likeButton",
		type : 'post',
		data : obj,
		success : function(data){
			console.log(data);
				if(data.like === true){
					$("#aeta-like-png").attr("src",appPath+"/images/aetaUploads/like.png");
					$("#count-likes").html(data.likesCount);
				}
				else{
					$("#aeta-like-png").attr("src",appPath+"/images/aetaUploads/dislike.png");
					$("#count-likes").html(data.likesCount);
				}
		},
		error:function(	){
			alert("error");
		}
	});
	});

/* 검색 function */
function search(page) {
			
			var obj = {
				"selectedOption" : $('select[name="option"]').val(),
				"inputValue" : $("#inputValue").val(),
				"page": page
			};		
			
			$.ajax({
				url : appPath+"/community/aetaSearch",
				data : obj,
				success : function(response) {
					console.log("button works");
					$('#aeta-list').html(response);
				},
				error : function() {
					alert("error");
				}
			});
}

/*검색 기능*/
$("#searchBtn").click(function(){
 	search(1);
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

/*애타 게시글등록*/
/* 게시글 등록 페이지 이동 (로그인 시 가능)*/
$("#postBtn").click(function(){
	location.href = appPath+"/community/aetaPosting";
})

/*애타 게시글 등록 시 사진미리보 */
function readUrl(input) {
	var file = input.files[0] 
	console.log(input);
	if (file != '') {
	   var reader = new FileReader();
	   reader.readAsDataURL(file);
	   reader.onload = function (e) { 
	   console.log(e.target)
	   console.log(e.target.result)
		 $('#imgPreview').attr('src', e.target.result);
		}
	}
} 

/*
$("#inputImg").on("change",function(){
	const input= $("#inputImg")[0].files[0];
	console.log(input);
});
*/
 
/*등록 데이터 전송 */
$('#PostingBtn').on('click',function(){
	
	var title=$('#inputTitle').val();
	var content=$('#inputContent').val();
	
	var images=$('#inputImg')[0].files;
	var imagesLength=$('#inputImg')[0].files.length;
	console.log("이미지"+images);
	console.log("이미지갯수"+imagesLength);
	
	var formData= new FormData();
		
	if(imagesLength===0){
		formData.append('imagesLength',0);
		formData.append('images',null);
	}else{
		formData.append('imagesLength',imagesLength);
		for(var i=0; i<imagesLength; i++){
			formData.append('images',images[i]);
		}
	}
	formData.append('title',title);
	formData.append('contents',content);
	
	
	$.ajax({
	type : "POST",
	url : appPath+"/community/aetaPosting",
	data : formData,
	processData: false,
	contentType : false,
	success : function(response) {
		if(response=="success"){
			alert("게시물등록완료");
			location.href=appPath+"/community/aetaBoard";
		}else{
			alert("failed");
		}
	}
	})
});

// $(document).ready(function() {
// 	$("a[name='file-delete']").on("click", function(e) {
// 		e.preventDefault();
// 		deleteFile($(this));
// 	});
// })

// function addFile() {
// 	var str = "<div class='file-group'><input type='file' name='file'><a href='#this' name='file-delete'>삭제</a></div>";
// 	$("#file-list").append(str);
// 	$("a[name='file-delete']").on("click", function(e) {
// 		e.preventDefault();
// 		deleteFile($(this));
// 	});
// }

// function deleteFile(obj) {
// 	obj.parent().remove();
// }

/*댓글*/
/*댓글입력 insertCommentBtn*/
$("#insertCommentBtn").click(function(){
	var aetaNumber = $('#aetaNumber').val();
	var contents = $('#inputComment').val();
	var obj = {
			"aetaNumber": aetaNumber,
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
			location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
		}
	});
})

/*댓글 삭제*/
$(".commentList").on('click', "#deleteCommentBtn", function(){
	var commentNo=$(this).parent().parent().find('.commentId').val();
	var aetaNumber = $('#aetaNumber').val(); 
	
	var obj = {		

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
			location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
		}
	})
});



/*애타 게시글수정 */
/* 수정페이지 이동 */
$("#AetaUpdateBtn").on('click',function(){
	var aetaNumber=$("#aetaNumber").val();

	$.ajax({
		type:"get",
		url:appPath+"/community/aetaUpdating",
		data:{
			"aetaNumber":aetaNumber
		},
		success:function(){	
				location.href=appPath+"/community/aetaUpdating?aetaNumber="+aetaNumber;
		}
	})
})


/* 수정 페이지에 데이터 전송*/
$("#updatePost").on('click',function(){
	//제목,사진,내용,글번호

	var title=$().val();
	var content=$().val();
	var aetaNumber=$().val();

	obj={
		"title":title,
		"content":content,
		"aetaNumber":aetaNumber
	}
	console.log(obj);
	$.ajax({
		type:"get",
		url:appPath+"/community/aetaUpdating",
		data:obj,
		success:function(response){
			if(res=="success"){		
				alert("update"+res);
				location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
			}else{
				alert("update"+res);
			}
		}
	})

}
)
/* 수정 커밋 버튼*/
$("#updateConfirmBtn").on('click',function(){
	var aetaNumber = $('#aetaNumber').val();
	var title= $('#inputTitle').val();
	var imgageURL =$('#inputImg').val();
	var content =$('#inputContent').val();
	
	// var data={
	var post={
		"aetaNumber":aetaNumber,
		"title":title,
		"content":content,
	};
	var images={
		"aetaNumber":aetaNumber,
		"imgageURL":imgageURL
	};
// };
	console.log(post);
	console.log(images);

	$.ajax({
		type:"put",
		url:appPath+"/community/aetaUpdatePost",
		// contentType: 'application/json',
        data:JSON.stringify(post,images),
		contentType : "application/json",
		success:function(res){
			if(res=="success"){
				alert("update"+res);
				location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
			}else{
				alert("update"+res);
			}
		}
	})
})


// $("#").click(function(){
// 	var aetaNumber=$('#aetaNumber').val();
// 	var clientId=$('#aetaWriter').attr("value");
// 	var title=$('#aetaTitle').attr("value");
// 	var content=$('#aetaContent').attr("value");
// 	var obj={
// 		"aetaNumber":aetaNumber,
// 		"clientId":clientId,
// 		"title":title,
// 		"contents":content,
// 	};

// 	console.log(obj);
// 	$.ajax({
// 		type: "put",
// 		url: appPath+"/community/aetaUpdatePost",
// 		data:JSON.stringify(obj),
// 		contentType : "application/json",
// 		success:function(res){
// 			if(res=="success"){
// 				alert("update"+res);
// 				location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
// 			}else{
// 				alert("update"+res);
// 			}
// 		}
// 	})
// });

/*애타 게시글삭제*/
$("#AetaDeleteBtn").click(function(){
	var aetaNumber=$('#aetaNumber').val();
	
	var obj={
		"aetaNumber":aetaNumber
	};

	console.log(obj);
	$.ajax({
		type: "DELETE",
		url: appPath+"/community/aetaDeletePost",
		data:JSON.stringify(obj),
		contentType : "application/json",
		success:function(res){
			alert("delete "+res);
			location.href=appPath+"/community/aetaBoard";
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
					location.href=appPath+"/community/aetaBoard";
				}else{
					alert("게시글 등록 실패 ㅅㄱ")
				}

			}
		})
		*/