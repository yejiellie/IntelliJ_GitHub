<%@ page import="com.study.dao.BoardDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 삭제하기</title>
</head>
<body>
<%
    int boardNo=Integer.parseInt(request.getParameter("boardNo"));
    if(new BoardDao().deleteBoard(boardNo)>0){
        out.println("<script>alert('삭제되었습니다.');location.href='/views/boards/free/list.jsp';</script>");
//        response.sendRedirect("list.jsp");
    }else{
        out.println("<script>alert('삭제를 실패했습니다.');</script>");
    }
%>

</body>
</html>
