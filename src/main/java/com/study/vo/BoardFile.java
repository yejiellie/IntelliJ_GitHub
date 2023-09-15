package com.study.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardFile {
    private int fileNo;         //파일 번호
    private int boardNo;        //게시글 번호 (Board테이블을 참조받음)
    private String oriName;     //파일 이름
    private String newName;
//    private Board board;

}
