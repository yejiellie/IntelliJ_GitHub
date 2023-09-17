package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Board;
import com.study.vo.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/board/BoardUpdatePage.do")
public class BoardUpdatePage extends HttpServlet {

    public BoardUpdatePage() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        BoardService service = new BoardService();

        List<Category> categoryList=service.categoryAll(); //전체 카테고리 호출

        int boardNo=Integer.parseInt(req.getParameter("boardNo"));
        Board b=service.viewDetail(boardNo); //내용

        req.setAttribute("categoryList",categoryList);
        req.setAttribute("b",b);
        req.setAttribute("boardNo",boardNo);
        req.getRequestDispatcher("/views/boards/servlet/modify.jsp").forward(req,res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}