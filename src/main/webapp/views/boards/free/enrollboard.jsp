<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="java.io.File" %>
<%--<%@ page import="com.oreilly.servlet.MultipartRequest" %>--%>
<%--<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>--%>
<%@ page import="java.util.Enumeration" %>
<html>
<head>
    <title>게시글등록</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
//            String path=request.getServletContext().getRealPath("/upload/");
//            MultipartRequest mr=new MultipartRequest(request ,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());
//            String pic="";
//            Enumeration e=mr.getFileNames();//파일 이름을 순서화 시켜서 저장
//            if(e.hasMoreElements()) {
//                String filename=(String)e.nextElement();//파일을 반환
//                pic = mr.getFilesystemName(filename);
//         }
//        String title=mr.getParameter("title");
//        String category=mr.getParameter("category");
//        String writer=mr.getParameter("writer");
//        String pw=mr.getParameter("boardpw");
//        String content=mr.getParameter("content");
        int category=Integer.parseInt((request.getParameter("category")));
        String writer=request.getParameter("writer");
        String pw=request.getParameter("boardpw");
        String title=request.getParameter("title");
        String content=request.getParameter("content");

        Board b=Board.builder()
                .category(category)
                .writer(writer)
                .boardPw(pw)
                .title(title)
                .content(content)
                .build();

        int result=new BoardDao().insertBoard(b);
        if(result>0) {
            response.sendRedirect("list.jsp");
        }
        %>
</body>
</html>
