<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String msg = "";
    String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user = "user";
    String pwd = "123";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString, user, pwd);
    Statement stmt = con.createStatement();

    String webUser = "";    //登录用户
    Cookie cookies[] = request.getCookies(); //读出用户硬盘上的Cookie，并将所有的Cookie放到一个cookie对象数组里面
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i ++) {    //用一个循环语句遍历刚才建立的Cookie对象数组
            if(cookies[i].getName().equals("user")){//如果cookie对象的名称是mrCookie
                webUser = cookies[i].getValue(); //获取用户名
            }
        }
    }

    //查看是否隐藏边栏
    String showHome = "";
    ResultSet rHome = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rHome.next()) {          
        showHome = rHome.getString("showHome");        
    }
    rHome.close();

    //加载签名
    String sign_value = "";
    ResultSet rsign = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rsign.next()) {          
        sign_value = rsign.getString("sign");        
    }
    rsign.close();
%>
<!DOCTYPE html>
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
    <link rel="stylesheet" type="text/css" href="css/friends.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="index.jsp" class="mobile_link">个人主页</a></li>
            <li><a href="friends.jsp" class="mobile_link">好友动态</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
            <li><a href="Data.jsp" class="mobile_link">个人资料</a></li>
            <li><a href="about.jsp" class="mobile_link">关于</a></li>
            <li><a href="setting.jsp" class="mobile_link">设置</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait">
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="index.jsp" id="mobile_com">「Lifeblog.com」</a>
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
            <p style="font-family: STKaiti"><%=sign_value%></p>
        </div>
        <div id="menu">
            <a href="setting.jsp">设置</a><br><br>
            <a href="about.jsp">关于</a><br><br>
        </div>
        <div id="footer">
            <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="index.jsp" id="index" class="nav_hover">个人主页&nbsp;</a></li>
                <li id="li_friends"><a href="friends.jsp" id="friends" class="nav_hover">&nbsp;好友动态&nbsp;</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_data"><a href="Data.jsp" id="data" class="nav_hover">&nbsp;个人资料&nbsp;</a></li>
                <li id="li_recommend"><a href="recommend.jsp" id="recommend" class="nav_hover">&nbsp;推荐&nbsp;</a></li>
                <%if(showHome.equals("false")) {%>
                    <li id="li_setting"><a href="setting.jsp" id="setting" class="nav_hover">&nbsp;设置&nbsp;</a></li>
                    <li id="li_about"><a href="about.jsp" id="about" class="nav_hover">&nbsp;关于&nbsp;</a></li>
                <%}%>
            </ul>
            <div id="welcomeBack">
                欢迎回来!&nbsp;<font id="userName"></font>
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

<script type="text/javascript">
    if("<%=showHome%>" == "false") {
        document.getElementById("home").style.display = "none";
        document.getElementById("main").style.setProperty('left','0%');
        document.getElementById("main").style.setProperty('width','100%');
        document.getElementById("nav").style.setProperty('width','460px');
    }
</script>

</html>