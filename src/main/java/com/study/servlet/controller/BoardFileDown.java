package com.study.servlet.controller;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/board/BoardFileDown.do")
public class BoardFileDown extends HttpServlet {

    public BoardFileDown() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //파일 다운로드
        //쿼리스트링으로 보낸 값을 받아옴
        String fileName = req.getParameter("oriName");

        //InputStream을 이용해서 지정된 저장경로에서 보낸 파일명과 일치하는 파일을 가져옴
        String path = getServletContext().getRealPath("/upload/");
        FileInputStream fis = new FileInputStream(path+fileName);

        //속도를 빨리하기 위해 보조스트림 이용
        BufferedInputStream bif = new BufferedInputStream(fis);

        // 클라이언트에게 보낼 파일명을 인코딩 처리하기 -> 파일명이 한글일때 깨지는 현상을 방지
        String fileReName = "";
        String header = req.getHeader("user-agent");
        boolean isMSIE = header.indexOf("MSIE")!=-1||header.indexOf("Trident")!=-1;
        if(isMSIE) {    //익스플로러
            fileReName = URLEncoder.encode(fileName,"utf-8").replaceAll("\\+","%20");
        }else {         //기타 웹 브러우저
            fileReName = new String(fileName.getBytes("utf-8"),"ISO-8859-1");
        }

        // 응답헤더 설정하기
        //content-type(MIME)타입 설정 (보통 application/octet-stream 으로 설정)
        res.setContentType("application/octet-steam");
        //							    ㄴ8비트로 된 데이터(지정되지 않는 파일형식)
        // 파일 링크를 클릭했을때 다운로드 화면이 출력되게 처리함
        //응답헤더명 : Content-Disposition
        //응답헤더값 : attachment;filename=파일명
        res.setHeader("Content-disposition", "attachment;filename="+fileReName);

        // 클라이언트 연결 스트림 열기
        ServletOutputStream sos = res.getOutputStream();
        // 웹브라우저에 연결할 출력 스트림 생성
        BufferedOutputStream bos = new BufferedOutputStream(sos);

        // 연결된 스트림으로 파일 전송하기
        int read = -1;
        while((read = bif.read()) != -1) {
            bos.write(read);
        }
        //스트림 닫기
        bif.close();
        bos.close();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}