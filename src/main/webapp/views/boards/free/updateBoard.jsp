<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<html>
<head>
    <title>게시글 수정하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    //첨부파일은 나중에 다시 시도하기!!!!
    int boardNo=Integer.parseInt(request.getParameter("boardNo"));
    String writer=request.getParameter("writer");
    String boardPw=request.getParameter("boardPw");
    String title=request.getParameter("title");
    String content=request.getParameter("content");

    Board b=Board.builder()
            .boardNo(boardNo)
            .writer(writer)
            .boardPw(boardPw)
            .title(title)
            .content(content)
            .build();

    int result=new BoardDao().updateBoard(b);
    if(result>0){
        out.println("<script>alert('수정이 완료되었습니다.');location.href='/views/boards/free/view.jsp?boardNo='"+boardNo+";</script>");
//        response.sendRedirect("view.jsp?boardNo="+boardNo);
    }
%>
</body>
</html>
