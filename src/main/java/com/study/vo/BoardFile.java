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
    private int fileNo;
    private int boardNo;
    private String oriName;
    private String newName;
//    private Board board;

}
