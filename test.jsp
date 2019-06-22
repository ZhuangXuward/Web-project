<%@page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>文件上传</title>
</head>
<body>
<p>文件上传</p>
<form name="fileupload" action="test2.jsp" method="POST" enctype="multipart/form-data">
<p>名称：<input type="text" name="name" size=24 value="David"></p>
<p>性别：<input type="text" name="sex" size=24 value="male"></p>
<p>年龄：<input type="text" name="age" size=24 value="28"></p>
<p>文件1：<input type="file" name="file1" size=24></p>
<p>文件2：<input type="file" name="file2" size=24></p>
<p><input type=submit name="submit" value="OK"></p>
</form>
</body>
</html>