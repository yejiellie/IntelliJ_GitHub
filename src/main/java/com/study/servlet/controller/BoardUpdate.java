package com.study.servlet.controller;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.servlet.service.BoardService;
import com.study.vo.Board;
import com.study.vo.BoardFile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@WebServlet("/board/BoardUpdate.do")
public class BoardUpdate extends HttpServlet {

    public BoardUpdate() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        //저장할 경로
        String path = req.getServletContext().getRealPath("/upload");

        MultipartRequest mr = new MultipartRequest(req ,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());

        int boardNo = Integer.parseInt(mr.getParameter("boardNo"));
        String writer = mr.getParameter("writer");
        String boardPw = mr.getParameter("boardPw");
        String title = mr.getParameter("title");
        String content = mr.getParameter("content");

        Board b = Board.builder()
                .boardNo(boardNo)
                .writer(writer)
                .boardPw(boardPw)
                .title(title)
                .content(content)
                .build();

        //파일 수정하기
        List<BoardFile> files = new ArrayList<>();
        Enumeration<String> fileNames = mr.getFileNames(); //파일을 순서화해서 저장
        //게시글의 파일 정보 불러오기
        List<BoardFile> array = new BoardService().selectFileList(boardNo);
        
        //파일 갯수만큼 반복
        while (fileNames.hasMoreElements()) {
            String paramName = fileNames.nextElement();          //파일을 반환
            String fileName = mr.getOriginalFileName(paramName); //원본파일 이름

            if (fileName != null) {
                // 파일이 선택된 경우에만 파일 정보를 추가
                files.add(BoardFile.builder().oriName(fileName).build());
            }
        }

        //파일이 선택되지 않았을때, 기존의 파일이 있다면 다시 담아준다
        if(files.isEmpty()) {
            if (array.size() != 0) {
                for(BoardFile f : array){
                    files.add(BoardFile.builder().oriName(f.getOriName()).build());
                }
            }
        }else{
            //파일을 추가했을때 기존 파일을 경로에서 삭제한다
            if (array.size() != 0) {
                for (BoardFile f : array) {
                    System.out.println(f.getOriName());
                    File del=new File(path+"/"+f.getOriName());
                    System.out.println(del);
                    if(del.exists()) del.delete();
                }
            }
        }
        b.setFile(files);
        int result = new BoardService().updateBoard(b);

        String msg = "", loc = "";
        if (result > 0) {
            msg = "게시글이 수정되었습니다.";
            loc = "/board/boardDetail.do?boardNo=" + boardNo;
        } else {
            msg = "게시글 수정을 실패했습니다.";
            loc = "/board/BoardUpdatePage.do?boardNo=" + boardNo;
        }
        req.setAttribute("msg", msg);
        req.setAttribute("loc", loc);
        req.getRequestDispatcher("/views/boards/free/common/msg.jsp").forward(req, res);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(req, res);
    }
}