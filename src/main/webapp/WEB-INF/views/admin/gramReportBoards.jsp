<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div class="gram-report-wrap">
    <div>
        <div id="gramBoardList">
            <div class="gram-board-menu">
                <span class="gram-number">게시글번호</span>
                <span>작성자</span>
                <span>내용</span>
                <span>해시태그</span>
                <span>작성일</span>
                <span>신고횟수</span>
                <span>차단여부</span>
            </div>
            <c:forEach var="board" items="${boards}">
            	<div class="gram-board-info">
	                <span class="gram-number">${board.COMMUNITY_NUMBER}</span>
	                <span>${board.CLIENT_ID}</span>
	                <span>${board.CONTENTS}</span>
	                <select>
	            		<option hidden>해시태그</option>
	               		<c:forEach var="hashTag" items="${board.hashTags}">
	                		<option>${hashTag}</option>
	               		</c:forEach>
	               	</select>
	                <span >${board.CREATED_DATE}</span>
	                <span>${board.REPORT_NUM}</span>
	                <c:if test="${board.VISIBILITY eq 1}">
	                	<button value="${board.COMMUNITY_NUMBER}">정상게시</button>
	                </c:if>
	                <c:if test="${board.VISIBILITY eq 0}">
	                	<button value="${board.COMMUNITY_NUMBER}">임시차단</button>
	                </c:if>
	                <div>
	                    <h3>${board.CLIENT_ID}</h3>
	                    <img src="${board.IMAGE_URL}">
	                    <div>
	                    	<div>
	                    		<span>신고자</span>
	                    		<span>사유</span>
	                    		<span>신고일</span>
	                    	</div>
	                    	<c:forEach var="report" items="${board.reportInfo}">
	                    		<div>
	                    			<span>${report.CLIENT_ID}</span>
	                    			<span>${report.REASON}</span>
	                    			<span>${report.REGISTERED_DATE}</span>
	                    		</div>
	                    	</c:forEach>
	                    </div>
	                    <button value="${board.COMMUNITY_NUMBER}">게시물 삭제</button>
	                </div>
	            </div>
            </c:forEach>
        </div>
    </div>
    <div id="gramAdminPages">
       	<c:forEach var="index" begin="1" end="${pages}">
       		<c:if test="${index eq offset + 1}">
       			<a href="#" class="page selected">${index}</a>
       		</c:if>
       		<c:if test="${index ne offset + 1}">
       			<a href="#" class="page">${index}</a>
       		</c:if>
       	</c:forEach>
       </div>
</div>

<script>
	var offset = '${offset}';
	
	$("#gramBoardList").on("click", ".gram-board-info span", function() {
		if($(this).parent().find('div').css("display") == "none") {
			for(var i = 0; i < $(".gram-board-info > div").length; i++) {
				if($(".gram-board-info > div").eq(i).css("display") == "block") {
					$(".gram-board-info > div").eq(i).css("display", "none");
				}
			}
			$(this).parent().find('div').css("display", "block");
		} else {
			$(this).parent().find('div').css("display", "none");
		}
	});
	
	$("#gramBoardList").on("click", ".gram-board-info div", function() {
		$(this).css("display", "none");
	});
	
	$("#gramAdminPages").on("click", "a", function() {
		offset = ((Number)($(this).html()) - 1);
        $.ajax({
        	url: "${appPath}/admin/ounwangram/reports",
        	data: { 'offset': offset },
        	success: function(res) {
        		$(".admin-wrap").html(res);
        	},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
	});
	
	$("#gramBoardList").on("click", ".gram-board-info > button", function() {
		var button = $(this);
		if(button.html() == "정상게시") {
			if(confirm("해당 게시물을 임시차단하시겠습니까?")) {
				$.ajax({
					url: "${appPath}/admin/ounwangram/update",
					data: { 
						'communityNumber': button.val(),
						'status': false
						},
					success: function(res) {
						if(res == 'success') {
							alert("해당 게시물을 임시차단하였습니다.");
							button.html("임시차단");
						}
					}
				});
			}
		} else {
			if(confirm("해당 게시물을 공개하시겠습니까?")) {
				$.ajax({
					url: "${appPath}/admin/ounwangram/update",
					data: { 
						'communityNumber': button.val(),
						'status': true
						},
					success: function(res) {
						if(res == 'success') {
							alert("해당 게시물을 정상게시하였습니다.");
							button.html("정상게시");
						}
					}
				});
			}
		}
	});
	
	$("#gramBoardList").on("click", ".gram-board-info > div > button", function() {
		if(confirm("해당 게시물을 삭제하시겠습니까?")) {
			$.ajax({
				url: "${appPath}/admin/ounwangram/delete",
				data: { 'communityNumber': $(this).val() },
				success: function(res) {
					if(res == 'success') {
						alert("해당 게시물을 삭제하였습니다.");
					}
				}
			});
		}
	});
</script>