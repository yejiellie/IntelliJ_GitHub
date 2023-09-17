package com.study.servlet.dao;

import com.study.vo.Board;
import com.study.vo.Category;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class BoardDaoServlet {

    /**
     * 게시글 전체조회
     * @param session 매핑 구문 실행
     * @param cPage 현재페이지 번호
     * @param numPerpage 한 페이지당 보여줄 게시물 수
     * @return 게시물의 결과값을 list로 반환
     */
    public List<Board> searchAll(SqlSession session,int cPage, int numPerpage){
        return session.selectList("board.searchAll",
                null,new RowBounds((cPage-1)*numPerpage,numPerpage));
    }

    /**
     * 게시글 수 조회
     * @param session 매핑
     * @return 게시글 수 반환
     */
    public int selectBoardCount(SqlSession session){
        return session.selectOne("board.selectBoardCount");
    }

    public List<Category> categoryAll(SqlSession session){
        return session.selectList("board.categoryAll");
    }

}
