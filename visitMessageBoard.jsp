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
        response.sendRedirect("index.jsp");
    }

    //加载签名
    String sign_value = "";
    ResultSet rsign = stmt.executeQuery("select * from users where name='"+visitName+"'");
    while (rsign.next()) {          
        sign_value = rsign.getString("sign");        
    }
    rsign.close();
	
	if (request.getMethod().equalsIgnoreCase("post")) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy年MM月dd日 HH:mm:ss");
        java.util.Date currentTime = new java.util.Date();
        String date = formatter.format(currentTime);

		String content = request.getParameter("cntt");
		try {
			String fmt = "insert into messageboard(date, content) values('%s', '%s')";
			String sql = String.format(fmt, date, content);
			int cnt = stmt.executeUpdate(sql);
			if (cnt > 0) msg = "保存成功！";
		}
		catch (Exception e) {
			msg = e.getMessage();
		}
	}
	
	String[] content_output = new String[1000];
	String[] date_output = new String[1000];
	int index = 0;
	ResultSet rs = stmt.executeQuery("select * from messageboard");
	while (rs.next()) {
		content_output[index] = rs.getString("content");
		date_output[index] = rs.getString("date");
		index ++;
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
    <script type="text/javascript" src="js/visitMessageBoard.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/messageBoard.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="index.jsp" class="mobile_link">返回个人主页</a></li>
            <li><a href="visitHome.jsp?visitName=<%=visitName%>" class="mobile_link">主页</a></li>
            <li><a href="visitMessageBoard.jsp?visitName=<%=visitName%>" class="mobile_link">资料</a></li>
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
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="visitHome.jsp?visitName=<%=visitName%>" id="index" class="nav_hover">主页&nbsp;</a></li>
                <li id="li_messageBoard"><a href="visitMessageBoard.jsp?visitName=<%=visitName%>" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_data"><a href="visitData.jsp?visitName=<%=visitName%>" id="data" class="nav_hover">&nbsp;资料&nbsp;</a></li>
            </ul>
            <div id="welcomeBack">
                欢迎来访!&nbsp;<font id="userName"><%=webUser%></font>
            </div>
        </div>
        <div id="content">
            <form action="visitMessageBoard.jsp" method="post" id="board">
                <fieldset id="board_set">
                    <!-- 发表留言 -->
                    <legend>
                        <img src="images/icon/maobi.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                        <b style="position: relative; left: -5px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">写下留言</b>
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
                        <div id="emojis">
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
                    <input onclick="submitMyMessage(this)" type="button" id="submit2" style="display: none;">
                </fieldset>
            </form>

            <!-- 留言板区域 -->
            <fieldset id="messageboard_zone">
                <legend>
                     <img src="images/icon/zhizhang.png" style="position: relative; width: 20px; height: 20px; top: 2px;" />
                    <b style="position: relative; left: -3px; top: -2px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">留言区域</b>
                </legend>
                <%for (int i = index - 1; i >= 0; i --) { %>
                    <div class="messageboard_block" onmouseover="blockHover(this)" onmouseout="bolckOut(this)">
                        <img class="head_portraits" src="images/default_avatar.jpeg" />
                        <div class="messageboard_top">
                            <div class="messageboard_name">昵称</div>
                            <div class="messageboard_floor">
                            <font>第<%= i+1 %>楼</font>
                            </div>     
                        </div>
                        <div class="messageboard_time">
                            <font><%= date_output[i] %></font>
                        </div>
                        <div class="messageboard_content">
                            <font><%= content_output[i] %></font>                       
                        </div>
                        <div class="messageboard_operator">
                            <div class="azone">
                                <a href="#">删除</a>
                                |
                                <a href="#">回复</a>
                            </div>
                        </div>
                    </div>
                <%}%>
            </fieldset>
        </div>
    </div>
    <div id="footer">
    </div>
</body>
</html>