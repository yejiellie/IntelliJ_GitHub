package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.BoardComment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/comment/CommentWrite")
public class CommentWrite extends HttpServlet {

    public CommentWrite() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        int boardNo=Integer.parseInt(req.getParameter("boardNo"));
        String comment=req.getParameter("comment");

        BoardComment b=BoardComment.builder()
                .boardNo(boardNo)
                .content(comment)
                .build();

        int result=new BoardService().inertBoardComment(b);

        String msg = "";
        if(result > 0) {
            msg = "댓글이 등록되었습니다.";
        }else {
            msg = "댓글 등록을 실패했습니다.";
        }
        req.setAttribute("msg", msg);
        req.setAttribute("loc", "/board/boardDetail.do?boardNo="+boardNo);
        req.getRequestDispatcher("/views/boards/free/common/msg.jsp").forward(req,res);




    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}