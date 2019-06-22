<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String param = request.getParameter("id");
    String value = request.getParameter("value");
    String conStr = "jdbc:mysql://172.18.187.10:3306/blog_15336202"
    + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    Connection con=DriverManager.getConnection(conStr, "user", "123");
    Statement stmt=con.createStatement(); //创建MySQL语句的对象
    
    if (value.equals("")) {
        out.print("输入点东西嘛~这么小气╭(╯^╰)╮");
    }
    else {
        if (param.equals("username")) {
            ResultSet rs=stmt.executeQuery("select * from users where name='" + value + "'");
            if (!rs.next()) {
                out.print("该昵称可以使用o(∩_∩)o");
            }
            else {
                out.print("该昵称已被注册了哦o_O");
            }
        
            rs.close();
        }
        else if (param.equals("email")) {
            ResultSet rs=stmt.executeQuery("select * from users where email='" + value + "'");
            if (!rs.next()) {
                out.print("这个邮箱可以使用呢o(∩_∩)o");
            }
            else {
                out.print("阿叻~这个邮箱被人注册了哦");
            }
            rs.close();
        }
    }
    stmt.close(); con.close();
%>