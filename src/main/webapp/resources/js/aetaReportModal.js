var appPath = '/myapp';

// 모달 열기
function openReportModal() {
	document.getElementById("reportModal").style.display = "block";
	document.getElementById("reportModalOverlay").style.display = "block";
}

// 모달 닫기
function closeReportModal() {
	document.getElementById("reportModal").style.display = "none";
	document.getElementById("reportModalOverlay").style.display = "none";
}

function submitReport() {
	var aetaNumber = $("#aetaNumber").val();
	var selectedReason = document.querySelector('input[name="reportReason"]:checked');
	var reportReason = "";
	
	if(selectedReason){
		var reportReason = selectedReason.parentElement.textContent.trim();
	}
    var obj = {
        "aetaNumber" : aetaNumber,
      	"reportReason" : reportReason
    };
    
    console.log(obj);
    console.log(aetaNumber);
    
    $.ajax({
      	url : appPath + '/community/report',
      	type : 'post',
      	data : JSON.stringify(obj),
      	contentType : 'application/json',
      	success : function(responseData){
      		alert(responseData);
			location.href=appPath+'/community/aetaBoard';
       }
      	
    });
  
}
  // '신고하기' 버튼에 이벤트 리스너 추가
  document.getElementById('reportSubmit').addEventListener('click', submitReport);