<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String msg = "";
    String connectString = "jdbc:mysql://172.18.187.10:3306/blog_15336202" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user="user"; 
    String pwd="123";
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

    //查看是否隐藏边栏
    String showHome = "";
    ResultSet rHome = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rHome.next()) {          
        showHome = rHome.getString("showHome");        
    }
    rHome.close();

    //上传表单修改数据库内容
    if (request.getMethod().equalsIgnoreCase("post")) {
        String namePost = request.getParameter("namePost");
        String sexPost = request.getParameter("sexPost");
        String birthdayPost = request.getParameter("birthdayPost");
        String phonePost = request.getParameter("phonePost");
        String hobbyPost = request.getParameter("hobbyPost");
        String hometownPost = request.getParameter("hometownPost");
        String emailPost = request.getParameter("emailPost");
        String jobPost = request.getParameter("jobPost");
        String schoolPost = request.getParameter("schoolPost");
        String companyPost = request.getParameter("companyPost");
        String signPost = request.getParameter("signPost");
        String resumePost = request.getParameter("resumeText");
        try {
            int cnt = stmt.executeUpdate("update users set name='"+namePost+"', sex='"+sexPost+"', birthday='"+birthdayPost+"', phone='"+phonePost+"', hobby='"+hobbyPost+"', hometown='"+hometownPost+"', email='"+emailPost+"', job='"+jobPost+"', school='"+schoolPost+"', company='"+companyPost+"', sign='"+signPost+"', resume='"+resumePost+"' where name='"+webUser+"'");

            //其他表格也要更改名字
            stmt.executeUpdate("update blog set blogOwner='"+namePost+"' where blogOwner='"+webUser+"'");
            stmt.executeUpdate("update blog set username='"+namePost+"' where username='"+webUser+"'");
            stmt.executeUpdate("update blog set level3ToWho='"+namePost+"' where level3ToWho='"+webUser+"'");
            stmt.executeUpdate("update messageBoard set boardOwner='"+namePost+"' where boardOwner='"+webUser+"'");
            stmt.executeUpdate("update messageBoard set visitName='"+namePost+"' where visitName='"+webUser+"'");

            //也需要更改cookie的用户名
            Cookie suser = new Cookie("user", namePost);
            // 设置cookie过期时间为一周。
            suser.setMaxAge(7*60*60*24); 
            // 在响应头部添加cookie
            response.addCookie(suser);

            if (cnt>0) 
                msg = "资料修改成功!";
            response.sendRedirect("Data.jsp?userId=" + userId);
        } catch(Exception e) {
            msg = e.getMessage();
        }
    }

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

    ResultSet rs = stmt.executeQuery("select * from users where name='"+webUser+"'");
    while (rs.next()) {    
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
        userId = rs.getString("id");
        //用户名更改
    }

    rs.close(); 

    //防止邮箱和名字重复
    ResultSet rss = stmt.executeQuery("select * from users");
    int index = 0;
    String[] name_array = new String[1000];
    String[] email_array = new String[1000];
    while (rss.next()) {
        name_array[index] = rss.getString("name");
        email_array[index] = rss.getString("email");
        index ++;
    } 
    
    rss.close(); stmt.close(); con.close();
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
            <li><a href="index.jsp" class="mobile_link">个人主页</a></li>
            <li><a href="friends.jsp" class="mobile_link">好友动态</a></li>
            <li><a href="messageBoard.jsp" class="mobile_link">留言板</a></li>
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
            <form action="Data.jsp" method="post" id="dataForm">
                <fieldset id="data_board">
                    <!-- 发表博客 -->
                    <legend>
                        <img src="images/icon/ziliao.png" style="position: relative; width: 22px; height: 22px; top: 2px;" />
                        <b style="position: relative; left: -3px; top: -4px; text-shadow: 2.5px 2.5px 2px #8a8a8a;">资料显示</b>
                    </legend>
                    <div id="data">
                        <div id="name">昵称：
                            <input type="text" name="namePost" value="<%=name_value%>" class="dataInput" id="namePost"/>
                            <font class="dataValue"><%=name_value%></font>
                        </div>
                        <div id="sex">性别：
                            <div class="dataInput" id="sexPost">          
                                <input type="radio" name="sexPost" value="男" id="male"/>男
                                <input type="radio" name="sexPost" value="女" id="female"/>女
                                <input type="radio" name="sexPost" value="保密" id="secret"/>保密
                                <script type="text/javascript">
                                    if("<%=sex_value%>" == "男")
                                        document.getElementById("male").setAttribute("checked", true);
                                    if("<%=sex_value%>" == "女")
                                        document.getElementById("female").setAttribute("checked", true);
                                    if("<%=sex_value%>" == "保密")
                                        document.getElementById("secret").setAttribute("checked", true);
                                </script>
                            </div>
                            <font class="dataValue"><%=sex_value%></font>
                        </div>
                        <div id="birthday">生日：
                            <div class="dataInput">
                                <select name="sel1" id="sel1" onchange="showMonth()">
                                    <option value="year" id="option_year" >年</option>
                                </select>
                                <select name="sel2" id="sel2" disabled="true">
                                    <option value="month" id="option_month">月</option>
                                </select>
                                <select name="sel3" id="sel3" disabled="true">
                                    <option value="day" id="option_day">日</option>
                                </select>
                                <input type="hidden" name="birthdayPost" id="birthdayPost" value="<%=birthday_value%>" />
                                <script type="text/javascript">
                                    var birthdayString = "<%=birthday_value%>";
                                    var birthdayTemp = birthdayString.split("-");
                                    document.getElementById("option_year").innerHTML = birthdayTemp[0];
                                    document.getElementById("option_month").innerHTML = birthdayTemp[1];
                                    document.getElementById("option_day").innerHTML = birthdayTemp[2];
                                    document.getElementById("option_year").value = birthdayTemp[0];
                                    document.getElementById("option_month").value = birthdayTemp[1];
                                    document.getElementById("option_day").value = birthdayTemp[2];

                                </script> 
                                <div id="birthday_result"></div>             
                            </div>
                            <input type="button" value="更改" onclick="changeBirthDay()" style="position: relative; display: none; left: -100px; cursor: pointer;" id="forChange" />
                            <font class="dataValue"><%=birthday_value%></font> 
                        </div>
                        <div id="phone">电话：
                            <input type="text" name="phonePost" value="<%=phone_value%>" class="dataInput" id="phonePost" />
                            <font class="dataValue"><%=phone_value%></font>
                        </div>
                        <div id="hobby">兴趣：
                            <input type="text" name="hobbyPost" value="<%=hobby_value%>" class="dataInput" id="hobbyPost" />
                            <font class="dataValue"><%=hobby_value%></font>
                        </div>
                        <div id="hometown">家乡：
                            <input type="text" name="hometownPost" value="<%=hometown_value%>" class="dataInput" id="hometownPost" />
                            <font class="dataValue"><%=hometown_value%></font>
                        </div>
                        <div id="email">邮箱：
                            <input type="text" name="emailPost" value="<%=email_value%>" class="dataInput" id="emailPost" />
                            <font class="dataValue"><%=email_value%></font>
                        </div>
                        <div id="job">职业：
                            <input type="text" name="jobPost" value="<%=job_value%>" class="dataInput" id="jobPost" />
                            <font class="dataValue"><%=job_value%></font>
                        </div>
                        <div id="school">学校：
                            <input type="text" name="schoolPost" value="<%=school_value%>" class="dataInput" id="schoolPost" />
                            <font class="dataValue"><%=school_value%></font>
                        </div>
                        <div id="company">公司：
                            <input type="text" name="companyPost" value="<%=company_value%>" class="dataInput" id="companyPost" />
                            <font class="dataValue"><%=company_value%></font>
                        </div>
                        <div id="sign">个性签名：
                            <input type="text" name="signPost" value="<%=sign_value%>" class="dataInput" id="signPost" />
                            <font class="dataValue"><%=sign_value%></font>
                        </div>
                        <div id="resume">个人简介：  
                            <div class="dataInput">
                                <textarea style="vertical-align: top;" id="resumeText" maxlength="120" name="resumeText"><%=resume_value%></textarea>
                                <!-- 注意textarea之间不能留有空格 -->
                            </div>
                            <font class="dataValue"><%=resume_value%></font>
                        </div>                      
                    </div>
                    <img src="images/icon/dataEdit.png" id="dataEdit" onmouseover="appendixto2(this)" onmouseout="removethe2(this)" onclick="dataToEdit(this)" style="opacity: 0.5;" />
                    <input type="button" name="exit" id="exit" value="退出" onclick="if(window.confirm('是否放弃此次编辑？')) window.location.reload();" />
                    <input type="button" name="save" value="保存" id="saveData" onclick="uploadData()" />
                    <img src="images/bamboo.png" id="dataBamboo" />
                </fieldset>          
            </form>
        </div>
    </div>
</body>
<script type="text/javascript">
    if("<%=showHome%>" == "false") {
        document.getElementById("home").style.display = "none";
        document.getElementById("main").style.setProperty('left','0%');
        document.getElementById("main").style.setProperty('width','100%');
        document.getElementById("nav").style.setProperty('width','460px');
    }

    //一定要把jsp定义的移到外面来
    //修改用户资料
    function uploadData() {
        if (window.confirm('是否进行资料修改？')) 
        { 
            var nameFlag = true;
            var emailFlag = true;
            //检查用户名是否被注册
            <%for (int i = 0; i < index; i ++) { %>
                //注意要加双引号！
                if ("<%=name_array[i]%>" == namePost.value && namePost.value != "<%=webUser%>")
                {
                    alert('"'+namePost.value+'"'+"这个用户名已被注册");
                    flag = false;
                    namePost.value = "<%=webUser%>";
                }
            <%}%>

            //检查邮箱是否被注册
            if (nameFlag == true) {
                <%for (int i = 0; i < index; i ++) { %>
                    if ("<%=email_array[i]%>" == emailPost.value && emailPost.value != "<%=email_value%>")
                    {
                        alert('"'+emailPost.value+'"'+"这个邮箱已被注册");
                        flag = false;
                        emailPost.value = "<%=email_value%>";
                    }
                <%}%>
            }

            if (nameFlag == true && emailFlag == true) {
                document.getElementById('dataForm').submit();  
                datatoShow();           
            }
        }
    }

    //这些直接引用也要抽出来
    //生成1日—31日
    sel2.onchange = function() {
        var dayNum = getDayNum(sel2.value, sel1.value);
        for(var i = 1; i <= dayNum; i ++) {
            var option = document.createElement('option');
            option.setAttribute('value', i);
            option.innerHTML = i;
            sel3.appendChild(option);    
        }
        showDay();
    }

    sel3.onchange = function() {
        document.getElementById('sel3').removeAttribute("disabled");
        document.getElementById("birthday_result").innerHTML = sel1.value + "-" + sel2.value + "-" + sel3.value;
        sel1.style.display = "none";
        sel2.style.display = "none";
        sel3.style.display = "none";
        document.getElementById("forChange").style.display = "inline-block";
        document.getElementById("birthdayPost").value = document.getElementById("birthday_result").innerHTML;
    }

    //更改前一次修改的生日
    function changeBirthDay() {
        document.getElementById('sel1').value = "";
        document.getElementById('sel2').value = "";
        document.getElementById('sel3').value = "";
        document.getElementById('sel1').removeAttribute("disabled");
        document.getElementById('sel3').setAttribute("disabled", "true");
        sel1.style.display = "inline-block";
        sel2.style.display = "inline-block";
        sel3.style.display = "inline-block";
        document.getElementById("forChange").style.display = "none";
        document.getElementById("birthday_result").innerHTML = "";   
    }

    //生成1950年到2019年
    for(var i = 2019; i >= 1950; i--) {
        var option = document.createElement('option');
        option.setAttribute('value', i);
        option.innerHTML = i;
        sel1.appendChild(option);
    }
    //生成1月-12月
    for(var i = 1; i <= 12; i ++) {
        var option = document.createElement('option');
        option.setAttribute('value', i);
        option.innerHTML = i;
        sel2.appendChild(option);    
    }
</script>
</html>