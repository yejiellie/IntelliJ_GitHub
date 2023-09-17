package com.study.common;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class SessionTemplate {
    public static SqlSession getSession() {
        SqlSession session=null;
        try {
            SqlSessionFactoryBuilder builder=new SqlSessionFactoryBuilder();
            String path="/mybaits-config.xml";
            //Resource클래스가 제공하는 static메소드 getResourceAsStream()을 이용함
            InputStream is=Resources.getResourceAsStream(path);
            SqlSessionFactory factory=builder.build(is);
            session=factory.openSession(false);
        }catch(IOException e) {
            e.printStackTrace();
        }
        return session;
    }
}
