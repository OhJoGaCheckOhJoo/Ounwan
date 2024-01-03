var appPath = '/myapp';

function openReportModal() {
	document.getElementById("reportModal").style.display = "block";
	document.getElementById("reportModalOverlay").style.display = "block";
}

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
document.getElementById('reportSubmit').addEventListener('click', submitReport);