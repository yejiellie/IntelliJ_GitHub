package com.study.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardComment {
    private int commentNo;
    private int boardNo;
    private Timestamp commentDate;
    private String content;
}
