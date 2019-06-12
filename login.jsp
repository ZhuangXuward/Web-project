<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>登录</title>
    <script src="js/loginAndRegister.js"></script>
    <style>
        * {
            font-family: Brush Script MT, STKaiti, YouYuan, sans-serif;
        }

        a {
            text-decoration: none;
        }

        body {
            background-color: lightblue;
            font-size: 15px;
        }

        input {
            font-family: 微软雅黑;
        }

        div#backgroundpic {
            position: absolute;
            z-Index: -100;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            background: url("images/wholehomepic.jpeg")no-repeat;
            background-size: cover;
            opacity: 0.5;
        }
        
        div#logInContain {
            text-align: center
        }
        
        div#logInContain form {
            width: 300px;
            margin: 0 auto;
        }

        div#logInContain form input {
            display: block;
            width: 300px;
            line-height: 35px;
            text-indent: 1em;
            margin: 30px 0;
            border-radius: 5px;
        }

        div#logInContain form input:last-child {
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

        span#loginMsg {
            color: red;
            font-weight: bold;
        }

        @media only screen and (max-width: 600px) {
            div#logInContain form input {
                width: 250px;
                margin: 20px auto;
                line-height: 35px;
            }

            div#logInContain form input:last-child {
                width: 250px;
            }
        }
    </style>
</head>
<body>
    <div id="backgroundpic"></div>
    <div id="logInWrap">
        <div id="logInContain">
            <h1>登录</h1>
            <form action="loginCheck.jsp?userId=<%=userId%>" method="POST" name="formLogin">
                <input type="text" placeholder="昵称/邮箱" name="name">
                <input type="password" placeholder="密码" name="password">
                <input type="button" value="登录" onclick="doCheck_logIn()" id="confirm">
            </form>
            <p>还没有帐号？<a href="signup.jsp?userId=<%=userId%>">前往注册</a></p>
    <%  
    String flag = request.getParameter("errNo");  
    try{
         if(flag!=null)
            out.println("<span id='loginMsg'>用户名不存在或密码错误</span>");
    }catch(Exception e){
        e.printStackTrace();
    }
   %>
        </div>
    </div>
</body>
</html>