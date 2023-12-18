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
    var selectedReasons = document.querySelectorAll('.reason:checked');
    var reportIdElement = document.getElementById('reportId');
    var reportId = reportIdElement.innerText;

    if (selectedReasons.length > 0 && reportId) {
      var reasons = Array.from(selectedReasons).map(reason => reason.value);
      alert('신고자: ' + '${clientInfo.clientId}' + '\n피신고자: ' + reportId + '\n선택된 사유: ' + reasons.join(', '));
      closeReportModal();
    } else {
      alert('신고 사유와 피신고자를 선택해주세요.');
    }
  }

  // '신고하기' 버튼에 이벤트 리스너 추가
  document.getElementById('reportSubmit').addEventListener('click', submitReport);