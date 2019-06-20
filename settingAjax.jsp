<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String msg=""; 
    String conStr = "jdbc:mysql://172.18.187.10:3306/blog_15336202"
    + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

    String webUser = request.getParameter("webUser");
    String showHome = request.getParameter("showHome");
    Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    Connection con=DriverManager.getConnection(conStr, "user", "123");
    Statement stmt=con.createStatement(); //创建MySQL语句的对象

    //修改‘是否显示边栏’的值
    stmt.executeUpdate("update users set showHome='"+showHome+"' where name='"+webUser+"'");

    stmt.close(); con.close();
%>