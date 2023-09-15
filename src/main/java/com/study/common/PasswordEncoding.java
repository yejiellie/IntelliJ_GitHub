package com.study.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordEncoding extends HttpServletRequestWrapper {
    public PasswordEncoding(HttpServletRequest request) {
        super(request);
    }

    @Override
    public String getParameter(String name) {
        if(name.contains("Pw")) {
            //데이터를 단방향 암호화해서 반환하기
            String ori=super.getParameter(name);
            System.out.println("암호화 전 : "+ori);
            String encrypt=getSHA512(super.getParameter(name));
            System.out.println("암호화 후 : "+encrypt);

            return getSHA512(super.getParameter(name));
        }
        return super.getParameter(name);//원본값
    }

    private String getSHA512(String orival) {
        //단방향 암호화하기
        MessageDigest md=null; ///java에서 제공하는 암호화 처리 클래스
        try {
            //적용할 암호화 알고리즘을 선택해서 클래스 생성
            md=MessageDigest.getInstance("SHA-512");
        }catch(NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        //md를 이용해서 암호화 처리를 진행 -> byte[]변경해서 암호화를 처리
        byte[] oriDataByte=orival.getBytes();	//바이트 배열로 변경해서 가져온다
        md.update(oriDataByte); //SHA-512방식으로 암호화처리
        byte[] encryptData=md.digest();//암호화된값을 byte배열로 가져옴
        //Base64라는 인코더를 이용해서 byte[]로 출력된 내용을 문자열(String)로 반환
        return Base64.getEncoder().encodeToString(encryptData);
//												byte를 String으로 변환해줌
    }



}
