	$("#like-button").on("click",function(){
		var aetaNumber = $("#aetaNumber").val();
		var obj={
			"aetaNumber":aetaNumber
		}
	$.ajax({
		url : appPath+"/community/likeButton",
		type : 'post',
		data : obj,
		success : function(data){
				if(data.like === true){
					$("#aeta-like-png").attr("src",appPath+"/images/likeImages/like.png");
					$("#count-likes").html(data.likesCount);
				}
				else{
					$("#aeta-like-png").attr("src",appPath+"/images/likeImages/dislike.png");
					$("#count-likes").html(data.likesCount);
				}
		},
		error:function(	){
			alert("error");
		}
	})
	});
	

function search(page) {
			var obj = {
				"selectedOption" : $('select[name="option"]').val(),
				"inputValue" : $("#inputValue").val(),
				"page": page
			};	
			$.ajax({
				url : appPath+"/community/aetaSearch",
				data : obj,
				type:"get",
				success : function(response) {
					$('#aeta-list').html(response);
				},
				error : function() {
					alert("error");
				}
			});
}

$("#searchBtn").click(function(){
 	search(1);
});

$("#inputValue").keypress(function(event){
	if(event.which===13){
	event.preventDefault();
	search();
	}
});


$("#loginPageBtn").click(function(){
	location.href = appPath+"/clients/login";
})

$("#postBtn").click(function(){
	location.href = appPath+"/community/aetaPosting";
})

var imageList = [];
if(window.location.pathname == '/myapp/community/aetaPosting') {
	$("#inputImg").on("change", function(event) {
		if(event.target.files.length > 0) {
			$("#imagePreview").html("");
	        imageList = event.target.files;
	        for(var i = 0; i < imageList.length; i++) {
	            $("#imagePreview").append('<img src="/">');
	            var imageURL = URL.createObjectURL(imageList[i]);
	            $("#imagePreview img").eq(i).attr("src", imageURL);
	        }
		}
	});
	
	$("#imagePreview").on("click", "img", function() {
		var i = 0;
		var removeIndex = 0;
		var temp = [];
		for(; i < $("#imagePreview img").length; i++) {
			if($(this).attr('src') == $("#imagePreview img").eq(i).attr('src')) {
				removeIndex = i;
			} else {
				temp.push(imageList[i]);
			}
		}
		$("#imagePreview img").eq(removeIndex).remove();
		imageList = temp;
	});
}
 
$('#PostingBtn').on('click',function(){
	
	var title=$('#inputTitle').val();
	var content=$('#inputContent').val();
	var fomattedContent= content.replace(/\n/g, '<br>');

	if (title.trim() === "" || content.trim() === "") {
        alert("제목과 내용을 입력해주세요.");
    } else {
		var images=$('#inputImg')[0].files;
		var imagesLength=$('#inputImg')[0].files.length;
		
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
		formData.append('contents', fomattedContent);
		
		$.ajax({
		type : "POST",
		url : appPath+"/community/aetaPosting",
		data : formData,
		processData: false,
		contentType : false,
		success : function(response) {
			if(response=="success"){
				alert("게시글을 등록하였습니다.");
				location.href=appPath+"/community/aetaBoard";
			}else{
				alert("failed");
			}
		}
		});
	}
});

$("#insertCommentBtn").click(function(){
	var aetaNumber = $('#aetaNumber').val();
	var contents = $('#inputComment').val();
	var obj = {
			"aetaNumber": aetaNumber,
			"contents": contents
		};
	$.ajax({
		type : "POST",
		url : appPath+"/community/aetaInsertComment",
		data : JSON.stringify(obj),
		contentType : "application/json",
		success : function(response) {
			alert("게시글을 작성 완료하였습니다.");
			location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
		}
	});
})

$("#commentList").on('click', "#deleteCommentBtn", function(){
	var commentNo=$(this).parent().parent().find('.commentId').val();
	var aetaNumber = $('#aetaNumber').val(); 
	
	var obj = {		
			"commentNumber": commentNo
		};
	$.ajax({
		type: "DELETE",
		url: appPath+"/community/aetaDeleteComment",
		data:JSON.stringify(obj),
		contentType : "application/json",
		success:function(res){
			alert("해당 댓글을 삭제하였습니다.");
			location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
		}
	})
});

$("#AetaUpdateBtn").on('click',function(){
	var aetaNumber=$("#aetaNumber").val();
	
	$.ajax({
		type:"get",
		url:appPath+"/community/aetaUpdating",
		data:{aetaNumber: aetaNumber},
		success:function(){	
				location.href=appPath+"/community/aetaUpdating?aetaNumber="+aetaNumber;
		}
	})
})

imageList = [];
if(window.location.pathname == '/myapp/community/aetaUpdating') {
	$("#inputImg").on("change", function(event) {
		if(event.target.files.length > 0) {
			$("#imagePreview").html("");
	        imageList = event.target.files;
	        for(var i = 0; i < imageList.length; i++) {
	            $("#imagePreview").append('<img src="/">');
	            var imageURL = URL.createObjectURL(imageList[i]);
	            $("#imagePreview img").eq(i).attr("src", imageURL);
	        }
		}
	});
	
	$("#imagePreview").on("click", "img", function() {
		var i = 0;
		var removeIndex = 0;
		var temp = [];
		for(; i < $("#imagePreview img").length; i++) {
			if($(this).attr('src') == $("#imagePreview img").eq(i).attr('src')) {
				removeIndex = i;
			} else {
				temp.push(imageList[i]);
			}
		}
		$("#imagePreview img").eq(removeIndex).remove();
		imageList = temp;
	});
}

$("#updatePost").on('click',function(){
	var title=$('#inputTitle').val();
	var content=$('#inputContent').val();
	var fomattedContent= content.replace(/\n/g, '<br>');
	var aetaNumber=$('#aetaNumber').val();
	
	var newImages=$('#inputImg')[0].files;
	var newImagesLength=$('#inputImg')[0].files.length;
	var formData= new FormData();
	if(newImagesLength===0){
		formData.append('newImagesLength',0);
		formData.append('newImages',null);
	}else{
		formData.append('newImagesLength',newImagesLength);
		for(var i=0; i<newImagesLength; i++){
			formData.append('newImages',newImages[i]);
		}
	}
	formData.append('title',title);
	formData.append('contents',fomattedContent);
	formData.append('aetaNumber', aetaNumber);
	
	$.ajax({
	type : "POST",
	url : appPath+"/community/aetaUpdating",
	data : formData,
	processData: false,
	contentType : false,
	success : function(response) {
		if(response=="success"){
			alert("해당 게시물을 수정하였습니다.");
			location.href=appPath+"/community/aetaPost?aetaNumber="+aetaNumber;
		}else{
			alert("게시물 수정에 실패하였습니다.");
		}
	}
	})
}
)
$("#AetaDeleteBtn").click(function(){
	var aetaNumber=$('#aetaNumber').val();
	var obj={
		"aetaNumber":aetaNumber
	};
	$.ajax({
		type: "DELETE",
		url: appPath+"/community/aetaDeletePost",
		data:JSON.stringify(obj),
		contentType : "application/json",
		success:function(res){
			location.href=appPath+"/community/aetaBoard";
		}
	})
});		