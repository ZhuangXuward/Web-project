<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = "";
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

    if (webUser == "") {
        response.sendRedirect("login.jsp"); 
    }   //如何没有用户信息转到登录页面


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
        userId = rsign.getString("id");
    }
    rsign.close();
    
    String blogOwner = webUser;
    if (request.getMethod().equalsIgnoreCase("post")) {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy年MM月dd日 HH:mm:ss");
        java.util.Date currentTime = new java.util.Date();
        String date = formatter.format(currentTime);
        String username = webUser;
        String blog = request.getParameter("cntt");
        int level = 1;
        int link = 0;
        try {
            String fmt = "insert into blog(blogOwner, date, username, blog, level, link) values('%s', '%s', '%s', '%s', '%s', '%s')";
            String sql = String.format(fmt, blogOwner, date, username, blog, level, link);
            int cnt = stmt.executeUpdate(sql);
            if (cnt > 0) msg = "保存成功！";
        }
        catch (Exception e) {
            msg = e.getMessage();
        }
    }
    
    //输出博客内容
    String[] blog_output = new String[1000];
    String[] date_output = new String[1000];
    int index = 0;
    ResultSet rs = stmt.executeQuery("select * from blog where username='"+webUser+"' and level='"+1+"'");
    while (rs.next()) {
        blog_output[index] = rs.getString("blog");
        date_output[index] = rs.getString("date");
        index ++;
    }
    rs.close();

    /************************************输出回复内容*****************************************/

    /*********************************记录每个博客的2级回复************************************/
    String msgs = "";
    int[] level2Num = new int[index];
    //按分类存储回复信息和对应时间
    String[][] replyContent = new String[index][1000];
    String[][] replyLink = new String[index][1000];
    String[][] replyDate = new String[index][1000];
    String[][] replyDate2 = new String[index][1000];    //第二种格式
    //用户
    String[][] replyPerson = new String[index][1000];
    for (int i = 0; i < index; i ++) {
        int count = 0;
        ResultSet rsk = stmt.executeQuery("select * from blog where blogOwner='"+webUser+"' and date='"+date_output[i]+"' and level='"+2+"'");
        while (rsk.next()) {
            replyContent[i][count] = rsk.getString("blog");
            replyLink[i][count] = rsk.getString("link");
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
            String fmt = "update blog set replyNum = '"+count+"' where blogOwner='"+webUser+"' and date='"+date_output[i]+"' and level='"+1+"'";
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

    /*********************************记录每个博客的3级回复************************************/
    int[][] level3Num = new int[index][1000];
    String msgss = "";
    //按分类存储回复信息和对应时间
    String[][][] replyContentLevel3 = new String[index][1000][1000];
    String[][][] replyDateLevel3 = new String[index][1000][1000];
    String[][][] replyDate2Level3 = new String[index][1000][1000];    //第二种格式
    //用户
    String[][][] replyPersonLevel3 = new String[index][1000][1000];
    //对谁
    String[][][] replyToWhoLevel3 = new String[index][1000][1000];
    for (int i = 0; i < index; i ++) {
        for (int j = 0; j < level2Num[i]; j ++) {
            int linkTemp = j + 1;
            int count2 = 0;
            ResultSet rsk2 = stmt.executeQuery("select * from blog where blogOwner='"+webUser+"' and level='"+3+"' and link='"+linkTemp+"' and date='"+date_output[i]+"'");
            while (rsk2.next()) {
                replyContentLevel3[i][j][count2] = rsk2.getString("blog");
                replyDateLevel3[i][j][count2] = rsk2.getString("replyDate");
                String dateTemp1Level3 = rsk2.getString("replyDate").substring(3, 9);
                String dateTemp2Level3 = rsk2.getString("replyDate").substring(10, 15);
                replyDate2Level3[i][j][count2] = dateTemp1Level3 + ' ' + dateTemp2Level3;
                replyPersonLevel3[i][j][count2] = rsk2.getString("username");
                replyToWhoLevel3[i][j][count2] = rsk2.getString("level3ToWho");
                count2 ++;
            }
            level3Num[i][j] = count2;    
            try {
                //存储每条博客被回复的level3留言数到表单
                String fmt = "update blog set replyNum = '"+count2+"' where blogOwner='"+webUser+"' and level='"+2+"' and link='"+linkTemp+"'";
                String sql = String.format(fmt, count2);
                int cntcc= stmt.executeUpdate(sql);

                if (cntcc > 0) {
                    msgss = "保存成功！";
                }
            }
            catch (Exception e) {
                msgs = e.getMessage();
            }
            rsk2.close();
        }  
    }

    //==================获取粉丝、关注、博客、点赞数量==================
    //粉丝数量
    String sql = "select count(*) num from followers where followed_id='" + userId + "'";
    ResultSet rs_fans = stmt.executeQuery(sql);
    String fans_amount = "";
    if (rs_fans.next()) {
        fans_amount = rs_fans.getString("num");
    }
    rs_fans.close();

    //关注数量
    sql = "select count(*) num from followers where fans_id='" + userId + "'";
    ResultSet rs_follow = stmt.executeQuery(sql);
    String follow_amount = "";
    if (rs_follow.next()) {
        follow_amount = rs_follow.getString("num");
    }
    rs_follow.close();

    //博客数量
    sql = "select count(*) num from blog where username='" + webUser + "' and level=1";
    ResultSet rs_blog = stmt.executeQuery(sql);
    String blog_amount = "";
    if (rs_blog.next()) {
        blog_amount = rs_blog.getString("num");
    }
    rs_blog.close();
    //==================END获取粉丝、关注、博客、点赞数量==================


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
    <title>我的主页</title>
    <script type="text/javascript" src="js/general.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
</head>

<body onload="isBlogEmpty()">
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="friends.jsp" class="mobile_link">好友动态</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
            <li><a href="Data.jsp" class="mobile_link">个人资料</a></li>
            <li><a href="recommend.jsp" class="mobile_link">推荐</a></li>
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

    <!-- normal -->
    <div id="home">
        <div id="com">
            <a href="index.jsp">「Lifeblog.com」</a>
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
            <a href="search.jsp?userId=<%=userId%>"><img src="./images/icon/search.png" style="width: 20px; opacity: 0.5;"></a>
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
                欢迎回来!&nbsp;<font id="userName"><%=webUser%></font>
            </div>
        </div>
        <div id="content">
            <form action="index.jsp" method="post" id="board">
                <fieldset id="board_set">
                    <!-- 发表博客 -->
                    <legend>
                        <img src="images/icon/maobi.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                        <b style="position: relative; left: -5px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">发表博客</b>
                    </legend>
                    <div id="msg" contenteditable="true" onclick="editMode()" onselect=""></div>
                    <br>
                    <!-- 编辑 -->
                    <div id="bianji" name="bianji">
                        <!-- <div id="mjs:tip" class="tip" style="position:fixed; left:0;top:0; display:none;"></div> -->
                        <img src="images/icon/jinghao.png" id="jinghao" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="hotTopic()" title="话题" />
                        <img src="images/icon/xiaolian.png" id="xiaolian" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onmouseover="tip.start(this)" title="表情" onclick="showEmojis()" />
                        <img src="images/icon/picture.png" id="picture" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" title="图片" onclick="picClick()" />
                        <!-- 高级编辑 -->
                        <img src="images/icon/gaojibianji.png" id="gaojibianji" onmouseover="appendixto2(this)" onmouseout="editOut(this)" title="高级编辑" onclick="topEdit()" />
                        <div id="edit">           
                            <img src="images/icon/title.png" id="etitle" onmouseover="appendixto2(this)" onmouseout="editHide(0, this)" onclick="Title(this)" title="字体"/>
                            <img src="images/icon/bold.png" id="ebold" onmouseover="appendixto2(this)" onmouseout="editHide(1, this)" onclick="bold(this)" title="粗体"/>
                            <img src="images/icon/xieti.png" id="exieti" onmouseover="appendixto2(this)" onmouseout="editHide(2, this)" onclick="italic()" title="斜体"/>
                            <img src="images/icon/underline.png" id="eunderline" onmouseover="appendixto2(this)" onmouseout="editHide(3, this)" onclick="underline(this)" title="下划线" />
                            <input type="button" id="ecolor" onclick="showColors()" onmouseover="colorHover(this)" onmouseout="colorOut(this)" />
                            <img src="images/icon/link.png" id="elink" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="linka()" title="链接" />
                        </div>
                        <img src="images/icon/huanyuan.png" id="huanyuan" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="huanYuan()" onmouseover="tip.start(this)" title="还原" />
                        <img src="images/icon/submit.png" id="submit" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="submit2=document.getElementById('submit2'); submit2.click()" title="发表" />
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
                        <div id="emojis" style="z-index: 100; opacity: 1">
                            <img src="images/emoji/laugh.png" class="emoji" id="laugh" onclick="insertEmoji(this)" />
                            <img src="images/emoji/naughty.png" class="emoji" id="naughty" onclick="insertEmoji(this)" />
                            <img src="images/emoji/embarrassed.png" class="emoji" id="embarrassed" onclick="insertEmoji(this)" />
                            <img src="images/emoji/ghost.png" class="emoji" id="ghost" onclick="insertEmoji(this)" />
                            <img src="images/emoji/shocking.png" class="emoji" id="shocking" onclick="insertEmoji(this)" /> 
                            <img src="images/emoji/skeleton.png" class="emoji" id="skeleton" onclick="insertEmoji(this)" />
                            <img src="images/emoji/weap.png" class="emoji" id="weap" onclick="insertEmoji(this)" />
                            <img src="images/emoji/sad.png" class="emoji" id="sad" onclick="insertEmoji(this)" />
                            <img src="images/emoji/angry.png" class="emoji" id="angry" onclick="insertEmoji(this)" />
                             <img src="images/emoji/shit.png" class="emoji" id="shit" onclick="insertEmoji(this)" />
                            <img src="images/emoji/hurt.png" class="emoji" id="hurt" onclick="insertEmoji(this)" />
                            <img src="images/emoji/cool.png" class="emoji" id="cool" onclick="insertEmoji(this)" />
                            <img src="images/emoji/sleep.png" class="emoji" id="sleep" onclick="insertEmoji(this)" />
                            <img src="images/emoji/think.png" class="emoji" id="think" onclick="insertEmoji(this)" />
                            <img src="images/emoji/vomit.png" class="emoji" id="vomit" onclick="insertEmoji(this)" />
                            <img src="images/emoji/laughcry.png" class="emoji" id="laughcry" onclick="insertEmoji(this)" />
                            <img src="images/emoji/liking.png" class="emoji" id="liking" onclick="insertEmoji(this)" />
                            <img src="images/emoji/astonishing.png" class="emoji" id="astonishing" onclick="insertEmoji(this)" />
                        </div>
                        <input type="file" name="file" id="uploadFiles" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" onchange="uploadFile(event)" />
                    </div>
                    <input type="submit" name="cntt" id="cntt" style="display: none;">
                    <input onclick="submitMyBlog(this)" type="button" id="submit2" style="display: none;">
                </fieldset>
            </form>

            <!-- 用户信息 -->
            <fieldset id="information">
                <legend id="name"><%=webUser%></legend>
                <div id="fan"><img src="images/fan.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 粉丝：<%=fans_amount%></div>
                <div id="guanzhu"><img src="images/guanzhu.png" style="position:relative; width: 15px; height: 15px; left: 0px;" /> 关注：<%=follow_amount%></div>
                <div id="blog_num"><img src="images/boke.png" style="width: 15px; height: 15px;" /> 博客：<%=blog_amount%></div>
                <div id="like"><img src="images/dianzan.png" style="width: 15px; height: 15px;" /> 点赞：0</div>
            </fieldset>


            <fieldset id="blog_zone">
                <!-- 博客区 -->
                <legend>
                     <img src="images/icon/zhizhang.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                    <b style="position: relative; left: -3px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">我的博客</b>
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
                            <textarea placeholder="回复<%=webUser%>的博客"></textarea>
                            <img src="images/back.png" width="15px" class="replyClose" onclick="replyClose(this)" />
                            <img src="images/icon/submit.png" width="18px" class="replyImg" onclick="replyBlog(this)" />
                        </div>
                        <div class="blog_operator">
                            <div class="azone">                       
                                <a onclick="deleteBlog(this)" id="<%= date_output[i] %>">删除</a>
                                |
                                <a onclick="replyShow(this)">回复</a>
                            </div>
                        </div>
                    </div>
                    <!-- 2级回复区 -->
                    <div class="reply_zone">
                        <%for (int j = 0; j < level2Num[i]; j ++) { %>
                            <div class="reply_block">
                                <div class="reply_left">
                                    <img src="images/default_avatar.jpeg" class="reply_head" />
                                    <font class="reply_person"><a href="visitHome.jsp?visitName=<%=replyPerson[i][j]%>"><%=replyPerson[i][j]%></a>：</font>
                                    <font class="reply_date"><%=replyDate2[i][j]%></font>   
                                    <br />
                                </div>
                                <div class="reply_content">
                                    <font><%=replyContent[i][j]%></font>
                                </div>
                                <img src="images/icon/level3Comment.png" width="15px" class="level3Comment" onclick="showCommentLevel3(this)" />

                                <!-- id保留link信息 -->
                                <div class="level3ReplyText" id="<%=replyLink[i][j]%>">
                                    <textarea placeholder="回复<%=replyPerson[i][j]%>的留言" id="<%=replyPerson[i][j]%>"></textarea>
                                    <img src="images/back.png" width="15px" class="level3ReplyClose" onclick="level3ReplyClose(this)" />
                                    <!-- 获取这个的id值作为日期 -->
                                    <img src="images/icon/submit.png" width="18px" class="level3ReplyImg" onclick="level3ReplyBlog(this)" id="<%=date_output[i]%>" />
                                </div>
                                
                                <!-- 3级回复区 -->
                                <%for (int k = 0; k < level3Num[i][j]; k ++) { %>
                                    <div class="reply_blockLevel3">
                                        <div class="reply_leftLevel3">
                                            <img src="images/default_avatar.jpeg" class="reply_headLevel3" />
                                            <font class="reply_personLevel3">
                                                <a href="visitHome.jsp?visitName=<%=replyPersonLevel3[i][j][k]%>" class="replyName1" style="font-size: 12px; text-shadow: 2px 2px 2px #8a8a8a"><%=replyPersonLevel3[i][j][k]%></a> 
                                                <font style="font-size: 10px; color: #8a8a8a">回复</font>
                                                <a href="visitHome.jsp?visitName=<%=replyToWhoLevel3[i][j][k]%>" class="replyName2" style="font-size: 12px; text-shadow: 2px 2px 2px #8a8a8a"><%=replyToWhoLevel3[i][j][k]%></a>
                                                <font style="font-size: 10px;">：</font>
                                            </font>
                                            <font class="reply_dateLevel3"><%=replyDate2Level3[i][j][k]%></font>  <br />
                                        </div>
                                        <div class="reply_contentLevel3">
                                            <font><%=replyContentLevel3[i][j][k]%></font>
                                        </div>
                                        <img src="images/icon/level3Comment.png" width="15px" class="level3Comment" onclick="showCommentLevel3(this)" />
                                        <!-- 回复框 -->

                                        <!-- 内嵌三级留言回复 -->
                                        <!-- id保留link信息 -->
                                        <div class="level3ReplyText" id="<%=replyLink[i][j]%>">
                                            <textarea placeholder="回复<%=replyPersonLevel3[i][j][k]%>的留言" id="<%=replyPersonLevel3[i][j][k]%>"></textarea>
                                            <img src="images/back.png" width="15px" class="level3ReplyClose" onclick="level3ReplyClose(this)" />
                                            <!-- 获取这个的id值作为日期 -->
                                            <img src="images/icon/submit.png" width="18px" class="level3ReplyImg" onclick="level3ReplyBlog(this)" id="<%=date_output[i]%>" />
                                        </div>
                                    </div>
                                <%}%>
                            </div>
                        <%}%>
                    </div>
                <%}%>
                <!-- 上传留言 -->
                <form action="delete.jsp" id="deleteForm" method="post">
                    <input type="submit" name="deleteButton" id="deleteButton" style="display: none;" />
                </form>
                <form action="reply.jsp" id="replyForm" method="post">
                    <input type="submit" name="replyButton" id="replyButton" style="display: none;" />
                    <input type="hidden" name="blogDate" id="blogDate" />
                </form>
                <!-- 上传三级留言 -->
                <form action="replyLevel3.jsp" id="replyFormLevel3" method="post">
                    <input type="submit" name="replyButtonLevel3" id="replyButtonLevel3" style="display: none;" />
                    <input type="hidden" name="blogDateLevel3" id="blogDateLevel3" />
                    <!-- 上传link信息 -->
                    <input type="hidden" name="blogLinkLevel3" id="blogLinkLevel3" />
                    <!-- 上传‘发给谁’的信息 -->
                    <input type="hidden" name="blogToWhoLevel3" id="blogToWhoLevel3" />
                </form>
            </fieldset>

            <!-- -----------------------附加区---------------------------------- -->
            <fieldset id="appendix1">
                <legend>关注</legend>

            </fieldset>
        </div>
    </div>
</body>
<script type="text/javascript">
    //是否为注册而来的
    if (document.referrer.search("signup.jsp") != -1) {
        alert("注册成功！");
    }

    if("<%=showHome%>" == "false") {
        document.getElementById("home").style.display = "none";
        document.getElementById("main").style.setProperty('left','0%');
        document.getElementById("main").style.setProperty('width','100%');
        document.getElementById("nav").style.setProperty('width','460px');
    }
    //一定要把jsp定义的移到外面来
    
    //如果为空显示空空如也图片
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

    //显示三级回复框
    function showCommentLevel3(obj) {
        //把其它回复框都除去
        var level3ReplyText = document.getElementsByClassName("level3ReplyText");
        for (var i = 0; i < level3ReplyText.length; i ++) {

            level3ReplyText[i].style.display = "none";
        }
        obj.nextElementSibling.style.display = "block";
    }

    //3级回复
    function level3ReplyBlog(obj) {
        if (obj.parentNode.children[0].value != "") {
            //回复框的值
            document.getElementById("replyButtonLevel3").value = obj.parentNode.children[0].value;
            //回复框所属的博客的日期
            document.getElementById("blogDateLevel3").value = obj.id; 
            document.getElementById("blogLinkLevel3").value = obj.parentNode.id; 
            document.getElementById("blogToWhoLevel3").value = obj.parentNode.children[0].id;
            //console.log(document.getElementById("blogLinkLevel3").value);
            document.getElementById("replyButtonLevel3").click();
        }

        else {
            window.alert("尚未输入回复内容");
        }
    }

    //隐藏3级回复 
    function level3ReplyClose(obj) {
        obj.parentNode.style.display = "none";
    }
</script>
    
<style type="text/css">

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

    .reply_zone .reply_block {
        position: relative;
        display: block;
        padding-top: 12px;
    }

    .reply_zone .reply_block .reply_left {
        position: relative;
        width: 100px;
        display: block;
        left: 20px;
    }

    .reply_zone .reply_block .reply_left .reply_head {
        width: 40px;
        border-radius: 50%;
        cursor: pointer;
    }

    .reply_zone .reply_block .reply_left .reply_person {
        position: relative;
        left: 4px;
        top: -5px;
        font-size: 12px;
        text-shadow: 2px 2px 2px #8a8a8a;
        cursor: pointer;
    }

    .reply_zone .reply_block .reply_left .reply_person a:hover {
        text-decoration: underline;
    }

    .reply_zone .reply_block .reply_left .reply_date {
        position: relative;
        left: 47px;
        top: -40px;
        display: inline-block;
        font-size: 10px;
        color: #8a8a8a;
    }

    .reply_zone .reply_block .reply_content {
        position: relative;
        padding-top: 20px;
        left: 120px;
    }

    /*三级回复区*/
    .level3Comment {
        position: absolute;
        cursor: pointer;
        z-index: 100;
    }

    .level3ReplyText {
        position: relative;
        left: 30px;
        width: 100%;
        display: none;
    } 

    .level3ReplyText textarea {
        position: relative;
        width: 80%;
    } 

    .level3ReplyText img {
        position: relative;
        cursor: pointer;
        opacity: 0.5;
        display: "block";
    }

    .level3ReplyText img:hover {
        opacity: 1;
    }

    .level3ReplyClose { 
        top: -20px;
        width: 10px;
    }

    .level3ReplyImg {
        left: -15px;
        width: 12px;
    }

    .reply_leftLevel3 {
        position: relative;
        width: 200px;
        left: 1%;
    } 

    .reply_headLevel3 {
        width: 40px;
        border-radius: 50%;
        cursor: pointer;
    }

    .reply_blockLevel3 {
        position: relative;
        width: 70%;
        left: 15%;
    }

    .reply_personLevel3 {
        position: absolute;
        bottom: 5px;
    }

    .replyName1:hover, .replyName2:hover {
        text-decoration: underline;
    }

    .reply_dateLevel3 {
        position: absolute;
        font-size: 10px;
        color: #8a8a8a;
        bottom: 25px;
        display: block;
        left: 45px;
    }

    .reply_contentLevel3 {
        position: relative;
        display: inline-block;
        width: 80%;
        max-width: 80%;
        left: 30px;
        padding: 20px;
    }

    @media only screen and (max-width: 600px) {
        .reply_content {
            padding-top: 40px;
            left: 80px;
        }
    }

    /**************************附加区***********************/
    #main #content #appendix1 {
        position: absolute;
        width: 14%;
        min-height: 215px;
        right: 20px;
        top: 290px;
        display: block;
        border-bottom-left-radius: 20px;
        border-top-right-radius: 20px;
        background: linear-gradient(to right, #ebebeb, #8a8a8a);
    }

    #main #content #appendix1 legend {
        text-shadow: 2px 2px 3px black;
    }

</style>
</html>