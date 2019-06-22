<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String msg = "";
    String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user="user"; 
    String pwd="123";
    String avatar_img = "";
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

    //显示数据库内容
    String name_value = "";
    String sex_value = "";
    String birthday_value = "";
    String phone_value = "";
    String hobby_value = "";
    String hometown_value = "";
    String email_value = "";
    String job_value = "";
    String school_value = "";
    String company_value = "";
    String sign_value = "";
    String resume_value = "";

    ResultSet rs = stmt.executeQuery("select * from users where name='"+visitName+"'");
    while (rs.next()) {    
        avatar_img = rs.getString("avatar");   
        name_value = rs.getString("name");
        sex_value = rs.getString("sex");
        birthday_value = rs.getString("birthday");
        phone_value = rs.getString("phone");
        hobby_value = rs.getString("hobby");
        hometown_value = rs.getString("hometown");
        email_value = rs.getString("email");
        job_value = rs.getString("job");
        school_value = rs.getString("school");
        company_value = rs.getString("company");
        sign_value = rs.getString("sign");
        resume_value = rs.getString("resume");
        //用户名更改
        
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
    <link rel="stylesheet" type="text/css" href="css/data.css" />
</head>

<body>
    <!-- for mobile device -->
    <div id="mobile_shadow">
    </div>
    <div id="mobile_box">
        <a href="#" id="mobile_back" onclick="hideShadow()"><img src="images/close.png"
                style="height: 20px; width: 20px;" /></a>
        <ul>
            <li><a href="index.jsp" class="mobile_link">返回我的主页</a></li>
            <li><a href="visitHome.jsp?visitName=<%=visitName%>" class="mobile_link">主页</a></li>
            <li><a href="visitMessageBoard.jsp?visitName=<%=visitName%>" class="mobile_link">留言板</a></li>
        </ul>
    </div>
    <div id="mobile_wrap">
        <div id="mobile_head_portrait">
            <img src="images/avatar/<%=avatar_img%>" style="width: 30px; height: 30px; border-radius: 50px;" />
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
            <img src="images/avatar/<%=avatar_img%>" style="width: 80px; height: 80px; border-radius: 50px;">
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
                <a href="index.jsp"><img src="images/icon/exit.png" width="12px" style="vertical-align: middle; opacity: 0.5;" onmouseover="this.style.opacity=1" onmouseout="this.style.opacity=0.5" title="离开" /></a>
            </div>
        </div>
        <div id="content">
                <fieldset id="data_board">
                    <!-- 发表博客 -->
                    <legend>
                        <img src="images/icon/ziliao.png" style="position: relative; width: 22px; height: 22px; top: 2px;" />
                        <b style="position: relative; left: -3px; top: -4px; text-shadow: 2.5px 2.5px 2px #8a8a8a;"><%=visitName%>的资料</b>
                    </legend>
                    <div id="data">
                        <div id="name">昵称：
                            <font class="dataValue"><%=name_value%></font>
                        </div>
                        <div id="sex">性别：
                            <font class="dataValue"><%=sex_value%></font>
                        </div>
                        <div id="birthday">生日：
                            <font class="dataValue"><%=birthday_value%></font> 
                        </div>
                        <div id="phone">电话：
                            <font class="dataValue"><%=phone_value%></font>
                        </div>
                        <div id="hobby">兴趣：
                            <font class="dataValue"><%=hobby_value%></font>
                        </div>
                        <div id="hometown">家乡：
                            <font class="dataValue"><%=hometown_value%></font>
                        </div>
                        <div id="email">邮箱：
                            <font class="dataValue"><%=email_value%></font>
                        </div>
                        <div id="job">职业：
                            <font class="dataValue"><%=job_value%></font>
                        </div>
                        <div id="school">学校：
                            <font class="dataValue"><%=school_value%></font>
                        </div>
                        <div id="company">公司：
                            <font class="dataValue"><%=company_value%></font>
                        </div>
                        <div id="sign">个性签名：
                            <font class="dataValue"><%=sign_value%></font>
                        </div>
                        <div id="resume">个人简介：  
                            <font class="dataValue"><%=resume_value%></font>
                        </div>                      
                    </div>
                    <img src="images/bamboo.png" id="dataBamboo" />
                </fieldset>          
        </div>
    </div>
</body>
</html>