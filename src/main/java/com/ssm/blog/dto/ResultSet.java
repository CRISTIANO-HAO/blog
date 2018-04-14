package com.ssm.blog.dto;

public class ResultSet {
	//是否报错
	private Boolean success;
	//状态码
	private int status;
	//返回结果
	private Object result;
	
	public ResultSet() {
		super();
	}
	public ResultSet(Boolean success, int status, Object result) {
		super();
		this.success = success;
		this.status = status;
		this.result = result;
	}
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Object getResult() {
		return result;
	}
	public void setResult(Object result) {
		this.result = result;
	}
}
