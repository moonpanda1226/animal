<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이 뚱 사 육 사 공 간</title>
</head>
<body>
	<h1>공지사항 글쓰기</h1>
	<form action="./noticeWrite" method="post">
		<input name="ntitle">
		<textarea name="ncontent"></textarea>
		<button type="submit">공지쓰기</button>
	</form>
</body>
</html>