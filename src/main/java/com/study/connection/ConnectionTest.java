package com.study.connection;

import java.sql.*;

public class ConnectionTest {

    static final String DB_URL = "jdbc:mysql://localhost:3306/ebrainsoft_study";
    static final String USER = "ebsoft";
    static final String PASS = "ebsoft";

    public static Connection getConnection() throws Exception {

        Connection conn = null;
        Statement stmt = null;

        try {
            //STEP 2: Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        return conn;
    }

    public static void close(Connection conn) {
        try {
            if (conn != null && !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void close(Statement stmt) {
        try {
            if (stmt != null && !stmt.isClosed())
                stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void close(ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed())
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    //트렌젝션 처리하는 메소드 만들기
    public static void commit(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void rollback(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) conn.rollback();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}