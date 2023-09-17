package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/board/CheckPassword.do")
public class CheckPassword extends HttpServlet {

    public CheckPassword() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int boardNo = Integer.parseInt(req.getParameter("boardNo"));
        String type = req.getParameter("type");

        Board b=new BoardService().viewDetail(boardNo);;

        req.setAttribute("b",b);
        req.setAttribute("type",type);
        req.setAttribute("boardNo",boardNo);
        req.getRequestDispatcher("/views/boards/free/common/JSTLcheckPassword.jsp").forward(req,res);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}