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
    <title>Lifeblog.com</title>
    <script type="text/javascript" src="js/general.js"></script>
    <script type="text/javascript" src="js/recommend.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/recommend.css" />
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
            <li><a href="Data.jsp" class="mobile_link">个人资料</a></li>
            <li><a href="about.jsp" class="mobile_link">关于</a></li>
            <li><a href="setting.jsp" class="mobile_link">设置</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait">
            <div id="mobile_select_upload">
                <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="mobile_upload_img" />
            </div>
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="index.jsp" id="mobile_com">「Lifeblog.com」</a>
        <img id="expand-menu" src="images/expand-menu.png" onclick="showShadow()" />
    </div>
    <!-- END for mobile device -->

    <!-- normal -->
    <!-- sidebar -->
    <!-- sidebar -->

    <!-- 主要内容 -->
    <div id="main" style="left: 0px; width: 100%; z-index: 99;">
        <!-- 调节main宽度 -->
        <!-- 标题导航栏 -->
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="index.jsp" id="index" class="nav_hover">个人主页&nbsp;</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_data"><a href="Data.jsp" id="data" class="nav_hover">&nbsp;个人资料&nbsp;</a></li>
                <li id="li_recommend"><a href="recommend.jsp" id="recommend" class="nav_hover">&nbsp;推荐&nbsp;</a></li>
            </ul>
            <div id="welcomeBack">
                欢迎回来!&nbsp;<font id="userName"></font>
                <script type="text/javascript">
                    var userTemp = document.cookie.split("=");
                    document.getElementById("userName").innerHTML = userTemp[1];
                </script>
            </div>
        </div>
        <!-- END 标题导航栏 -->

        <!-- 轮播图 -->
        <div id="content">
            <div id="carousel_wrap">
                <div id="carousel_images">
                    <!-- 前后分别加上一张图片，方便无缝过渡显示。可以使用JS DOM增加节点操作省去该步骤 -->
                    <img src="images/carousel/3.jpg">
                    <img src="images/carousel/1.jpg">
                    <img src="images/carousel/2.jpg">
                    <img src="images/carousel/3.jpg">
                    <img src="images/carousel/1.jpg">
                </div>
                <span class="arrow left-arrow">&lt;</span>
                <span class="arrow right-arrow">&gt;</span>
                <div id="dots">
                    <!-- 使用小点标记实际多少张图片，要添加图片时需要修改carousel_images和此处 -->
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
            </div>
            <div id="inner_content">
                <a href="https://www.bilibili.com/video/av37295820">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/leaves.jpg);"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/zhuang.jpg)"></div>
                            <div class="inner_username">
                                绣花DIARY
                            </div>
                        </div>
                        <div class="inner_intro">
                            vlog也能混剪？快来看
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av55954291">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/fon.jpg)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/fon.jpg)"></div>
                            <div class="inner_username">
                                叫GG就好
                            </div>
                        </div>
                        <div class="inner_intro">
                            跨越城市穿过人海的跑步路线
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av55571607/">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/zhou.png)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/zhou.png)"></div>
                            <div class="inner_username">
                                卡布叻_周深
                            </div>
                        </div>
                        <div class="inner_intro">
                            亲爱的旅人啊【千与千寻】
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av55210171/">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/prin.png)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/prin.png)"></div>
                            <div class="inner_username">
                                D2KMON_柠檬
                            </div>
                        </div>
                        <div class="inner_intro">
                            【中字.迪士尼反派系列2】后妈们的抱怨
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av55484165">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/tomato.png)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/tomato.png)"></div>
                            <div class="inner_username">
                                老番茄
                            </div>
                        </div>
                        <div class="inner_intro">
                            【老番茄】史上最骚大侦探(第二集)
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av55915329/">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/lexBurner.png)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/lexBurner.png)"></div>
                            <div class="inner_username">
                                lexBurner
                            </div>
                        </div>
                        <div class="inner_intro">
                            一拳超人最强角色竟然是他？一拳超人有趣的梗！
                        </div>
                    </div>
                </a>
                <a href="https://www.bilibili.com/video/av54127949/">
                    <div class="inner_item">
                        <div class="inner_img" style="background-image: url(./images/recommend/hh.png)"></div>
                        <div class="inner_user">
                            <div class="inner_avatar" style="background-image: url(./images/avatar/hh.png)"></div>
                            <div class="inner_username">
                                满江红红
                            </div>
                        </div>
                        <div class="inner_intro">
                            【雨女无瓜】轮到游乐王子给你洗脑了
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <!-- END 轮播图和好友动态 -->
    </div>
    <!-- END 主要内容 -->
    <!-- END normal -->
</body>

</html>