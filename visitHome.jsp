<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

    String visitName = "";    //要访问用户
    visitName = request.getParameter("visitName");
    //如果访问的用户是自己，就回到个人主页
    if (visitName.equals(webUser)) {
        response.sendRedirect("index.jsp?userId=<%=userId%>");
    }

    //加载签名
    String sign_value = "";
    ResultSet rsign = stmt.executeQuery("select * from users where name='"+visitName+"'");
    while (rsign.next()) {          
        sign_value = rsign.getString("sign");        
    }
    rsign.close();
    
    //输出博客内容
    String[] blog_output = new String[1000];
    String[] date_output = new String[1000];
    int index = 0;
    ResultSet rs = stmt.executeQuery("select * from blog where username='"+visitName+"' and level='"+1+"'");
    while (rs.next()) {
        blog_output[index] = rs.getString("blog");
        date_output[index] = rs.getString("date");
        index ++;
    }
    rs.close();

    //输出回复内容

    //记录每个博客的2级回复
    String msgs = "";
    int[] level2Num = new int[index];
    //按分类存储回复信息和对应时间
    String[][] replyContent = new String[index][1000];
    String[][] replyDate = new String[index][1000];
    String[][] replyDate2 = new String[index][1000];    //第二种格式
    //用户
    String[][] replyPerson = new String[index][1000];
    for (int i = 0; i < index; i ++) {
        int count = 0;
        ResultSet rsk = stmt.executeQuery("select * from blog where date='"+date_output[i]+"' and level='"+2+"'");
        while (rsk.next()) {
            replyContent[i][count] = rsk.getString("blog");
            replyDate[i][count] = rsk.getString("replyDate");
            String dateTemp1 = rsk.getString("replyDate").substring(3, 9);
            String dateTemp2 = rsk.getString("replyDate").substring(10, 15);
            replyDate2[i][count] = dateTemp1 + ' ' + dateTemp2;
            replyPerson[i][count] = rsk.getString("username");
            count ++;
        }
        level2Num[i] = count;    
        try {
            //存储每条博客被回复的level2留言数到表单
            String fmt = "update blog set replyNum = '"+count+"' where date='"+date_output[i]+"' and level='"+1+"'";
            String sql = String.format(fmt, count);
            int cntc = stmt.executeUpdate(sql);
            
            if (cntc > 0) {
                msgs = "保存成功！";
            }
        }
        catch (Exception e) {
            msgs = e.getMessage();
        }
        rsk.close();
    }



    stmt.close(); con.close();
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
    <title>的主页</title>
    <script type="text/javascript" src="js/general.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
</head>

<style type="text/css">
    /*博客分区*/
    #blog_zone {
        position: relative;
        display: block;
        top: 24px;
        left: 6%;
        width: 70%;
        max-width: 70%;
        border-top-left-radius: 20px;
        border-bottom-right-radius: 20px;
    }

    .blog_block {
        position: relative;
        border-radius: 5px;
        display: block;
        margin: 0px auto;
        margin-bottom: 20px; 
        margin-top: 20px;
        padding: 12px;
        padding-bottom: 24px;
        padding-top: 24px;
        background: linear-gradient(to left, #8a8a8a, #ebebeb);
        border-radius: 20px; 
        width: 90%;
        max-width: 90%;
    }

    .blog_block a {
        color: black;
        font-size: 14px;
    }

    .blog_block a:hover {
        text-decoration: underline;
        cursor: pointer;
    }

    .blog_block .blog_time {
        position: relative;
        display: inline-block;
        float: right;
        right: 0px;
        top: -5px;
        font-size: 10px;
        color: #ebebeb;
    }

    .blog_block .blog_content {
        position: relative;
        display: inline-block;
        font-size: 20px;
        left: 35px;
        width: 90%;
    }

    .blog_block .blog_operator {
        position: relative;
        display: block;
        bottom: 0px;
        width: 100%;
        height: 14px;   
        font-size: 14px;   
    }

    .blog_block .blog_operator .azone {
        position: relative;
        float: right;
        display: none;
    }

    .blog_block .replyText {
        position: relative;
        top: 20px;
        left: 30px;
        display: none;
    }

    .blog_block .replyText textarea {
        position: relative;
        border-radius: 5px;
        outline: none;
        font-size: 15px;
        width: 85%;
        height: 45px;
        top: -8px;
    }

    .blog_block .replyText img {
        position: relative;
        cursor: pointer;
        opacity: 0.5;
        display: "block";
    }

    .blog_block .replyText .replyClose {
        top: -43px;
    }

    .blog_block .replyText .replyImg {
        left: -20px;
        z-index: 100;
        top: -8px;
    }

    .blog_block .replyText .img:hover {
        opacity: 1;
    }

    /*回复区*/
    .reply_zone {
        position: relative;
        display: block;
        /*border: 1px solid black;*/
        width: 80%;
        background: linear-gradient(to left, #fff, #ebebeb);
        max-width: 80%;
        top: -20px;
        margin: 0px auto;
        padding: 12px;
        border-bottom-left-radius: 20px;
        border-bottom-right-radius: 20px;
    }

    .reply_block {
        position: relative;
        display: block;
        padding-top: 12px;
    }

    .reply_left {
        position: relative;
        width: 25%;
        display: block;
        left: 20px;
    }

    .reply_head {
        width: 40px;
        border-radius: 50%;
        cursor: pointer;
    }

    .reply_person {
        position: relative;
        left: 4px;
        top: -25px;
        font-size: 12px;
        text-shadow: 2px 2px 2px #8a8a8a;
        cursor: pointer;
    }

    .reply_person a:hover {
        text-decoration: underline;
    }

    .reply_date {
        position: relative;
        left: 47px;
        top: -20px;
        display: inline-block;
        font-size: 10px;
        color: #8a8a8a;
    }

    .reply_content {
        position: relative;
        left: 29%;
        top: -55px;
        width: 70%;
        display: inline-block;
    }

</style>

<body onload="isBlogEmpty()">
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="friends.jsp?userId=<%=userId%>" class="mobile_link">返回我的主页</a></li>
            <li><a href="album.jsp?userId=<%=userId%>" class="mobile_link">相册</a></li>
            <li><a href="messageBoard.jsp?userId=<%=userId%>" class="mobile_link">留言板</a></li>
            <li><a href="Data.jsp?userId=<%=userId%>" class="mobile_link">资料</a></li>
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
            <img src="images/default_avatar.jpeg" style="width: 80px; height: 80px; border-radius: 50px;">
        </div>
        <div id="personal_signature">
            <p style="font-family: STKaiti"><%=sign_value%></p>
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
                欢迎来访!&nbsp;<font id="userName"><%=webUser%></font>
            </div>
        </div>
        <div id="content">
            <fieldset id="information">
                <legend id="name"><%=visitName%></legend>
                <div id="fan"><img src="images/fan.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 粉丝：0</div>
                <div id="guanzhu"><img src="images/guanzhu.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 关注：0</div>
                <div id="blog_num"><img src="images/boke.png" style="width: 15px; height: 15px;" /> 博客：0</div>
                <div id="like"><img src="images/dianzan.png" style="width: 15px; height: 15px;" /> 点赞：0</div>
            </fieldset>
            <fieldset id="blog_zone">
                <!-- 博客区 -->
                <legend>
                     <img src="images/icon/zhizhang.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                    <b style="position: relative; left: -3px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;"><%=visitName%>的博客</b>
                </legend>
                <%for (int i = index - 1; i >= 0; i --) { %>
                    <div class="blog_block" onmouseover="blockHover(this)" onmouseout="bolckOut(this)" id="<%=i%>">
                        <div class="blog_time" id="<%=date_output[i]%>">
                            <font><%=date_output[i]%></font>
                        </div>
                        <div class="blog_content">
                            <font><%=blog_output[i]%></font>                       
                        </div>
                        <!-- 回复框 -->
                        <div class="replyText">
                            <textarea placeholder="评论<%=visitName%>的博客"></textarea>
                            <img src="images/back.png" width="15px" class="replyClose" onclick="replyClose(this)" />
                            <img src="images/icon/submit.png" width="18px" class="replyImg" onclick="replyBlog(this)" />
                        </div>
                        <div class="blog_operator">
                            <div class="azone">                       
                                <a onclick="deleteBlog(this)" id="<%= date_output[i] %>">点赞</a>
                                |
                                <a onclick="replyShow(this)">评论</a>
                            </div>
                        </div>
                    </div>
                    <div class="reply_zone">
                        <%for (int j = 0; j < level2Num[i]; j ++) { %>
                            <div class="reply_block">
                                <div class="reply_left">
                                    <img src="images/default_avatar.jpeg" class="reply_head" />
                                    <font class="reply_person"><a href="visitHome.jsp?userId=<%=userId%>&visitName=<%=replyPerson[i][j]%>"><%=replyPerson[i][j]%></a>：</font>
                                    <font class="reply_date"><%=replyDate2[i][j]%></font>   
                                    <br />
                                </div>
                                <div class="reply_content">
                                    <font><%=replyContent[i][j]%></font>
                                </div>
                            </div>
                        <%}%>
                    </div>
                <%}%>
                <!-- 每条博客的留言区 -->

                <form action="delete.jsp?userId=<%=userId%>" id="deleteForm" method="post">
                    <input type="submit" name="deleteButton" id="deleteButton" style="display: none;" />
                </form>
                <form action="visitReply.jsp?userId=<%=userId%>" id="replyForm" method="post">
                    <input type="submit" name="replyButton" id="replyButton" style="display: none;" />
                    <input type="hidden" name="blogDate" id="blogDate" />
                    <!-- 传递访问的用户的name -->
                    <input type="hidden" name="visitName" id="visitName" value="<%=visitName%>">
                </form>
            </fieldset>
        </div>

    </div>

<script type="text/javascript">
    function isBlogEmpty() {
        if (<%=index%> == 0) {            
            document.getElementById("blog_zone").style.cssText = "background: url('images/blogEmpty.jpg') no-repeat; background-size: cover; height:330px; background-position: 0% 80%;";
        }
    }

    //是否拉出回复框的标志
    var replyFlag = [];
    var index = <%=index%>;
    for (var k = index - 1; k >= 0; k --) {
        replyFlag[k] = false;
    }

    function blockHover(obj) {
        var temp = obj.id;
        if (!replyFlag[temp - 1]) {
            obj.style.opacity = "0.9";       
            obj.lastElementChild.lastElementChild.style.display = "block";
        }
    }

    function bolckOut(obj) {
        var temp = obj.id;
        if (!replyFlag[temp - 1]) {
            obj.style.opacity = "1";
            obj.lastElementChild.lastElementChild.style.display = "none";
        }
    }

    //删除某博客，以时间为介定
    function deleteBlog(obj) {
        if(window.confirm("确定删除此博客？")) {
            document.getElementById("deleteButton").value = obj.id;
            document.getElementById("deleteButton").click();
        }
    }

    //展开回复框
    function replyShow(obj) {
        //展开的回复框之外的回复框要隐藏
        for (var i = index - 1; i >= 0; i --) {
            if (replyFlag[i - 1] == true) {
                replyClose(document.getElementById(i.toString()).children[2].lastElementChild);
            }
        }
        //显示replyText
        obj.parentNode.parentNode.previousElementSibling.style.display = "block";
        //隐藏blog_operator
        obj.parentNode.style.display = "none";
        var temp = obj.parentNode.parentNode.parentNode.id;
        replyFlag[temp - 1] = true;
    }

    //隐藏回复框
    function replyClose(obj) {
        //显示blog_operator
        obj.parentNode.nextElementSibling.style.display = "block";
        //隐藏replyText
        obj.parentNode.style.display = "none";
        var temp = obj.parentNode.parentNode.id;
        replyFlag[temp - 1] = false;
    }

    //回复博客
    function replyBlog(obj) {
        if (obj.parentNode.children[0].value != "") {
            //回复框的值
            document.getElementById("replyButton").value = obj.parentNode.children[0].value;
            //回复框所属的博客的日期
            document.getElementById("blogDate").value = obj.parentNode.parentNode.children[0].id; 
            document.getElementById("replyButton").click();
        }

        else {
            window.alert("尚未输入回复内容");
        }
    }

    //console.log();
</script>

</body>
</html>