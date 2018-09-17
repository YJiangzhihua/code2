
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<jsp:forward page="/emp"/>--%>

<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="static/dist/css/bootstrap.min.css">
  <script>
    $("#btn").click(function () {
        url:"${pageContext.request.contextPath}/getform",
        $.post()
    });
  </script>
</head>
<body>
<a href="/emp"><p style="font-size: 100px">HaHaHaHaHaHaHaHaHaHaHaHaHaHaHaHa</p></a>
<form action="/uploadFile" enctype="multipart/form-data" method="post">
  <input type="text" name="name">
  <br><br>
  <input type="file" name="uploadFile">
  <br>
  <button type="submit" >提交</button>
</form>
</body>
</html>
