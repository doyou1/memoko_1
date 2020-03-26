<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="setDownloadDefaults()">
  <h1>Hello Google Cloud Storage!</h1>

  <form action="uploadFile" method="post" enctype="multipart/form-data">
  		<input type="file" name="upload">
  		<input type="submit" value="등록">
  </form>
</body>
</html>