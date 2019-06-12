<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
%>

<html>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="referrer" content="always" />
    <meta name="author" content="superteam" />
    <meta name="date" content="2019-05-21T12:00:00+00:00" />
    <title>Lifeblog.com</title>
    <script type="text/javascript" src="js/general.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/album.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="index.jsp?userId=<%=userId%>" class="mobile_link">个人主页</a></li>
            <li><a href="friends.jsp?userId=<%=userId%>" class="mobile_link">好友动态</a></li>
            <li><a href="messageBoard.jsp?userId=<%=userId%>" class="mobile_link">留言板</a></li>
            <li><a href="Data.jsp?userId=<%=userId%>" class="mobile_link">个人资料</a></li>
            <li><a href="about.jsp?userId=<%=userId%>" class="mobile_link">关于</a></li>
            <li><a href="setting.jsp?userId=<%=userId%>" class="mobile_link">设置</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait">
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="index.jsp?userId=<%=userId%>" id="mobile_com">「Lifeblog.com」</a>
        <img id="expand-menu" src="images/expand-menu.png" onclick="showShadow(); closeAnimate()" />
    </div>

    <!-- normal -->
    <div id="home">
        <div id="com">
            <a href="">「Lifeblog.com」</a>
        </div>
        <div id="head_portrait">  
            <div id="select_upload">
                <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="upload_img" />
            </div>
            <img src="images/default_avatar.jpeg" style="width: 80px; height: 80px; border-radius: 50px;">
        </div>
        <div id="personal_signature">
            <p>Show your life this moment!</p>
        </div>
        <div id="menu">
            <a href="setting.jsp?userId=<%=userId%>">设置</a><br><br> 
            <a href="about.jsp?userId=<%=userId%>">关于</a><br><br>
            <a href="search.jsp?userId=<%=userId%>"><img src="./images/icon/search.png" style="width: 20px; opacity: 0.5;"></a>
        </div>
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="visitHome.jsp?userId=<%=userId%>&visitName=<%=visitName%>" id="index" class="nav_hover">主页&nbsp;</a></li>
                <li id="li_album"><a href="visitAlbum.jsp?userId=<%=userId%>&visitName=<%=visitName%>" id="album" class="nav_hover">&nbsp;相册&nbsp;</a></li>
                <li id="li_messageBoard"><a href="visitMessageBoard.jsp?userId=<%=userId%>&visitName=<%=visitName%>" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_data"><a href="visitData.jsp?userId=<%=userId%>&visitName=<%=visitName%>" id="data" class="nav_hover">&nbsp;资料&nbsp;</a></li>
            </ul>
            <div id="welcomeBack">
                欢迎来访!&nbsp;<font id="userName"></font>
                <script type="text/javascript">
                    var userTemp = document.cookie.split("=");
                    document.getElementById("userName").innerHTML = userTemp[1];
                </script>
            </div>
        </div>
        <div id="content">
        </div>
    </div>

</body>
</html>