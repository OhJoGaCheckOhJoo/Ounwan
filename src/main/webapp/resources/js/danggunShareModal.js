function openShareModal() {
	document.getElementById("shareModal").style.display = "block";
	document.getElementById("shareModalOverlay").style.display = "block";
}

function closeShareModal() {
	document.getElementById("shareModal").style.display = "none";
	document.getElementById("shareModalOverlay").style.display = "none";
}

function clipboardShare() {
	var url = '';
	var tmpTextarea = document.createElement("textarea");
	var url = window.location.href;

	tmpTextarea.value = url;

	tmpTextarea.setAttribute("readonly", "");
	tmpTextarea.style.position = "absolute";
	tmpTextarea.style.left = "-9999px";
	document.body.appendChild(tmpTextarea);

	tmpTextarea.select();
	tmpTextarea.setSelectionRange(0, 9999);
	var successChk = document.execCommand("copy");

	document.body.removeChild(tmpTextarea);

	if (!successChk) {
		alert("클립보드 복사에 실패하였습니다.");
	} else {
		alert("클립보드에 복사가 완료되었습니다.");
	}
}