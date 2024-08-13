<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.dobby.utils.DBManager" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file upload</title>
<link rel="stylesheet" href="./css/upload.css">
</head>
<body>
	<h1>동영상 파일 업로드</h1>
	<form action="upload_file.jsp" method="post" enctype="multipart/form-data">
        File to upload: <input type="file" name="upfile"><br/>
        제목: <input type="text" name = "title" placeholder="Title"><br/>
        영상설명: <textarea placeholder="Description" name="description"></textarea><br/>
        카테고리: <input type="text" placeholder="Category" name="category"><br/>
        태그: <input type="text" placeholder="Tags" name="tags"><br/>
        <input type="submit" value="Press to upload the file!">
        
    </form>
</body>
</html>