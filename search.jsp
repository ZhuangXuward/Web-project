<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String msg = "";
    String sql = "";
	String query = "";
    String ifFollow = "";
    int flag = 0;
    String pid = request.getParameter("pid");
    String userId = request.getParameter("userId");
	String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
    StringBuilder table=new StringBuilder("");
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "user", "123");
	  Statement stmt=con.createStatement();
      
      //根据ID/email/phone查找用户
      if(request.getMethod().equalsIgnoreCase("post")) {
        query = request.getParameter("query");
        sql="select*from users where name like '%"+query+"%' or email like '%"+query+"%' or phone like '%"+query+"%'";
      }
      else {
           sql="select*from users";
      }
	  ResultSet rs=stmt.executeQuery(sql);
      if(!rs.next()) {
          msg = "没有该用户！";
      }
	  else {
          rs=stmt.executeQuery(sql);
          table.append("<div class='user_searched'>");
          while(rs.next()) {
            table.append(String.format(
                "<div class='user_item'>" +
                "<div class='user_avatar'><img src='./images/default_avatar.jpeg' style='width: 60px; height: 60px; border-radius: 50px;'></img>" +
                "</div>" + 
                "<div class='user_content'><span class='user_name'>%s</span> <span class='user_hobby'>%s</span> <span class='user_follow'>%s</span></div></div>",
                rs.getString("name"), rs.getString("hobby"),
                "<button class='follow_button'><a href='search.jsp?userId=" + userId + "&pid="+rs.getString("id")+"'>关注</a></button>"
                //TODO 关注，添加到数据库，判断关注关系是否存在。可使用已关注样式
                )
            );
		}
      table.append("</div>");
      }

      //关注用户
      //rs=stmt.executeQuery("insert into followed_fans(fans_id, followed_id) values(userId, pid)");
      if (pid != null) {
        sql = "select * from followers where fans_id='"+userId+"' and followed_id='"+pid+"'";
        rs=stmt.executeQuery(sql);
        if(!rs.next()) {
            String fmt="insert into followers(fans_id,followed_id) values('%s', '%s')";
            sql = String.format(fmt,userId,pid);
            //userId为当前用户id，pid为关注的用户id
            int cnt2 = stmt.executeUpdate(sql);
            if (cnt2>0) flag = 1;
        }
      }

	  rs.close();
	  stmt.close();
	  con.close();
	}
	catch (Exception e){
	  //msg = e.getMessage();
	}
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
    <script type="text/javascript" src="js/data.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css" />
    <link rel="stylesheet" type="text/css" href="css/mobile.css" />
    <link rel="stylesheet" type="text/css" href="css/search.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="Index.jsp" class="mobile_link">个人主页</a></li>
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
            <img src="images/default_avatar.jpeg" style="width: 30px; height: 30px; border-radius: 50px;" />
        </div>
        <a href="Index.jsp" id="mobile_com">「Lifeblog.com」</a>
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
            <p>Show your life this moment!</p>
        </div>
        <div id="menu">
            <a href="setting.html">设置</a><br><br> 
            <a href="about.html">关于</a><br><br>
            <a href="search.jsp"><img src="./images/icon/search.png" style="width: 20px; opacity: 0.5;"></a>
        </div>
        <div id="footer">
           <span>Copyright © 2019 LifeBlog.com</span>
        </div>
    </div>

    <div id="main">
        <div id="wrap">
            <ul id="nav">
                <li id="li_index"><a href="Index.jsp" id="index" class="nav_hover">个人主页&nbsp</a></li>
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
            <div id="container"> 
              <form action="search.jsp" method="post">
                  <span id="search_inner">userId:<%=userId%> pid:<%=pid%>输入查询：<input type="text" name="query" placeholder="输入昵称/邮箱/手机号码" value="<%=query%>"></span>
                  <input type="submit" value="查询">
                  <a href="Index.jsp?userId=<%=userId%>"><input type="button" value="返回"></a>
              </form>
              <%=table%><br><br>  
              <%=msg%>
            </div>
        </div>
    </div>
    <div id="follow_result">关注成功٩(ˊᗜˋ*)و</div>
    <script>
        window.onload = function() {

            // 关注成功效果
            var Obtn = document.getElementsByClassName("follow_button");
            for (let i = 0; i < Obtn.length; ++ i) {
                Obtn[i].onclick = function() {
                    if (<%=flag%> != 0) {//关注成功
                    
                        followSuccess();
                    }
                    else {//关注失败
                        // followFail();
                    } 
                } //onclick
            } //for
        }

        // ==============关注提示框===============
        //当滚轮滚动时使关注提示框消失
        window.onmousewheel = function() {
            var followBorad = document.getElementById("follow_result");
            followBorad.style.display = "none";
        }

        function followSuccess() {
            var followBorad = document.getElementById("follow_result");
            followBorad.style.display = "block";
        }
        // ==============END关注提示框===============
    </script>
</body>
</html>