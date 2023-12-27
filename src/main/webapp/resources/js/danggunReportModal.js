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
    var reportIdElement = document.getElementById('reportId');
    var postClientId = document.getElementById('reportSelectModal').getAttribute('postClientId');	
    var sessionClientId = document.getElementById('reportSelectModal').getAttribute('sessionClientId');	
    var reportId = reportIdElement.innerText;
	var danggunNumber = document.getElementById('reportSelectModal').getAttribute('danggunNumber');
	
	var selectedReason = document.querySelector('input[name="reportReason"]:checked');
	
	var reason = "";
	
	if(selectedReason){
		var reason = selectedReason.parentElement.textContent.trim();
	}
    var obj = {
        "danggunNumber" : danggunNumber,
      	"reason" : reason
    };
    
    $.ajax({
      	url : appPath + '/danggun/report',
      	type : 'post',
      	data : JSON.stringify(obj),
      	contentType : 'application/json',
      	success : function(responseData){
      		alert(responseData);
       }
      	
    });
  
}

  // '신고하기' 버튼에 이벤트 리스너 추가
  document.getElementById('reportSubmit').addEventListener('click', submitReport);