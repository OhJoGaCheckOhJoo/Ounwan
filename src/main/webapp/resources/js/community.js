var countGramFfollow = 0;
var countGramWhole = 0;
var gramEnd = false;
var scrollHeight = $(document).height() - $(window).height();
var timer;

var loadGramWholeBoard = function() {
	$.ajax({
        url: "/ounwan/ounwangram/wholeBoard",
        data: { "rowNum": countGramWhole * 5 },
        success : function(res) {
            console.log(res.length);
            for(let i = 0; i < res.length; i++) {
                $("#ounwangram").append(`
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
		                	<button><img src="./images/ounwan_like.png"></button>
		                	<span>${res[i].likes}</span><span>Likes</span>
		                </div>
		                <div class="ounwangram-content">
		                	<div>${res[i].contents}</div>
		                </div>
	                </div>
                </div>
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

$(window).on("load", loadGramWholeBoard);
$("#gramWholeBoard").on("click", function() {countGramFfollow = 0;});
$(window).scroll(function() {
    if(!gramEnd) {
        if(!timer) {
            if($(window).scrollTop() > scrollHeight - 300) {
                timer = setTimeout(function() {
                    loadGramWholeBoard();
                    timer = null;
                }, 300);
            }
        }
    }
});