package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/board/BoardUpdate.do")
public class BoardUpdate extends HttpServlet {

    public BoardUpdate() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        int boardNo = Integer.parseInt(req.getParameter("boardNo"));
        String writer = req.getParameter("writer");
        String boardPw = req.getParameter("boardPw");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Board b = Board.builder()
                .boardNo(boardNo)
                .writer(writer)
                .boardPw(boardPw)
                .title(title)
                .content(content)
                .build();

        int result = new BoardService().updateBoard(b);

        String msg = "", loc = "";
        if (result > 0) {
            msg = "게시글이 수정되었습니다.";
            loc = "/board/boardDetail.do?boardNo=" + boardNo;
        } else {
            msg = "게시글 수정을 실패했습니다.";
            loc = "/board/BoardUpdatePage.do?boardNo=" + boardNo;
        }
        req.setAttribute("msg", msg);
        req.setAttribute("loc", loc);
        req.getRequestDispatcher("/views/boards/free/common/msg.jsp").forward(req, res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}