<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String msg=""; 
    String pwd="", name="";//数据库中保存的密码和用户名
    String conStr = "jdbc:mysql://172.18.187.10:3306/blog_15336202"
    + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String userName = request.getParameter("name"); //从登录页面post过来的用户名和密码
    String userPwd = request.getParameter("password");
    try {
        Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
        Connection con=DriverManager.getConnection(conStr, "user", "123");
        Statement stmt=con.createStatement(); //创建MySQL语句的对象
        ResultSet rs=stmt.executeQuery("select * from users where (name = '" + userName + "' or email = '" + userName + "') and password = '" + userPwd + "'");//执行查询，返回结果集
        if(rs.next()) { //把游标(cursor)移至第一个或下一个记录
            response.sendRedirect("loGinsuccess.jsp?username=" + userName); //密码正确跳转loGinsuccess.jsp
        }else{
            response.sendRedirect("login.jsp?errNo");//密码不对返回到登陆  
        }
    rs.close(); stmt.close(); con.close();
    }
    catch(Exception e){
        msg = e.getMessage();
    }
%>