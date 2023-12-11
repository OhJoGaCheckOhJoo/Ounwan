var countGramFollow = 0;
var countGramWhole = 0;
var gramEnd = false;
var scrollHeight = $(document).height() - $(window).height();
var timer;
var originalImg = $("#ounwanUploadImage").attr("src");
var fileTag = $("#uploadImageInput")[0];
var gramContentsInput = $(".writeGramContents").children("input");
var gramContent = "";

var loadGramWholeBoard = function() {
	$.ajax({
        url: "/ounwan/ounwangram/wholeBoard",
        data: { "rowNum": countGramWhole * 5 },
        success : function(res) {
            for(let i = 0; i < res.length; i++) {
                $("#ounwangramBoard").append(`
                <div class="ounwangram-main">
	                <div>
		                <div class="pointer ounwangram-profile">
		                    <img src="${res[i].profileUrl}">
		                    <div>${res[i].clientId}</div>
		                </div>
		                <div class="ounwangram-threedot-div">
		                    <button class="ounwangram-threedot"><img class="ounwangram-threedot" src="./images/three_dot.png"></button>
		                </div>
		                <div class="ounwangram-board">
		                	<img src="${res[i].imageUrl}">
		                </div>
		                <div class="ounwan-like">
		                	<button id="ounwanLikeBtn" value="${res[i].communityNumber}">
		                		<img src="./images/ounwan_like_${res[i].likesCheck}.png">
		                	</button>
		                	<span>${res[i].likes}</span><span>Likes</span>
		                </div>
		                <div class="ounwangram-content">${res[i].contents}</div>
	                </div>
                </div>
                <hr>
                `);
            }
            if(res.length < 5) {
                gramEnd = true;
            }
            countGramWhole += 1;
            scrollHeight = $(document).height() - $(window).height();
        }
    })
}

var loadGramFollowBoard = function() {
	$.ajax({
        url: "/ounwan/ounwangram/followBoard",
        data: { "rowNum": countGramFollow * 5 },
        success : function(res) {
            for(let i = 0; i < res.length; i++) {
                $("#ounwangramBoard").append(`
                <div class="ounwangram-main">
	                <div>
		                <div class="pointer ounwangram-profile">
		                    <img src="${res[i].profileUrl}">
		                    <div>${res[i].clientId}</div>
		                </div>
		                <div class="ounwangram-threedot-div">
		                    <button class="ounwangram-threedot"><img class="ounwangram-threedot" src="./images/three_dot.png"></button>
		                </div>
		                <div class="ounwangram-board">
		                	<img src="${res[i].imageUrl}">
		                </div>
		                <div class="ounwan-like">
		                	<button id="ounwanLikeBtn" value="${res[i].communityNumber}">
		                		<img src="./images/ounwan_like_${res[i].likesCheck}.png">
		                	</button>
		                	<span>${res[i].likes}</span><span>Likes</span>
		                </div>
		                <div class="ounwangram-content">${res[i].contents}</div>
	                </div>
                </div>
                <hr>
                `);
            }
            if(res.length < 5) {
                gramEnd = true;
            }
            countGramFollow += 1;
            scrollHeight = $(document).height() - $(window).height();
        }
    })
}

$(window).on("load", function() {
    if(window.location.pathname == "/ounwan/ounwangram") {
        loadGramWholeBoard();

        $("#gramFollowBoard").on("click", function() {
            if($("#gramWholeBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramWholeBoard").removeClass("ounwangram_selected");
                $("#gramFollowBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramWhole = 0;
                loadGramFollowBoard();
            }
        });

        $("#gramWholeBoard").on("click", function() {
            if($("#gramFollowBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramFollowBoard").removeClass("ounwangram_selected");
                $("#gramWholeBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramFollow = 0;
                loadGramWholeBoard();
            }
        });

        $("#toTopScroll").on("click", function() {
            window.scrollTo(0, 0);
        })
        
        $(window).scroll(function() {
            if(!gramEnd) {
                if(!timer) {
                    if($(window).scrollTop() > scrollHeight - 300) {
                        timer = setTimeout(function() {
                            if($("#gramWholeBoard").attr("class").toString().includes("ounwangram_selected")) {
                                loadGramWholeBoard();
                            } else {
                                loadGramFollowBoard();
                            }    
                            timer = null;
                        }, 300);
                    }
                }
            }
        });
		
		
		$("#ounwangramBoard").on("click", "#ounwanLikeBtn", function() {
            $(this).disabled = true;
            var img = $(this).children('img');
            var span = $(this).parent().children('span').first();
            $.ajax({
                url: "/ounwan/ounwangram/likeBoard",
                data: { "communityNumber" : $(this).val() },
                success : function(res) {
                    if(res.likesCheck < 2) {
                        img.attr("src", "./images/ounwan_like_" + res.likesCheck + ".png");
                        span.html(res.likes);
                    } else {
                        alert("좋아요를 실패하였습니다.");
                    }
                }
            })
            $(this).disabled = false;
		});
		
    } else if(window.location.pathname == "/ounwan/writeGramBoard") {
    	$("#uploadImageInput").on("change", function() {
            var imgTag = $("#ounwanUploadImage");
            if(fileTag.files.length > 0) {
                var reader = new FileReader();

                reader.onload = function(data) {
                    imgTag.attr("src", data.target.result);
                }

                reader.readAsDataURL(fileTag.files[0]);
            } else {
                imgTag.attr("src", "../images/white.jpg");
            }
        })

        $("#ounwanGramContent").on("input", function() {
            $("#gramContentLength").html($(this).val().length);
            if($(this).val().length == 30) {
                gramContent = $(this).val();
            } else if ($(this).val().length > 30) {
                $(this).val(gramContent);
                $("#gramContentLength").html("30");
            }
        })

        $("#submitButton").on("click", function() {
            if(originalImg == $("#ounwanUploadImage").attr("src")) {
                alert("이미지를 등록해주세요!");
            } else {
                var formData = new FormData();
                formData.append('image', $("input[name='uploadImageInput']")[0].files[0]);
                formData.append('content', $("#ounwanGramContent").val());
                formData.append('hashTag', $("#ounwanGramHashTag").val());
                $.ajax({
                	url: "/ounwan/ounwangram/writeBoard",
                	data: formData,
                	type: "post",
                	processData: false,
                	contentType: false,
                	enctype: 'multipart/form-data',
                	success: function(res) {
                		alert(res);
                	}
                })
            }
        })
    }
})