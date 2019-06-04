<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user = "user";
	String pwd = "123";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString, user, pwd);
	Statement stmt = con.createStatement();
	
	if (request.getMethod().equalsIgnoreCase("post")) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();
		String str_date1 = formatter.format(currentTime);
		String date = currentTime.toString();
		String content = request.getParameter("msg");
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
	
	String[] content_output = new String[100];
	String[] date_output = new String[100];
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
            <li><a href="Index.html" class="mobile_link">个人主页</a></li>
            <li><a href="friends.html" class="mobile_link">好友动态</a></li>
            <li><a href="album.html" class="mobile_link">相册</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
            <li><a href="Data.html" class="mobile_link">个人资料</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait">
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="Index.html" id="mobile_com">「Lifeblog.com」</a>
        <img id="expand-menu" src="images/expand-menu.png" onclick="showShadow(); closeAnimate()" />
    </div>

    <!-- normal -->
    <div id="home">
        <div id="search">
        </div>
        <div id="com">
            <a href="">「Lifeblog.com」</a>
        </div>
        <div id="head_portrait">
            <img src="images/default_avatar.jpeg" style="width: 80px; height: 80px; border-radius: 50px;">
        </div>
        <div id="personal_signature">
            <p>Show your life this moment!<p>
        </div>
        <ul id="menu">
            <li>
                <a href="">设置</a>
            </li>
            <li>
                <a href="">关于</a>
            </li>
    </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="Index.html" id="index" class="nav_hover">个人主页&nbsp</a></li>
                <li id="li_friends"><a href="friends.html" id="friends" class="nav_hover">&nbsp好友动态&nbsp</a></li>
                <li id="li_album"><a href="album.html" id="album" class="nav_hover">&nbsp相册&nbsp</a></li>
                <li id="li_messageBoard"><a href="messageBoard.html" id="message_board" class="nav_hover">&nbsp留言板&nbsp</a></li>
                <li id="li_data"><a href="Data.html" id="data" class="nav_hover">&nbsp个人资料&nbsp</a></li>
            </ul>
            <div id="register">
                <a href="login.jsp">登录</a>
                |
                <a href="signup.jsp">注册</a>
                <img id="logo" />
            </div>
        </div>
        <div id="content">
            <form action="messageBoard.jsp" method="post" id="board">
                <fieldset id="board_set">
                    <legend><b>联系留言</b></legend>
                    <textarea id="msg" name="msg"></textarea>
                    <br>
                    <input type="submit" id="btn" value="留言">
                </fieldset>
                <fieldset id="board_style">
                	<legend><b>留言</b></legend>
                	<%for (int i = index - 1; i >= 0; i --) { %>
	  					<h2><%=content_output[i]%><%=date_output[i]%></h2>
					<%}%>
                </fieldset>
            </form>
        </div>
    </div>

    <div id="footer">
    </div>
</body>
</html>