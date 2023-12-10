<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="./main.css" rel="stylesheet" >
        <link href="./community.css" rel="stylesheet" >
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title>오늘운동했다그램</title>
    </head>
    <body>
        <%@ include file="./common/header.jsp" %>
    
        <div class="container">
            <%@ include file="./common/nav.jsp" %>
    
            <div id="writeOunwangram">
                <div id="uploadImage" class="uploadImage">
                    <div id="darkBorder"></div>
                    <label for="uploadImageInput">+</label>
                    <input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*">
                    <img id="ounwanUploadImage" src="../images/white.jpg">
                </div>
    
                <div class="writeGramContents">
                    <label>Content</label>
                    <input type="text" placeholder="최대 30자까지 작성 가능합니다.">
                    <span></span>
                    <div><div>0</div>/30</div>
                </div>
    
                <div class="writeGramContents">
                    <label>Hash Tag</label>
                    <input type="text" placeholder="HashTag 최대 5개 작성 가능합니다.">
                    <span></span>
                </div>
    
                <div class="writeGramScope">
                    <label>Scope</label>
                    <input class="ounwangramScope" name="ounwangramScope" type="radio" checked><span>전체 공개</span>
                    <input class="ounwangramScope" name="ounwangramScope" type="radio"><span>친구 공개</span>
    
                </div>
            </div>
    
        </div>

        <%@ include file="./common/footer.jsp" %>
    
        <script>
            var fileTag = $("#uploadImageInput")[0];
            var gramContentsInput = $(".writeGramContents").children("input");
    
            $("#uploadImageInput").on("change", function() {
                var imgTag = $("#ounwanUploadImage");
                console.log(fileTag[0]);
                if(fileTag.files.length > 0) {
                    var reader = new FileReader();
    
                    reader.onload = function(data) {
                        console.log(data);
                        imgTag.attr("src", data.target.result);
                    }
    
                    reader.readAsDataURL(fileTag.files[0]);
                } else {
                    imgTag.attr("src", "../images/white.jpg");
                }
            })
    
            
        </script>
    
        <style>
            #writeOunwangram {
                width: 1000px;
                margin: 50px auto 0px auto;
            }
    
            #darkBorder {
                position: relative;
                display: inline-block;
                width: 760px;
                height: 660px;
                border-radius: 10px;
                background-color: rgba(0, 0, 0, 0.3);
                z-index: 5;
                transform: scale(0);
            }
    
            #uploadImageInput {
                visibility: hidden;
                position: relative;
                bottom: 500px;
            }
    
            .uploadImage {
                width: 760px;
                height: 660px;
                margin: auto;
                border: 1px solid #ddd;
                border-radius: 10px;
            }
    
            .uploadImage:hover #darkBorder {
                transform: scale(1);
            }
    
            .uploadImage:hover label {
                transform: scale(1);
            }
    
            .uploadImage > label {
                position: relative;
                display: inline-block;
                background-color: #fff;
                width: 130px;
                height: 130px;
                bottom: 395px;
                left: 315px;
                border: 0;
                border-radius: 65px;
                font-size: 80px;
                transform: scale(0);
                text-align: center;
                z-index: 10;
            }
    
            .uploadImage > img {
                position: relative;
                display: inline-block;
                width: 760px;
                height: 660px;
                bottom: 794px;
                border-radius: 10px;
            }
    
            .writeGramContents {
                position: relative;
                z-index: 20;
            }
    
            .writeGramContents label, .writeGramScope label {
                display: block;
                padding-top: 30px;
                font-size: 30px;
                margin-bottom: 10px;
            }
    
            .writeGramContents input {
                width: 960px;
                padding: 10px 20px 10px 20px;
                border: 0;
                border-bottom: 2px solid #ddd;
            }
    
            .writeGramContents input:focus {
                outline: none;
            }
    
            .writeGramContents input:focus  ~ span {
                transform: scaleX(1);
            }
    
            .writeGramContents span {
                display: inline-block;
                position: relative;
                width: 1000px;
                border: 2px solid #aaa;
                border-radius: 30px;
                bottom: 15px;
                transform: scaleX(0);
                transition: all linear 0.2s;
            }
    
            .writeGramContents > div {
                text-align: right;
                position: relative;
                bottom: 20px;
            }
    
            .writeGramContents div > div {
                display: inline-block;
            }
    
            .ounwangramScope {
                width: 20px !important;
                height: 20px;
            }
    
            .writeGramScope {
                position: relative;
                z-index: 20;
            }
    
            .writeGramScope span {
                padding: 0px 40px 0px 10px;
                font-size: 20px;
            }
        </style>
    
        <script src="../js/community.js"></script>
        <script src="../js/main.js"></script>
    </body>
    </html>