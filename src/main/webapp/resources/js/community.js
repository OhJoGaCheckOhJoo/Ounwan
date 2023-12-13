var countGramFollow = 0;
var countGramWhole = 0;
var gramEnd = false;
var scrollHeight = $(document).height() - $(window).height();
var timer;
var originalImg = $("#ounwanUploadImage").attr("src");
var fileTag = $("#uploadImageInput")[0];
var gramContentsInput = $(".writeGramContents").children("input");
var gramContent = "";
var gramHashTag = "";
var changImage = false;

$(window).on("load", function() {

    if(window.location.pathname == "/ounwan/ounwangram") {
        const orgId = $("#clientId").html();
        loadGramWholeBoard(orgId);
        
        $("#goMyProfile").on("click", function() {
        	location.href = "/ounwan/ounwanProfile?clientId=" + $("#clientId").html();
        })

        $("#gramFollowBoard").on("click", function() {
            if($("#gramWholeBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramWholeBoard").removeClass("ounwangram_selected");
                $("#gramFollowBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramWhole = 0;
                loadGramFollowBoard(orgId);
            }
        });

        $("#gramWholeBoard").on("click", function() {
            if($("#gramFollowBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramFollowBoard").removeClass("ounwangram_selected");
                $("#gramWholeBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramFollow = 0;
                loadGramWholeBoard(orgId);
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
                                loadGramWholeBoard(orgId);
                            } else {
                                loadGramFollowBoard(orgId);
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

        $("#ounwangramBoard").on("click", "#threeDotBtn", function() {
        	if($(this).parent().parent().find('div:eq(2)').css("visibility") == "hidden") {
            	$(this).parent().parent().find('div:eq(2)').css("visibility","visible");
            } else {
            	$(this).parent().parent().find('div:eq(2)').css("visibility","hidden");
            }
        })

        $("#ounwangramBoard").on("click", "#updateGramBoard", function() {
            location.href="updateGramBoard?communityNumber=" + $(this).val();
        })

        $("#ounwangramBoard").on("click", "#deleteGramBoard", function() {
            if(confirm("삭제하시겠습니까?")){
            	var communityNumber = $(this).val();
            	console.log("delete : " + communityNumber);
            	$.ajax({
                	url: "/ounwan/ounwangram/deleteBoard",
                	data: { "communityNumber" : communityNumber },
                	success: function(res) {
                		if(res == 'success') {
                			alert("삭제하였습니다.");
                            location.href = "ounwangram";
                        } else {
                            alert("게시글 삭제에 실패하였습니다. 이후에 다시 시도해주세요.");
                        }
                	}
                })
            } else {
            	console.log("삭제취소");
            }
            
        })

        $("#ounwangramBoard").on("click", "#reportGramBoard", function() {
            console.log("report : " + $(this).val());
        })
        
        $("#gramSearch").on("input", function() {
            var keyword = $(this).val();
            if(keyword.length > 0) {
                $("#gramSearchResult").css('visibility', 'visible');
            } else {
                $("#gramSearchResult").css('visibility', 'hidden');
            }
            $.ajax({
                url: "/ounwan/ounwangram/ajaxSearch",
                data: { "keyword" : keyword },
                success: function(res) {
                    if(res[0] != null) {
                        $("#gramSearchResult").html(`
                        <div>해시태그로 검색</div>
                        <a href="#">
                            <span>#${res[0].NAME}</span>
                            <span id="searchRight">게시글 ${res[0].COUNT}</span>
                        </a>`
                        );
                    } else{
                        $("#gramSearchResult").html("");
                    }
                    
                    if(keyword.length > 3) {
                        if(res.length > 1) {
                            $("#gramSearchResult").append("<div>아이디로 검색</div>");
                        }
                        for(var i = 1; i < res.length; i++) {
                            $("#gramSearchResult").append(`
                            <a href="/ounwan/ounwanProfile?clientId=${res[i].CLIENT_ID}">
                                <img src='${res[i].PROFILE_URL}'>
                                <span>${res[i].CLIENT_ID}</span>
                                <span id="searchRight">팔로워 ${res[i].FOLLOWER}</span>
                                </a>`
                                );
                        }
                    }
                }
            })
        });
		
    } else if(window.location.pathname == "/ounwan/writeGramBoard" || window.location.pathname == "/ounwan/updateGramBoard") {
    	var hashTagArray = [];
        if(hashTagArray.length == 0) {
            for(var i = 0; i < document.querySelectorAll("#addedHashTag span").length; i++) {
                var text = document.querySelectorAll("#addedHashTag span")[i].textContent;
                hashTagArray.push(text.substr(0, text.length - 1));
            }
        }
    	
    	$("#uploadImageInput").on("change", function() {
            var imgTag = $("#ounwanUploadImage");
            if(fileTag.files.length > 0) {
                var reader = new FileReader();

                reader.onload = function(data) {
                    imgTag.attr("src", data.target.result);
                }

                reader.readAsDataURL(fileTag.files[0]);
                changImage = true;
            } else {
                imgTag.attr("src", "../images/white.jpg");
            }
        });

        $("#ounwanGramContent").on("input", function() {
            $("#gramContentLength").html($(this).val().length);
            if($(this).val().length == 30) {
                gramContent = $(this).val();
            } else if ($(this).val().length > 30) {
                $(this).val(gramContent);
                $("#gramContentLength").html("30");
            }
        });

        $("#ounwanGramHashTag").on("input", function() {
            var hashTags = $(this).val();
            $("#gramHashTagLength").html(hashTags.length - hashTags.includes("#"));
            if($(this).val().length == 15) {
                gramHashTag = $(this).val();
            } else if ($(this).val().length - hashTags.includes("#") > 15) {
                $(this).val(gramHashTag);
                $("#gramHashTagLength").html("15");
            }
        });

        $("#ounwanGramHashTag").on("keypress", function(event) {
            var hashTags = "";
            if($("#ounwanGramHashTag").val().includes("#")) {
            	hashTags = $("#ounwanGramHashTag").val();
            } else {
            	hashTags = "#" + $("#ounwanGramHashTag").val();
            }
            if(hashTags.length >= 2 && (event.keyCode == 13 || event.keyCode == 32)) {
                event.preventDefault();
                if(hashTagArray.length < 5) {
                    if(!hashTagArray.includes(hashTags)) {
                        $("#addedHashTag").append("<span>" + hashTags + "<button id='removeHashTag'>x</button></span>");
                        hashTagArray.push(hashTags.slice(1));
                    }
                    $("#ounwanGramHashTag").val("");
                    $("#gramHashTagLength").html("0");
                } else {
                    $("#hashTagAlert").css("visibility", "visible");
                }
            }
        });

        $("#addedHashTag").on("click", "#removeHashTag", function() {
            hashTagArray.splice(hashTagArray.indexOf($(this).parent().text().substr(1, $(this).parent().text().length - 1)), 1);
            $(this).parent().remove();
            $("#hashTagAlert").css("visibility", "hidden");
        });

        $("#submitButton").on("click", function() {
            if(originalImg == $("#ounwanUploadImage").attr("src")) {
                alert("이미지를 등록해주세요!");
            } else {
                var formData = new FormData();
                if(hashTagArray.length < 5 && $("#ounwanGramHashTag").val() != "") {
                    if($("#ounwanGramHashTag").val().includes("#")) {
                        hashTagArray.push($("#ounwanGramHashTag").val().slice(1,$("#ounwanGramHashTag").val().length));
                    } else {
                        hashTagArray.push($("#ounwanGramHashTag").val());
                    }
                }
                formData.append('image', $("input[name='uploadImageInput']")[0].files[0]);
                formData.append('content', $("#ounwanGramContent").val());
                formData.append('hashTag', hashTagArray);
                $.ajax({
                	url: "/ounwan/ounwangram/writeBoard",
                	data: formData,
                	type: "post",
                	processData: false,
                	contentType: false,
                	enctype: 'multipart/form-data',
                	success: function(res) {
                		if(res == 'success') {
                            location.href = "ounwangram";
                        } else {
                            alert("게시글 등록에 실패하였습니다. 이후에 다시 시도해주세요.");
                        }
                	}
                })
            }
        });

        $('#updateButton').on("click", function() {
            var formData = new FormData();
            if(hashTagArray.length < 5 && $("#ounwanGramHashTag").val() != "") {
                if($("#ounwanGramHashTag").val().includes("#")) {
                    hashTagArray.push($("#ounwanGramHashTag").val().slice(1,$("#ounwanGramHashTag").val().length));
                } else {
                    hashTagArray.push($("#ounwanGramHashTag").val());
                }
            }
            console.log(hashTagArray);
            formData.append('communityNumber', $('#updateButton').val());
            if(changImage) {
                formData.append('image', $("input[name='uploadImageInput']")[0].files[0]);
            }
            formData.append('content', $("#ounwanGramContent").val());
            formData.append('hashTag', hashTagArray);
            $.ajax({
                url: "/ounwan/ounwangram/updateBoard",
                data: formData,
                type: "post",
                processData: false,
                contentType: false,
                enctype: 'multipart/form-data',
                success: function(res) {
                    if(res == 'success') {
                        location.href = "ounwangram";
                    } else {
                        alert("게시글 수정에 실패하였습니다. 이후에 다시 시도해주세요.");
                    }
                }
            })
        });
    }
})

const loadGramWholeBoard = function(orgId) {
	if(orgId != $("#clientId").html()) {
		alert("잘못된 요청입니다.");
		location.href = "./";
	}
	$.ajax({
        url: "/ounwan/ounwangram/wholeBoard",
        data: { "rowNum": countGramWhole * 5 },
        success : function(res) {
        	var clientId = $("#clientId").html();
            for(let i = 0; i < res.length; i++) {
            	if(res[i].contents == null) {
            		res[i].contents = "";
            	}
            	if(res[i].updatedDate == null) {
            		res[i].updatedDate = "";
            	} else {
            		res[i].updatedDate = " (수정됨)";
            	}
            	if(res[i].clientId == clientId) {
            		boardOption = "<button id='updateGramBoard' value=" + res[i].communityNumber + ">수정하기</button>";
                    boardOption += "<button id='deleteGramBoard' value=" + res[i].communityNumber + ">삭제하기</button>";
            	} else {
            		boardOption = "<button id='reportGramBoard' value=" + res[i].communityNumber + ">신고하기</button>";
            	}
                var hashTagDiv = "";
                for(var j = 0; j < res[i].hashTags.length; j++) {
                    hashTagDiv += "<span id='searchTag'>#" + res[i].hashTags[j] + "</span>";
                }
                $("#ounwangramBoard").append(`
                <div class="ounwangram-main">
	                <div>
		                <a class="pointer ounwangram-profile" href="/ounwan/ounwanProfile?clientId=${res[i].clientId}">
		                    <img src="${res[i].profileUrl}">
		                    <div>${res[i].clientId}</div>
		                </a>
		                <div class="ounwangram-threedot-div">
		                    <button id='threeDotBtn' class="ounwangram-threedot"><img class="ounwangram-threedot" src="./images/three_dot.png"></button>
		                </div>
		                <div class="gramBoardOption">
		                	${boardOption}
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
                        <div class="hashDiv">${hashTagDiv}</div>
		                <div class="ounwan-date">
                            <span>${new Date(res[i].createdDate).toISOString().split('T')[0]}</span>
                        	<span>${new Date(res[i].createdDate).toTimeString().split(' ')[0].slice(0,5)}</span>
                        	<span>${res[i].updatedDate}</span>
                        </div>
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

const loadGramFollowBoard = function(orgId) {
	if(orgId != $("#clientId").html()) {
		alert("잘못된 요청입니다.");
		location.href = "./";
	}
	$.ajax({
        url: "/ounwan/ounwangram/followBoard",
        data: { "rowNum": countGramFollow * 5 },
        success : function(res) {
        	var clientId = $("#clientId").html();
            for(let i = 0; i < res.length; i++) {
            	if(res[i].contents == null) {
            		res[i].contents = "";
            	}
            	if(res[i].updatedDate == null) {
            		res[i].updatedDate = "";
            	} else {
            		res[i].updatedDate = "(수정됨)";
            	}
            	var boardOption = "";
            	if(res[i].clientId == clientId) {
            		boardOption = "<button id='updateGramBoard' value=" + res[i].communityNumber + ">수정하기</button>";
                    boardOption += "<button id='deleteGramBoard' value=" + res[i].communityNumber + ">삭제하기</button>";
            	} else {
            		boardOption = "<button id='reportGramBoard' value=" + res[i].communityNumber + ">신고하기</button>";
            	}
                var hashTagDiv = "";
                for(var j = 0; j < res[i].hashTags.length; j++) {
                    hashTagDiv += "<span id='searchTag'>#" + res[i].hashTags[j] + "</span>";
                }
                $("#ounwangramBoard").append(`
                <div class="ounwangram-main">
	                <div>
		                <a class="pointer ounwangram-profile"  href="/ounwan/ounwanProfile?clientId=${res[i].clientId}">
		                    <img src="${res[i].profileUrl}">
		                    <div>${res[i].clientId}</div>
		                </a>
		                <div class="ounwangram-threedot-div">
		                    <button id='threeDotBtn' class="ounwangram-threedot"><img class="ounwangram-threedot" src="./images/three_dot.png"></button>
		                </div>
		                <div class="gramBoardOption">
		                	${boardOption}
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
                        <div class="hashDiv">${hashTagDiv}</div>
		                <div class="ounwan-date">
                            <span>${new Date(res[i].createdDate).toISOString().split('T')[0]}</span>
                        	<span>${new Date(res[i].createdDate).toTimeString().split(' ')[0].slice(0,5)}</span>
                        	<span>${res[i].updatedDate}</span>
                        </div>
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
