var host = window.location.host + '/';
var appPath = '/myapp';
var router = new Map([
	['/ounwan/html/login.html', '/' + appPath + '/clients/login']
]);
var arrayBanner = [
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704252314009.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704252595798.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704252703729.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704305918409.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704305940177.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704305967157.png',
	'https://ounwan.s3.ap-northeast-2.amazonaws.com/1704306067755.png'
];

$(function() {
	loadBanner(arrayBanner);

    $("#profileImage").on("click", function() {
        if($(".header-sub-menu").css("visibility") == 'hidden'){
            $(".header-sub-menu").css("visibility", 'visible');
        } else {
            $(".header-sub-menu").css("visibility", 'hidden');
        }
    })
    
    $("body").on("click", "#findPWButton", function() {
    	$("#findIdModalWrap").css("display", "none");
    	location.href = "/myapp/clients/login";
    });

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
    	if($("#findPwId").val().length == 0) {
    		alert("아이디를 입력해주세요");
    	} else if($("#findPwEmail").val().length == 0) {
    		alert("이메일을 입력해주세요");
    	} else {
    		$("#findPassword").attr("disabled");
	    	$("#findPWBtnDiv").hide();
	    	$("#loading").show();
	        var obj = {
	            "id" : $("#findPwId").val(),
	            "email" : $("#findPwEmail").val()
	        };
	        $.ajax({
	            url : appPath + '/clients/findPassword',
	            type : 'GET',
	            data : obj,
	            contentType : "text/plain;charset=utf-8",
	            dataType : "text",
	            success : function(res) {
	            	$("#findIdModalBody").html(res);
        			$("#findIdModalWrap").css("display", "block");
	            }
	        });
    	}
    });

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
    }, 5000);
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
					location.href = appPath;
				}
			}
		});
	});
    
$('#findIdModalBody').on('click', '#findIdClose', function() {
	$('#findIdModalWrap').css('display', 'none');
});
