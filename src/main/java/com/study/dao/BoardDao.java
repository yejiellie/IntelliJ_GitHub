package com.study.dao;

import com.study.connection.ConnectionTest;
import com.study.vo.Board;
import com.study.vo.BoardComment;
import com.study.vo.BoardFile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import static com.study.connection.ConnectionTest.*;

public class BoardDao {

    public BoardDao(){}

    //게시판 전체 조회

    /**
     * 게시물 목록 조회
     * @param cPage 현재페이지 번호
     * @param numPerpage 한 페이지당 보여줄 게시물 수
     * @return 조회된 게시물 목록
     */
    public List<Board> searchAll(int cPage, int numPerpage) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<Board> result = new ArrayList();
        try{
            conn = ConnectionTest.getConnection();

            String sql = "SELECT * FROM board ORDER BY board_no ASC LIMIT ?,?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,(cPage-1)*numPerpage+1);
            pstmt.setInt(2,cPage*numPerpage);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                result.add(getBoard(rs));
            }

        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        } finally{
            close(pstmt);
            close(rs);
        }
        return result;
    }

    /**
     * 페이지처리시 사용
     * @return 게시글 갯수반환
     */
    public int selectBoardCount() {
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        int count=0;
        try {
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("SELECT COUNT(*) FROM board");
            rs=pstmt.executeQuery();
            if(rs.next()) count=rs.getInt(1);
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
        }return count;
    }

    /**
     * 
     *게시글 등록
     * @param b 게시글의 정보를 builder에 담음
     * @return 성공시 1반환 실패시 0 반환
     */
    public int insertBoard(Board b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            String sql="INSERT INTO baord VALUES(NULL,?,?,?,?,?,DEFAULT,NULL,DEFAULT);";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1,b.getCateNo());
            pstmt.setString(2,b.getWriter());
            pstmt.setString(3,b.getBoardPw());
            pstmt.setString(4,b.getTitle());
            pstmt.setString(5,b.getContent());
            result=pstmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(pstmt);
        }
        return result;
    }

    /**
     * 게시글 등록 후 게시글 번호를 바로 가져오기 위해 생성
     * @return 게시글 번호 (boardNo)
     */
    public int newKeyValue(){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        int count=0;
        try {
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("SELECT MAX(board_no) FROM  board;");
            rs=pstmt.executeQuery();
            if(rs.next()) count=rs.getInt(1);
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
        }
        return count;
    }

    /**
     *
     * @param b 파일 정보
     * @param boardNo 게시글 번호
     * @return 성공시 1, 실패시 0 반환
     */
    public int upload(BoardFile b,int boardNo){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            String sql="INSERT INTO baordfile VALUES(NULL,?,?,?)";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1,boardNo);
            pstmt.setString(2,b.getOriName());
            pstmt.setString(3,b.getNewName());
            result=pstmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(pstmt);
        }
        return result;
    }

    /**
     * 
     * 게시글 builder용
     * @return
     */
    public static Board getBoard(ResultSet rs) throws SQLException{
        return Board.builder()
                .boardNo(rs.getInt("BOARD_NO"))
                .cateNo(rs.getInt("CATE_NO"))
                .writer(rs.getString("WRITER"))
                .boardPw(rs.getString("BOARD_PW"))
                .title(rs.getString("TITLE"))
                .content(rs.getString("CONTENT"))
                .createDay(rs.getTimestamp("CREATEDAY"))
                .updateDay(rs.getTimestamp("UPDATEDAY"))
                .boardCount(rs.getInt("BOARD_COUNT"))
                .build();
    }

    /**
     * 게시글 상세보기
     * @param boardNo 게시글 번호
     * @return 게시글 정보
     */
    public Board viewDetail(int boardNo){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        Board b=null;
        try{
            conn=ConnectionTest.getConnection();
            updateReadCount(boardNo);
            pstmt=conn.prepareStatement("SELECT * FROM board WHERE board_no=?");
            pstmt.setInt(1,boardNo);
            rs=pstmt.executeQuery();
            if(rs.next()) b=getBoard(rs);
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(rs);
        }
        return b;
    }

    /**
     * 게시글 수정하기
     * @param b 게시글 정보
     * @return 성공시 1, 실패시 0
     */
    public int updateBoard(Board b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            String sql="UPDATE BOARD SET writer=?,board_pw=?,title=?,content=?,updateday=NOW() WHERE baord_no=?;";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,b.getWriter());
            pstmt.setString(2,b.getBoardPw());
            pstmt.setString(3,b.getTitle());
            pstmt.setString(4,b.getContent());
            pstmt.setInt(5,b.getBoardNo());
            result=pstmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
        }
        return result;
    }

    /**
     * 게시글 조회수
     * @param boardNo 게시글 번호
     * @return 성공시 1, 실패시 0 반화
     */
    public int updateReadCount(int boardNo){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try {
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("UPDATE board SET board_count=board_count+1 WHERE board_no=?");
            pstmt.setInt(1, boardNo);
            result=pstmt.executeUpdate();
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(pstmt);
        }
        return result;
    }

    /**
     * 게시글 삭제
     * @param boardNo 게시글 번호
     * @return 성공시 1, 실패시 0 반환
     */
    //게시글 삭제
    public int deleteBoard(int boardNo){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try {
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("DELETE FROM board WHERE board_no=?");
            pstmt.setInt(1, boardNo);
            result=pstmt.executeUpdate();
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            close(pstmt);
        }return result;
    }

    /**
     * 댓글 목록 
     * @return 댓글 전체 목록
     */
    public List<BoardComment> listComment(){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        List<BoardComment> list=new ArrayList();
        try{
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("SELECT * FROM boardcomment");
            rs=pstmt.executeQuery();
            while(rs.next()) {
                BoardComment b = new BoardComment();
                b.setCommentNo(rs.getInt("COMMENT_NO"));
                b.setBoardNo(rs.getInt("BOARD_NO"));
                b.setCommentDate(rs.getTimestamp("COMMENT_DATE"));
                b.setContent(rs.getString("CONTENT"));
                list.add(b);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        } finally{
            ConnectionTest.close(pstmt);
            ConnectionTest.close(rs);
        }
        return list;
    }

    /**
     * 댓글 등록
     * @param b 댓글 정보
     * @return 성공시 1, 실패시 0 반환
     */
    public int inertBoardComment(BoardComment b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("INSERT INTO boardcomment VALUES(NULL,?,DEFAULT,?);");
            pstmt.setInt(1,b.getBoardNo());
            pstmt.setString(2,b.getContent());
            result=pstmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
        }
        return result;
    }
}
