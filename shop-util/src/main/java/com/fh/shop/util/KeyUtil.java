package com.fh.shop.util;

public class KeyUtil {

    public static String buildCodeKey(String value) {
        return "code:"+value;
    }

    public static String buildUserKey(String value) {
        return "user:"+value;
    }
}
