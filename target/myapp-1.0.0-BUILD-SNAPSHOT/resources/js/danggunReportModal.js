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
    var postClientId = document.getElementById('reportSelectModal').getAttribute('postClientId');	
    var sessionClientId = document.getElementById('reportSelectModal').getAttribute('sessionClientId');	
    var reportId = reportIdElement.innerText;

    if (selectedReasons.length > 0 && reportId) {
      var reasons = Array.from(selectedReasons).map(reason => reason.value);
      //alert('신고자: ' + sessionClientId + '\n피신고자: ' + reportId + '\n선택된 사유: ' + reasons.join(', '));
      alert('신고가 완료되었습니다.');
      closeReportModal();
    } else {
      alert('신고 사유를 선택해주세요.');
    }
  }

  // '신고하기' 버튼에 이벤트 리스너 추가
  document.getElementById('reportSubmit').addEventListener('click', submitReport);