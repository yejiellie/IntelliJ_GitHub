package com.study.servlet.dao;

import com.study.vo.Board;
import com.study.vo.BoardComment;
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

    /**
     * 카테고리 목록 조회
     * @param session
     * @return 카테고리 전체 내용
     */
    public List<Category> categoryAll(SqlSession session){
        return session.selectList("board.categoryAll");
    }

    /**
     * 게시글 작성
     * @param session
     * @param b 게시글 정보
     * @return 성공시 1 반환
     */
    public int insertBoard(SqlSession session, Board b){
        return session.insert("board.insertBoard",b);
    }

    /**
     * 게시글 상세보기 
     * @param session
     * @param boardNo 게시글 번호
     * @return 게시글 정보
     */
    public Board viewDetail(SqlSession session, int boardNo){
        return session.selectOne("board.viewDetail",boardNo);
    }

    /**
     * 게시글 조회수 증가
     * @param session
     * @param boardNo 게시글 번호
     * @return 성공시 1 반환
     */
    public int updateReadCount(SqlSession session, int boardNo){
        return session.update("board.updateReadCount",boardNo);
    }

    /**
     * 게시글 삭제
     * @param session
     * @param boardNo 게시글 번호
     * @return 성공시 1 반환
     */
    public int deleteBoard(SqlSession session, int boardNo){
        return session.delete("board.deleteBoard",boardNo);
    }

    /**
     * 게시글 수정
     * @param session
     * @param b 게시글정보
     * @return 성공시 1반환
     */
    public int updateBoard(SqlSession session,Board b){
        return session.update("board.updateBoard",b);
    }



//    댓글

    /**
     * 댓글 전체 조회
     * @param session
     * @return 댓글 목록
     */
    public List<BoardComment> listComment(SqlSession session){
        return session.selectList("board.listComment");
    }

    /**
     * 댓글 등록
     * @param session
     * @param b 댓글 정보
     * @return
     */
    public int inertBoardComment(SqlSession session,BoardComment b){
        return session.insert("board.inertBoardComment",b);
    }
}
