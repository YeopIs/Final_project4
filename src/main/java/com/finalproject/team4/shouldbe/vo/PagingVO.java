package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PagingVO {
    private int nowPage = 1;
    private int onePageRecord = 10;
    private int totalRecord;
    private int totalPage;
    private int offsetPoint = (nowPage - 1) * onePageRecord;
    private int onePageCount = 5;
    private int startPage = 1;
    private String searchKey;
    private String searchWord;
    private String board_cat;
    private String postSort;
    private int todayRecord;

    public void setNowPage(int nowPage) {
        this.nowPage = nowPage;
        offsetPoint = (nowPage - 1) * onePageRecord;
        startPage = (nowPage - 1) / onePageCount * onePageCount + 1;
    }

    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
        if (totalRecord == 0) {
            this.setTotalPage(1);
        } else {
            this.setTotalPage((int) Math.ceil(totalRecord / (double) onePageRecord));
        }
    }
}