<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
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
    <title>ABOUT</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/about.css" />
    <style type="text/css">
        #aboutMain #team {
            position: relative;
            top: 40px;
            width: 760px;
            height: 500px;
            font-size: 15px;
            margin: 0px auto;
            padding: 20px;
            padding-left: 40px;
            padding-right: 40px;
            border-bottom-left-radius: 30px;
            border-top-right-radius: 30px;
            background: linear-gradient(to left, #ebebeb, #8a8a8a);
        }

        @media only screen and (max-width: 600px) {
            #home {
                display: none;
            }

            .expand {
                position: fixed;
                display: inline-block;
                top: 17.5px;
                float: right;
                right: 4.5%;
                width: 20px;
                height: 20px;
                cursor: pointer;
            }

            #aboutWrap {
                top: 0px;
                left: 60px;
                width: 600px;
                font-size: 23px;
            }

            #aboutMain #introduction {
                left: -80px;
                width: 390px;
                padding: 10px;
                height: 350px;
            }

            #aboutMain #introduction p {
                font-size: 14px;
            }

            #aboutMain #team {
                left: -80px;
                width: 330px;
                height: 485px;
                font-size: 14px;
                overflow: hidden;
            }

            #aboutMain #contact {
                left: -80px;
                width: 370px;
                font-size: 14px;
            }

            #aboutMain #team .bamboo {
                opacity: 0.1;
                left: 120px;
            }

            #aboutMain #team .member {
                position: relative;
                width: 270px;
                height: 95px;
                border-bottom: 1px solid black;
            }

            #aboutMain #team #member2 {
                top: 20px;
                width: 250px;
            }

            #aboutMain #team #member3 {
                top: 40px;
                float: left;
            }

            #aboutMain #team #member4 {
                top: 60px;
                width: 250px;
            }
        }
    </style>
</head>

<body>
    <!-- for mobile devices -->
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
            <li><a href="Data.jsp?userId=<%=userId%>" class="mobile_link">个人资料</a></li>
            <li><a href="setting.jsp?userId=<%=userId%>" class="mobile_link">设置</a></li>
        </ul>
    </div>
    <!-- normal -->
    <div id="home">
        <div id="com">
            <a href="about.jsp?userId=<%=userId%>">「About」</a>
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
            <a href="index.jsp?userId=<%=userId%>">返回主页</a>
        </div>
        <div id="footer">
            <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="aboutWrap">
        <font style="position: relative; top: 15px;">纸上悲欢难堪月，轴尽待收浮生卷</font>
        <img src="images/expand_black.png" class="expand" onclick="showShadow()" id="expand-menu" />
    </div>

    <div id="aboutMain">
        <fieldset id="introduction">
            <legend id="l0">Introdution</legend>
            <p>人生如行路，无论是一马平川，还是荆棘丛生，都是一种体验。路上的风景，亦是人生的风景，无论驻足停留，还是匆匆而过，路上的历练，就是一次成长。</p>
            <p>每一个人的人生经历都有所不同。择路的茫然，无助的恍惚，梦想破碎的落寞，收获成功的喜悦，甚至是生活中不经意发现的小惊喜，都值得记录，分享和回味。为什么要记录，分享和回味？</p>
            <p>“幸福就像玻璃,平时从未察觉,只要稍微改变看的角度,就会映照出光芒!”当记录下生活的点滴，分享给不同的人，在不同的时间回味，就会得到新的收获，甚至是收获幸福！</p>
            <p>这个博客平台建立的目的就是方便用户记录生活的点点滴滴，可以是成长的历程，学习的收获，甚至也可以是一点点生活上的吐槽。整个平台的风格基调是简约、中国水墨风，以黑、白、灰三色为主颜色。
                <p>就像我们平台的核心语句：“show your life this moment”，尽情地感受、记录和分享自己独一无二的生活吧！希望在这个平台您能收获喜悦、快乐！</p>
        </fieldset>

        <fieldset id="team">
            <img src="images/bamboo.png" height="500px" class="bamboo" />
            <legend id="l1">Our Team</legend>
            <div id="member1" class="member">
                <div class="photoZone"><img src="images/team/zyl.jpeg" class="teamPhoto"
                        onclick="window.location.href='http://zhuylin.xyz'" /></div>Designer & Director|朱泳霖<br>
                <br>
            </div>
            <div id="member2" class="member">
                庄少华|Project Programmer<div class="photoZone"><img src="images/team/zsh.jpeg" class="teamPhoto"
                        onclick="window.location.href='https://shaohuahua.top'" /></div><br><br>
            </div><br><br>
            <div id="member3" class="member">
                <div class="photoZone"><img src="images/team/zkh.jpeg" class="teamPhoto" /></div>Project
                Programmer|庄开鸿<br><br>
            </div><br><br>
            <div id="member4" class="member">
                谢铭琦|DB Administrator&nbsp;&nbsp;&nbsp;&nbsp;<div class="photoZone"><img src="images/team/xmq.jpeg"
                        class="teamPhoto" /></div><br>
            </div>
        </fieldset>

        <fieldset id="contact">
            <legend id="l2">Contact Us</legend>
            <img src="images/icon/phone.png" style="width: 20px; height: 20px;" />
            <font>电话：15989005480</font>
            <br><br><br>
            <img src="images/icon/email.png" style="width: 20px; height: 15px;" />
            <font>邮件：1151030072@qq.com</font><br>
            <br><br>
            <font style="font-size: 18px;">Welcome to contact us!</font>
        </fieldset>
    </div>
</body>
<script type="text/javascript">
    function showShadow() {
        var shadow = document.getElementById("mobile_shadow");
        shadow.style.width = "" + document.documentElement.scrollWidth + "px";

        if (document.documentElement.clientHeight > document.documentElement.scrollHeight)
            shadow.style.height = "" + document.documentElement.clientHeight + "px";
        else
            shadow.style.height = "" + document.documentElement.scrollHeight + "px";
        shadow.style.display = "block";

        //隐藏三横图像
        var hideObj = document.getElementById("expand-menu");
        hideObj.style.display = "none";

        var showBox = document.getElementById("mobile_box");
        showBox.style.display = "block";
    }

    function hideShadow() {
        var shadow = document.getElementById("mobile_shadow");
        shadow.style.display = "none";

        var hideBox = document.getElementById("mobile_box");
        hideBox.style.display = "none";

        var showObj = document.getElementById("expand-menu");
        showObj.style.display = "inline-block";
    }
</script>

</html>