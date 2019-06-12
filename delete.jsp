<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");
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
    
    if (request.getMethod().equalsIgnoreCase("post")) {
        String date = request.getParameter("deleteButton");
        try {
            int cnt = stmt.executeUpdate("delete from blog where date='"+date+"'");
            if (cnt > 0) {
                msg = "删除该blog成功！";
                response.sendRedirect("index.jsp?userId=<%=userId%>");
            }
        }
        catch (Exception e) {
            msg = e.getMessage();
        }
    }
    
    String[] blog_output = new String[1000];
    String[] date_output = new String[1000];
    int index = 0;
    ResultSet rs = stmt.executeQuery("select * from blog where username='"+webUser+"'");
    while (rs.next()) {
        blog_output[index] = rs.getString("blog");
        date_output[index] = rs.getString("date");
        index ++;
    }
    rs.close(); stmt.close(); con.close();
%>