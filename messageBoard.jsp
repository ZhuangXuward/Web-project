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

    //加载签名
    String sign_value = "";
    ResultSet rsign = stmt.executeQuery("select * from users where name='"+webUser+"'");
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
            <li><a href="index.jsp" class="mobile_link">个人主页</a></li>
            <li><a href="friends.jsp" class="mobile_link">好友动态</a></li>
            <li><a href="Data.jsp" class="mobile_link">个人资料</a></li>
            <li><a href="recommend.jsp" class="mobile_link">推荐</a></li>
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
            <a href="setting.jsp">设置</a><br /><br /> 
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
                <li id="li_recommend"><a href="recommend.jsp" id="album" class="nav_hover">&nbsp;推荐&nbsp;</a></li>
            </ul>
            <div id="welcomeBack">
                欢迎回来!&nbsp;<font id="userName"><%=webUser%></font>
            </div>
        </div>
        <div id="content">
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
</body>
</html>