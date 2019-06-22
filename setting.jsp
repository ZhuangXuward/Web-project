<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String msg = "";
    String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user="user"; 
    String pwd="123";
    String avatar_img = "";
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
        avatar_img = rHome.getString("avatar");           
    }
    rHome.close();

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

    //判断是否禁止访问
    String ifAccess = "";
    ResultSet rAccess = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rAccess.next()) {          
        ifAccess = rAccess.getString("Access");      
    }
    rAccess.close();

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
            <li><a href="index.jsp" class="mobile_link">个人主页</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
            <li><a href="recommend.jsp" class="mobile_link">推荐</a></li>
            <li><a href="about.jsp" class="mobile_link">关于</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait"> 
            <div id="mobile_select_upload">
                <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="mobile_upload_img" />
            </div>  
            <img src="images/avatar/<%=avatar_img%>" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="index.jsp" id="mobile_com">「Lifeblog.com」</a>
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
            <img src="images/avatar/<%=avatar_img%>" style="width: 80px; height: 80px; border-radius: 50px;">
        </div>
        <div id="personal_signature">
            <p>Show your life this moment!</p>
        </div>
        <div id="menu">
            <a href="setting.jsp">设置</a><br><br> 
            <a href="about.jsp">关于</a>
        </div>
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="index.jsp" id="index" class="nav_hover">个人主页&nbsp;</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_recommend"><a href="recommend.jsp" id="recommend" class="nav_hover">&nbsp;推荐&nbsp;</a></li>
                <li id="li_about" style="display: none;"><a href="about.jsp" id="about" class="nav_hover">&nbsp;关于&nbsp;</a></li>
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
                    <div class="slideButton" onclick="hideOrShow(this)" id="hideOrShowHome">
                        <div class="colorSlide"></div>
                        <div class="smallButton"></div>
                    </div>
                </div>
                <!-- 禁止访问 -->
                <div class="settingRow" id="banAccess">
                    禁止访问
                    <div class="slideButton" onclick="ifAccess(this)" id="accessButton">
                        <div class="colorSlide"></div>
                        <div class="smallButton"></div>
                    </div>
                </div>
                <!-- 上传头像 -->
                <div id="uploadHead" class="settingRow">
                    <form action="avatarUpload.jsp">
                        <font class="fonts">上传头像</font>
                    </form>
                </div>
                <!-- 修改密码 -->
                <div id="updatePassword" class="settingRow">
                    <font onclick="updatePassword()" class="fonts">修改密码</font>
                </div>
                <!-- 修改资料 -->
                <div id="updateData" class="settingRow">
                    <font onclick="window.location.href = 'Data.jsp';" class="fonts">修改资料</font>
                </div>
                <!-- 退出登录 -->
                <div id="exitLogin" class="settingRow">
                    <font onclick="exitLogin()" class="fonts">退出登录</font>
                </div>
                <img src="images/horse.png" width="400px" id="horse" />
                <form method="post" action="setting.jsp" id="updateForm"> 
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
<script type="text/javascript">
    if("<%=showHome%>" == "false") {
        toSlide(document.getElementById("hideOrShowHome"));
        hideHome();
    }

    if("<%=ifAccess%>" == "false") {
        var accessButton = document.getElementById("accessButton");       
        accessButton.firstElementChild.style.width = "100%";
        accessButton.lastElementChild.style.left = "12px";
    }

    //把有引用jsp的提取出来
    function updateButton() {
        if (window.confirm("确定修改密码吗？")) {
            var flag1 = true;
            var flag2 = true;
            var flag3 = true;
            var password1 = document.getElementById("password1").value;
            var password2 = document.getElementById("password2").value;
            var password3 = document.getElementById("password3").value;

            if (password1 == "") {
                document.getElementById("alert1").innerHTML = "请输入原始密码";
                flag1 = false;
            } else {
                document.getElementById("alert1").innerHTML = "&nbsp;";
                flag1 = true;
            }
            if (password2 == "") {
                document.getElementById("alert2").innerHTML = "请输入新密码";
                flag2 = false;
            } else {
                document.getElementById("alert2").innerHTML = "&nbsp;";
                flag2 = true;
            }
            if (password3 == "") {
                document.getElementById("alert3").innerHTML = "请输入确认密码";
                flag3 = false;
            } else {
                document.getElementById("alert3").innerHTML = "&nbsp;";
                flag3 = true;
            }

            if (flag1 == true && flag2 == true && flag3 == true) {

                if (password1 != "<%=oldPassword%>") {
                    document.getElementById("alert1").innerHTML = "密码不正确";
                } else {
                    document.getElementById("alert1").innerHTML = "&nbsp;";
                    if (password2 != password3)
                        document.getElementById("alert2").innerHTML = "两次密码不同";
                    else {
                        document.getElementById("alert2").innerHTML = "&nbsp;";
                        document.getElementById("alert3").innerHTML = "密码修改成功";
                        //延时一秒后上传表单
                        setTimeout(function () {
                            document.getElementById('updateForm').submit();
                        }, 1 * 1000);
                    }
                }
            }
        }
    }

    //隐藏边栏
    function hideHome() {
        document.getElementById("home").style.display = "none";
        document.getElementById("main").style.setProperty('left','0%');
        document.getElementById("main").style.setProperty('width','100%');
        document.getElementById("nav").style.setProperty('width','460px');
        document.getElementById("li_about").style.display = "inline-block";
        flagHOS = true;

        // 利用ajax将修改上传给后台
        // 创建http请求
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            // 当http请求的状态变化时执行 
            if(xmlhttp.readyState==4) { // 4-已收到http响应数据
                if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                    // 200~299-OK 304-unmodified
                } else {
                }
            };
        }; //打开http请求（open）的参数：get|post，url，是否异步发送 
        var param = "showHome=false" + "&webUser=<%=webUser%>";
        xmlhttp.open("post", "settingAjax.jsp?showHome=false", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(param);
    }

    //显示边栏
    function showHome() {
        document.getElementById("home").style.display = "block";
        document.getElementById("main").style.setProperty('left','20%');
        document.getElementById("main").style.setProperty('width','80%');
        document.getElementById("nav").style.setProperty('width','375px');
        document.getElementById("li_about").style.display = "none";
        flagHOS = false;

        // 利用ajax将修改上传给后台
        // 创建http请求
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            // 当http请求的状态变化时执行 
            if(xmlhttp.readyState==4) { // 4-已收到http响应数据
                if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                    // 200~299-OK 304-unmodified
                } else {
                }
            };
        }; //打开http请求（open）的参数：get|post，url，是否异步发送 
        var param = "showHome=true" + "&webUser=<%=webUser%>";
        xmlhttp.open("post", "settingAjax.jsp?showHome=true", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(param);
    }

    //禁止访问
    function banAccess() {
         // 利用ajax将修改上传给后台
        // 创建http请求
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            // 当http请求的状态变化时执行 
            if(xmlhttp.readyState==4) { // 4-已收到http响应数据
                if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                    // 200~299-OK 304-unmodified
                } else {
                }
            };
        }; //打开http请求（open）的参数：get|post，url，是否异步发送 
        var param = "ifAccess=false" + "&webUser=<%=webUser%>";
        xmlhttp.open("post", "settingAjax2.jsp?ifAccess=false", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(param);
    }

    //允许访问
    function admitAccess() {
         // 利用ajax将修改上传给后台
        // 创建http请求
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            // 当http请求的状态变化时执行 
            if(xmlhttp.readyState==4) { // 4-已收到http响应数据
                if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                    // 200~299-OK 304-unmodified
                } else {
                }
            };
        }; //打开http请求（open）的参数：get|post，url，是否异步发送 
        var param = "ifAccess=true" + "&webUser=<%=webUser%>";
        xmlhttp.open("post", "settingAjax2.jsp?ifAccess=true", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(param);
    }

    function ifAccess(obj) {
        if (obj.lastElementChild.style.left != "12px") {
            obj.firstElementChild.style.width = "100%";
            obj.lastElementChild.style.left = "12px";
            banAccess();
        }
        else {
            obj.firstElementChild.style.width = "0px";
            obj.lastElementChild.style.left = "-1px";
            admitAccess();
        }
    }
</script>
</html>















