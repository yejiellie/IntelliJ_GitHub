package com.study.dao;

import com.study.connection.ConnectionTest;
import com.study.vo.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    public CategoryDao(){}

    public List<Category> selectAll(){
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        List<Category> result=new ArrayList();
        try{
            conn=ConnectionTest.getConnection();
            String sql="SELECT * FROM CATEGORY";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            while(rs.next()){
                Category c=new Category();
                c.setCateNo(rs.getInt("CATE_NO"));
                c.setCateName(rs.getString("CATE_NAME"));
                result.add(c);
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            ConnectionTest.close(pstmt);
            ConnectionTest.close(rs);
        }return result;
    }

}
