<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest " %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.study.vo.BoardFile" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.common.PasswordEncoding" %>
<html>
<head>
    <title>게시글등록</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        BoardDao dao=new BoardDao();
        //저장할 경로
        String path=request.getServletContext().getRealPath("upload/");
        MultipartRequest mr=new MultipartRequest(request ,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());
//                                                request객체,경로 ,최대업로드 파일크기, 경로상에 동일한 이름이 있다면 뒤에 번호를 부여함
        String file="";
        String ori="";
        BoardFile boardfile=null;
        List<BoardFile> files=new ArrayList();
        Enumeration e=mr.getFileNames();//파일 이름을 순서화 시켜서 저장
        while(e.hasMoreElements()) {
            String filename = (String) e.nextElement();//파일을 문자열로 반환
            ori = mr.getOriginalFileName(filename);
            file = mr.getFilesystemName(filename);

            boardfile = BoardFile.builder().newName(file).oriName(ori).build();
            files.add(boardfile);
            int key=dao.newKeyValue();
            for(BoardFile bf : files){
                dao.upload(boardfile,key);
            }
        }

//        PasswordEncoding pw=new PasswordEncoding(request);
        String title=mr.getParameter("title");
        int category=Integer.parseInt(mr.getParameter("category"));
        String writer=mr.getParameter("writer");
        String boardPw=mr.getParameter("boardPw");
        String content=mr.getParameter("content");



//        int category=Integer.parseInt((request.getParameter("category")));
//        String writer=request.getParameter("writer");
//        String pw=request.getParameter("boardpw");
//        String title=request.getParameter("title");
//        String content=request.getParameter("content");
        Board b=Board.builder()
                .cateNo(category)
                .writer(writer)
                .boardPw(boardPw)
                .title(title)
                .content(content)
                .build();
        int result=dao.insertBoard(b);

        if(result>0) {
            out.println("<script>alert('게시글이 등록되었습니다.');location.href='/views/boards/free/list.jsp';</script>");
        }else{
    %>
    <script>
        alert("게시물 등록에 실패했습니다!");
    </script>
    <%
            response.sendRedirect("list.jsp");
        }
    %>
</body>
</html>
