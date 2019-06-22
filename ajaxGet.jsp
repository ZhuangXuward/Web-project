<%@page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
    String msg=""; 
    String follower = request.getParameter("userId");
    String followed = request.getParameter("followedId");
    String conStr = "jdbc:mysql://172.18.187.10:3306/blog_15336202"
    + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

    Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    Connection con=DriverManager.getConnection(conStr, "user", "123");
    Statement stmt=con.createStatement(); //创建MySQL语句的对象
    ResultSet rs=stmt.executeQuery("select * from followers where fans_id='" + follower + "' and followed_id='" + followed + "'");
    
    //1.原先不存在关注关系->执行关注操作
    if (!rs.next()) {
        String fmt="insert into followers(fans_id, followed_id) values('%s', '%s')";
        String sql = String.format(fmt, follower, followed);
        stmt.executeUpdate(sql);
        out.print("已关注");
    }

    //2.原先存在关注关系->取关
    else{
        int cnt = stmt.executeUpdate("delete from followers where fans_id='"+follower+"' and followed_id='" + followed + "'");
        out.print("关注");
    }

    rs.close(); stmt.close(); con.close();
%>