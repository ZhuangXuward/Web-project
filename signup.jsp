<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
String userId = request.getParameter("userId");
String msg = "";
String query = "";
String sql = "";
String sql2 = "";
String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
String user="user"; String pwd="123";
String username = request.getParameter("name");
String password = request.getParameter("password");
String sex = "保密";
String birthday = "";
String phone = "";
String hobby = "";
String hometown = "";
String email = request.getParameter("email");
String job = "";
String school = "";
String company = "";
String sign = "";
String resume = "";
if (request.getMethod().equalsIgnoreCase("post")){
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(connectString, user, pwd);
    Statement stmt = con.createStatement();
    query = request.getParameter("query");
    sql="select*from users where name='" + username +"'"; //查询数据库中是否有相同用户名
    sql2="select*from users where email='" + email + "'"; //查询数据库中是否有相同邮箱
    ResultSet rs=stmt.executeQuery(sql); 
      if (!rs.next()) { //没有相同用户名，继续判断邮箱是否相同
        try {
            ResultSet rss = stmt.executeQuery(sql2);
            if (!rss.next()) { //没有相同邮箱，注册成功
                String fmt="insert into users(name, password, sex, birthday, phone, hobby, hometown, email, job, school, company, sign, resume) values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
                sql = String.format(fmt, username, password, sex, birthday, phone, hobby,hometown, email, job, school, company, sign, resume);
                int cnt = stmt.executeUpdate(sql);
                if (cnt > 0) {
                    msg = "注册成功啦！";
                    response.sendRedirect("signUpSuccess.jsp");
                }
            }
            else { //用户名相同，但是邮箱已注册
                msg = "啊呀！这个邮箱被人注册了！";
            }
            stmt.close(); con.close();
        }
        catch (Exception e) {
            msg = e.getMessage();
        }
      }
      else { //用户名已注册
        msg = "啊哦！这个名字已经被别人抢先一步了！";
      }
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册</title>
    <script src="js/loginAndRegister.js"></script>
    <style>
        * {
            font-family: Brush Script MT, STKaiti, YouYuan, sans-serif;
        }
        a {
            text-decoration: none;
        }

        body {
            font-size: 15px;
        }

        input {
            font-family: 微软雅黑;
        }

        div#backgroundpic {
            position: absolute;
            z-index: -100;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            background: url("images/wholehomepic.jpeg")no-repeat;
            background-size: cover;
            opacity: 0.5;
        }

        div#signUpContain {
            text-align: center
        }

        div#signUpContain form {
            width: 300px;
            margin: 0 auto;
            /* text-align: center */
        }

        div#signUpContain form input {
            display: block;
            width: 300px;
            line-height: 35px;
            text-indent: 1em;
            margin: 30px 0;
            border-radius: 5px;
        }

        div#signUpContain form input:last-child {
            text-indent: 0;
            width: 300px;
            outline: none;
            border: 1px solid lightgray;
            background-color: gray;
            line-height: 35px;
            color: white;
            font-size: 18px;
            font-weight: bold;
        }

        span#registerMsg {
            font-family: 宋体;
            color: red;
            font-weight: bold;
        }

        @media only screen and (max-width: 600px) {
            div#signUpContain form input {
                width: 250px;
                margin: 20px auto;
                line-height: 35px;
            }

            div#signUpContain form input#confirm {
                width: 250px;
            }
        }

        div#signUpContain form>div {
            position: relative;
        }

        div#signUpContain form span {
            line-height: 10px;
            left: 10px;
            top: 45px;
            position: absolute;
        }
    </style>
</head>
<body>
    <div id="backgroundpic"></div>
    <div id="signUpWrap">
        <div id="signUpContain">
            <h1>注册</h1>
            <form action="signup.jsp" method="post" name="formRegister">
                <div>
                    <input type="text" placeholder="昵称" name="name" id="username" onchange="register_check(id)">
                    <span class="username"></span>
                </div>
                <div>
                    <input type="text" placeholder="邮箱" name="email" id="email" onchange="register_check(id)">
                    <span class="email"></span>
                </div>
                <div>
                    <input type="password" placeholder="密码" name="password" id="password" onchange="register_check(id)">
                    <span class="password"></span>
                </div>
                <div>
                    <input type="password" placeholder="确认密码" name="password2" id="password2" onchange="register_check(id)">
                    <span class="password2"></span>
                </div>
                <input type="button" value="注册" onclick="doCheck_Register()" id="confirm">
            </form>
            <p>已有帐号？<a href="login.jsp">前往登录</a></p>
            <span id="registerMsg"><%=msg%><span>
            <span id="result"></span>
        </div>   
    </div>
</body>
<script>   
    //===============注册界面输入框检测函数===============
    function register_check(id) {
        // 创建http请求
        var inPut_value = document.getElementById(id).value;
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            // 当http请求的状态变化时执行 
            if (xmlhttp.readyState == 4) { // 4-已收到http响应数据
                if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status == 304) {
                    var inPut = document.getElementById(id);
                    var span_result = document.getElementsByClassName(id)[0];
                    inPut_value = inPut.value;
                    // 200~299-OK 304-unmodified
                    // alert(xmlhttp.responseText);
                    // http响应的正文 
                    span_result.innerHTML = xmlhttp.responseText;
                } else {
                    alert("error");
                }
            };
        }; //打开http请求（open）的参数：get|post，url，是否异步发送 
        console.log(inPut_value);
        xmlhttp.open("get", "registerCheck.jsp?id=" + id + "&value=" + inPut_value, true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(null);
        //发送http请求。get只能用null作为参数 
    }
    //===============END注册界面输入框检测函数===============
</script>
</html>