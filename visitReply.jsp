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

    String visitname = "";    //要访问用户
    visitname = request.getParameter("visitName");

    String datePost = request.getParameter("blogDate");

    String link_value = "";
    int index_link = 0;
    ResultSet rss = stmt.executeQuery("select * from blog where date='"+datePost+"'");
    while (rss.next()) {    
        index_link ++;
    }
    link_value = Integer.toString(index_link);
    rss.close();
    
    if (request.getMethod().equalsIgnoreCase("post")) {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yy年MM月dd日 HH:mm:ss");
        java.util.Date currentTime = new java.util.Date();
        String replyDate = formatter.format(currentTime);
        String date = datePost;
        String username = webUser;
        String blog = request.getParameter("replyButton");
        String level = "2";
        String link = link_value;
        try {
            String fmt = "insert into blog(date, username, blog, level, link, replyDate) values('%s', '%s', '%s', '%s', '%s', '%s')";
            String sql = String.format(fmt, date, username, blog, level, link, replyDate);
            int cnt = stmt.executeUpdate(sql);
            if (cnt > 0) 
            { 
                msg = "保存成功！"; 
                String temp = "visitHome.jsp?visitName=";
                temp += visitname; 
                //返回访问主页
                response.sendRedirect(temp);
            }
        }
        catch (Exception e) {
            msg = e.getMessage();
        }
    }
    stmt.close(); con.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>test</title>
</head>
<body>

<h1><%=msg%></h1>
</body>
</html>