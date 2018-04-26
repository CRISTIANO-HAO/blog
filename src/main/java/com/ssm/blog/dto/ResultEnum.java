package com.ssm.blog.dto;

public enum ResultEnum {
    SUCCESS(200,"success","操作成功"),
    ERROR(500,"server error","服务器错误！");

    private int statusCode;
    private String state;
    private String comment;

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    ResultEnum(int statusCode, String state, String comment) {
        this.statusCode = statusCode;
        this.state = state;
        this.comment = comment;
    }
}
