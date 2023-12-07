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
var appPath = '/ounwan';
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

    $("#email").on("propertychange change paste input", function() {
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
        //location.href = appPath + '/login';
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
            		var openWindow = window.open(appPath + "/findId?" + obj.name + "@" + res,'','width=700px,height=500px,location=no,status=no');
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
  })
});

var loginPage = `
<header><a class="logo" href= "./"></a></header>

    <div class="container">
        <div class="login-menu">
            <div><a href="#" class="login-menu-selected" id="loginAccount">&nbsp;로그인&nbsp;</a></div>
            <div class="float-right"><a href="#" id="findAccount">&nbsp;아이디/비밀번호 찾기&nbsp;</a></div>
        </div>

        <!-- 로그인 -->
        <div class="login-container" id="loginAccountSelected">
            <!-- 소셜 로그인 -->
            <div class="social-wrap">
                <a href="#"><img class="login login-radius" src="./images/google.png"></a><br>
                <a href="#"><img class="login login-radius" src="./images/naver_btn.png"></a><br>
                <a href="#"><img class="login login-radius" src="./images/kakao.png"></a><br>
            </div>

            <!-- 일반 로그인 -->
            <div class="login-wrap-1 float-right">
                <form>
                    <div class="login">
                        <input type="text" required>
                        <label>아이디</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input type="password" required>
                        <label>비밀번호</label>
                        <span></span>
                    </div>
                    <div class="login login-radius"><button>로그인</button></div>
                </form>
                <div class="login-sub"><a class="login-sub-1" href="#">회원이 아니신가요? 지금 가입하세요!</a></div>
                <div class="login-sub"><a class="login-sub-2" href="#">비회원 주문조회</a></div>
            </div>
        </div>

        <!-- 아이디/비밀번호 찾기 -->
        <div class="login-container" id="findAccountSelected" hidden>
            <div class="login-wrap-2">
                <h3>아이디 찾기</h3>
                <form>
                    <div class="login">
                        <input id="findIdName" type="text" required>
                        <label>이름</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input id="findIdEmail" type="text" required>
                        <label>이메일</label>
                        <span></span>
                    </div>
                    <div class="email-autocomplete" id="emailAutocomplete"></div>
                    <div class="login login-radius"><button type="button" id="findId">아이디 찾기</button></div>
                </form>
            </div>
            <div class="login-wrap-1 float-right">
                <h3 class="login-padding-left">비밀번호 찾기</h3>
                <form>
                    <div class="login">
                        <input id="findPwId" type="text" required>
                        <label>아이디</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input id="findPwEmail" type="text" required>
                        <label>이메일</label>
                        <span></span>
                    </div>
                    <div class="login login-radius">
                        <button type="button" id="findPassword">
                        	<div class="btn-div" id="findPWBtnDiv">임시비밀번호 발급</div>
	                        <div class="loading-container" id="loading">
	                            <div class="loading"></div>
	                        </div>
                        </button>
                    </div>
                </form>
            </div>
            <div class="find-guide">* 회원가입 시 사용하신 이메일 주소를 통해 아이디/비밀번호를 찾으실 수 있습니다.</div>
        </div>
    </div>
    <script src="./js/main.js"></script>
`;