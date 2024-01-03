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
				type:"get",
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
 
/*등록 데이터 전송 */
$('#PostingBtn').on('click',function(){
	
	var title=$('#inputTitle').val();
	var content=$('#inputContent').val();
	var fomattedContent= content.replace(/\n/g, '<br>');

	if (title.trim() === "" || content.trim() === "") {
		/*제목 또는 내용 입력 안하면 데이터 못 넘기게 해주기 */
        alert("제목과 내용을 입력해주세요.");
    } else {
       	// 폼이 유효하면 제출하거나 추가 작업을 수행하세요.
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
		formData.append('contents', fomattedContent);
		
		
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
		});
	}
});


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
$("#commentList").on('click', "#deleteCommentBtn", function(){
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
		data:{aetaNumber: aetaNumber},
		success:function(){	
				location.href=appPath+"/community/aetaUpdating?aetaNumber="+aetaNumber;
		}
	})
})


/* 수정 페이지에 데이터 전송*/
$("#updatePost").on('click',function(){
	//제목,사진,내용,글번호

	var title=$('#inputTitle').val();
	var content=$('#inputContent').val();
	var fomattedContent= content.replace(/\n/g, '<br>');
	var aetaNumber=$('#aetaNumber').val();
	//var oldImagesLength = document.getElementById('aetaCountImages').value;
	
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
	console.log(formData);
	
	$.ajax({
	type : "POST",
	url : appPath+"/community/aetaUpdating",
	data : formData,
	processData: false,
	contentType : false,
	success : function(response) {
		if(response=="success"){
			alert("게시물수정완료");
			location.href=appPath+"/community/aetaBoard";
		}else{
			alert("failed");
		}
	}
	})
}
)
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