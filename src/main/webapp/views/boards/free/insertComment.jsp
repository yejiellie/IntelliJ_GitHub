<%@ page import="com.study.vo.BoardComment" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>댓글 작성 jsp</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    int boardNo=Integer.parseInt(request.getParameter("boardNo"));

    String comment=request.getParameter("comment");

    BoardComment b=BoardComment.builder()
            .boardNo(boardNo)
            .content(comment)
            .build();

    int result=new BoardDao().inertBoardComment(b);
    if(result>0){
        response.sendRedirect("view.jsp?boardNo="+boardNo);
    }
%>

</body>
</html>
