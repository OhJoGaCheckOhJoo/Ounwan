var host = window.location.host + '/';
var appPath = '/myapp';
var router = new Map([
	['/ounwan/html/login.html', '/' + appPath + '/clients/login']
]);

$(function() {

    $("#profileImage").on("click", function() {
        if($(".header-sub-menu").css("visibility") == 'hidden'){
            $(".header-sub-menu").css("visibility", 'visible');
        } else {
            $(".header-sub-menu").css("visibility", 'hidden');
        }
    })

    $("#findAccount").click(function() {
        $("#findAccount").addClass("login-menu-selected");
        $("#loginAccount").removeClass("login-menu-selected");
        $("#loginAccountSelected").hide();
        $("#findAccountSelected").show();
    });

    $("#loginAccount").click(function() {
        $("#findAccount").removeClass("login-menu-selected");
        $("#loginAccount").addClass("login-menu-selected");
        $("#findAccountSelected").hide();
        $("#loginAccountSelected").show();
    });

    $("#findIdEmail").on("input", function() {
        var emails = [
            '@naver.com',
            '@gmail.com',
            '@daum.net',
            '@hanmail.net',
            '@yahoo.com',
            '@outlook.com',
            '@nate.com',
            '@kakao.com'
        ];
        if($(this).val().indexOf('@') > 1) {
            const id = $(this).val().slice(0, $(this).val().indexOf('@'));
            const mailAddress = $(this).val().slice($(this).val().indexOf('@'));
            const htmltag = emails.reduce((a,b) => {
                if(b.indexOf(mailAddress) > -1 && b != mailAddress) {
                    return a + "<a class='mail-menu' href='javascript:mailSelected(" + '"' + id + b + '"' + ");'>" + id + b + "</a><br>";
                } else {
                    return a;
                }
            }, "");
            $("#emailAutocomplete").html(htmltag);
        } else {
            $("#emailAutocomplete").html("");
        }
    });

    $("#loginSelect").click(function() {
        $.ajax({
        	url : appPath + "/clients/login",
        	type : 'GET',
        	success : function() {
        		$("body").html(loginPage);
        	}
        });
    });

    $("#findId").on("click", function() {
        var obj = {
            "name" : $("#findIdName").val(),
            "email" :  $("#findIdEmail").val()
        };
        $.ajax({
            url : appPath + '/clients/findId',
            data : obj,
            success : function(res) {
            	$("#findIdModalBody").html(res);
            	$("#findIdModalWrap").css("display", "block");
            },
            error : function(request,status,error) {
            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        })
    })

    $("#findPassword").on("click", function() {
    	$("#findPassword").attr("disabled");
    	$("#findPWBtnDiv").hide();
    	$("#loading").show();
        var obj = {
            "clientId" : $("#findPwId").val(),
            "email" : $("#findPwEmail").val()
        }
        $.ajax({
            url : appPath + '/clients/findPassword',
            type : 'GET',
            data : obj,
            contentType : "text/plain;charset=utf-8",
            dataType : "text",
            success : function(res) {
            	if(res == '변경성공') {
            		var openWindow = window.open(appPath + "/findPassword",'','width=700px,height=450px,location=no,status=no');
                	$("body").html(loginPage);
            	} else {
            		$("#findPassword").removeAttr("disabled");
            		$("#loading").hide();
            		$("#findPWBtnDiv").show();
            		alert("일치하는 회원 정보가 없습니다.");
            	}
            }
        })
    })

    $("#loginButton").on("click", function() {
        var userInfo = {
            "clientId" : "jj1234",
            "password" : "123456789",
            "name" : "정진",
            "email" : "jj@daum.net",
            "birthday" : "2022-08-29",
            "phone" : "010-1234-1234",
            "address" : "서울 마포구 월드컵북로4길 77",
            "address_detail" : "2호실",
            "zip_code" : "03993",
            "profile_url" : ""
        };
        if($("#loginId").val() == userInfo.clientId && $("#loginPassword").val() == userInfo.password) {
            sessionStorage.setItem("userInfo", userInfo);
            //location.href = "./";
        }

    })
})

function loadBanner(arr) {
    var i = 0;
    setInterval(function() {
        i = (i + 1) % arr.length;
        $("#main-banner").html("<img src = '" + arr[i] + "'>");
    }, 3000);
}

function populars(arr) {
    let tag = "";
    for(let i = 0; i < arr.length; i++) {
        let price = numberComma(arr[i].price) + "원";
        tag += "<div class='pointer'>";
        tag += "<img class='img-2 img-border' src= '" + arr[i].img + "'>";
        tag += "<div>" + arr[i].name + "</div>";
        tag += "<div>" + price + "</div>";
        tag += "</div>";
    }
    return tag;
}

function secondhands(arr) {
    let tag = "";
    for(let i = 0; i < arr.length; i++) {
        tag += "<div class='pointer'>";
        tag += "<img class='img-2 img-border' src= '" + arr[i].img + "'>";
        tag += "<div>" + arr[i].name + "</div>";
        tag += "</div>";
    }
    return tag;
}

function numberComma(n) {
    return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
}

function mailSelected(mail) {
    $("#email").val(mail);
    $("#emailAutocomplete").html("");
}

var burger = $('.menu-trigger');

burger.each(function(index){
  var $this = $(this);
  
  $this.on('click', function(e){
    e.preventDefault();
    $(this).toggleClass('active-' + (index+1));
    if($(this).attr("class") == 'menu-trigger') {
        $(".nav-submenu").show();
        $(".nav-menu").css("transform", "scaleY(0)");
    } else {
        $(".nav-submenu").hide();
        $(".nav-menu").css("transform", "scaleY(1)");
    }
  })
});

$(".faq-delivery").on("click", function() {
	faqCategory = 1;
	location.href = "/myapp/faq";
});

$('#logoutBtn').on('click', function() {
		$.ajax({
			url : appPath + "/clients/logout",
			type : "post",
			success : function (res) {
				if (res === 'success') {
					alert('어서가소');
					location.href = appPath;
				}
			}
		});
	});
    
$('#findIdModalBody').on('click', '#findIdClose', function() {
	$('#findIdModalWrap').css('display', 'none');
});
