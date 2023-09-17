package com.study.servlet.controller;

import com.study.servlet.service.BoardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/board/DeleteBoard.do")
public class DeleteBoard extends HttpServlet {

    public DeleteBoard() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        int boardNo = Integer.parseInt(req.getParameter("boardNo"));

        int result = new BoardService().deleteBoard(boardNo);

        String msg = "",loc = "";
        if(result > 0) {
            msg = "게시글이 삭제되었습니다.";
            loc = "/board/BoardList.do";
        }else {
            msg = "게시글 삭제를 실패했습니다.";
            loc = "/board/boardDetail.do?boardNo="+boardNo;
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