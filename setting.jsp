<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String msg = "";
    String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user="user"; 
    String pwd="123";
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

    //上传表单修改数据库内容
    if (request.getMethod().equalsIgnoreCase("post")) {
        String newPassword = request.getParameter("newPassword");
        try {
            int cnt = stmt.executeUpdate("update users set password='"+newPassword+"' where name='"+webUser+"'");
            if (cnt>0) 
                msg = "密码修改成功!";
        } catch(Exception e) {
                msg = e.getMessage();
        }
    }

    //旧密码
    String oldPassword = "";

    ResultSet rs = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rs.next()) {    
        oldPassword = rs.getString("password");       
    } 

    rs.close(); stmt.close(); con.close();
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
    <script type="text/javascript" src="js/setting.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/setting.css" />
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
            <li><a href="album.jsp?userId=<%=userId%>" class="mobile_link">相册</a></li>
            <li><a href="messageBoard.jsp?userId=<%=userId%>" class="mobile_link">留言板</a></li>
            <li><a href="about.jsp?userId=<%=userId%>" class="mobile_link">关于</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait"> 
            <div id="mobile_select_upload">
                <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="mobile_upload_img" />
            </div>  
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="index.jsp?userId=<%=userId%>" id="mobile_com">「Lifeblog.com」</a>
        <img id="expand-menu" src="images/expand-menu.png" onclick="showShadow()" />
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
            <a href="about.jsp?userId=<%=userId%>">关于</a>
        </div>
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="index.jsp?userId=<%=userId%>" id="index" class="nav_hover">个人主页&nbsp</a></li>
                <li id="li_friends"><a href="friends.jsp?userId=<%=userId%>" id="friends" class="nav_hover">&nbsp好友动态&nbsp</a></li>
                <li id="li_album"><a href="album.jsp?userId=<%=userId%>" id="album" class="nav_hover">&nbsp相册&nbsp</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp?userId=<%=userId%>" id="message_board" class="nav_hover">&nbsp留言板&nbsp</a></li>
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
            <fieldset id="settingBoard">
                <legend><img src="images/icon/setting.png" width="20px" height="20px" /><i style="position: relative; top: -3px;">setting</i></legend>
                <!-- 隐藏边栏 -->
                <div class="settingRow" id="hideHome">
                    隐藏边栏
                    <div class="slideButton" onclick="hideOrShow(this)">
                        <div class="colorSlide"></div>
                        <div class="smallButton"></div>
                    </div>
                </div>
                <!-- 禁止访问 -->
                <div class="settingRow" id="banAccess">
                    禁止访问
                    <div class="slideButton" onclick="hideOrShow(this)">
                        <div class="colorSlide"></div>
                        <div class="smallButton"></div>
                    </div>
                </div>
                <!-- 上传头像 -->
                <div id="uploadHead" class="settingRow">
                    <font onclick="uploadHead()" class="fonts">上传头像</font>
                </div>
                <!-- 修改密码 -->
                <div id="updatePassword" class="settingRow">
                    <font onclick="updatePassword()" class="fonts">修改密码</font>
                </div>
                <!-- 修改资料 -->
                <div id="updateData" class="settingRow">
                    <font onclick="window.location.href = 'Data.jsp?userId=<%=userId%>';" class="fonts">修改资料</font>
                </div>
                <!-- 退出登录 -->
                <div id="exitLogin" class="settingRow">
                    <font onclick="exitLogin()" class="fonts">退出登录</font>
                </div>
                <img src="images/horse.png" width="400px" id="horse" />
                <form method="post" action="setting.jsp?userId=<%=userId%>" id="updateForm"> 
                    <input type="password" placeholder="输入旧密码" class="password" id="password1" /> 
                    <span id="alert1" class="alert">&nbsp;</span>
                    <input type="password" placeholder="输入新密码" class="password" id="password2" />
                    <span id="alert2" class="alert">&nbsp;</span>
                    <input type="password" placeholder="确认密码" class="password" id="password3" name="newPassword" />
                    <span id="alert3" class="alert">&nbsp;</span>
                    <input type="button" name="passwordSave" value="保存" class="buttons" onclick="updateButton()" id="button1" />
                    <input type="button" name="passwordExit" value="退出" class="buttons" onclick="exitButton()" id="button2" />
                </form>
            </fieldset>
            
        </div>
    </div>
</body>

</html>