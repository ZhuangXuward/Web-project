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
	  Connection con=DriverManager.getConnection(connectString, "user", "123");
	  Statement stmt=con.createStatement();
      Connection con_follow=DriverManager.getConnection(connectString, "user", "123");
	  Statement stmt_follow=con_follow.createStatement();
      ResultSet rs;

      //========================根据ID/email/phone查找用户========================
      if(request.getMethod().equalsIgnoreCase("post")) {
        query = request.getParameter("query");
        sql="select*from users where name like '%"+query+"%' or email like '%"+query+"%' or phone like '%"+query+"%'";
      }
      else {
           sql="select*from users";
      }
	  rs=stmt.executeQuery(sql);
      if(!rs.next()) {
          msg = "没有该用户！";
      }
	  else {
          rs=stmt.executeQuery(sql);
          table.append("<div class='user_searched'>");
          while(rs.next()) {
            sql = "select * from followers where fans_id='" + userId + "' and followed_id='" + rs.getString("id") + "'";
            ResultSet rs_follow=stmt_follow.executeQuery(sql);
            String cssStr = "";
            if(rs_follow.next()) {
                ifFollow = "已关注";
                cssStr = "<a href='#' onclick='get(" + userId + ", " + rs.getString("id") + "); return false'><button class='follow_button followed' id='" + rs.getString("id") + "'>" + ifFollow + "</button></a>";
            }
            else {
                ifFollow = "关注";
                cssStr = "<a href='#' onclick='get(" + userId + ", " + rs.getString("id") + "); return false'><button class='follow_button' id='" + rs.getString("id") + "'>" + ifFollow + "</button></a>";
            }
            rs_follow.close();
            table.append(String.format(
                "<div class='user_item'>" +
                "<div class='user_avatar'><img src='./images/default_avatar.jpeg' style='width: 60px; height: 60px; border-radius: 50px;'></img>" +
                "</div>" + 
                "<div class='user_content'><a class='user_name' href='visitHome.jsp?visitName=" + rs.getString("name") + "' style='text-decoration: underline;'>%s</a> <span class='user_hobby'>%s</span> <span class='user_follow'>%s</span></div></div>",
                rs.getString("name"), rs.getString("hobby"),
                cssStr
                //TODO 关注，添加到数据库，判断关注关系是否存在。可使用已关注样式
                )
            );
		}
      table.append("</div>");
      }
      //========================END根据ID/email/phone查找用户========================


      stmt_follow.close();
      con_follow.close();

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
            <p>Show your life this moment!</p>
        </div>
        <div id="menu">
            <a href="search.jsp?userId=<%=userId%>"><img src="./images/icon/search.png" style="width: 20px; opacity: 0.5;"></a><br><br>
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
                <li id="li_friends"><a href="friends.jsp" id="friends" class="nav_hover">&nbsp;好友动态&nbsp;</a></li>
                <li id="li_messageBoard"><a href="messageBoard.jsp" id="message_board" class="nav_hover">&nbsp;留言板&nbsp;</a></li>
                <li id="li_data"><a href="Data.jsp" id="data" class="nav_hover">&nbsp;个人资料&nbsp;</a></li>
                <li id="li_recommend"><a href="recommend.jsp" id="album" class="nav_hover">&nbsp;推荐&nbsp;</a></li>
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
              <form action="search.jsp?userId=<%=userId%>&pid=<%=pid%>" method="post" name="searchForm"> 
                  <div id="search_borad">
                    <input type="text" name="query" placeholder="搜索用户" value="<%=query%>" style="outline: none;">
                    <a href="#" onclick="searchForm.submit(); return false"><img src="./images/icon/search2.png"> </a>
                  </div>
              </form>
              <%=table%><br><br>  
              <%=msg%>
            </div>
        </div>
    </div>
    <script>
        window.onload = function() {
            //===========关注成功效果===========
            var Obtn = document.getElementsByClassName("follow_button");
            for (let i = 0; i < Obtn.length; ++ i) {
                Obtn[i].onclick = function() {
                    if (Obtn[i].innerHTML == "关注") 
                    {}
                }
            }
            //===========END关注成功效果===========

            //===========搜索框效果===========
            var searchBorad = document.getElementById("search_borad");
            searchBorad.getElementsByTagName("input")[0].onfocus = function() {
                searchBorad.classList.add("search_active");
            }
            searchBorad.getElementsByTagName("input")[0].onblur = function() {
                searchBorad.classList.remove("search_active");
            }
            //===========END搜索框效果===========
        }

        //===========关注AJAX请求===========
        function get(follower, followed) {
            // 创建http请求
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                // 当http请求的状态变化时执行 
                if(xmlhttp.readyState==4) { // 4-已收到http响应数据
                    if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                        // 200~299-OK 304-unmodified
                        // alert(xmlhttp.responseText);
                        // http响应的正文 
                        var oTest = document.getElementById(followed);
                        oTest.innerHTML = xmlhttp.responseText;
                        if(!oTest.classList.contains("followed")) {
                            oTest.classList.add("followed");
                        }
                        else {
                            oTest.classList.remove("followed");
                        }
                        console.log("xmlhttp.responseText:" + xmlhttp.responseText);
                    } else {
                        alert("error");
                    }
                };
            }; //打开http请求（open）的参数：get|post，url，是否异步发送 
            var param = "userId=" + follower + "&followedId=" + followed;
            xmlhttp.open("get", "ajaxGet.jsp?userId=" + follower + "&followedId=" + followed, true);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send(null);
            //发送http请求。get只能用null作为参数 
        }
        //===========END关注AJAX请求===========

    </script>
</body>
</html>