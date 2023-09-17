package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/board/boardWritePage.do")
public class BoardWritePage extends HttpServlet {

    public BoardWritePage() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        List<Category> categoryList=new BoardService().categoryAll();
        req.setAttribute("categoryList",categoryList);
        req.getRequestDispatcher("/views/boards/servlet/write.jsp").forward(req,res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}