package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Board;
import com.study.vo.BoardComment;
import com.study.vo.Category;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@Slf4j
@WebServlet("/board/boardDetail.do")
public class boardDetail extends HttpServlet {

    public boardDetail() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        BoardService service = new BoardService();
        //전체 카테고리 호출
        List<Category> categoryList = service.categoryAll();
        //게시글 번호
        int boardNo=Integer.parseInt(req.getParameter("boardNo"));
        //게시글 상세보기
        Board b=service.viewDetail(boardNo);
        //댓글
        List<BoardComment> boardComment = service.listComment();


        log.info("로그 테스트");
        log.info(String.valueOf(b));


        req.setAttribute("categoryList",categoryList);  //카테고리
        req.setAttribute("boardNo",boardNo);
        req.setAttribute("boardComment",boardComment);
        req.setAttribute("b",b);
        req.getRequestDispatcher("/views/boards/servlet/view.jsp").forward(req,res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}