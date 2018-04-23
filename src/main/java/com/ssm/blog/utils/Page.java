package com.ssm.blog.utils;

public class Page {
    //当前页
    private int pageIndex;
    //每页条数
    private int pageSize;
    //总页数
    private int totalPages;
    //总记录数
    private int totalCount;
    //偏移量
    private int offsetCount;

    //设置默认值
    {
        pageIndex = 1;
        pageSize = 10;
        totalPages = 1;
        totalCount = 0;
        offsetCount = 0;
    }

    public Page() {
    }

    public Page(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Page(int pageIndex, int pageSize) {
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
    }

    public Page(int pageIndex, int pageSize, int totalCount) {
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        //需要手动设置总页数，否则JSP页面无法获取到
        this.totalPages = getTotalPages();
    }

    /*
    * 获取偏移数量
    * */
    public int getOffsetCount(){
        //mysql偏移量从0开始
        int offset = (pageIndex - 1) * pageSize;
        return offset;
    }

    public void setOffsetCount(int offsetCount) {
        this.offsetCount = offsetCount;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /*
     * 获取总页数
     *
     * */
    public int getTotalPages() {
        if (totalCount == 0) {
            totalPages = 1;
        } else {
            totalPages = totalCount % pageSize == 0 ? (totalCount / pageSize) : (int) Math.floor(totalCount / pageSize + 1);
        }
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
}
