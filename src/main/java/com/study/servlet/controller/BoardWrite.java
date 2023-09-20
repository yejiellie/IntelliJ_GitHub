package com.study.servlet.controller;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.servlet.service.BoardService;
import com.study.vo.Board;
import com.study.vo.BoardFile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@WebServlet("/board/boardWrite.do")
public class BoardWrite extends HttpServlet {

    public BoardWrite() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        //저장할 경로
        String path = req.getServletContext().getRealPath("/upload");

        MultipartRequest mr = new MultipartRequest(req ,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());
//                                                request객체,경로 ,최대업로드 파일크기, 경로상에 동일한 이름이 있다면 뒤에 번호를 부여함

        //게시물 정보 가져오기
        String title = mr.getParameter("title");
        int category = Integer.parseInt(mr.getParameter("category"));
        String writer = mr.getParameter("writer");
        String boardPw = mr.getParameter("boardPw");
        String content = mr.getParameter("content");

        Board b = Board.builder()
                .cateNo(category)
                .writer(writer)
                .boardPw(boardPw)
                .title(title)
                .content(content)
                .build();

        //파일 이름을 순서화 시켜서 저장
        List<BoardFile> files = new ArrayList<>();
        Enumeration<String> fileNames = mr.getFileNames();
        //파일 갯수만큼 반복
        while (fileNames.hasMoreElements()) {
            String paramName = fileNames.nextElement();          //파일을 반환
            String fileName = mr.getOriginalFileName(paramName); //원본파일 이름

            if (fileName != null) {
                // 파일이 선택된 경우에만 파일 정보를 추가
                files.add(BoardFile.builder().oriName(fileName).build());
            }
        }
        b.setFile(files);


        int result = new BoardService().insertBoard(b);

        String msg = "",loc = "";
        if(result > 0) {
            msg = "게시글이 등록되었습니다.";
            loc = "/board/boardDetail.do?boardNo="+b.getBoardNo();
        }else {
            msg = "게시글 등록을 실패했습니다.";
            loc = "/board/boardWritePage.do";
        }
        req.setAttribute("msg", msg);
        req.setAttribute("loc", loc);
        req.getRequestDispatcher("/views/boards/free/common/msg.jsp").forward(req,res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}