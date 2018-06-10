package com.ssm.blog.dto;

public class Archive {
    private String year;
    private String month;
    private Integer count;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        //重写月份返回值
        if (Integer.valueOf(this.month) <10 ){
            return "0" + month;
        }
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
