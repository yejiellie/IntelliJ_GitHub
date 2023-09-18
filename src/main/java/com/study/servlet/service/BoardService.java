package com.study.servlet.service;

import com.study.servlet.dao.BoardDaoServlet;
import com.study.vo.Board;
import com.study.vo.BoardComment;
import com.study.vo.Category;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

import static com.study.common.SessionTemplate.getSession;
public class BoardService {
    private BoardDaoServlet dao = new BoardDaoServlet();

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

    /**
     * 게시글 입력
     * @param b 게시글 정보
     * @return 성공시 1 반환
     */
    public int insertBoard(Board b){
        SqlSession session = getSession();
        int result = dao.insertBoard(session,b);
        if(result > 0){
            session.commit();
        }else{
            session.rollback();
        }
        session.close();
        return result;
    }

    /**
     * 게시글 상세보기 + 조회수 증가
     * @param boardNo 게시글 번호
     * @return 게시글 정보
     */
    public Board viewDetail(int boardNo){
        SqlSession session = getSession();
        Board result = dao.viewDetail(session,boardNo);
        if(result != null) {
            //게시글 조회에 성공시 조회수 증가
            int count = dao.updateReadCount(session,boardNo);
            if(count>0) {
                session.commit();
                result.setBoardCount(result.getBoardCount()+1);
            }
            else session.rollback();
        }
        session.close();
        return result;
    }

    /**
     * 게시글 삭제
     * @param boardNo 게시글 번호
     * @return 성공시 1반환
     */
    public int deleteBoard(int boardNo){
        SqlSession session = getSession();
        int result = dao.deleteBoard(session,boardNo);
        if(result > 0) session.commit();
        else session.rollback();
        session.close();
        return result;
    }

    /**
     * 게시글 수정하기
     * @param b 게시글 정보들
     * @return 성공시 1반환
     */
    public int updateBoard(Board b){
        SqlSession session = getSession();
        int result = dao.updateBoard(session,b);
        if(result > 0) session.commit();
        else session.rollback();
        session.close();
        return result;
    }

    /**
     * 게시글 검색
     * @param param
     * @return 검색 결과
     */
    public List<Board> searchBoard(Map<String,Object> param){
        SqlSession session = getSession();
        List<Board> result = dao.searchBoard(session,param);
        session.close();
        return result;
    }

////댓글

    /**
     * 댓글 전체 조회
     * @return 댓글 목록
     */
    public List<BoardComment> listComment(){
        SqlSession session =  getSession();
        List<BoardComment> result = dao.listComment(session);
        session.close();
        return result;
    }

    /**
     * 댓글 등록
     * @param b 댓글 정보
     * @return 성공시 1 반환
     */
    public int inertBoardComment(BoardComment b){
        SqlSession session = getSession();
        int result = dao.inertBoardComment(session,b);
        if(result > 0) session.commit();
        else session.rollback();
        session.close();
        return result;
    }


}
