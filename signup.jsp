<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
String msg = "";
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
    try {
        String fmt="insert into users(name,password,sex,birthday,phone,hobby,hometown,email,job,school,company,sign,resume) values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
        String sql = String.format(fmt, username, password, sex, birthday, phone, hobby,hometown, email, job, school, company, sign, resume);
        int cnt = stmt.executeUpdate(sql);
        if (cnt > 0) {
            msg = "注册成功!";
            response.sendRedirect("signUpSuccess.jsp");
        }
        stmt.close(); con.close();
    }
    catch (Exception e) {
        msg = e.getMessage();
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

            div#signUpContain form input:last-child {
                width: 250px;
            }
        }
    </style>
</head>
<body>
    <div id="backgroundpic"></div>
    <div id="signUpWrap">
        <div id="signUpContain">
            <h1>注册</h1>
            <form action="signup.jsp" method="post" name="formRegister">
                <input type="text" placeholder="昵称" name="name" id="username">
                <input type="text" placeholder="邮箱" name="email" id="email">
                <input type="password" placeholder="密码" name="password" id="password">
                <input type="password" placeholder="确认密码" name="password2" id="password2">
                <input type="button" value="注册" onclick="doCheck_Register()">
            </form>
            <p>已有帐号？<a href="login.jsp">前往登录</a></p>
            <span id="registerMsg"><%=msg%><span>
        </div>   
    </div>
</body>
</html>