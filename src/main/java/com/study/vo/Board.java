package com.study.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
    private int boardNo;
    private int category;
    private String writer;
    private String boardPw;
    private String title;
    private String content;
    private Date createDay;
    private Date updateDay;
    private int boardCount;

    private List<BoardFile> file;

//    private MultipartFile file;
}
