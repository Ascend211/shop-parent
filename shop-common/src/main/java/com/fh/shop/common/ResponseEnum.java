package com.fh.shop.common;

public enum ResponseEnum {
    ERROR(-1, "error"),
    USERNAME_USERPWD_IS_EMPTY(1000, "用户名或密码或验证码为空"),
    USERNAME_IS_EXIST(1003, "用户名已存在"),
    CODE_IS_ERROR(1004, "验证码错误"),
    USERNAME_IS_ERROR(1001, "用户名错误"),
    USERPWD_IS_ERROR(1002, "密码错误"),
    SUCCESS(200, "ok");

    private int code;

    private String msg;

    private ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
