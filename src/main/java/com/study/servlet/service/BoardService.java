package com.study.servlet.service;

import com.study.servlet.dao.BoardDaoServlet;
import com.study.vo.Board;
import com.study.vo.Category;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

import static com.study.common.SessionTemplate.getSession;
public class BoardService {
    private BoardDaoServlet dao=new BoardDaoServlet();

    /**
     * 게시글 조회
     * @param cPage 현재페이지 번호
     * @param numPerpage 한 페이지당 보여줄 게시물 수
     * @return 게시글
     */
    public List<Board> searchAll(int cPage, int numPerpage){
        SqlSession session = getSession();
        List<Board> result = dao.searchAll(session,cPage,numPerpage);
        session.close();
        return result;
    }

    /**
     * 전체 게시글 갯수 
     * @return 게시글 수
     */
    public int selectBoardCount(){
        SqlSession session = getSession();
        int result = dao.selectBoardCount(session);
        session.close();
        return result;
    }

    /**
     * 카테고리 전체 조회
     * @return 카테고리 리스트
     */
    public List<Category> categoryAll(){
        SqlSession session = getSession();
        List<Category> result = dao.categoryAll(session);
        session.close();
        return result;
    }

}
