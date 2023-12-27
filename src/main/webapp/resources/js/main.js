// 더미 데이터

var array_banner = ["./images/v616_37.png", "./images/v616_38.png", "./images/v616_39.png", "./images/v616_40.png"];

var popular1 = {
    "name" : "닭가슴살 100g",
    "price" : 1900,
    "img" : "./images/v606_26.png"
}

var popular2 = {
    "name" : "나이키 츄리닝 팬츠",
    "price" : 63000,
    "img" : "./images/v606_27.png"
}

var popular3 = {
    "name" : "단백질 쉐이크 초코맛 2kg",
    "price" : 68000,
    "img" : "./images/v606_28.png"
}

var popular4 = {
    "name" : "리스펙짐 헬스 이용권 (1개월)",
    "price" : 55000,
    "img" : "./images/v606_29.png"
}

var popular5 = {
    "name" : "접이식 런닝머신",
    "price" : 319900,
    "img" : "./images/v606_30.png"
}

var array_popular = [popular1, popular2, popular3, popular4, popular5];

var secondhand1 = {
    "name" : "이고진 마에스트로 런닝머신",
    "img" : "./images/v861_260.png"
}

var secondhand2 = {
    "name" : "단백질 숯불갈비맛 새상품 9개 냉동",
    "img" : "./images/v861_261.png"
}

var secondhand3 = {
    "name" : "헬스장 스포짐 오목교점 9개월 양도합니다~!",
    "img" : "./images/v861_262.png"
}

var secondhand4 = {
    "name" : "자라 검은색 트레이닝복 팝니다 30",
    "img" : "./images/v861_263.png"
}

var secondhand5 = {
    "name" : "접이식 실내 자전거",
    "img" : "./images/v861_264.png"
}

var array_secondhand = [secondhand1, secondhand2, secondhand3, secondhand4, secondhand5];

// -----------

var host = window.location.host + '/';
var appPath = '/myapp';
var router = new Map([
	['/ounwan/html/login.html', '/' + appPath + '/clients/login']
]);

$(function() {
    loadBanner(array_banner);
    $("#populars").html(populars(array_popular));
    $("#secondhands").html(secondhands(array_secondhand));

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
            type : 'GET',
            data : obj,
            contentType : "text/plain;charset=utf-8",
            dataType : "text",
            success : function(res) {
            	if(res != "") {
            		var openWindow = window.open(appPath + "/findId?" + res,'','width=700px,height=500px,location=no,status=no');
            	} else {
            		alert("일치하는 회원 정보가 없습니다.");
            	}	
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
        console.log(obj);
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
            alert(1);
            console.log(sessionStorage.getItem("userInfo"));
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