package com.study.com.study.dao;

import com.study.connection.ConnectionTest;
import com.study.vo.Board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {

    public BoardDao(){}

    //게시판 전체 조회
    public List<Board> searchAll(){
        Connection conn=null;
        Statement stmt=null;
        ResultSet rs=null;
        List<Board> result=new ArrayList();
        try{
            String sql="SELECT * FROM BOARD";
            stmt=conn.prepareStatement(sql);
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                Board b=new Board();
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
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            ConnectionTest.close(stmt);
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
            String sql="INSERT INTO BOARD VALUES(NULL,?,?,?,?,?,DEFAULT,NULL,DEFAULT);";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1,b.getCategory());
            pstmt.setString(2,b.getWriter());
            pstmt.setString(3,b.getBoardPw());
            pstmt.setString(4,b.getTitle());
            pstmt.setString(5,b.getContent());
            result=pstmt.executeUpdate(sql);
            if(result>0)conn.commit();
            else conn.rollback();
        }catch(SQLException e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
        }
        return result;
    }

}
