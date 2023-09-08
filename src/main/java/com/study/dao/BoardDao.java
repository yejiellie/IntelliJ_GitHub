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

public class BoardDao {

    public BoardDao(){}

    //게시판 전체 조회
    public List<Board> searchAll(){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        List<Board> result=new ArrayList();
        try{
            conn=ConnectionTest.getConnection();
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebrain_study","ebsoft","ebsoft");
            String sql="SELECT * FROM BOARD";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery(sql);
            while(rs.next()){
                Board b=new Board();
                b.setBoardNo(rs.getInt("BOARD_NO"));
                b.setCategory(rs.getInt("CATE_NO"));
                b.setWriter(rs.getString("WRITER"));
                b.setBoardPw(rs.getString("BOARD_PW"));
                b.setTitle(rs.getString("TITLE"));
                b.setContent(rs.getString("CONTENT"));
                b.setCreateDay(rs.getDate("CREATEDAY"));
                b.setUpdateDay(rs.getDate("UPDATEDAY"));
                b.setBoardCount(rs.getInt("BOARD_COUNT"));
                result.add(b);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        } finally{
            ConnectionTest.close(pstmt);
            ConnectionTest.close(rs);
        }
        return result;
    }

    //게시글 등록
    public int insertBoard(Board b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            String sql="INSERT INTO BOARD VALUES(NULL,?,?,?,?,?,DEFAULT,NULL,DEFAULT);";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1,b.getCategory());
            pstmt.setString(2,b.getWriter());
            pstmt.setString(3,b.getBoardPw());
            pstmt.setString(4,b.getTitle());
            pstmt.setString(5,b.getContent());
            result=pstmt.executeUpdate();
//            if(result>0)conn.commit();  // 트렌젝션 처리
//            else conn.rollback();
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
        }
        return result;
    }
    //파일 업로드
    public int upload(BoardFile b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            String sql="INSERT INTO BOARDFILE VALUES(NULL,?,?,?)";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1,b.getBoardNo());
            pstmt.setString(2,b.getOriName());
            pstmt.setString(3,b.getNewName());
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

    public static Board getBoard(ResultSet rs) throws SQLException{
        return Board.builder()
                .boardNo(rs.getInt("BOARD_NO"))
                .category(rs.getInt("CATE_NO"))
                .writer(rs.getString("WRITER"))
                .boardPw(rs.getString("BOARD_PW"))
                .title(rs.getString("TITLE"))
                .content(rs.getString("CONTENT"))
                .createDay(rs.getDate("CREATEDAY"))
                .updateDay(rs.getDate("UPDATEDAY"))
                .boardCount(rs.getInt("BOARD_COUNT"))
                .build();
    }

    //게시글 상세보기
    public Board viewDtail(int boardNo){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        Board b=null;
        System.out.print(boardNo);
        try{
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("SELECT * FROM BOARD WHERE BOARD_NO=?");
            pstmt.setInt(1,boardNo);
            rs=pstmt.executeQuery();
            if(rs.next()) b=getBoard(rs);
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
            ConnectionTest.close(rs);
        }
        System.out.println(b);
        return b;
    }

    //댓글 목록
    public List<BoardComment> listComment(){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        List<BoardComment> list=new ArrayList();
        try{
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("SELECT * FROM BOARDCOMMENT");
            rs=pstmt.executeQuery();
            while(rs.next()) {
                BoardComment b = new BoardComment();
                b.setCommentNo(rs.getInt("COMMENT_NO"));
                b.setBoardNo(rs.getInt("BOARD_NO"));
                b.setCommentDate(rs.getDate("COMMENT_DATE"));
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
    
    //댓글 등록
    public int inertBoardComment(BoardComment b){
        Connection conn=null;
        PreparedStatement pstmt=null;
        int result=0;
        try{
            conn=ConnectionTest.getConnection();
            pstmt=conn.prepareStatement("INSERT INTO BOARDCOMMENT VALUES(NULL,?,DEFAULT,?);");
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
