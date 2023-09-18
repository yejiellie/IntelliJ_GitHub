package com.study.servlet.controller;

import com.study.servlet.service.BoardService;
import com.study.vo.Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/board/searchBoard.do")
public class SearchBoard extends HttpServlet {

    public SearchBoard() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {


        //제목, 작성자, 내용
        String searchbox = req.getParameter("searchbox");
        int cateNo = Integer.parseInt(req.getParameter("cateNo"));
        String beforeDate = req.getParameter("beforeDate");
        String currentDate = req.getParameter("currentDate");

        Map<String,Object> param = new HashMap<>();
        param.put("search", searchbox);
        param.put("cateNo", cateNo);
        param.put("beforeDate", beforeDate);
        param.put("currentDate", currentDate);
        System.out.println(param);
        List<Board> searchBoard = new BoardService().searchBoard(param);

        req.setAttribute("searchBoard",searchBoard);
        req.getRequestDispatcher("/views/boards/servlet/list.jsp").forward(req,res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}