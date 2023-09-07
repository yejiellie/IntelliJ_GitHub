<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%@ page import="com.study.dao.CategoryDao" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%--<%@ page import="com.oreilly.servlet.MultipartRequest" %>--%>
<%--<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>--%>

<body>
    <%

        String path=request.getServletContext().getRealPath("/upload/");
//        MultipartRequest mr=new MultipartRequest(request,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());

        String title=request.getParameter("title");

        Board b=Board.builder()
//                .writer(writer)
//                .


                .build();



    %>
</body>
</html>
