package com.fh.shop.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class ControllerExceptionHandler {

    @ResponseBody
    @ExceptionHandler(AjaxException.class)
    public Map handleException(AjaxException ex) {
        Map result = new HashMap();
        result.put("code", "-100");
        result.put("msg", "error");
        return result;
    }

    @ResponseBody
    @ExceptionHandler(Exception.class)
    public Map handleException(Exception ex) {
        ex.printStackTrace();
        Map result = new HashMap();
        result.put("code", "-1");
        result.put("msg", "error");
        return result;
    }

}
