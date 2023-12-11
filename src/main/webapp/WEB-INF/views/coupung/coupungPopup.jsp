<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/popup.css">
<title>Insert title here</title>
</head>
 <script>
    function openPopup() {
      document.getElementById('popup').style.display = 'block';
    }

    function closePopup() {
      document.getElementById('popup').style.display = 'none';
    }
  </script>
<body>
	<div id="popup" class="modal">
		<h2>팝업 내용</h2>
		<p>팝업 창입니다.</p>
		<button onclick="closePopup()">닫기</button>
	</div>
</body>
</html>