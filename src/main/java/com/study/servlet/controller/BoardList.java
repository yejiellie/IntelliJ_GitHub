package com.study.servlet.controller;

import com.study.dao.BoardDao;
import com.study.dao.CategoryDao;
import com.study.vo.Board;
import com.study.vo.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/board/BoardList.do")
public class BoardList extends HttpServlet {

    public BoardList() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated constructor stub
        CategoryDao cdao=new CategoryDao();
        List<Category> categoryList=cdao.selectAll(); //전체 카테고리 호출

        BoardDao dao=new BoardDao();
//    List<Board> list=dao.searchAll();  //전체 게시글 호출

        //페이지바 구현하기
        int cPage;              //현재 사용자가 보고있는 페이지
        int numPerpage=5;       //페이지당 출력될 데이터의 갯수

        try {
            cPage=Integer.parseInt(req.getParameter("cPage"));
        }catch(NumberFormatException e) {
            cPage=1;
        }

        List<Board> list=dao.searchAll(cPage,numPerpage);

        int totalData=dao.selectBoardCount();
        String pageBar="";
        int pageBarSize=5;
        //전체 페이지 수
        int totalPage=(int)Math.ceil((double)totalData/numPerpage);

        int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
        int pageEnd=pageNo+pageBarSize-1;

        if(pageNo==1) {
            pageBar+="<span>[이전]</span>";
        }else {
            pageBar+="<a href='"+req.getContextPath()
                    +"/views/boards/free/list.jsp?cPage="+(pageNo-1)+"'> [이전] </a>";
        }
        while(!(pageNo>pageEnd||pageNo>totalPage)) {
            if(cPage==pageNo) {
                pageBar+="<span>"+pageNo+"</span>";
            }else {
                pageBar+="<a href='"+req.getContextPath()
                        +"/views/boards/free/list.jsp?cPage="+pageNo+"'>"+" "+pageNo+" "+"</a>";
            }
            pageNo++;
        }

        if(pageNo>totalPage) {
            pageBar+="<span>[다음]</span>";
        }else {
            pageBar+="<a href='"+req.getContextPath()
                    +"/views/boards/free/list.jsp?cPage="+pageNo+"'> [다음] </a>";
        }

        req.setAttribute("totalData",totalData);        //총 게시글수
        req.setAttribute("categoryList",categoryList);  //카테고리
        req.setAttribute("list",list);                  //모든 게시글
        req.setAttribute("pageBar",pageBar);
        req.getRequestDispatcher("/views/boards/servlet/list.jsp").forward(req,res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}