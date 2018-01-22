package com.tyh.exception;

public class Ex extends RuntimeException{

	private static final long serialVersionUID = 1L;
	private String code;

	public Ex() {
		super();
	}

	public Ex(String message) {
		super(message);
	}

	public Ex(String code, String message) {
		super(message);
		this.code = code;
	}

	public Ex(Throwable cause) {
		super(cause);
	}

	public Ex(String message, Throwable cause) {
		super(message, cause);
	}

	public Ex(String code, String message, Throwable cause) {
		super(message, cause);
		this.code = code;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
