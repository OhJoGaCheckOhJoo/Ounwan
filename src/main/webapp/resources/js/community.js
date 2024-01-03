var countGramFollow = 0;
var countGramWhole = 0;
var countGramTag = 0;
var gramEnd = false;
var scrollHeight = $(document).height() - $(window).height();
var timer;
var originalImg = $("#ounwanUploadImage").attr("src");
var fileTag = $("#uploadImageInput")[0];
var gramContentsInput = $(".writeGramContents").children("input");
var gramContent = "";
var gramHashTag = "";
var changImage = false;
var gramPath = "/myapp/community";

$(window).on("load", function() {

    if(window.location.pathname == gramPath + "/ounwangram") {
        loadGramWholeBoard();
        const modal = document.getElementById('modalWrap');
		const closeBtn = document.getElementById('closeBtn');
		var report = {};
		var reportReason = [];
		
		modal.style.display = "none";
        
        $("#goMyProfile").on("click", function() {
        	location.href = gramPath + "/ounwanProfile?clientId=" + $("#clientId").html();
        });
        
        $(".reason").on("change", function() {
        	if($(this).is(":checked")) {
        		reportReason.push($(this).val());
        	} else {
        		reportReason.splice(reportReason.indexOf($(this).val()), 1);
        	}
        });
        
        $("#reportSubmit").on("click", function() {
        	if(reportReason.length > 0) {
	        	report.reason = reportReason;
	        	$.ajax({
		            url: gramPath + "/ounwangram/reportBoard",
		            data: report,
		            traditional: true,
		            success : function(res) {
		            	if(res == 'success') {
		            		report = {};
		            		alert("신고처리가 완료되었습니다.");
		            	} else {
		            		report = {};
		            		alert("신고 처리에 실패하였습니다.");
		            	}
		            	report = {};
		            	modal.style.display = "none";
		            	location.href = gramPath + "/ounwangram";
		            },
		            error : function(request,status,error) {
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            }    
	            });
        	} else {
        		alert("신고 사유를 선택해주세요.");
        	}
        });
        
        $("#gramSearchResult").on("click", "#searchTag", function() {
        	countGramTag = 0;
        	$("#ounwangramBoard").html("");
        	$("#gramWholeBoard").removeClass("ounwangram_selected");
        	$("#gramFollowBoard").removeClass("ounwangram_selected");
        	loadGramTagBoard($(this).find('span').html().slice(1));
        });
        
        $("#ounwangramBoard").on("click", "#searchTag", function() {
        	countGramTag = 0;
        	$("#ounwangramBoard").html("");
        	$("#gramWholeBoard").removeClass("ounwangram_selected");
        	$("#gramFollowBoard").removeClass("ounwangram_selected");
        	loadGramTagBoard($(this).html().slice(1));
        });

        $("#gramFollowBoard").on("click", function() {
            if(!$("#gramFollowBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramWholeBoard").removeClass("ounwangram_selected");
                $("#gramFollowBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramFollow = 0;
                loadGramFollowBoard();
            }
        });

        $("#gramWholeBoard").on("click", function() {
            if(!$("#gramWholeBoard").attr("class").toString().includes("ounwangram_selected")) {
                $("#gramFollowBoard").removeClass("ounwangram_selected");
                $("#gramWholeBoard").addClass("ounwangram_selected");
                $("#ounwangramBoard").html("");
                gramEnd = false;
                countGramWhole = 0;
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
                            } else if($("#gramFollowBoard").attr("class").toString().includes("ounwangram_selected")) {
                                loadGramFollowBoard();
                            } else {
                            	loadGramTagBoard();
                            }   
                            timer = null;
                        }, 500);
                    }
                }
            }
        });
		
		
		$("#ounwangramBoard").on("click", "#ounwanLikeBtn", function() {
            $(this).disabled = true;
            var img = $(this).children('img');
            var span = $(this).parent().children('span').first();
            $.ajax({
                url: gramPath + "/ounwangram/likeBoard",
                data: { "communityNumber" : $(this).val() },
                success : function(res) {
                    if(res.likesCheck < 2) {
                        img.attr("src", "../images/ounwan_like_" + res.likesCheck + ".png");
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
        });

        $("#ounwangramBoard").on("click", "#updateGramBoard", function() {
            location.href= gramPath + "/updateGramBoard?communityNumber=" + $(this).val();
        })

        $("#ounwangramBoard").on("click", "#deleteGramBoard", function() {
            if(confirm("삭제하시겠습니까?")){
            	var communityNumber = $(this).val();
            	console.log("delete : " + communityNumber);
            	$.ajax({
                	url: gramPath + "/ounwangram/deleteBoard",
                	data: { "communityNumber" : communityNumber },
                	success: function(res) {
                		if(res == 'success') {
                			alert("삭제하였습니다.");
                            location.reload();
                        } else {
                            alert("게시글 삭제에 실패하였습니다. 이후에 다시 시도해주세요.");
                        }
                	}
                })
            } else {
            	console.log("삭제취소");
            }
            
        });

        $("#ounwangramBoard").on("click", "#reportGramBoard", function() {
        	reportReason = [];
            $("#reportId").html("|&nbsp;" + $(this).val().split("@")[1]);
            report.communityNumber = $(this).val().split("@")[0];
            $(".reason").prop("checked", false);
            report.board = $(this).parent().parent().parent();
            modal.style.display = 'block';
        })
        
        $("#gramSearch").on("input", function() {
            var keyword = $(this).val();
            if(keyword.length > 0) {
                $("#gramSearchResult").css('visibility', 'visible');
            } else {
                $("#gramSearchResult").css('visibility', 'hidden');
            }
            $.ajax({
                url: gramPath + "/ounwangram/ajaxSearch",
                data: { "keyword" : keyword },
                success: function(res) {
                    if(res[0] != null) {
                        $("#gramSearchResult").html(`
                        <div>해시태그로 검색</div>
                        <a id='searchTag'>
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
                            <a href="${gramPath}/ounwanProfile?clientId=${res[i].CLIENT_ID}">
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
        
        closeBtn.onclick = function() {
        	  report = {};
			  modal.style.display = 'none';
		}
		
    } else if(window.location.pathname == gramPath + "/writeGramBoard" || window.location.pathname == gramPath + "/updateGramBoard") {
    	var hashTagArray = [];
        if(hashTagArray.length == 0) {
            for(var i = 0; i < document.querySelectorAll("#addedHashTag span").length; i++) {
                var text = document.querySelectorAll("#addedHashTag span")[i].textContent;
                hashTagArray.push(text.substr(0, text.length - 1));
            }
        }

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

        var formData = new FormData();

        $("#uploadImageInput").on("change", function() {
            var imgTag = $("#ounwanUploadImage");
            if(fileTag.files.length > 0) {
            	$("#ounwanUploadImage").attr('hidden', false);
                var reader = new FileReader();
                formData = new FormData();
                formData.append('image', $("input[name='uploadImageInput']")[0].files[0]);
                reader.onload = function(data) {
                    imgTag.attr("src", data.target.result);
                }

                reader.readAsDataURL(fileTag.files[0]);
                changImage = true;
            }
        });

        $("#submitButton").on("click", function() {
            if(!changImage) {
                alert("이미지를 등록해주세요!");
            } else {
                if(hashTagArray.length < 5 && $("#ounwanGramHashTag").val() != "") {
                    if($("#ounwanGramHashTag").val().includes("#")) {
                        hashTagArray.push($("#ounwanGramHashTag").val().slice(1,$("#ounwanGramHashTag").val().length));
                    } else {
                        hashTagArray.push($("#ounwanGramHashTag").val());
                    }
                }
                formData.append('content', $("#ounwanGramContent").val());
                formData.append('hashTag', hashTagArray);
                $.ajax({
                	url: gramPath + "/ounwangram/writeBoard",
                	data: formData,
                	type: "post",
                	processData: false,
                	contentType: false,
                	enctype: 'multipart/form-data',
                	success: function(res) {
                		if(res == 'success') {
                            location.href = gramPath + "/ounwangram";
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
                url: gramPath + "/ounwangram/updateBoard",
                data: formData,
                type: "post",
                processData: false,
                contentType: false,
                enctype: 'multipart/form-data',
                success: function(res) {
                    if(res == 'success') {
                        location.href = gramPath + "/ounwangram";
                    } else {
                        alert("게시글 수정에 실패하였습니다. 이후에 다시 시도해주세요.");
                    }
                }
            })
        });
    } else if(window.location.pathname == gramPath + '/ounwanProfile') {
    	const modal = document.getElementById('modalWrap');
    	const followModal = document.getElementById('followModalWrap');
    	const boardModal = document.getElementById('boardModalWrap');
		modal.style.display = "none";
		followModal.style.display = "none";
		boardModal.style.display = "none";
		
		$("#boardDetail").on("click", "#reportGramBoard", function() {
			var communityNumber = $(this).val().split("@")[0];
			if(confirm("해당 게시물을 정말 신고하시겠습니까?")) {
				$.ajax({
		            url: gramPath + "/ounwangram/reportBoard",
		            data: {
		            	"communityNumber": communityNumber,
		            	"reason": [8]
		            },
		            traditional: true,
		            success : function(res) {
		            	if(res == 'success') {
		            		report = {};
		            		alert("신고처리가 완료되었습니다.");
		            	} else {
		            		report = {};
		            		alert("신고 처리에 실패하였습니다.");
		            	}
		            	report = {};
		            	modal.style.display = "none";
		            	location.reload();
		            },
		            error : function(request,status,error) {
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            }    
	            });
			} else {
			
			}
		});
		
		$("#boardDetail").on("click", "#ounwanLikeBtn", function() {
            $(this).disabled = true;
            var img = $(this).children('img');
            var span = $(this).parent().children('span').first();
            $.ajax({
                url: gramPath + "/ounwangram/likeBoard",
                data: { "communityNumber" : $(this).val() },
                success : function(res) {
                    if(res.likesCheck < 2) {
                        img.attr("src", "../images/ounwan_like_" + res.likesCheck + ".png");
                        span.html(res.likes);
                    } else {
                        alert("좋아요를 실패하였습니다.");
                    }
                }
            })
            $(this).disabled = false;
		});
		
		$("#boardDetail").on("click", "#searchTag", function() {
        	countGramTag = 0;
        	$("#ounwangramBoard").html("");
        	$("#gramWholeBoard").removeClass("ounwangram_selected");
        	$("#gramFollowBoard").removeClass("ounwangram_selected");
        	loadGramTagBoard($(this).find('span').html().slice(1));
        });

		$("#boardDetail").on("click", "#threeDotBtn", function() {
        	if($(this).parent().parent().find('div:eq(2)').css("visibility") == "hidden") {
            	$(this).parent().parent().find('div:eq(2)').css("visibility","visible");
            } else {
            	$(this).parent().parent().find('div:eq(2)').css("visibility","hidden");
            }
        });

 		$("#boardDetail").on("click", "#updateGramBoard", function() {
            location.href = gramPath + "/updateGramBoard?communityNumber=" + $(this).val();
        });

        $("#boardDetail").on("click", "#deleteGramBoard", function() {
            if(confirm("삭제하시겠습니까?")){
            	var communityNumber = $(this).val();
            	console.log("delete : " + communityNumber);
            	$.ajax({
                	url: gramPath + "/ounwangram/deleteBoard",
                	data: { "communityNumber" : communityNumber },
                	success: function(res) {
                		if(res == 'success') {
                			alert("삭제하였습니다.");
                            location.reload();
                        } else {
                            alert("게시글 삭제에 실패하였습니다. 이후에 다시 시도해주세요.");
                        }
                	}
                })
            } else {
            	console.log("삭제취소");
            }
            
        })
		
		$("#myProfileBoards").on("click", ".myProfileBoardImage", function() {
			var communityNumber = $(this).parent().find('input').val();
			$.ajax({
				url: gramPath + "/gramDetail?communityNumber=" + communityNumber,
				success: function(res) {
					$("#boardDetail").html(res);
					boardModal.style.display = "block";
				}
			});
		})
		
		$("#myProfileOption").on("click", "#followButton", function() {
			var button = $(this);
			$.ajax({
				url: gramPath + "/checkFollowing" + window.location.search,
				success: function(res) {
					if(res > 0) {
						if(confirm("정말 팔로우를 취소하시겠습니까?")) {
							$.ajax({
								url: gramPath + "/cancelFollowing" + window.location.search,
								success: function(res) {
									if(res > 0) {
										button.html("follow");
									} else {
										alert("실패하였습니다.");
									}
								}
							});
						}
					} else {
						$.ajax({
							url: gramPath + "/addFollowing" + window.location.search,
							success: function(res) {
								if(res > 0) {
									button.html("following ✔");
								} else {
									alert("실패하였습니다.");
								}
							}
						});
					}
				}
			})
		});
		
		$("#followList").on("click", "#followBtn", function() {
			var button = $(this);
			$.ajax({
				url: gramPath + "/checkFollowing?clientId=" + button.val(),
				success: function(res) {
					if(res > 0) {
						if(confirm("정말 팔로우를 취소하시겠습니까?")) {
							$.ajax({
								url: gramPath + "/cancelFollowing?clientId=" + button.val(),
								success: function(res) {
									if(res > 0) {
										button.html("follow");
									} else {
										alert("실패하였습니다.");
									}
								}
							});
						}
					} else {
						$.ajax({
							url: gramPath + "/addFollowing?clientId=" + button.val(),
							success: function(res) {
								if(res > 0) {
									button.html("following ✔");
								} else {
									alert("실패하였습니다.");
								}
							}
						});
					}
				}
			})
		})
		
		$("#followList").on("click", "#following", function() {
			$.ajax({
				url: gramPath + "/following" + window.location.search,
				success: function(res) {
					$("#followList").html(res);
				}
			})
		});
		
		$("#followList").on("click", "#follower", function() {
			$.ajax({
				url: gramPath + "/followers" + window.location.search,
				success: function(res) {
					$("#followList").html(res);
				}
			})
		});
		
		$("#follower").on("click", function() {
			$.ajax({
				url: gramPath + "/followers" + window.location.search,
				success: function(res) {
					$("#followList").html(res);
					followModal.style.display = "block";
				}
			})
			console.log(window.location.search);
		});
		
		$("#following").on("click", function() {
			$.ajax({
				url: gramPath + "/following" + window.location.search,
				success: function(res) {
					$("#followList").html(res);
					followModal.style.display = "block";
				}
			})
			console.log(window.location.search);
		});
		
		$("#myInbodyButton").on("click", function() {
			$.ajax({
				url: gramPath + "/inbody",
				success: function(res) {
					$("#inbodyGraph").html(res);
					modal.style.display = "block";
				}
			});
		});
		
		$("#closeBtn").on("click", function() {
			modal.style.display = "none";
		})
		$("#followCloseBtn").on("click", function() {
			followModal.style.display = "none";
		})
		$("#boardCloseBtn").on("click", function() {
			boardModal.style.display = "none";
		})
    } else if(window.location.pathname == gramPath + '/inbodyInsert') {
    	$("#inbodyInsertBtn").on("click", function() {
    		var formData = new FormData($("#insertData")[0]);
    		$.ajax({
	    		url: gramPath + "/insertInbody",
	    		type: 'post',
	    		data: formData,
	    		processData: false,
                contentType: false,
	    		success: function(res) {
	    			if(res.result == 'success') {
	    				alert('등록하였습니다.');
	    			} else {
	    				alert('등록에 실패하였습니다.');
	    			}
	    			location.href = gramPath + "/ounwanProfile?clientId=" + res.clientId;
	    		}
    		})
    	})
    	
    	$("#inbodyDetail").on("click", "#updateInbody", function() {
    		var formData = new FormData($(this).parent()[0]);
    		$.ajax({
	    		url: gramPath + "/updateInbody",
	    		type: 'post',
	    		data: formData,
	    		processData: false,
                contentType: false,
	    		success: function(res) {
	    			if(res.result == 'success') {
	    				alert('수정하였습니다.');
	    			} else {
	    				alert('수정에 실패하였습니다.');
	    			}
	    			location.href = gramPath + "/ounwanProfile?clientId=" + res.clientId;
	    		}
    		})
    	})
    }
})

var loadGramTagBoard = function(tagName) {
	$.ajax({
        url: gramPath + "/ounwangram/tagBoard",
        data: {
        		"rowNum": countGramTag * 5,
        		"name": tagName
        	},
        success : function(res) {
            loadBoard(res);
            countGramTag += 1;
        }
    })
}

var loadGramWholeBoard = function() {
	$.ajax({
        url: gramPath + "/ounwangram/wholeBoard",
        data: { "rowNum": countGramWhole * 5 },
        success : function(res) {
            loadBoard(res);
            countGramWhole += 1;
        }
    })
}

var loadGramFollowBoard = function() {
	$.ajax({
        url: gramPath + "/ounwangram/followBoard",
        data: { "rowNum": countGramFollow * 5 },
        success : function(res) {
            loadBoard(res);
            countGramFollow += 1;
        }
    })
}

var loadBoard = function(res) {
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
    	if(res[i].mine) {
    		boardOption = "<button id='updateGramBoard' value=" + res[i].communityNumber + ">수정하기</button>";
            boardOption += "<button id='deleteGramBoard' value=" + res[i].communityNumber + ">삭제하기</button>";
    	} else {
    		boardOption = "<button id='reportGramBoard' value=" + res[i].communityNumber + "@" + res[i].clientId + ">신고하기</button>";
    	}
        var hashTagDiv = "";
        for(var j = 0; j < res[i].hashTags.length; j++) {
            hashTagDiv += "<span id='searchTag'>#" + res[i].hashTags[j] + "</span>";
        }
        $("#ounwangramBoard").append(`
        <div class="ounwangram-main">
            <div>
                <a class="pointer ounwangram-profile"  href="${gramPath}/ounwanProfile?clientId=${res[i].clientId}">
                    <img src="${res[i].profileUrl}">
                    <div>${res[i].clientId}</div>
                </a>
                <div class="ounwangram-threedot-div">
                    <button id='threeDotBtn' class="ounwangram-threedot"><img class="ounwangram-threedot" src="../images/three_dot.png"></button>
                </div>
                <div class="gramBoardOption">
                	${boardOption}
                </div>
                <div class="ounwangram-board">
                	<img src="${res[i].imageUrl}">
                </div>
                <div class="ounwan-like">
                	<button id="ounwanLikeBtn" value="${res[i].communityNumber}">
                		<img src="../images/ounwan_like_${res[i].likesCheck}.png">
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
    scrollHeight = $(document).height() - $(window).height();
}

