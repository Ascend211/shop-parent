package com.fh.shop.controller.pay;

import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

public class PayController {

    @RequestMapping("/pay/alipayCallback")
    public Map alipayCallback() {
        return null;
    }
}
