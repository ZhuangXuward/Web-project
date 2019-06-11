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
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/Index.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="Index.html" class="mobile_link">个人主页</a></li>
            <li><a href="friends.html" class="mobile_link">好友动态</a></li>
            <li><a href="album.html" class="mobile_link">相册</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
            <li><a href="Data.jsp" class="mobile_link">个人资料</a></li>
            <li><a href="about.html" class="mobile_link">关于</a></li>
            <li><a href="setting.html" class="mobile_link">设置</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait"> 
            <div id="mobile_select_upload">
                <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="mobile_upload_img" />
            </div>  
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="Index.html" id="mobile_com">「Lifeblog.com」</a>
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
            <a href="setting.html">设置</a><br><br> 
            <a href="about.html">关于</a><br><br>
            <a href="search.jsp?userId=<%=userId%>"><img src="./images/icon/search.png" style="width: 20px; opacity: 0.5;"></a>
        </div>
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="Index.html" id="index" class="nav_hover">个人主页&nbsp</a></li>
                <li id="li_friends"><a href="friends.html" id="friends" class="nav_hover">&nbsp好友动态&nbsp</a></li>
                <li id="li_album"><a href="album.html" id="album" class="nav_hover">&nbsp相册&nbsp</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp" id="message_board" class="nav_hover">&nbsp留言板&nbsp</a></li>
                <li id="li_data"><a href="Data.jsp" id="data" class="nav_hover">&nbsp个人资料&nbsp</a></li>
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
            <form id="board" >
                <fieldset id="board_set">
                    <!-- 发表博客 -->
                    <legend>
                        <img src="images/icon/maobi.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                        <b style="position: relative; left: -5px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">发表博客</b>
                    </legend>
                    <div id="msg" contenteditable="true" onclick="editMode()" onselect=""></div>
                    <br>
                    <!-- 编辑 -->
                    <div id="bianji">
                        <!-- <div id="mjs:tip" class="tip" style="position:fixed; left:0;top:0; display:none;"></div> -->
                        <img src="images/icon/jinghao.png" id="jinghao" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" tips="话题" onclick="hotTopic()" />
                        <img src="images/icon/xiaolian.png" id="xiaolian" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onmouseover="tip.start(this)" tips="表情" onclick="showEmojis()" />
                        <img src="images/icon/picture.png" id="picture" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" tips="图片" onclick="picClick()" />
                        <!-- 高级编辑 -->
                        <img src="images/icon/gaojibianji.png" id="gaojibianji" onmouseover="appendixto2(this)" onmouseout="editOut(this)" tips="高级编辑" onclick="topEdit()" />
                        <div id="edit">           
                            <img src="images/icon/title.png" id="etitle" onmouseover="appendixto2(this)" onmouseout="editHide(0, this)" onclick="Title(this)" />
                            <img src="images/icon/bold.png" id="ebold" onmouseover="appendixto2(this)" onmouseout="editHide(1, this)" onclick="bold(this)" />
                            <img src="images/icon/xieti.png" id="exieti" onmouseover="appendixto2(this)" onmouseout="editHide(2, this)" onclick="italic()" />
                            <img src="images/icon/underline.png" id="eunderline" onmouseover="appendixto2(this)" onmouseout="editHide(3, this)" onclick="underline(this)" />
                            <input type="button" id="ecolor" onclick="showColors()" onmouseover="colorHover(this)" onmouseout="colorOut(this)" />
                            <img src="images/icon/link.png" id="elink" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="linka()" />
                        </div>
                        <img src="images/icon/quanping.png" id="quanping" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="quanPing()" onmouseover="tip.start(this)" tips="全屏" />
                        <img src="images/icon/huanyuan.png" id="huanyuan" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="huanYuan()" onmouseover="tip.start(this)" tips="还原" />
                        <img src="images/icon/submit.png" id="submit" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" />
                        <!-- 颜色条 -->
                        <div id="colorBar">
                            <input type="button" id="red_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('red')" />
                            <input type="button" id="orange_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('orange')" />
                            <input type="button" id="yellow_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('yellow')" />
                            <input type="button" id="green_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('green')" />
                            <input type="button" id="blue_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('blue')" />
                            <input type="button" id="purple_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('purple')" />
                            <input type="button" id="black_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('black')" />
                            <input type="button" id="brown_block" class="colors" onmouseover="colorHover(this)" onmouseout="colorOut(this)" onclick="changeColor('brown')" />
                        </div>
                        <div id="emojis">
                            <img src="images/emoji/laugh.png" class="emoji" id="laugh" onclick="insertEmoji(this)">
                            <img src="images/emoji/naughty.png" class="emoji" id="naughty" onclick="insertEmoji(this)">
                            <img src="images/emoji/embarrassed.png" class="emoji" id="embarrassed" onclick="insertEmoji(this)">
                            <img src="images/emoji/ghost.png" class="emoji" id="ghost" onclick="insertEmoji(this)">
                            <img src="images/emoji/shocking.png" class="emoji" id="shocking" onclick="insertEmoji(this)">
                            <img src="images/emoji/skeleton.png" class="emoji" id="skeleton" onclick="insertEmoji(this)">
                            <img src="images/emoji/weap.png" class="emoji" id="weap" onclick="insertEmoji(this)">
                            <img src="images/emoji/sad.png" class="emoji" id="sad" onclick="insertEmoji(this)">
                            <img src="images/emoji/angry.png" class="emoji" id="angry" onclick="insertEmoji(this)">
                             <img src="images/emoji/shit.png" class="emoji" id="shit" onclick="insertEmoji(this)">
                            <img src="images/emoji/hurt.png" class="emoji" id="hurt" onclick="insertEmoji(this)">
                            <img src="images/emoji/cool.png" class="emoji" id="cool" onclick="insertEmoji(this)">
                            <img src="images/emoji/sleep.png" class="emoji" id="sleep" onclick="insertEmoji(this)">
                            <img src="images/emoji/think.png" class="emoji" id="think" onclick="insertEmoji(this)">
                            <img src="images/emoji/vomit.png" class="emoji" id="vomit" onclick="insertEmoji(this)">
                            <img src="images/emoji/laughcry.png" class="emoji" id="laughcry" onclick="insertEmoji(this)">
                            <img src="images/emoji/liking.png" class="emoji" id="liking" onclick="insertEmoji(this)">
                            <img src="images/emoji/astonishing.png" class="emoji" id="astonishing" onclick="insertEmoji(this)">
                        </div>
                        <input type="file" name="file" id="uploadFiles" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" onchange="uploadFile(event)" />
                    </div>
                </fieldset>
            </form>
            <fieldset id="information">
                <legend id="name">
                    <script type="text/javascript">
                    var userTemp = document.cookie.split("=");
                    document.getElementById("name").innerHTML = userTemp[1];
                    </script>
                </legend>
                <div id="fan"><img src="images/fan.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 粉丝：0</div>
                <div id="guanzhu"><img src="images/guanzhu.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 关注：0</div>
                <div id="blog_num"><img src="images/boke.png" style="width: 15px; height: 15px;" /> 博客：0</div>
                <div id="like"><img src="images/dianzan.png" style="width: 15px; height: 15px;" /> 点赞：0</div>
            </fieldset>
        </div>
    </div>
<script type="text/javascript">
    //点击div外会隐藏emojis和colorBar
    window.onclick = function(event) {
       var target = event ? event.target : window.event.srcElement;
       if(target.id != "colorBar" && target.id != "ecolor" && target.id != "msg")
            colorBarHide();
       if(target.id != "emojis" && target.id != "xiaolian")
            hideEmojis();
        //console.log(document.cookie);
    }
    
</script>


</body>
</html>